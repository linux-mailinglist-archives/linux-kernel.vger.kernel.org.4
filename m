Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A753C5E7424
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIWGav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiIWGaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:30:16 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC58427DC7;
        Thu, 22 Sep 2022 23:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663914586; x=1695450586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=v2iYqvCPRr/dGj/xWiETCjB9OLX80CoYbn7ickw0Fvw=;
  b=GD60H79d4xoH0cn3zPxE9Zxu4ZqjD9NkMGW0DH7eZFG1PUv0TUOcoEM8
   HBBMpza+iyQYC2Swks538zHDHPeaJ500yoe4ZgztbP2PoxX7EadKD2J5R
   8s1j5oP0C4PBd+WEzV2pwdky8/ei9dIPwFJkQT5frBx7pGJ809Me/TYAF
   ynDWYHvqJqQ27cNGlHf7g6P65c2xj4Hd7FZLHax7Xy7gKe30jCz/e4HnM
   Qzg2mQ+LHUtsXzZZT5Ri/JmKuJCZ2xhlMfBV2XBX1A2Ld+CifxeJcGnDC
   w13eByfFz9xKNuEVceK0usRyaZQUKFTiZA4vo5dv19Wsco37Sr5lKKQLQ
   w==;
X-IronPort-AV: E=Sophos;i="5.93,337,1654531200"; 
   d="scan'208";a="212093524"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2022 14:29:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFp6FQw0WKxELE05k0etYQPRBV1rqxb/SeUs4kXp1KLYO4euqFN32ali5gw3WTQpPbryjW/SkoRDWoP4PP6nOb1BeOe7SuToSNHpe+B37vibE58VXoPCXQ+I+MRWUmzOKZVdOHkJWB4DvBRLGN58uOHo/0T/ABNVFWOdmxjik9hdz901xULWjDffnsSecR0zjY5HV7IWw34QVVlTGGUXvJq53QtkvN7egId8tyno37klroosj2OkeHjjytn3l0ymjZQlLNV6ER4tu5lCR4aGr5r1sLMPeQ5TBKnIAXW+FAIza8ik0F2xKohVmKfdJrxiNleEPeRGHa+tD47WnZdXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2iYqvCPRr/dGj/xWiETCjB9OLX80CoYbn7ickw0Fvw=;
 b=IAyE9IfuI7JrvqCS0fY+TieI7B0n3UxjlNweWJlDlynRrtJ4UiIND/iqMaN6LwN6MP9bVLUr+1zx9v/zcPCt4FUpz/DQ0Fdd9dA5E3Oa05t0f468+outm2uM1KvEIakudjPG20zXnRlo3doPJgAoaX1yAMocuUlE3N1f7H7i8TsXVHaifnwn4xIn20sAXrdL5o1uyFJsrL0oYypnzKxj/YowKra40fadIsdV4GRsQ+wwaRcXLnq/4VFwdhOVTEH+Tk+EYEzUsq4UcEXHRkjtAKakK2lnWVVIuV9yu/UUK/TSUyUIBFUtT8zpT1prqRPERYrSv+UTTiOCy2stUTdFRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2iYqvCPRr/dGj/xWiETCjB9OLX80CoYbn7ickw0Fvw=;
 b=XKpQDvHVFUXtrY+gOWRc2foBlk9csWMBHkVucI7cVirHwnTI1HNuUC/RTZsaTlCS7HEvEkM9TgpfifqVj+ehUB6kObjvB1zn8n4Ixw1OdBLfvkoL8snQrIHRNjEbMvKiLWR4tDWhP9kK0DR9VvutGH2DCbnV1bz+raq82TFfE60=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by DM5PR04MB0395.namprd04.prod.outlook.com (2603:10b6:3:a7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.18; Fri, 23 Sep 2022 06:29:42 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::971b:edb2:b548:362e]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::971b:edb2:b548:362e%5]) with mapi id 15.20.5632.021; Fri, 23 Sep 2022
 06:29:42 +0000
From:   =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
CC:     "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>
Subject: RE: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Thread-Topic: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Thread-Index: AQHYzhW1Mb/B0wZcH0CBE49f2UQ9X63sIZgAgABnTfA=
Date:   Fri, 23 Sep 2022 06:29:41 +0000
Message-ID: <BYAPR04MB4968EB5E341049DFF973B9B1F1519@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
 <8fd1d8b1-9f43-eb03-4a7f-187723d1c483@acm.org>
In-Reply-To: <8fd1d8b1-9f43-eb03-4a7f-187723d1c483@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4968:EE_|DM5PR04MB0395:EE_
x-ms-office365-filtering-correlation-id: 6a1f9abb-662d-4ee6-9807-08da9d2cffbf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: StPIXNNFIg6qZ95lEXTtcJubeIvZaRaJuS6JhEZlkTzRrOQdjhxnGZBDdvrcL7EpV7igHp90jzZKPeIXpp2ubG/cFxzK0FGDdHot3kHCXOs8PDJK9nnPL1DCCGCdMGlwoupg21oJYLkm3vzLQk2JdajXAjCnWSm0pMZf1mLt09JqQbE+pQ5CufAab0mETwH6d7lEgYk5qOVOIefBAwBmAqCXPOihgDfeSyb8h1zwkvnmsoNbrAZXvXtBJju2qLByr7ESzB/RlY8oaTohnnOCohX2JnFCgv4p6PeY355yl3OafRjfKbyqHndGQeWCRm9nXfd68afaS9h4dBR03sSchrq7mTffd5BA2UIZyg66vaHNQpM9QWVqiDaRVhnFGLLeQc86zov1UtGKgLnOeRZuWeTrRmtiCaln736dYoUnLiIeTMbmAMw8DoE+l0rhEI/tKgDI+XGcXfUqgnIX3ti271otTCE23DpatxPt3d6iPyjfuMsR4lW/n36V9xxSjzBq3cd6Cq7mz44FevnkunuYuTqk2cFjUfi2xDYqeSwY2/e2p3F6pDpjwJ75QUakRg3HjfNGke2puWgj0D/TC5DcnobeYqMgVA+RtAjGnjMLx4ml/GLnE8K+C4qv49AkwS6MudaL0gUMJe+0HR7NnSjbVY3t3jE3jqMSHn1r+W1sW0vvdoke5lI+w8BHEjDI8N+KWGIoxssCVX2R5kyil8Zcke5/uRtVkwH7eNhCLmDZUduPtLxVE6KhtuhKY67CspzVJ5OwlZ8CZwpBIuYVGxLkDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4968.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199015)(55016003)(54906003)(71200400001)(82960400001)(110136005)(186003)(86362001)(38100700002)(2906002)(53546011)(5660300002)(7416002)(66556008)(66574015)(316002)(33656002)(66446008)(8936002)(66946007)(6506007)(7696005)(85202003)(9686003)(478600001)(83380400001)(76116006)(52536014)(38070700005)(66476007)(41300700001)(26005)(122000001)(4326008)(64756008)(8676002)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGVFbnAyU09mdUpBNWhXclNjWDduUUw4T0YrNFBEQjYrL1VhN24xSDBZUW1C?=
 =?utf-8?B?QUVFYUl0R1gxSnF4T1JIb1JpQVhhdERRSWZCUTJscVdia0s1aE9ENWpNcGJm?=
 =?utf-8?B?dDEzN2FjbHVuVit1Z21MVTRvY0E4NkU5Q0l0WXBuZllsSWxVVzNOTzh3eEFB?=
 =?utf-8?B?UE1DRlJJUWNVYThMV2FqN2xkOWNiVVFiMjRza0JESU9JcDYrSVhUZEorZzRu?=
 =?utf-8?B?SldNcmZUendtVkNTcGcyRmN5YWNpdmlHOW9NUTVNV2lDUmtBVE1Xa2s0Wkhs?=
 =?utf-8?B?U3l5YWozaUdjR25SS0Ivd0FHWnI4SlF5Vy9TUUljeWt5dVliMzRpVEkzV3RZ?=
 =?utf-8?B?dFdWZkcrZzZyUWRPVDFBNE1wUDg2TW5uV0hXanY0bERGZ1haeDU0VHd6N0hw?=
 =?utf-8?B?NmV6NFhiSkIxUjJnZGR2LzNremNtb1o4Y2U1TmIvUUVJSkxlYkRNeVhOZjRF?=
 =?utf-8?B?MVdiOEI5M3I3dUJlM0h2RHpVVzZNK0duNlNaeVRNdlF5L3Vsb28xMnE5bzZ1?=
 =?utf-8?B?U01wV1Q5Ymc3b0VzK2lvaENBdFNCOCtrRXpBNlFhcE5BYUgzdkpjUnVuL2lB?=
 =?utf-8?B?THZaZllIZjNHZlVSOVlOT1ZZUjZ6c0FHTDFua3BPWC9oby9mN3pudURvcVF0?=
 =?utf-8?B?ZjNsaXNWZFBEdE54NFM5YUtVZU12dWh6Z3ZlRkdyN2psYWhmNjVNQlJHVGdy?=
 =?utf-8?B?SGY0RzFiVzlQdXlsKzBmMmtwY2FyWGV0TkJlVXJwMWlDRWdRZ1o0U3dxTysr?=
 =?utf-8?B?Um9SMzhTcmhTdEpRamZZMnJxM0tlODA3SHBwODYzNG1iMkZoTk1ickIwcTVS?=
 =?utf-8?B?SFNIKzhVdnN2alR0R1VEaHRweGxJVU9haHh3c0FwMGpTTTVOUEhDQ2VaQ3N5?=
 =?utf-8?B?ZTFmVGlWZWhNT2lKZXh5SUI2cmxpa1BSRkRVMXhvR01ld3ZvS05QaUg2Y21V?=
 =?utf-8?B?a3FNQXlUY2NoU1JHQWszWEowZUxnRVI2UVBRWVJSU1NJUmdQOWVuK2kzblJ6?=
 =?utf-8?B?WGcyZGJrNzF4VFRWV04xTm5RYzhseDNaQ0xOZFMxUExEb2E2OXF2MG9zNC9H?=
 =?utf-8?B?cFBPRVAwbE5VVFF2OHVGcnNSemppd0h6QXZXRUIyd0tRcEFrUUo3MzlSeFI4?=
 =?utf-8?B?dXFtMzZPUUtXRUdUbjJPOVBpQUxLUndpc2haNjl5ZnVKL0dSOTJSRlk4VGV6?=
 =?utf-8?B?dW51SVh3bWV0bTF6L2Q2WjE5R2EwZlNzR095R3FjWFNHdXUxYjdBYXlId1FP?=
 =?utf-8?B?dkYrMU5jNFVzSnFLdDY0cENTMFMxRStPNVdPNTI5a2pBemtRVHFoVzhxdnkx?=
 =?utf-8?B?c3BQMWJKUktHUndBLzQwTjEvRHowVld4VzkvMjk0SVpnKzRXdHdhWDg0QlJ4?=
 =?utf-8?B?cStSRlkyaGR2Y1pYVXR4NHY5MHdDV2g2d3BjSDdIc3FlZ3poWUJ0UG9tSUFr?=
 =?utf-8?B?NEs2ZUVwa2l2dEt1WEtjZ3pUbDEzaTVYTWVBaUJRc2lkYjN0NDJPUDExcGxX?=
 =?utf-8?B?dk12TVVsSTVlakY2QkY5QkFBb0R4TXlaQ1FlL3FDRlhSdzZURURGVmR3UUFx?=
 =?utf-8?B?ZDdwdDFFcVFGMnhrNCtuN0dQMkY3QUlycmRDOVV4MHZHajFVT3B3T3MwendJ?=
 =?utf-8?B?NkxPNUJ3Y01QZHYydGp4YlBSQmRSSXo1MVVQR25sY3J5eGNVZGtod1RGS3JN?=
 =?utf-8?B?NGQrS2ZWbU1BVkwyZGRxcVR3elQyWFIrY1VLaXV6N0FRN1hON2R2aTNaQXVq?=
 =?utf-8?B?Z1EvLzQzVFNlSTVrSDFaTGt5R21mMEJTUW9EM29QNVBxb3RPbDhWVzN4bHpx?=
 =?utf-8?B?NHBwdnl4OSs2WGdOUm9BZWI5Rkp1ajBHTmpXTjErTXVHKzc5YUpycmpaQkJr?=
 =?utf-8?B?V081WFY3V1BxdEo0YnM5RXUySHQ0YkFKVGZxNXpuaU1ub1hVL3BrVlMvN09w?=
 =?utf-8?B?ck1pd244T1BqRUVpRHRDT25QcTBPanQ2eTdVWGJPUit3QnFPRFBxZFhUTytr?=
 =?utf-8?B?WS82dGRvaGFwVmw3MHVkSlZvR2cwMnk5cjViekhQaHdITFJ6ejdqem9uU2VE?=
 =?utf-8?B?QlVsZVh2WkxqQVhIV0Zzc0xEcGpSamcrWmduUWZFNXErWUJLTDU1UU5RWnZO?=
 =?utf-8?Q?sCdG2WAEJtxCMU3x3nKa2WE67?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1f9abb-662d-4ee6-9807-08da9d2cffbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 06:29:42.0902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5aRRx3fXll3UuhnKrMRjWxmp1RoQWZrmGWzhiXrU1pNbImagaRgDZ58IcdBgAKhUMDTzahV3RONbCavmRmKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0395
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2
YW5hc3NjaGVAYWNtLm9yZz4NCj4gU2VudDogRnJpZGF5LCAyMyBTZXB0ZW1iZXIgMjAyMiAwMS41
Ng0KPiBUbzogRGFtaWVuIExlIE1vYWwgPGRhbWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29t
PjsgTWlrZSBTbml0emVyDQo+IDxzbml0emVyQHJlZGhhdC5jb20+OyBQYW5rYWogUmFnaGF2IDxw
LnJhZ2hhdkBzYW1zdW5nLmNvbT4NCj4gQ2M6IGFna0ByZWRoYXQuY29tOyBzbml0emVyQGtlcm5l
bC5vcmc7IGF4Ym9lQGtlcm5lbC5kazsgaGNoQGxzdC5kZTsNCj4gcGFua3lkZXY4QGdtYWlsLmNv
bTsgZ29zdC5kZXZAc2Ftc3VuZy5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtYmxvY2tAdmdlci5rZXJuZWwu
b3JnOyBkbS0NCj4gZGV2ZWxAcmVkaGF0LmNvbTsgSm9oYW5uZXMgVGh1bXNoaXJuIDxKb2hhbm5l
cy5UaHVtc2hpcm5Ad2RjLmNvbT47DQo+IGphZWdldWtAa2VybmVsLm9yZzsgTWF0aWFzIEJqw7hy
bGluZyA8TWF0aWFzLkJqb3JsaW5nQHdkYy5jb20+DQo+IFN1YmplY3Q6IFJlOiBQbGVhc2UgZnVy
dGhlciBleHBsYWluIExpbnV4J3MgInpvbmVkIHN0b3JhZ2UiIHJvYWRtYXAgW3dhczogUmU6DQo+
IFtQQVRDSCB2MTQgMDAvMTNdIHN1cHBvcnQgem9uZWQgYmxvY2sgZGV2aWNlcyB3aXRoIG5vbi1w
b3dlci1vZi0yIHpvbmUNCj4gc2l6ZXNdDQo+IA0KPiBPbiA5LzIxLzIyIDE2OjU1LCBEYW1pZW4g
TGUgTW9hbCB3cm90ZToNCj4gPiBCdXQgYWdhaW4sIHRoYXQgYWxsIGRlcGVuZHMgb24gaWYgUGFu
a2FqIHBhdGNoIHNlcmllcyBpcyBhY2NlcHRlZCwNCj4gPiB0aGF0IGlzLCBvbiBldmVyeWJvZHkg
YWNjZXB0aW5nIHRoYXQgd2UgbGlmdCB0aGUgcG93ZXItb2YtMiB6b25lIHNpemUNCj4gY29uc3Ry
YWludC4NCj4gDQo+IFRoZSBjb21wYW5pZXMgdGhhdCBhcmUgYnVzeSB3aXRoIGltcGxlbWVudGlu
ZyB6b25lZCBzdG9yYWdlIGZvciBVRlMgZGV2aWNlcw0KPiBhcmUgYXNraW5nIGZvciBrZXJuZWwg
c3VwcG9ydCBmb3Igbm9uLXBvd2VyLW9mLTIgem9uZSBzaXplcy4NCj4gDQo+IFRoYW5rcywNCj4g
DQo+IEJhcnQuDQoNCkhpIEJhcnQsDQoNCldpdGggVUZTLCBpbiB0aGUgcHJvcG9zZWQgY29weSBJ
IGhhdmUgKG1heSBiZWVuIGNoYW5nZWQpIC0gdGhlcmUncyB0aGUgY29uY2VwdCBvZiBnYXAgem9u
ZXMsIHdoaWNoIGlzIHpvbmVzIHRoYXQgY2Fubm90IGJlIGFjY2Vzc2VkIGJ5IHRoZSBob3N0LiBU
aGUgZ2FwIHpvbmVzIGFyZSBlc3NlbnRpYWxseSAiTEJBIGZpbGxlcnMiLCBlbmFibGluZyB0aGUg
bmV4dCB3cml0ZWFibGUgem9uZSB0byBzdGFydCBhdCBhIFggKiBwb3cyIHNpemUgb2Zmc2V0LiBN
eSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhpcyBzcGVjaWZpYyBhcHByb2FjaCB3YXMgY2hvc2Vu
IHRvIHNpbXBsaWZ5IHN0YW5kYXJkaXphdGlvbiBpbiBVRlMgYW5kIGF2b2lkIHVwZGF0aW5nIFQx
MCdzIFpCQyB3aXRoIHpvbmUgY2FwYWNpdHkgc3VwcG9ydC4gDQoNCldoaWxlIFVGUyB3b3VsZCB0
ZWNobmljYWxseSBleHBvc2Ugbm9uLXBvd2VyIG9mIDIgem9uZSBzaXplcywgdGhleSdyZSBhbHNv
LCBkdWUgdG8gdGhlIGdhcCB6b25lcywgY291bGQgYWxzbyBiZSBjb25zaWRlcmVkIHBvd2VyIG9m
IDIgem9uZXMgaWYgb25lIGNvbnNpZGVycyB0aGUgc2VxLiB3cml0ZSB6b25lICsgdGhlIGdhcCB6
b25lIGFzIGEgc2luZ2xlIHVuaXQuIA0KDQpXaGVuIEkgdGhpbmsgYWJvdXQgaGF2aW5nIFVGUyBz
dXBwb3J0IGluIHRoZSBrZXJuZWwsIHRoZSBTV1IgYW5kIHRoZSBnYXAgem9uZSBjb3VsZCBiZSBy
ZXByZXNlbnRlZCBhcyBhIHNpbmdsZSB1bml0LiBGb3IgZXhhbXBsZToNCg0KVUZTIC0gWm9uZSBS
ZXBvcnQNCiAgWm9uZSAwOiBTV1IsIExCQSAwLTExDQogIFpvbmUgMTogR2FwLCBMQkEgMTItMTUN
CiAgWm9uZSAyOiBTV1IsIExCQSAxNi0yNw0KICBab25lIDM6IEdhcCwgTEJBIDI4LTMxDQogIC4u
Lg0KDQpLZXJuZWwgcmVwcmVzZW50YXRpb24gLSBab25lIFJlcG9ydCAoYXMgc3VwcG9ydGVkIHRv
ZGF5KQ0KICBab25lIDA6IFNXUiwgTEJBIDAtMTUsIFpvbmUgQ2FwYWNpdHkgMTINCiAgWm9uZSAx
OiBTV1IsIExCQSAxNi0zMSwgWm9uZSBDYXBhY2l0eSAxMg0KICAuLi4NCg0KSWYgZG9pbmcgaXQg
dGhpcyB3YXksIGl0IHJlbW92ZXMgdGhlIG5lZWQgZm9yIGZpbGVzeXN0ZW1zLCBkZXZpY2UtbWFw
cGVycywgdXNlci1zcGFjZSBhcHBsaWNhdGlvbnMgaGF2aW5nIHRvIHVuZGVyc3RhbmQgZ2FwIHpv
bmVzLCBhbmQgYWxsb3dzIFVGUyB0byB3b3JrIG91dCBvZiB0aGUgYm94IHdpdGggbm8gY2hhbmdl
cyB0byB0aGUgcmVzdCBvZiB0aGUgem9uZWQgc3RvcmFnZSBlY28tc3lzdGVtLiANCg0KSGFzIHRo
ZSBhYm92ZSByZXByZXNlbnRhdGlvbiBiZWVuIGNvbnNpZGVyZWQ/DQoNCkJlc3QsIE1hdGlhcw0K
