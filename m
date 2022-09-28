Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0285EE27D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiI1RCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234308AbiI1RB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:01:57 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B05DB95A;
        Wed, 28 Sep 2022 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664384511; x=1695920511;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VlQ5GTpECTEAeHmiAGAGWgunC7WcM9uw9HtjP4STZlA=;
  b=LlqzmNft1Y/2dfl9w5GhLUBCCY3WxSJtg1y4QKZCuk9065M0zHLxWgMn
   /1u0Re9+2c8k2+LAY2LkSL6wahZEcVcQhmCvck/tFogm9K8MoRmWUouvj
   x+POaagH1P7P3sXrmemoWZxnxJrZk1wErPhzfVBuJqyAfu6ulgFyQWRCB
   mIXlTzmZANmLaQ/idSOviT/maIcolVz3de+vxeeoe7GJKtqIADh4J7441
   AFfZixB1GYu0jTOGpDth+JtGxenIAZ8i0iYqK6+a2jGUOXTWP+dJ8//7F
   wL+PKgZj1jnl4Rm45kZm7hCiMeMrwGRbC1QPsIpE7WKZo9S+S/2Kwx2hA
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,352,1654531200"; 
   d="scan'208";a="316788019"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 01:01:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfZP9gJ9nPWmFcxFOx/KNnYjk2aR69ncDr0bsLya0nW9BnAZMJvtjND4e7jl2RTU2/bJ/E40j2Xhl6QS5saMjWKCw0vuBN4F2IbThY9ENAy7gIUifqBKlyhj7+/t41JCdZ7KY9Rd2kGVSaKu06liH2N5pkQcsKXsqHKkLOc9CrsbHKuE00IhWVMJeJciR50iKW4ggogTRkbuU4as9322YEYkgbfNj1930FXnGWHlI3cB8HMO0mCBSPrZxnM7bSsRMl+N4Mde0ukf6tDHlZ4cdUWJOZpnKz49IEx0MSEv+8AtS4j1+SF8PSKr4+7vfZ/9SkTm0CW0lK1oM+KlntKIQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlQ5GTpECTEAeHmiAGAGWgunC7WcM9uw9HtjP4STZlA=;
 b=EAsmLInpXNvm8mNOSJq+xK0KRytX2UfloYCi7gO8SMvRM3YLjYzaKBk5vyptlNwu/vGfBij6WcG/nGMNPEGCm+l1GfuZiAY0mW4TjW6oQ9t13Soq6nqTcbZMqK1G/IdAVq3O4WJ9Vp3cZgFvZTCNIXCRhoLcPSYnpCqQOh8uUAryG1wbKprLdwRnmBLQtgCap6o9C1ldXdZyPkRdCkUoaJT2rzYUPfWkGypmpcIRg2nGEbufWwF1X2r30ZPsW+NEKoeTzuAe9bGFX4tNIwMO7YEGxF15xeSIjFJuqykA2IjdFLnxWtRT8yZGowkROMWsNXHm3FiDsD5f8tqxWTgkZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlQ5GTpECTEAeHmiAGAGWgunC7WcM9uw9HtjP4STZlA=;
 b=IDhV1j7FZXApvWTBC/MR4MtkyG82jALayjgcxdSrBNsWXFWijRb4CaEFqcNg1jDtyneSgriY6c/ALxl+kqz90sAOBZ7phBAEBrpDwxF0dnE07JPYKA0ymNko1jxQTdJ7o4g8iAA/t8yemIbJVX2P4AHcUSSL8sZpQ0NXrhcEwT4=
Received: from BY5PR04MB6327.namprd04.prod.outlook.com (2603:10b6:a03:1e8::20)
 by BN0PR04MB8159.namprd04.prod.outlook.com (2603:10b6:408:15f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.16; Wed, 28 Sep
 2022 17:01:47 +0000
Received: from BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7]) by BY5PR04MB6327.namprd04.prod.outlook.com
 ([fe80::b116:fb8d:6e10:37b7%2]) with mapi id 15.20.5676.018; Wed, 28 Sep 2022
 17:01:46 +0000
From:   Arthur Simchaev <Arthur.Simchaev@wdc.com>
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        Bean Huo <huobean@gmail.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniil Lunev <dlunev@chromium.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>
Subject: RE: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Topic: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size
 function
Thread-Index: AQHYhKDynvKkVtaQm0SrWhB5D1T9dq3ooC4AgAGVWkCACuorUIAAI1gAgABD8GCAACWBcA==
Date:   Wed, 28 Sep 2022 17:01:46 +0000
Message-ID: <BY5PR04MB63270395126089C821E9B72DED549@BY5PR04MB6327.namprd04.prod.outlook.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
         <87e6fdb49d9d76c468712e1b42cbc130273b5635.camel@gmail.com>
         <BY5PR04MB6327B8C5001E315009E3AC6EED4F9@BY5PR04MB6327.namprd04.prod.outlook.com>
         <BY5PR04MB6327ED5C6D91CBD3A024F709ED549@BY5PR04MB6327.namprd04.prod.outlook.com>
 <0e2334ebc4ba0ba137e83c60a090fde536be7f26.camel@gmail.com>
 <BY5PR04MB6327294F1E861DD13771EAAAED549@BY5PR04MB6327.namprd04.prod.outlook.com>
In-Reply-To: <BY5PR04MB6327294F1E861DD13771EAAAED549@BY5PR04MB6327.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6327:EE_|BN0PR04MB8159:EE_
x-ms-office365-filtering-correlation-id: 603f0150-4b42-4cdb-3525-08daa17320a4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IruxO+aBaKF/KGZcfwtIDAuQTd+FRtjGrwwCMhmEDj5CE61BZPPtcpdOqaq7VKLsDsuBLB0c/Y5nHQaojCKH+0JSkZf091o51KzsYkgaLQqc8tpd6O2CgPUv61JWpNZPva+jG7udqdtFgTxF8oTiZZo/iGNUv73CY+RPWatgvFSRZCb0LULZG5/QNu2agNPP+wjUQvwAoQHSsu5VN/AH/n6Vis5966K13/X3+tAuj1V6LDCh2PNfEp4RBanmWtzEILPsLPg88FkfkK8LFLciBHkklxp76ZdpAu2f97h0s38rCa7OMnrxJAY95UYCsrhyXGYOztFkouHVssHLSwx/biMzFgLiICa2mnzxk+PQ6tWcZLkBK2c74IkgnovydVmlcrabAZfETFjkLJxZV49CRDSRozzio1PjzZx/MOx1U6oH/NVhp5FpKJVv54LGcA1ybMwg+j1LLI1WVfaNOl7KpFDm++FuMiW9gcTUTTk9vEWoPy0KRFo67yV3aMyuX1LayEVhymmJCmj8zOK389ItahFBJCfCWasjsyETuYVLSdfmQXrx0HAHe2ixNTN0EcGZI9Fw655CltKlem/OmxIiTEtLogGZp1ZYeJXfRwq/b/okJqFmKeP9hPS4ZynitmwnVhmilzH09G6+NuCTWMuRBRJmlNw8tNDOPLXnSUJPllRsKa/vYtm7Ki41tcTdnA9uRJZl92qPRkV4FXDo18h9TNcLpsBD+jI1dXw/a6p8hahrZy5jRVjz57Ybeipy8+EdrkjRfZPnSQjrrYSxrHVczg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6327.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(8936002)(33656002)(82960400001)(38100700002)(2906002)(110136005)(86362001)(55016003)(38070700005)(54906003)(9686003)(6506007)(316002)(122000001)(53546011)(26005)(7696005)(41300700001)(66446008)(478600001)(2940100002)(71200400001)(76116006)(66476007)(66946007)(64756008)(66556008)(4326008)(5660300002)(83380400001)(186003)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUxwMWgvOUNFYU1NR3A4Unl6Tm0wbUxxTFgvdFdnZVRXN3BLNG5sNFNKZldX?=
 =?utf-8?B?U3lOcGRjc2FZdjJPV0JMWVR1THZKdUxaeFVRNlZUbVRLbW1lMjRzb3BtZFZu?=
 =?utf-8?B?aHkrcnV6VUhlQmRXTk1GMWYvY2FWSlY0WWxkYUhFaWFPV09SejNHWjljS2xX?=
 =?utf-8?B?VDg3aVMxRXN5eldnd3NwK2dxNTFwN3JVUmdXT3pkaHUvUVVlbXZ6ZzdHVDdD?=
 =?utf-8?B?TnlXM1BkMkJSL0NZVDROODJPT2tieGp1TGhvV0JLWkNLZnJQTS9GVkZNMTl4?=
 =?utf-8?B?a014RW4vZlltQUlFQXhCMlA3YytBZWhJV3RnMTdmVFhCcFR0QXUvVmoxVDNL?=
 =?utf-8?B?ZHhkdGVEQXRxb3FodEVtTmhld0pzS1hCTllybnZnQ05aZ2NhVGZ0QW14cm1H?=
 =?utf-8?B?Q0lTc3JobXMyS2FwTTZhd0hkTTJTR3ZMUUVOT25CQ0dLR0dtNkhoWFBjalRG?=
 =?utf-8?B?bEsyckRoRU5tY0xEMk93VDlpRzhKQ3Z1WkRYZEZSOWdiNDRYUTVVT3NadjJI?=
 =?utf-8?B?Yzg0V0c4ZEJGQ3RoNGl3TmovM3ZSRWdSdUxQMDhjeHVKb2lsaGNSUm5RMDJX?=
 =?utf-8?B?R3N3SWVCRlRNMHBEdkZwZUxOUG1Bb2FwSml1TkpVNGJWNnR3anBpaStpemNo?=
 =?utf-8?B?d3lVQUJuUWpSdUhoV3hvMjFGMHczTGtXQUtUemM2TGpKYWtGaHhwT21rSEN3?=
 =?utf-8?B?eTBPSU9MK3g3ckdxZWpRc0kyWVFlM1h4cVA5RWZaQ1YrT3RyKzlGU0RUWlNj?=
 =?utf-8?B?Sk4xQllZYlpscVcwcGYvaFc1anZBb01TUXhSbC9iazJEK0g3bGhuRm5RbFAx?=
 =?utf-8?B?R0VvaTB1aFBQbkNQcnhUM3Q2cC9sbEY3ZHlZY2UreXlkOGk4aU4yNUpoQjll?=
 =?utf-8?B?SStpd2tiR3ZMbFdQdG9qVTZURFd1MUQ1NTZocTlwY1MxVDZqSEtQNHRVd3Ay?=
 =?utf-8?B?TlU5YlpteVRrc3pobkZMSm1zZStmUlgrVndvU1oxQmhQWUVXTmxOSDYxa3BQ?=
 =?utf-8?B?T0MrL1JvcVNuMTFYek5Ta2R5U2RVL2hhUEpSYUtVVHBLZnoraTF3cDlHN2lT?=
 =?utf-8?B?cG1tTEFPRTZ1citMTTFEUzVBN2t6aVdBeHY0V0t5bXlZYkY2QmI0K2ZYdUo4?=
 =?utf-8?B?eVc3Z3pzK0RucEhMRGhJcEkwZ2lhUmFHZGY3R3ptLzFicjNKMlFGREtndFBx?=
 =?utf-8?B?cjM3bFQzSkFQbzY4VWEycGRXemh0enFieUlZWXAvNi81SVE5UkNOdGlXQ0NL?=
 =?utf-8?B?REdsRXdTUElkU0dUR05SdWVQdXpzY0krempzU0RpOFNFNjBSeVArcTMydUdi?=
 =?utf-8?B?cE9JQ2V6dlZ5RFNLKyt1Z1VrSUtwZFFVMlN6MEdyaEpIalFGY09pR0tsTElF?=
 =?utf-8?B?L3VYOVNsODNPVkhNV21wNHg0eG1zWVhrZ202c2hiL2E3U2d1ZWZsdEN4WjJZ?=
 =?utf-8?B?TjAyRzVxZHF1WGcwZjg1WC9FbENhcjFGZXB4MU9sSFowWDBvdlFFalB1ZHM3?=
 =?utf-8?B?WTI1T1cxdFlaUVZaaVBzU1d0VFNtejljdGN2RVhvV01xQVZNemdrTmFoTjRT?=
 =?utf-8?B?NlJHY015MkhyaUh0Sk9XTkpua09VS0JWNmVnZ1UwU0MvdFV3aU9rWituWDV1?=
 =?utf-8?B?Y3JQZXpIc09oM3ZyNVBVQWVYeEVPbWJuaFpOSlZnZ3BYRTZCcFpPZVBxZFZk?=
 =?utf-8?B?RGxYZHptUE4rOVFXRk0xQm84UjdsWjgveTJOWlphM1RFQ0poMHJSbmRIMDBR?=
 =?utf-8?B?U0tEb050dk9Xa09iZDhPMzAxY1VLRWh3a2J5MHZzUnpQTXdiWTMwaS9uTVZs?=
 =?utf-8?B?anpxNnRMWjE1TE9sMU1tdmNlcmFlc1p0RXVGYTF3RnVNa294em9McFVINnZr?=
 =?utf-8?B?OE5wa2xXeEFPV2h0d3hXSW13VzlzVHdRRFdtMVpydGwvM0wzYThjd3prelVC?=
 =?utf-8?B?SUk4MkVNZUpjS0xxeVpmMXpWQTZ5S1JodlJXTzJCWkNXaC9qd3VYNk01Y04z?=
 =?utf-8?B?dXV6VHpWano4TnBUUG5JSUhPRlk2REh2aWxlL1pCWDZpM2VDVXAzOUZSYUEw?=
 =?utf-8?B?SndqZnErWnl0V1duUXJpVm45ckttR2I2R1BWVWxVdnE1dkNxQkJ3ZkFMRjhI?=
 =?utf-8?Q?aBVbZ4EtCgzTA/DCm3fNVKteu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6327.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603f0150-4b42-4cdb-3525-08daa17320a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 17:01:46.6977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1IDoMLBbUhQVTEel/aVy72bPFqr36P5Gcr9asD1SQmd2Bi079rWWSrTbJbFuUpADNm/FO4EakIMhERXgbMOWxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8159
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQmVhbi4gDQoNCkkgdGhpbmsgaW4gYW55IGNhc2Ugd2UgbmVlZCByZW1vdmUgdGhlIHJlZHVu
ZGFudCAgdWZzX2JzZ19nZXRfcXVlcnlfZGVzY19zaXplDQpmdW5jdGlvbiBmcm9tIHVmc19ic2cu
IEFzIGRvbmUgaW4gdGhpcyBwYXRjaCBhbmQgc3VibWl0IHRoZSBhbm90aGVyIG9uZSBpbiBvcmRl
ciB0byByZW1vdmUgDQp0aGUgZGVzYyBzaXplIGNoZWNrIGluIHVmc2hjZC5jIGVudGlyZWx5LiAN
CkFyZSB5b3UgYWdyZWU/ICANCg0KUmVnYXJkcw0KQXJ0aHVyDQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJ0aHVyIFNpbWNoYWV2IDxBcnRodXIuU2ltY2hhZXZAd2Rj
LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjgsIDIwMjIgNTo0MiBQTQ0KPiBU
bzogQmVhbiBIdW8gPGh1b2JlYW5AZ21haWwuY29tPjsgbWFydGluLnBldGVyc2VuQG9yYWNsZS5j
b207DQo+IGJlYW5odW9AbWljcm9uLmNvbQ0KPiBDYzogbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IERhbmlpbCBMdW5ldg0KPiA8ZGx1bmV2
QGNocm9taXVtLm9yZz47IEF2cmkgQWx0bWFuIDxBdnJpLkFsdG1hbkB3ZGMuY29tPjsgQXZpDQo+
IFNoY2hpc2xvd3NraSA8QXZpLlNoY2hpc2xvd3NraUB3ZGMuY29tPg0KPiBTdWJqZWN0OiBSRTog
W1BBVENIXSBzY3NpOiB1ZnMtYnNnOiBSZW1vdmUgdWZzX2JzZ19nZXRfcXVlcnlfZGVzY19zaXpl
DQo+IGZ1bmN0aW9uDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBv
dXRzaWRlIG9mIFdlc3Rlcm4gRGlnaXRhbC4gRG8gbm90IGNsaWNrDQo+IG9uIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNlbmRlciBhbmQga25vdyB0
aGF0DQo+IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gQWdyZWUgd2l0aCB5b3UuIFdp
bGwgY2hhbmdlICYgc2VuZCB0aGUgcGF0Y2guDQo+IA0KPiBSZWdhcmRzDQo+IEFydGh1cg0KPiAN
Cj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEJlYW4gSHVvIDxodW9i
ZWFuQGdtYWlsLmNvbT4NCj4gPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyOCwgMjAyMiAx
OjM2IFBNDQo+ID4gVG86IEFydGh1ciBTaW1jaGFldiA8QXJ0aHVyLlNpbWNoYWV2QHdkYy5jb20+
Ow0KPiA+IG1hcnRpbi5wZXRlcnNlbkBvcmFjbGUuY29tOyBiZWFuaHVvQG1pY3Jvbi5jb20NCj4g
PiBDYzogbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IERhbmlpbCBMdW5ldg0KPiA+IDxkbHVuZXZAY2hyb21pdW0ub3JnPjsgQXZyaSBBbHRt
YW4gPEF2cmkuQWx0bWFuQHdkYy5jb20+OyBBdmkNCj4gPiBTaGNoaXNsb3dza2kgPEF2aS5TaGNo
aXNsb3dza2lAd2RjLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBzY3NpOiB1ZnMtYnNn
OiBSZW1vdmUgdWZzX2JzZ19nZXRfcXVlcnlfZGVzY19zaXplDQo+ID4gZnVuY3Rpb24NCj4gPg0K
PiA+IENBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgV2VzdGVy
biBEaWdpdGFsLiBEbyBub3QgY2xpY2sNCj4gPiBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cNCj4gdGhhdA0KPiA+IHRo
ZSBjb250ZW50IGlzIHNhZmUuDQo+ID4NCj4gPg0KPiA+IE9uIFdlZCwgMjAyMi0wOS0yOCBhdCAw
ODozMyArMDAwMCwgQXJ0aHVyIFNpbWNoYWV2IHdyb3RlOg0KPiA+ID4gSGkgQmVhbg0KPiA+ID4N
Cj4gPiA+IEluIGNhc2UgeW91IGRvbid0IGhhdmUgYW55IGNvbW1lbnRzIEkgd2lsbCBhcHByZWNp
YXRlIGlmIHlvdSB3aWxsIGFkZA0KPiA+ID4gInJldmlld2VkIGJ5IiB0byB0aGUgcGF0Y2guDQo+
ID4gPg0KPiA+ID4gUmVnYXJkcw0KPiA+ID4gQXJ0aHVyDQo+ID4NCj4gPg0KPiA+IEhpIEFydGh1
ciwNCj4gPg0KPiA+IEknbSB0aGlua2luZyB3ZSBzaG91bGQgcmVtb3ZlIHRoZSBkZXNjIHNpemUg
Y2hlY2sgaW4gdWZzaGNkLmMgZW50aXJlbHkuDQo+ID4gSnVzdCByZWFkIGFueSBkZXNjcmlwdG9y
IHdpdGggYSBtYXhpbXVtIHNpemUgb2YgUVVFUllfREVTQ19NQVhfU0laRSAuDQo+ID4gRm9yIHVz
ZXIgc3BhY2UgcXVlcmllcywgdWZzX2JzZyByZWFkcyBkYXRhIG9mIHRoZSBtYXhpbXVtIGxlbmd0
aCBhbmQNCj4gPiByZXR1cm5zIHRoZSByZXF1ZXN0ZWQgbGVuZ3RoIGRhdGEuIFRodXMgY2FuIGlt
cHJvdmUgY29kZSByZWFkYWJpbGl0eQ0KPiA+IGFuZCBzYXZlIENQVSBjeWNsZXMsIGFsc28gY2Fu
IGZpeCB5b3VyIGNvbmNlcm4uDQo+ID4NCj4gPiBJIGRvbid0IGtub3cgaG93IGFib3V0IG90aGVy
cycgb3Bpbmlvbj8NCj4gPg0KPiA+IEtpbmQgcmVnYXJkcywNCj4gPiBCZWFuDQo+ID4NCj4gPg0K
DQo=
