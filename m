Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADDD5BC45C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiISId6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiISIdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:33:55 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2D2127F;
        Mon, 19 Sep 2022 01:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663576434; x=1695112434;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=23GhewKWFbsjao7hFVZGTI+oKe2RGwdFg/RRO/YKy0k=;
  b=G/cuIsih7UVxy01/he+d3w9m1A4LUuzyChwsw2bc7inLls8MzFSNnLXV
   xW4ztmb3zdCLGD/08UbLev/zwdVH300UARzbH4qGsYjCW0ZCU/u5BzOge
   GJcm51NvWNz3fiZ6Cggezcox/U7bZfYJJvE1G8Kiw0yC+AaPXSmpER6Y8
   tdPRs1iSh9+wXakjxN7SWGjNbAKQfJXakyPRwRKgDb3QusyskVZDMrsU6
   sJrDn/Zs005sIM16Ij7clX85r4+7sVFvPwY7BbvsK31DU5LaC7Q0qbFdU
   dG/K19xyD0ITsOFy4vX9Lq9HrndCzFKC4F2gm5EMsk71Dl/pGxMWMm8V7
   A==;
X-IronPort-AV: E=Sophos;i="5.93,327,1654531200"; 
   d="scan'208";a="212135380"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2022 16:33:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h73OucUvyOZuqoPek4w4s0s6z8eFaHal/Fq770CIgux/n5+tYg8l4MMRtf6RjsPlPNFo03znLysvCS8BpjqsSK4Kc4sVBM33AGaPaIoiIwC+DvMLGCkN6WkkJqaTNpn/G8XLZkq3KbSE8r9P+Q4Tltyko+R5a/Cne0yUs3W6i8PmWdcqEBCGGbuAWzlt4rl9+6BZ2J9/haPyAsA1dJTR1F5eOiIaKuhBkSauvCEwipjsNWvuVXkH8zQygkiKt/kpGWoZAlJrGfZFXrE0Pu6tUqqqxxHlnFL2SfWmi4QY7Uqgxhbewx5S7xzDEu6t5DqRunsdWJ4J2VuLDFKxOK3Peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23GhewKWFbsjao7hFVZGTI+oKe2RGwdFg/RRO/YKy0k=;
 b=WPcgWREJc+i2393oneFBIE2Pnb+lbYdEJqV6sPDrivVlnA812FRIyufPW3Oz/o5/Er57YJNApeEmu9W5njGYtFv/3Rt8oHCAbSSytwe6iU2MgtBqJdswP89ZcNePHpT19HMqbudJ4VFccG+IUWbNen718Y8Acts+e5KGoCRcHLtkyL/fyk2Q3l20bPiQOL/3UDy3mKmmbDSqbjBnPU+GneIS4UTue7EyIVsJE0ch6Hib/sj/tW9OqmwOrZArkFUQGO/+EFwk0UjKYuAv2Yvabita2xdPinuwXu0o4DR9x6tugU9OgnCC0vlzI3jFN2IaRxQwtNkha+1ttxbL7TVCgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23GhewKWFbsjao7hFVZGTI+oKe2RGwdFg/RRO/YKy0k=;
 b=t2Ej1KPfjiQ1xLGpUhXrtblJSihvYN0jN79rU/OnxFBQg7yJ0iOIozo6upqHMyTOnDKArevzEFePNIU3TFC5TGufXU7wqGlXXaVJEXWDXZxwSO31DLeKb8aNtsTZTenA1o0E6d6djAAxaKz/tCNhgno84ULTOBSm+HGMEaOebv4=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by BN7PR04MB3809.namprd04.prod.outlook.com (2603:10b6:406:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 08:33:51 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7%2]) with mapi id 15.20.5632.021; Mon, 19 Sep 2022
 08:33:51 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Daniil Lunev <dlunev@chromium.org>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq2kYf+AgA2Q4OCADD3GAIAcWViwgAxxyRA=
Date:   Mon, 19 Sep 2022 08:33:51 +0000
Message-ID: <BY5PR04MB6327FA0C19A60F8318FC79AFED4D9@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
 <YvBK/8yeohLhu2Za@google.com>
 <BY5PR04MB6327431615BFFFD735EB2502ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
 <CAONX=-cXDcekWznHf6h1WwtJfELyFxSPAZ4bnA5t3xOrmUQZ5Q@mail.gmail.com>
 <BY5PR04MB6327C911666B7A5AE0E92A96ED459@BY5PR04MB6327.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6327C911666B7A5AE0E92A96ED459@BY5PR04MB6327.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|BN7PR04MB3809:EE_
x-ms-office365-filtering-correlation-id: 5e4aaf48-ac80-414e-2f0a-08da9a19ae0a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QwPbEEPruZ/0wYIm4tApZieAjnGtESqP8JxYPnb5VwhwS5rPoMVm4wMOiz4QfxF+cpdfRHkXLphb6AsqGkd4j1gItun8PdedEFWQscFXqV4VW8LlwgNbsHNC0nYXxGZ3gQidJGYM+W7JtTxIBU4jsD07CIYsILrUJLQ+VFYib2v/M55mtjDRBQBp9ApGTJ246K6TNGdl7iBn1a+iPjzYGyRW79huCkAvJ1L5hotPSoR6wBJt0fwnSweS0oGh/B03dWda2PFS9WTESNgPTIvoqcBqp1/ca6Ir2cVG1G3cnScwSGTiel12yMaX56CjnJfhnB2kU4b6VJeoFxuhi2DVGhbvGUrh89eMmmd5rizddKog5/na+usjnSXlY88EDqiav5Wfissn6LyvhO6SLKKh+A8eoiM1+g8qWuVBHqKUBfaMqrjW5MlF8mYMfJGTwOk9dVozwgYA/x75cSZQNtFZvqJ+MITIMdadw3Jg3qgHb2yg7wWdNieGbdNvEwiSrR9H4BD7ArvsDBgus8GlzRiQMNVX3ocUfd6j6zms0M/I3wRTa+v3dlFsHGtXvMsfOWTsr0ervHdm7kM4cQ09nOj49WtXyUg/abkCLVOEwf8afk+m28Ptif19IAMDt6kjsKct+WV+dckAJ0pPjQ/bmbWIgv9fQBd3bn6nOBT7o6MV9KwRsBgx0e6DMA/Gk96zQLHqWUvPioOjcEwkmj7YJYJ/3Crct/+Gk1ZT/cNIctOfi9wJbv7Ljo9yW2Pv3iwwZOJZv0i+9IVf6zlnJuw1B9nxJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199015)(55016003)(38070700005)(33656002)(122000001)(86362001)(38100700002)(82960400001)(66446008)(64756008)(4326008)(110136005)(41300700001)(76116006)(66556008)(66476007)(66946007)(54906003)(8676002)(2906002)(316002)(52536014)(8936002)(5660300002)(186003)(83380400001)(478600001)(53546011)(26005)(9686003)(71200400001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3VXdTc1U2YvSXN6aklib2NaeTlrWXMzWUNPQTUzaXk3Z1AwbHh1emZZNUtC?=
 =?utf-8?B?VjhlRjc1cFVnN3EySkhQT25wWGtMR1JVM01LS3lILy9rSFQ1MUtXS09CdVFo?=
 =?utf-8?B?eE8vZEFDY2R6bUJ6OGpVNTZyRWxwY1ZpNE9uODRNenhwVFRXWUlROW40YTBI?=
 =?utf-8?B?anYxR210R09JNk82OS9nUlhvczZWZHBWRlE4ZVpqNkxVQnhvMm0vZTBiNWRt?=
 =?utf-8?B?NEtkb3cxME56LzZNVENaYVNmV2gySk5Vc1E2cjlNdnprU3ZXU1RTMGpBNlNo?=
 =?utf-8?B?NmZ4SHJES2Zyb0pGT2Vxbkp2aXllUW1ic1ZucDc2WjJuWHhpSU1wak5tbVR3?=
 =?utf-8?B?TnJKZ2I3UCtaUW9pK1JHWmJLMmVkQ3NjNDhzbk5pMnEyQlluT0FobU5odlJM?=
 =?utf-8?B?ZjNDdTFYNFQvNjNVYWlFZzlrYWVvVER1R0paUHZTN2NQcTI3T2gvZnRHd2ND?=
 =?utf-8?B?aHhFOVlNWjl6QW9HRGFFeGc5YTFwbVRTZ3l2cVFtT0hMWGM2cExkQkplRnNx?=
 =?utf-8?B?ekNMc3MxVnJLZ1V0QmRUMDRjR0FZR25FbTkyVUZpUEdhRDI2NjR4a3IyWTJx?=
 =?utf-8?B?enBYMTVQcFBvSkJsbTE1T2RMcTY0QUdEL0FrSnVzejZWOEdQOWJkclNNR3Rl?=
 =?utf-8?B?c3kyYzIxeFpRdTJKSU1VWjN2NlJSekFVR3JlZWlsNHhaRmp3VjcwV1g3K284?=
 =?utf-8?B?RWdra0VGMnFRZkNkNk8vNS9TYUJWYkpPMUROeGJsR2VIVURPT3EzTi9XU1Fq?=
 =?utf-8?B?LzAvYzN6d21LUnJQcE80ZlhnM2lVblJQS3FUWmdQZmNSbGxEalRWMTQ3SWUw?=
 =?utf-8?B?Q2hvWVd4ZGRtQUxoUDBVOUt1emwwUjBjWitqNDMveERabUxYeVdudUI3UjY0?=
 =?utf-8?B?TDNIRGdGVVcxYXRRd1NoNUpiaGNUcXdxdElYczZqVHY5aUlhUDh0YUlBbGp4?=
 =?utf-8?B?d09JWWREQS9SQS9na3dxakU2bzB3RWsyLy9ISnd6cTJLbjl1WmczWU41Q0FD?=
 =?utf-8?B?K3ZzazhpY1d4Wmw4WDFQdmg3UWJTYXhOV3hkSkxCWnFpT2pkQnp2cmg3MllQ?=
 =?utf-8?B?RzB6Mk9tNnVTMnpUcUpDM3ZrU25BODZ2c1pxcUpKTVVjSFpMdWE4VzdUM0ZG?=
 =?utf-8?B?a3BXZU4wQ2tMZHBUMXY3S2R6SlNlVE9od2JVTEVib0xVMVNuei9SVHFRS2JZ?=
 =?utf-8?B?a212ak5xTmZLdzQvdHBWOGFNOXNscWVGU2doc2txc1NlVndHcnhCOW9xamtu?=
 =?utf-8?B?NjJiRTBnN3FvZHlNalpVaTZKOEJrZWR2ZWZGTXQ2Zm11M3J6dWV2RzFNdnBz?=
 =?utf-8?B?Q3hWVGVkR1hGek5vZ0NkaXdRRU10VkphRFRkK2JpQ1NzMHd5WS95U3J5eUVB?=
 =?utf-8?B?ajNzTVJGT1hYU21BdW9kYU5zck8wZE9RR0IvWTlWaUpHeG5jekM1K2xLcXdK?=
 =?utf-8?B?bU10SWg0clYxSmtWaUxxMjcxRThESmo4QW96OVBjN2dUWHMvMVNhTlRBOWNW?=
 =?utf-8?B?bXJQYzE3aUFQMHZlNWxDRDdtZ1JJZ1hpNGpVb1UzeUpXczJiRnhlZmJOaDg4?=
 =?utf-8?B?Rk9hRGxrVC9VY1o4Ri9FVkNXMlkxVEYzekVjNVJ0WkFSMWJWRzQ4NTQ2TElv?=
 =?utf-8?B?KzN4OWhTU0loZEV0TFM2b0NBRmNtREpLRjR1VjJlV3JINThDbkc3WXgxbDhS?=
 =?utf-8?B?RHZLQ1p1eXphNWFWcW5GTittaTEvY0RaMjhMSFVjdkRsOHUzNHRhMkc0dWJi?=
 =?utf-8?B?Qms1K3ZmWTFtWlNXbmp6OGRJRWtsbVdvUVRKMll1bmNQRXBQY0hhZHY2Uzhr?=
 =?utf-8?B?K2grOERlaThvVG84NS9icmpubERXeW5JS29zeUtlK3h3VnhKalZLZTBoZ1dL?=
 =?utf-8?B?cFovSnlhM25ubDVIVXMrTXN6VjF3OWRqV0VQT1EwVXBKcXcwQk5MNUQ3NVpI?=
 =?utf-8?B?WjFJaDJHOVZHcmNRd0ZaSGJheklBbmRIM1kxT0puQnpFazVHYnBZU3JtL3J6?=
 =?utf-8?B?T3hLRmNzMXpNdE80L0N2eHEzdEZqclBEdEdsd250a1NRMHpDeE1XcXZwRXc2?=
 =?utf-8?B?MVl0WlptSU1Kd01aOWM0VlRzYkRhRlFMQTJaMzFwbnFBc1BDclJnYmtFNkFQ?=
 =?utf-8?Q?DEo4H9DLo6hJrlCvheq8E8ISZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e4aaf48-ac80-414e-2f0a-08da9a19ae0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2022 08:33:51.0640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rpY1rRDzTXKkeG9gIw7vOdVlSPcBTwkhtrvet33phPpq9xEyhrqSGCVq4UiHLjgsKDtb04Z55H5Bw/RPrzva4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3809
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TWFydGluIC0gYSBraW5kIHJlbWluZGVyLg0KDQpSZWdhcmRzDQpBcnRodXINCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBcnRodXIgU2ltY2hhZXYgPEFydGh1ci5TaW1j
aGFldkB3ZGMuY29tPg0KPiBTZW50OiBTdW5kYXksIFNlcHRlbWJlciAxMSwgMjAyMiAxOjM1IFBN
DQo+IFRvOiBtYXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbQ0KPiBDYzogbGludXgtc2NzaUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJlYW5odW9AbWlj
cm9uLmNvbTsgQXZpIFNoY2hpc2xvd3NraSA8QXZpLlNoY2hpc2xvd3NraUB3ZGMuY29tPjsgRGFu
aWlsDQo+IEx1bmV2IDxkbHVuZXZAY2hyb21pdW0ub3JnPg0KPiBTdWJqZWN0OiBSRTogW1BBVENI
XSBzY3NpOiB1ZnMtYnNnOiBSZW1vdmUgdWZzX2JzZ19nZXRfcXVlcnlfZGVzY19zaXplDQo+IGZ1
bmN0aW9uDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRl
IG9mIFdlc3Rlcm4gRGlnaXRhbC4gRG8gbm90IGNsaWNrDQo+IG9uIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0aGF0DQo+
IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gSGkgTWFydGluDQo+IA0KPiBQbGVhc2Ug
Y29uc2lkZXIgYXBwbHlpbmcgdGhpcyBwYXRjaCB0byB0aGUga2VybmVsLg0KPiANCj4gUmVnYXJk
cw0KPiBBcnRodXINCj4gDQo+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiBGcm9t
OiBEYW5paWwgTHVuZXYgPGRsdW5ldkBjaHJvbWl1bS5vcmc+DQo+ID4gU2VudDogV2VkbmVzZGF5
LCBBdWd1c3QgMjQsIDIwMjIgMTI6MzYgUE0NCj4gPiBUbzogQXJ0aHVyIFNpbWNoYWV2IDxBcnRo
dXIuU2ltY2hhZXZAd2RjLmNvbT4NCj4gPiBDYzogbWFydGluLnBldGVyc2VuQG9yYWNsZS5jb207
IGxpbnV4LXNjc2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gPiBrZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBiZWFuaHVvQG1pY3Jvbi5jb207IEF2aSBTaGNoaXNsb3dza2kNCj4gPiA8QXZpLlNo
Y2hpc2xvd3NraUB3ZGMuY29tPg0KPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHNjc2k6IHVmcy1i
c2c6IFJlbW92ZSB1ZnNfYnNnX2dldF9xdWVyeV9kZXNjX3NpemUNCj4gPiBmdW5jdGlvbg0KPiA+
DQo+ID4gQ0FVVElPTjogVGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0
ZXJuIERpZ2l0YWwuIERvIG5vdCBjbGljaw0KPiA+IG9uIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVu
dHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdw0KPiB0aGF0DQo+ID4g
dGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gPg0KPiA+DQo+ID4gUmV2aWV3ZWQtYnk6IERhbmlpbCBM
dW5ldiA8ZGx1bmV2QGNocm9taXVtLm9yZz4NCg==
