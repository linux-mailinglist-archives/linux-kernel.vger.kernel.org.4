Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0B746A88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjGDHYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjGDHXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:23:54 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49E4E64;
        Tue,  4 Jul 2023 00:23:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9L6nOKWT7lc3AfSe7qG10u2VeTo0/0DOAB44y3bOvLdvv/lah7LKNuw8scEbeRo4It6Mty90eWChC04ijJpnQnS4DECmuiabljd47xPD8/YpLCh0Hc3+7nBTX2ICf0VQM52RWrBom5JOjBKsH8SOhObBRP3yHPzaB/Yhi6jHVQQkkk8M/EosBqkRRn+zvY544t2kWX+OCj061C5VI/PbQANe68i1ODI7CPpJ5fGUoZADiZNU6m2Zn7uvnWYzaqEqVgxMr6729VEyJK3XdfKUfSMMY2BhkFrAqnJdUF/RfQZ77Ci5mgRXw1cl/Xri4x1O51OOuEUqgdypWLHgvV24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05u9SC8sHtpYvHEeQSeVAY9TsM+xG6xCS6n4TT/vreY=;
 b=i6rx38NE6tED38GnBlCp4RRq+hAcJIr/RNh0g7Tvcio2s+psQ4rpvW1MLUMi9tUtLCP422O09E7qb0mRQTJesVVActAyHNsj0C72us8WXrbQUaQ8HbgIeZLDXkEAUxd4u90rd9K2eBLjArkRfjwOdJYuEPIcbtSEtTZ8Kbiua2tvKJy6pcQrMTIpFt7qf79QejGd4VY67i7KuObrtpGY++qZtVGnbIrmvAwyKi9ESXwG1mA2X0GiujIHEUl0lXrm61gzS/0s7Tmm0qVK2R/ay6EFKhpqu3V4xGmE7gzAGx7rF6tcq32wnltzYWdSis7Jhwhmzj0xXt9zWhzi+P29BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05u9SC8sHtpYvHEeQSeVAY9TsM+xG6xCS6n4TT/vreY=;
 b=FTu3x/G/93o01ty1Eh+ATY44cKpAG4s63RRXKhktmNJKRIJCpLIiUlGudwn1TQEy2F6sEFnV+e3RALRWJuP+ZJY2bYPkSFElsrCQcPpEEmkx4fLkMbo0krLp+Bep6FYR2wxxA74HRR5/TTLqvM1GdWnoOG2qHl9cIqaEH35EjuwZbIRGGGz1G9pn69Xs1R93InePYE89SLmi5eoQzuAQmLCEbR4I8KC3Evu0gNjv+/V0VLaUZesXXZ2PzoS7frGMadJa8OdjFNptAWmnAevsbliqU6YyLyuUp9sKsNYp2hTOzC720olFN1ETuGNKgu8evvE4SSCeFk1eTKXth6fTAQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB6178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 07:23:49 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c056:6a8e:6bed:d7e1%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 07:23:49 +0000
From:   "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Topic: [PATCH v2 3/3] net: dsa: mv88e632x: Add SERDES ops
Thread-Index: AQHZrkUc18qHp6R0xUiZXNYp+5YEHa+pNGgA
Date:   Tue, 4 Jul 2023 07:23:49 +0000
Message-ID: <5a337d2cdf514c016c227dcc9a6ba0c42a951f97.camel@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
         <20230704065916.132486-4-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-4-michael.haener@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB6178:EE_
x-ms-office365-filtering-correlation-id: 3a6ac995-c632-4724-74ba-08db7c5f9c92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PMCDAD8MHn5pB+YMidKG26v4u3codt1xQ1VJMT9MjYAlGS6uuV/3d9r+Wu7xCYm+1aamb03ETEzLEjzwTkxHhj/b4kK9OfRzGiaygYnXjMZK3XwpBfpJ2bUOIzsQ1S1sgWkXupNOO9m6ss9Hq3tlwvRiNy6tzIJME6UIzbTgcZGIjvuXChWQf857+fUDGPK/gfmZv5P6cbbdoZd6UI1HR5R99CqKuEXGdl6VyiMNjf9vOWPi7AauvVrjtSkShW0AVSKDHGuO2NtkRpZP1CB3PXmQcezbLepxv8eLxeF9j1lGDr7TieZVyDBGFQxnDldVfAOpQ/7x5BwTWYQA7X1hsEjw88nmVQUEvqM+mGw5QK7mEfZ5jCYY0F1xcQ1VLEjj3Brx8lox519weju2RDfIVtTaW+QmkkvTr5eljbihrBKII93j2ZGOemDXYb9qBiqg4qSpuK2lYD9yDSGu19s07Jbj25yw4z/w/EcJIUeMctuczz65TkILX81C6P/wec0p5+C9yE7RkT8tkF+Kx0TaPx250nzYaXmbeNUq4o3DcPUT2SOxGw+I0aFpsP+29wghiH606HFzQIVqQ5rY2IEvn5cOUY/YnLuif00+eHFf56rnUejxHwJGdXfn3A9aXmkTMcz6xdBnCofARMmpum1fxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(451199021)(83380400001)(36756003)(26005)(122000001)(82960400001)(38070700005)(71200400001)(186003)(55236004)(6512007)(6506007)(15974865002)(2616005)(86362001)(38100700002)(6486002)(450100002)(91956017)(8676002)(8936002)(316002)(478600001)(41300700001)(5660300002)(4744005)(2906002)(66476007)(66556008)(64756008)(66946007)(6916009)(66446008)(76116006)(4326008)(18886075002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azBlbzZBajFVTjk3dnB6LzRsOVNrMnV6Skg0d3phZjB2MExDZVRkLzN3RExr?=
 =?utf-8?B?S3BuNUhzTGJDMDZaVDhjYStLaXJ4dEx5aTNWVGpDSmtySUdnenlYbWYrSjZU?=
 =?utf-8?B?SDZURm1HVmFBak1mNUhFYXVjclhJVExlbkcwV2xNZWdkc1oxSW1aRVZ3ZTNU?=
 =?utf-8?B?SGZxdEJQWDVLTGJDa1QyZExNWkhHNSt6aFd1SUlmcSs0U241V2RUSHpmaVlv?=
 =?utf-8?B?S1NMK1h1Vlh5TDFsalRnMm0zK1VwczlaMU4ySXhQTHlWWGpLajBlN0w0aGox?=
 =?utf-8?B?S2IvUkE1ZnJTQWN6K2RreU9BalJJMjVPcnFQN0tXQXcwTXpTZmFKdk1sTkd3?=
 =?utf-8?B?UmNnV1REVkR3elhiUitOaW9BNUtYMTB5end1Y3JmS0tDbHVGeTA0SlE1MDA2?=
 =?utf-8?B?NkhQdmtDWlIzbTNMcjh6aFZBZjJjdjBIYUVnZXNGa1lzcVBHQmVIS1hSaHpC?=
 =?utf-8?B?S1RqdnFYYUN1TjlnU05nMlNsMGpMaFJtMHcyZTcyUTdLWG5RcFlsU1hPZFFB?=
 =?utf-8?B?QXBwMGRWMmZoNlhtUzF2dTlJK2VEaXdBNXRhUlNYVTlodWltS1BBSHBVKzdY?=
 =?utf-8?B?cEMzelI5NGxMSVROQ1lDNVMxUXhZRkpJSjhTZmtkNkRyUlZ3cFRGc0tjV1d3?=
 =?utf-8?B?Q0tSSTRRNlh5bWJPQlVXSFFLRnIvbnhDeC9LUlVuRS9VbnFsQ040ZkRBSC9h?=
 =?utf-8?B?bmJWSk51bjY0a0RueWRJZlhwY2NrUUIvcjg1OFE2UkhaQlQ4QUF1WDFoMDJr?=
 =?utf-8?B?WURBdFIxSE04Nlk1TjRTbUxsam4rWVU1b1pWQzFFdjVxT2trMGl3MC9ITjJx?=
 =?utf-8?B?R2I1TFVvZUp3blRCMHRJT1FOdTI3Vi9jUXJzSEFmdHdmQm1nekl1TjVrT3ZB?=
 =?utf-8?B?ZmtJMTcySy93QUdJVWJVTXlrTnErWHFoZzEwdGJ5bHRaQTdQWllwNEtCZ2Nu?=
 =?utf-8?B?T0YxUXA5Z0szQ0tMUkxkTTMxbE1BRm1xS1FXdkd2L2h0YTQ0NnROWi9Wd1Mx?=
 =?utf-8?B?MXV3SXhhQTFJRVhDeURNeG11WmVWU3dwZysweEh4dGJScXIzbHdQTHc0U1Vx?=
 =?utf-8?B?QXhJOTNzNnplK1FzOVR1UW5KbERicFk1RERkYkRFdW04QTNRMnQ4OVRsUXBQ?=
 =?utf-8?B?aVJid1lOUTdITnNvUG0vMUxYQmQyODlyVjFXa0QvaDZhTW9HVEE0R3g1aSto?=
 =?utf-8?B?aE9xc2hhMENJWkV2STduT1VRRURGRVdlOTZ5Z3NpRFV0bzZibWRJU0lETHJw?=
 =?utf-8?B?YnNTKysvU1JYa2l4UVNxTnkvMUlPc0NDdkxOdUFhQ2hUOWJVVTdUTmwrVUEv?=
 =?utf-8?B?QXpvRFZqSjFGTDc5TlBZTXViV0MyRFdsTm82S0huenNEWWs3UzFzRjJvdm1W?=
 =?utf-8?B?dG84cGM0dDM1bjh5NVNNV2ZWU1NScG03QzJXS1FwVG1ldHNHdTVIRVFCaFYz?=
 =?utf-8?B?djF0aXRkd05QaWpqZDBoVTBtME5OQmZUMHdNZ3JTRnhFRndoR043MTNnaWRY?=
 =?utf-8?B?a2lYTFZsVW0rVFZ5TElkRmpZdDJtUFN6eVhFZFZiQjJiL1FLUEZWM2pXOHRr?=
 =?utf-8?B?MFU4NytGZFVsYTZCL0xWRmF5TFQ4WWl0bFZoMVBxQkh2NS81SmZ3bWlWY3dR?=
 =?utf-8?B?amJqblFCNTdNNnF0V3h6V3ZTbVFHOXBxaHIyMVVQazZMaC80Mml5bU5RTzhB?=
 =?utf-8?B?YUxCd3lFQ3I0YkJMMFM0ZWIybHRxdFEzYjNwd2VoK1o0K1NyUzlaWHBTbG9X?=
 =?utf-8?B?M2FCZHg1VWZNc3FrR2l3dnhDSzdRWUE0bGw3ZjdwNFYvendZcUtRaFV1QTJX?=
 =?utf-8?B?ZDFpMk9TNTlpWWdkb2swbStKT1lDT1FqSkRuWlRWSTJTSlFvY1BIcmxmRzJw?=
 =?utf-8?B?eTJ4ZUhyWGZwUEc2OUtwc0tMcDZlU0kwNXZPVXI0MWVzUmFGNEFnenJFblEv?=
 =?utf-8?B?bDk2OWVUejhuN1dyYVlrS0FrdEoxTW5odHJ1dGdvekxhL3RDQjZIdVVqeG40?=
 =?utf-8?B?ZS9IMDNsWmpWdmdpWWl5RmxHcXNkUlN0b3pkUGkwUW9GTHBVQzJ0WFd6Q0Zx?=
 =?utf-8?B?Y210OWw5NmVhdzJWWHdwZFVRaS9DRTVjM0JoTlB4c2p2L2I1cm9ZOStsd3o2?=
 =?utf-8?B?QlhwM290cXZSWVMyQ1I1WmtFS21QOHVYb1pGc3V6SUg0M2g3enN5WnBlcVVw?=
 =?utf-8?Q?4ioISRcG9bjIJgsUUK93XtY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <157ECD65A892EB448D1DD162D67E3422@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6ac995-c632-4724-74ba-08db7c5f9c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 07:23:49.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EDSkM3jDX1c4bn19o/yTwb5M5xN+BXNagFW0sL41axWipoiHOsmwk33zQp1f0fjusAPIG+McFaWbqOaDJPyrTKyYXfDIVKWLBB778JZRCng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6178
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTA0IGF0IDA4OjU5ICswMjAwLCBNLiBIYWVuZXIgd3JvdGU6DQo+IEZy
b206IE1pY2hhZWwgSGFlbmVyIDxtaWNoYWVsLmhhZW5lckBzaWVtZW5zLmNvbT4NCj4gDQo+IFRo
ZSA4OGU2MzJ4IGZhbWlseSBoYXMgc2V2ZXJhbCBTRVJERVMgMTAwLzEwMDAgYmxvY2tzLiBCeSBh
ZGRpbmcNCj4gdGhlc2UNCj4gb3BlcmF0aW9ucywgdGhlc2UgZnVuY3Rpb25hbGl0aWVzIGNhbiBi
ZSB1c2VkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWljaGFlbCBIYWVuZXIgPG1pY2hhZWwuaGFl
bmVyQHNpZW1lbnMuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4
YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9uZXQvZHNh
L212ODhlNnh4eC9jaGlwLmPCoMKgIHwgMTggKysrKysrKysrKysrKysNCj4gwqBkcml2ZXJzL25l
dC9kc2EvbXY4OGU2eHh4L3NlcmRlcy5jIHwgMzkNCj4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+IMKgZHJpdmVycy9uZXQvZHNhL212ODhlNnh4eC9zZXJkZXMuaCB8wqAgOSArKysr
KysrDQo+IMKgMyBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspDQoNCi0tIA0KQWxleGFu
ZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
