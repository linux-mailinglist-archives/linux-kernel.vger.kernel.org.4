Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48046AFFEA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 08:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCHHjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 02:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjCHHjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 02:39:11 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E594B2CFE1;
        Tue,  7 Mar 2023 23:38:57 -0800 (PST)
X-UUID: 46ac4a28bd8411eda06fc9ecc4dadd91-20230308
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gzp9fRbLCQyWYtExBgVDQg5o+ecwDyiOqrBaf8EXMco=;
        b=k+KYrZ1qTbCf2PwKexnjQQFhF292NXylRSbDrxHli2x3vPF9+gBMWFkmfr6i6Xu5CU1WOqZKOyRyaCiksOyPXg7Dyz/D2toI5OT2LzvcGtMd0GdAtYs9CUH2K6ka3ThyQnBUmfxfjDz08I7ZJemcZRnflQf1tUE/r+IkoQ47zFc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:d3b3d176-20d5-42c2-9e22-b2dab274f020,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:23
X-CID-INFO: VERSION:1.1.20,REQID:d3b3d176-20d5-42c2-9e22-b2dab274f020,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:28,RULE:Release_Ham,ACTION:
        release,TS:23
X-CID-META: VersionHash:25b5999,CLOUDID:003fb327-564d-42d9-9875-7c868ee415ec,B
        ulkID:230307172758IQBBNO8X,BulkQuantity:70,Recheck:0,SF:17|19|102,TC:nil,C
        ontent:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40|20,QS:nil,BEC:nil,COL:0,O
        SI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: 46ac4a28bd8411eda06fc9ecc4dadd91-20230308
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <kyrie.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2090710178; Wed, 08 Mar 2023 15:38:53 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 8 Mar 2023 15:38:52 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 8 Mar 2023 15:38:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1EQtcFDcIexaLO9SkRYEDsFdvqYyMgNy8PnP1IbuHJo8Ue0EmUxlG4raJ4tTewiG3Mkls0gDHiy8F1gNCf9WNgEeaF6us6wiv8MuL74dOB4UShZSOvZm4i/c7zQw2CF/X27rPyJ7gUSiiHAhhF+BsJkQ7IltPu5hDlF95Au0vgok+668/j/n6kSSi5UzlN72vtaIdU6szggs/9CdrNj9pxVTT9f1IJiHG3RP/FC9lF6QokY54fUWnaQPWqfxJWLPQxZzlqUqHzNbUXbXliUIG7W/hpyJ5XOMzdWOm/G3Fj4O6B2B51Ohym3/y7Ala8Ia8TEI0bmSjkf+udaLQJ6aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzp9fRbLCQyWYtExBgVDQg5o+ecwDyiOqrBaf8EXMco=;
 b=T6gNBXRBUwj5xliKUCMBz2Ofc+ITJzHm8Odooeg9tqjqeNf2gaXyxVNwH65lPnM3SocclXUVSh7+RYWQB/rWKIMeQ0baMsCD16kZ8McyAOyzC4/oHMHgRrpSOAavDtYT0tvxwGF3C+tUuJeum7fdkSXWZK1C0brdLFcz3IylJxeliphQOENiLs1VLP8irebFhLx7nsWFVOPkCU24o0OJEPWR4QRZim6cvv6D3dok56Re/TEiPsTzRAD9rag6bEJEPvuJxGjsFFXzl15e4U9zQEYAlc+jKzGokZ2etbAVQVVKzqrQt+9PqC04qfW6/9RUDEij5VoXZiLKQ2PLv7pGww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzp9fRbLCQyWYtExBgVDQg5o+ecwDyiOqrBaf8EXMco=;
 b=vGZsajFvHceaSaORSslDJqQ6gNSRWKldfn2IJnDhiTvLnlRUIPgHMlpdweCsAabt8fpgpvQtBitusifuewOoVgJxJlcfScwWHhQgpjBerzklvgf363cbYxIr0dLyvB1qub7X45FiaTXFOl0UxrACIkI1+Djtkd+q+Q6x4CL0ILY=
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com (2603:1096:301:b9::5)
 by SI2PR03MB6437.apcprd03.prod.outlook.com (2603:1096:4:1a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 07:38:49 +0000
Received: from PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::804e:d33a:c275:6d52]) by PUZPR03MB6186.apcprd03.prod.outlook.com
 ([fe80::804e:d33a:c275:6d52%8]) with mapi id 15.20.6156.028; Wed, 8 Mar 2023
 07:38:49 +0000
From:   =?utf-8?B?S3lyaWUgV3UgKOWQtOaZlyk=?= <Kyrie.Wu@mediatek.com>
To:     "hackerzheng666@gmail.com" <hackerzheng666@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "zyytlz.wz@163.com" <zyytlz.wz@163.com>,
        =?utf-8?B?QmluIExpdSAo5YiY5b2sKQ==?= <bin.liu@mediatek.com>,
        "alex000young@gmail.com" <alex000young@gmail.com>,
        =?utf-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "1395428693sheep@gmail.com" <1395428693sheep@gmail.com>
Subject: Re: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Topic: [RESEND PATCH] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Thread-Index: AQHZUNol+KoTCb2NbEShoW8BcHTMZK7vGQcAgABRWYCAALIggIAACusAgAAUAgCAACxIAIAAGJ4A
Date:   Wed, 8 Mar 2023 07:38:49 +0000
Message-ID: <0bf5c11128f96d820f8e3ffaf5e9402aa0c0a1a5.camel@mediatek.com>
References: <20230306062633.200427-1-zyytlz.wz@163.com>
         <CAJedcCzeVwwi9SkkwouFXUAVhF-tKF4dkqsFqVQwszSwY1SJ0A@mail.gmail.com>
         <57c17bfd-83f3-fcce-0eab-e28469fb0ced@collabora.com>
         <11c2bce1e5286ad3a9a5be2ee59c2beac168f135.camel@mediatek.com>
         <CAJedcCx13sz5h=fWvJU38P_1W-zd6yZe=iSMpO28_E_kAqUGDA@mail.gmail.com>
         <cfa2f64d2d01ffc53a6afdc9a5b867bbcb07b5f6.camel@mediatek.com>
         <CAJedcCwhk_XuMF8keGZGBTVBZSMuoQeyV_7L1H2VeT2x_vj-ZQ@mail.gmail.com>
         <86c98d73b0d294e143014ea5e15d0a5d065e1a66.camel@mediatek.com>
         <CAJedcCyiczZiKm=zQyYwJCszmEHKYX+sVEBx7UC082pS5K5Oww@mail.gmail.com>
In-Reply-To: <CAJedcCyiczZiKm=zQyYwJCszmEHKYX+sVEBx7UC082pS5K5Oww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR03MB6186:EE_|SI2PR03MB6437:EE_
x-ms-office365-filtering-correlation-id: 9269d139-24d2-4a0a-a806-08db1fa8284d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HklYWfsc1xlAnA6Pwyfy0IHVRrXnVx47b+yozUkNpr+M9sZPDM0gfaaj48BiV2Rd4Kakz+yPLDP3UJeRKnipcBsLD7MsQvM1dhs0ZnOljOqzuyBokuueOTt3p/1tbdv5XurzCpryg7n8T9uKFaO5zpjQW80gg4zkOo894dGTuU9G2p1YJ3bInFeg7lRNHWN5nltnmaYiwWnN/R4qix7OQdVI/eG0l6yWksy1VMJGvpLKrF8YU4ZEUSSUAtdnXLX0zmGHnaEN0peJ/Dh0ZIToLXGMWHXJECEGrVMm60ILKnB+bJBoYwQ85QcVG01FYt7Jw9X5R7820R1IiQ3Lkcnp2x9Nx0Sy+5GiCAYbRATaZjfSLap8pAfeTfgdX/TgG+/x1lPpV5Kytwe3OdNy/rCjJleyCNcsHM/G5/sKHdU4gHvFkwNv0gcosAsOoKTLVmAsRWAHo6XeEf4JnS3rBLQ1WP87nj7HAGJrLrPvT1Vr0BOLcJIcG1NXYEuUiJazyJtZwb0MCs4yE0dVOB4N/pDX9y73hOcIJ8ryY+QhXJJf/yRkPiKnjqprGOoyYtOi77WcCm8l26ymg6smyvZJTdTb964SaWE/BafbacV34OfHmtTIkbPnfnKQ6GhTLbAThZKo70efzpuMxoXwn3YtfdIPDZWEWFB/Nk5H5uAQrNGoynFNn/8M/XGNJ9U7Bry9TKiacqKt5SqO4a7VemRuGdgavA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR03MB6186.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199018)(83380400001)(36756003)(85182001)(26005)(54906003)(478600001)(122000001)(38100700002)(316002)(38070700005)(5660300002)(6512007)(2616005)(71200400001)(6486002)(41300700001)(6506007)(186003)(66476007)(66446008)(30864003)(76116006)(64756008)(4326008)(91956017)(7416002)(8936002)(66556008)(66946007)(2906002)(86362001)(6916009)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anBSdW1YNEhiMFB5VnFRT1ZwQ0I3WWNsNFZWN3BQYXUzU1RkbGZwMmdxSzFH?=
 =?utf-8?B?MUkwZUhYeDc3YTQ0bEptS0llaWhkQ0F2ajVUWVllSDg4NVdCT2NvM25JUStS?=
 =?utf-8?B?cEJHbDdCOHBLN2ZvWFlheXExNXdNeHpTZnc5a1dTcWpkTjNwcHJKb0FDQmJl?=
 =?utf-8?B?L1hJdUxnSjRFWnpTcnNWRW4vNGdkTUFIcjV5MmVEZyt5b3Ntc1owUVNRbmlC?=
 =?utf-8?B?UUQvTU81bi90ZFNFNGlTTmNyQTh3c0IwMWZFZ1pCKzJsVGp0VUwxYTYxMVcy?=
 =?utf-8?B?dnlwOW4yZGZvK2dRZGNnVXBCNU5uOFJLSFhMazkzczlKckFoK0Q0NncwQkha?=
 =?utf-8?B?UVN6REMxRklCVTRFZXZvQTBMMzFvdVQwVitycXYzZUNCbWhobXVYQWlLM1Rh?=
 =?utf-8?B?dzZUYlF1azJFbVFlWTI4NFRHcWhRZHg0bE13YXBmejhoMUFwTUVJM09iMWhw?=
 =?utf-8?B?UHpxSXBaNGk3dzBybmRYa01pYzFTSGRaNWptOEhlb2U0a1pVNWJWa1ZHZ3JS?=
 =?utf-8?B?MVExTU1nRU5kcjlqUnliNTdWRFdHRjBSY0xkZ2ZzQmIzdVVoZkJRaXltM0FW?=
 =?utf-8?B?dDl4cVM4ODZzOVB0TWZBZFVpSW1OZXFWb3k0MGxqYUhnYWVDdDUzd1kxeGk2?=
 =?utf-8?B?ZEJERjVrUE4xcUtnT0hQMTdBeWV6cGMrRkQ0cUxBTGY5U2pEaFdrL1hRMXU2?=
 =?utf-8?B?cGFKWWlCMi84TURYekRzTzZHbmZYYXk4eGZEMjB4UU0yNW5jYjA1M2FzcmlD?=
 =?utf-8?B?VWZocGR2dW1BNmZoaGZFU3VuSEkvNG9NWU96bjFOd3RGdy91SGxNUitxWXN4?=
 =?utf-8?B?R0dXV1pMSEpoTWx6WmxFcFRnQThzbTJtaGpNZXQ0RVRpMnJ5OWdKOGtaYWtx?=
 =?utf-8?B?ektzVlB3cWhybnlBRkR0SVlsczJqNy9STEJOTTU2eHUzemQxdzgyZjduVUxP?=
 =?utf-8?B?STF6NTNuRFlsZXkwdTRHa1gycldBdklxZExXOE1pZ2RDTHJ5cmRTUEdLaE5Q?=
 =?utf-8?B?bW82VEtYWWdNdnV1bHY3R0FlZEFLY21SS2pQS25tWnJ4QkxaeSt1MWtuZjJX?=
 =?utf-8?B?TnIycWRuSGpoeGJXWTNBT3hmM1lsSUNWNHhrSlc0UENPM3ZtZk5VZEEyRE1M?=
 =?utf-8?B?VlZCaVpSc3BGWnZoWmZQbkFiWUdFelQvM1VSdG5EWW1PNXRzdDRhYy9BTWRq?=
 =?utf-8?B?M0JxNmJhbkJlcDQzRHFKSkxpK2dzcG9CMm5qRytpcVNsbkpkVDNUS05qSTBT?=
 =?utf-8?B?T2JydFhDcGZJSHVEY1ZhSHc5KzZidkVEbjZUUHh3VCtKV2NNb3ZmNkR2MFMy?=
 =?utf-8?B?OG5QVTc3eUQ3cVhFTWY0WEdabXRta0ZQM2xtMDNzbUl5WWFmd3dLMFNnMWJt?=
 =?utf-8?B?L1FjVlZKNmdsd3U2SFgxUVp6VFhwN3pFWmNTTE53TWdYWXMwSGpUbTVEaWNX?=
 =?utf-8?B?dEY5Z2Z1djdFQjhHNEJjc1VOYVVJQTBoNWQvTWowS3U2aXZna2lhR0pyMHlD?=
 =?utf-8?B?UmlPMUxOZ1ptZStoSFpybWtBOCtrNkdwT3JiMStxeHlKcGExYzNOTGZjS3dP?=
 =?utf-8?B?ZWszazBObVhTTWtOUzB1dGNDYWV4ZHNTaXB2OVFsVENTRzluZzMxNFpJeU9r?=
 =?utf-8?B?SjIybFIyVEdpQWpaU0pQQnRnc01BWXRYSnR6NlhQT2ZSUjVYTUx2bHdpOTBv?=
 =?utf-8?B?UFcyaTY2UjFmLzhSWVR0enZSQ1FNYXM4YUw2RS9TS3FjWTk3elMzVW5PQUxJ?=
 =?utf-8?B?WjBzTGpuT0pEcDRLT1k2aXVQQzQ2aThYY0JQcGFuMEV4TDVKb2FnYmJxbnY0?=
 =?utf-8?B?VmJoTVk0cGxKQnBrMzNXanIvR2pQcldLVENhTzYyZnlLV2QrZmpsZVVjOEtY?=
 =?utf-8?B?S01kcjhNaHA2d21aMlF1THdZQmd0SmVia2M3YzRrb2liQUJlcDFwL3FFYWFo?=
 =?utf-8?B?cHZqQmJCSi9hclV1MlNBMHVEa3dTYjJtZlMvUDdCcCtSQXkrbFZSZHZEcDFY?=
 =?utf-8?B?N3VPODAvbE9SU2grVHVHQThUMGNaUUJxVjBCcjliRlU5cXBkNVp1YnBodUFj?=
 =?utf-8?B?QmwvNFpCeTJxTVpZTDVzUzgxZWJPWnQ0aTlGN2RTbGIrVGtYRkZ6UEwzeXQx?=
 =?utf-8?B?SWpmdEVoVFJyTlhmZ2ZDNFVqT0FLWXNUMGY3NlJ4WFBURnQyZE1GVDNQdXZy?=
 =?utf-8?B?ZXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <413D56CEE9934A4FBB9D6C5F519B8ACC@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR03MB6186.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9269d139-24d2-4a0a-a806-08db1fa8284d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 07:38:49.3889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJJin9JrlVjI11cAT1tf/dRh8as8lBZPIkS4tgIToxxTgX59YXNuvk0DeFryVbXS+ukduDIWtM8FO2RH4YbD7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6437
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTAzLTA4IGF0IDE0OjEwICswODAwLCBaaGVuZyBIYWNrZXIgd3JvdGU6DQo+
IEhpIEt5cmllLA0KPiANCj4gQWZ0ZXIgcmV2aWV3aW5nIHRoZSBjb2RlLCBJIGZvdW5kIGFub3Ro
ZSBwb3NzaWJsZSBjb2RlIHBhdGguIEFzIEkgYW0NCj4gbm90IGZhbWlsaWFyIHdpdGggdGhlIG1v
ZHVsZS4gSXQgaGFzIGhpZ2ggcG9zc2liaWxpdHkgaXQncyB3cm9uZy4NCj4gQ291bGQgcGxlYXNl
IGhlbHAgbWUgY2hlY2sgdGhpcz8gVmVyeSBtdWNoIGFwcHJlY2lhdGVkIGZvciB5b3VyDQo+IHZh
bHVhYmxlIHRpbWUuDQo+IA0KPiBJbiBzdW1tYXJ5LCBtdGtfanBlZ2RlY193b3JrZXIgd2FzIHNl
dCBpbiBtdGtfanBlZ19vcGVuIGFuZCBzdGFydGVkDQo+IGluDQo+IG10a19qcGVnX211bHRpY29y
ZV9kZWNfZGV2aWNlX3J1biwgd2hpY2ggbWFkZSBpdCBydW5uaW5nIG9uIGNwdTEuDQo+IEluc2lk
ZSB0aGUgbXRrX2pwZWdfbXVsdGljb3JlX2RlY19kZXZpY2VfcnVuLCBpdCB3aWxsIGNhbGwNCj4g
c2NoZWR1bGVfZGVsYXllZF93b3JrICB0byBzdGFydCB0aGUgdGltZW91dF93b3JrLCB3aGljaCB3
aWxsIG1ha2UgaXQNCj4gcnVubmluZyBvbiBjcHUyLiBNZWFud2hpbGUsIHdlIGNhbiBjYWxsDQo+
IG10a19qcGVnX3JlbGVhc2UgdG8gY2FuY2VsIHRoZSBqb2IuIEJ1dCB0aGVyZSBtaWdodCBiZSBh
IHJhY2UgYmV0d2Vlbg0KPiBtdGtfanBlZ2RlY193b3JrZXIgYW5kIHY0bDJfbTJtX2NhbmNlbF9q
b2IuIEl0IG1heSBjYWxsDQo+IHY0bDJfbTJtX2pvYl9maW5pc2ggdG9vIGVhcmx5IHRvIHdha2Ug
dXAgdGhlIGV2ZW50Lg0KPiBUaGUgcmVtb3ZlIHdpbGwgZ28gb24sIHRoZSBvdGhlciByYWNlIGlz
IGFzIGRlc2NyaWJlZCBlYXJsaWVyLg0KPiANCj4gY3B1MCAgICAgICAgICAgICAgICAgICAgICAg
ICBjcHUxICAgICAgICAgICAgICAgICAgY3B1Mg0KPiAoMSktPmRldmljZV9ydW4NCj4gbXRrX2pw
ZWdfbXVsdGljb3JlDQo+IF9kZWNfZGV2aWNlX3J1bg0KPiBxdWV1ZV93b3JrDQo+IChqcGVnLT53
b3JrcXVldWUsDQo+ICZjdHgtPmpwZWdfd29yayk7DQo+ICAgICAgICAgICAgICAgICAgICAgICAo
MiltdGtfanBlZ2RlY193b3JrZXINCj4gKDMpbXRrX2pwZWdfcmVsZWFzZQ0KPiB2NGwyX20ybV9j
YW5jZWxfam9iDQo+IHdhaXQgZXZlbnQNCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICBzY2hl
ZHVsZV9kZWxheWVkX3dvcmsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAoNCltdGtfanBlZ19qb2JfdGltZW91dF93DQo+IG9yaw0KPiAgICAgICAgICAgICAg
ICAgICAgICAgKDUpdjRsMl9tMm1fam9iX2ZpbmlzaA0KPiAgICAgICAgICAgICAgICAgICAgICAg
d2FrZSB1cA0KPiAoNiltdGtfanBlZ19yZW1vdmUNCj4gdjRsMl9tMm1fcmVsZWFzZQ0KPiBrZnJl
ZShtMm1fZGV2KQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICg3KXY0bDJfbTJtX2dldF9jdXJyX3ByaXYNCj4gDQpEZWFyIHpoZW5nLA0KDQpUaGUgbXRrX2pw
ZWdfbXVsdGljb3JlX2RlY19kZXZpY2VfcnVuIGZ1bmN0aW9uIGlzIHVzZWQgZm9yIG11bHRpLWh3
DQpqcGVnIGRlY29kaW5nLiBJbnN0ZWFkIG9mIHNjaGVkdWxpbmcgbXRrX2pwZWdfam9iX3RpbWVv
dXRfd29yaywNCm10a19qcGVnZGVjX3dvcmtlciBpcyBzY2hlZHVsZWQgaW4gdGhpcyBmdW5jdGlv
bi4NCg0KVGhlIG10a19qcGVnX2RlY19kZXZpY2VfcnVuIGZ1bmN0aW9uIGlzIHVzZWQgZm9yIHNp
bmdsZSBodyBqcGVnDQpkZWNvZGluZywgd2hpY2ggc2NoZWR1bGVzIG10a19qcGVnX2pvYl90aW1l
b3V0X3dvcmsuDQoNCkEgZHJpdmVyIGlzIGVpdGhlciBhIHNpbmdsZSBodyBkcml2ZXIgb3IgYSBt
dWx0aS1odyBkcml2ZXIgYW5kIGNhbm5vdA0KcmVwcmVzZW50IGJvdGggYXQgdGhlIHNhbWUgdGlt
ZS4gDQptdGtfanBlZ19qb2JfdGltZW91dF93b3JrIGFuZCBtdGtfanBlZ2RlY193b3JrZXIgY2Fu
bm90IGJlIHNjaGVkdWxlZCBhdA0KdGhlIHNhbWUgdGltZS4gDQpTbyBtdGtfanBlZ19qb2JfdGlt
ZW91dF93b3JrIGNhbGxzIHY0bDJfbTJtX2pvYl9maW5pc2ggd291bGQgbm90IGNhdXNlDQpjb21w
ZXRpdGlvbiBiZXR3ZWVuIHRoZSBtdGtfanBlZ2RlY193b3JrZXIgYW5kIHY0bDJfbTJtX2NhbmNl
bF9qb2IuDQoNClJlZ2FyZHMsDQpLeXJpZS4NCg0KDQo+IEt5cmllIFd1ICjlkLTmmZcpIDxLeXJp
ZS5XdUBtZWRpYXRlay5jb20+IOS6jjIwMjPlubQz5pyIOOaXpeWRqOS4iSAxMTozMuWGmemBk++8
mg0KPiA+IA0KPiA+IE9uIFdlZCwgMjAyMy0wMy0wOCBhdCAxMDoyMCArMDgwMCwgWmhlbmcgSGFj
a2VyIHdyb3RlOg0KPiA+ID4gSGkgS3lyaWUsDQo+ID4gPiANCj4gPiA+IFRoYW5rIHlvdSBmb3Ig
eW91ciBjYXJlZnVsIGFuYWx5c2lzIGFuZCByZXNwb25zZS4gSSBzdGlsbCBoYXZlDQo+ID4gPiBz
b21lDQo+ID4gPiBhcmVhcyB0aGF0IEkgZG9uJ3QgcXVpdGUgdW5kZXJzdGFuZCBhbmQgd291bGQg
bGlrZSB0byBhc2sgZm9yDQo+ID4gPiBjbGFyaWZpY2F0aW9uLiBUaGF0IGlzLCBob3cgZG8gdGhl
IGZ1bmN0aW9uIHBvaW50ZXJzIGZvciBzdG9wDQo+ID4gPiBzdHJlYW1pbmcsIGluaXRpYWxpemVk
IGFzIG10a19qcGVnX2VuY19zdG9wX3N0cmVhbWluZyBhbmQNCj4gPiA+IG10a19qcGVnX2RlY19z
dG9wX3N0cmVhbWluZywgZW5zdXJlIHRoYXQgdGhlIHdvcmtlciBpcyBjYW5jZWxlZD8NCj4gPiA+
IEkNCj4gPiA+IHdvdWxkIGdyZWF0bHkgYXBwcmVjaWF0ZSB5b3VyIHJlc3BvbnNlLg0KPiA+ID4g
DQo+ID4gPiBCZXN0IHJlZ2FyZHMsDQo+ID4gPiBaaGVuZw0KPiA+IA0KPiA+IERlYXIgemhlbmcs
DQo+ID4gDQo+ID4gRm9yIHN0b3Agc3RyZWFtaW5nLCB3aGF0IEkgbWVhbiBpcyB0aGF0IHN0b3Bw
cGluZyBqcGVnIGRlY29kaW5nIG9yDQo+ID4gZW5jb2RpbmcuDQo+ID4gT2ssIGxldCBtZSBpbnRy
b2R1Y2UgdGhlIHN3IGZsb3cgb2Ygc3RvcCBzdHJlYW1pbmc6DQo+ID4gRmlyc3RseSwgdGhlIGFw
cCB3aWxsIGNhbGwgdjRsMl9tMm1faW9jdGxfc3RyZWFtb2ZmLCB3aGljaCB3aWxsDQo+ID4gY2Fs
bA0KPiA+IHY0bDJfbTJtX2NhbmNlbF9qb2IsIGlmIGl0IGZpbmRzIGEgam9iIHJ1bm5pbmcoYXMg
eW91IG5vdGUsIGNwdTEgaXMNCj4gPiBydW5uaW5nKSwgaXQgd2lsbCB3YWl0IGV2ZW50LCB0aGUg
ZXZlbnQgaXMgd2FrZSB1cCBieQ0KPiA+IHY0bDJfbTJtX2pvYl9maW5pc2ggZnVuY3Rpb24uIEFu
ZCB2NGwyX20ybV9qb2JfZmluaXNoIGlzIGNhbGxlZCBieQ0KPiA+IGpwZWcNCj4gPiBkZWMvZW5j
IGlycSBoYW5kbGVyLCB3aGljaCBtZWFucyB0aGF0IHRoZSB3YWl0dGluZyB3b3VsZCByZXN1bHQg
bXRrDQo+ID4gaHcNCj4gPiB0byBmaW5pc2ggZGVjL2VuYywgaXJxIHdpbGwgb2NjdXIgYW5kIGly
cSBoYW5kbGVyIHdvdWxkIGNhbmNlbA0KPiA+IHRpbWVvdXQNCj4gPiB3b3JrZXIuIFRoZSBmb2xs
b3cgaXMgc2hvd24gYXMgYmxvdy4NCj4gPiB2NGwyX20ybV9pb2N0bF9zdHJlYW1vZmYNCj4gPiAg
ICB2NGwyX20ybV9jYW5jZWxfam9iICAgICAgICAgICAgICAgIG10a19qcGVnX2VuY19pcnEvbXRr
X2pwZWdfZGVjDQo+ID4gX2lycQ0KPiA+ICAgICAgICB3YWl0IGV2bmV0IDwtLS0tLS0gd2FrZSB1
cCAtLS0tLS12NGwyX20ybV9qb2JfZmluaXNoDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGNhbmNlbCB0aW1lb3V0IHdvcmsNCj4gPiANCj4gPiBBcyBtZW50aW9u
ZWQgYWJvdmUsIGlmIGl0IGlzIG5vcm1hbCBzdG9wIHN0cmVhbWluZyBhY3Rpb24sIHRoZXJlDQo+
ID4gd2lsbA0KPiA+IGJlIG5vIGhhcHBlbiB0aGF0IHRoZSB0aW1lb3V0IHdvcmtlciBkb2VzIG5v
dCBjYW5jZWxlZC4NCj4gPiANCj4gPiBCdXQgaWYgbXRrX2pwZWdfcmVtb3ZlIGlzIGNhbGxlZCBk
aXJlY3RseSB3aXRob3V0IGFib3ZlIGZsb3csIGl0DQo+ID4gd291bGQNCj4gPiBjYXVzZSBsb3Rz
IG9mIGlzc3Vlcy4NCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IEt5cmllLg0KPiA+ID4gDQo+ID4g
PiBLeXJpZSBXdSAo5ZC05pmXKSA8S3lyaWUuV3VAbWVkaWF0ZWsuY29tPiDkuo4yMDIz5bm0M+ac
iDjml6XlkajkuIkgMTA6MDLlhpnpgZPvvJoNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFR1ZSwgMjAy
My0wMy0wNyBhdCAyMzowMyArMDgwMCwgWmhlbmcgSGFja2VyIHdyb3RlOg0KPiA+ID4gPiA+IFRo
ZSB0aW1lciBmdW5jdGlvbiB3YXMgc2V0IGluIG10a19qcGVnX3Byb2JlIHdpdGgNCj4gPiA+ID4g
PiBtdGtfanBlZ19qb2JfdGltZW91dF93b3JrIGZ1bmN0aW9uLg0KPiA+ID4gPiA+IEFuZCB0aGUg
d29ya2VyIGlzIHN0YXJ0ZWQgaW4gbXRrX2pwZWdfZGVjX2RldmljZV9ydW4uDQo+ID4gPiA+ID4g
VGhlcmUgYXJlIHR3byBmdW5jdGlvbnMgKG10a19qcGVnX2VuY19pcnEgYW5kDQo+ID4gPiA+ID4g
bXRrX2pwZWdfZGVjX2lycSkNCj4gPiA+ID4gPiB3aGljaA0KPiA+ID4gPiA+IG1heSBjYW5jZWwg
dGhlIHdvcmtlci4NCj4gPiA+ID4gPiBUaGV5IGFyZSB1c2VkIGFzIElSUSBoYW5kbGVyIGZ1bmN0
aW9uIHdoaWNoIGlzIHNhdmVkIGFzDQo+ID4gPiA+ID4gZnVuY3Rpb24NCj4gPiA+ID4gPiBwb2lu
dGVyIGluIGEgdmFyaWFibGUuDQo+ID4gPiA+ID4gSW4gbXRrX2pwZWdfcHJvYmUsIHRoZXkgYXJl
IHJlZ2lzdGVyZWQgYnkgZGV2bV9yZXF1ZXN0X2lycToNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBy
ZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsDQo+ID4gPiA+ID4gICAgICAgICAgICAg
ICAganBlZ19pcnEsDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAganBlZy0+dmFyaWFudC0+aXJx
X2hhbmRsZXIsDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgMCwNCj4gPiA+ID4gPiAgICAgICAg
ICAgICAgICBwZGV2LT5uYW1lLCBqcGVnKTsNCj4gPiA+ID4gPiAgICAgaWYgKHJldCkgew0KPiA+
ID4gPiA+ICAgICAgIGRldl9lcnIoJnBkZXYtPmRldiwgIkZhaWxlZCB0byByZXF1ZXN0IGpwZWdf
aXJxICVkDQo+ID4gPiA+ID4gKCVkKVxuIiwNCj4gPiA+ID4gPiAgICAgICAgIGpwZWdfaXJxLCBy
ZXQpOw0KPiA+ID4gPiA+ICAgICAgIHJldHVybiByZXQ7DQo+ID4gPiA+ID4gICAgIH0NCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBIb3dldmVyLCBpZiB3ZSByZW1vdmUgdGhlIG1vZHVsZSB3aXRob3V0
IHRyaWdnZXJpbmcgdGhlIGlycSwNCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiB3b3JrZXIgd2ls
bCBuZXZlciBiZSByZW1vdmVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IEFzIGZvciB0aGUgc2No
ZWR1bGUsIG10a19qcGVnX2RlY19kZXZpY2VfcnVuIGFuZA0KPiA+ID4gPiA+IG10a19qcGVnX2Vu
Y19kZXZpY2VfcnVuIHdpbGwgc3RhcnQgdGhlIHdvcmtlci4NCj4gPiA+ID4gPiBUaGUgc2NoZWR1
bGUgaW52b2tpbmcgaXMgcXVpdGUgY29tcGxpY2F0ZWQuIEFzIGZhciBhcyBJIGtub3csDQo+ID4g
PiA+ID4gdGhlDQo+ID4gPiA+ID4gaW52b2tpbmcgY2hhaW4gaXMgYXMgZm9sbG93czoNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiB2NGwyX20ybV9pbml0LT52NGwyX20ybV9kZXZpY2VfcnVuX3dvcmst
PnY0bDJfbTJtX3RyeV9ydW4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiB0aGUgdjRsMl9tMm1fZGV2
aWNlX3J1bl93b3JrIGZ1bmN0aW9uIGlzIGFsc28gYSB3b3JrZXIgd2hpY2gNCj4gPiA+ID4gPiBp
cw0KPiA+ID4gPiA+IHNldA0KPiA+ID4gPiA+IGluDQo+ID4gPiA+ID4gdjRsMl9tMm1faW5pdCBh
bmQgc3RhcnRlZCBpbg0KPiA+ID4gPiA+IHY0bDJfbTJtX3NjaGVkdWxlX25leHRfam9iLg0KPiA+
ID4gPiA+IA0KPiA+ID4gPiA+IEJlZm9yZSBjYWxsaW5nIHJlbW92ZSBmdW5jdGlvbiwgdGhlICBt
dGtfanBlZ19yZWxlYXNlIHdhcw0KPiA+ID4gPiA+IGludm9rZWQNCj4gPiA+ID4gPiB0bw0KPiA+
ID4gPiA+IHJlbGVhc2UgdGhlIHJlbGF0ZWQgcmVzb3VyY2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gdjRsMl9tMm1fY2FuY2VsX2pvYiB3aWxsIGNhbmNlbCB0aGUgam9iIGJ5IGNhbGxpbmcNCj4g
PiA+ID4gPiBtMm1fZGV2LT5tMm1fb3BzLT5qb2JfYWJvcnQobTJtX2N0eC0+cHJpdikuDQo+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gQnV0IHRoaXMgd2lsbCBvbmx5IGNhbmNlbCB0aGUgY3VycmVudCBx
dWV1ZSBieQ0KPiA+ID4gPiA+IGxpc3RfZGVsKCZtMm1fZGV2LT5jdXJyX2N0eC0+cXVldWUpOw0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IEkgdGhpbmsgdGhpcyBjYW4gbm90IGNhbmNlbCB0aGUgcG9z
dGVkIHRhc2sgbWVudGlvbmVkIGJlZm9yZS4NCj4gPiA+ID4gPiBTbw0KPiA+ID4gPiA+IEkNCj4g
PiA+ID4gPiB0aGluayBpZiBtdGtfanBlZ19qb2JfdGltZW91dF93b3JrDQo+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gaXMgd29ya2luZyBvbiwgYW5kIHVzaW5nIGpwZWctPm0ybV9kZXYgYWZ0ZXIgZnJl
ZWluZyBpdCBpbg0KPiA+ID4gPiA+IG10a19qcGVnX3JlbW92ZSwgaXQgd2lsbCBjYXVzZSBhIFVB
RiBidWcuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gc3RhdGljIGludCBtdGtfanBlZ19yZWxlYXNl
KHN0cnVjdCBmaWxlICpmaWxlKQ0KPiA+ID4gPiA+IHsNCj4gPiA+ID4gPiAgIHN0cnVjdCBtdGtf
anBlZ19kZXYgKmpwZWcgPSB2aWRlb19kcnZkYXRhKGZpbGUpOw0KPiA+ID4gPiA+ICAgc3RydWN0
IG10a19qcGVnX2N0eCAqY3R4ID0gbXRrX2pwZWdfZmhfdG9fY3R4KGZpbGUtDQo+ID4gPiA+ID4g
PiBwcml2YXRlX2RhdGEpOw0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+ICAgbXV0ZXhfbG9jaygmanBl
Zy0+bG9jayk7DQo+ID4gPiA+ID4gICB2NGwyX2N0cmxfaGFuZGxlcl9mcmVlKCZjdHgtPmN0cmxf
aGRsKTsNCj4gPiA+ID4gPiAgIFsxXSB2NGwyX20ybV9jdHhfcmVsZWFzZShjdHgtPmZoLm0ybV9j
dHgpOw0KPiA+ID4gPiA+ICAgdjRsMl9maF9kZWwoJmN0eC0+ZmgpOw0KPiA+ID4gPiA+ICAgdjRs
Ml9maF9leGl0KCZjdHgtPmZoKTsNCj4gPiA+ID4gPiAgIGtmcmVlKGN0eCk7DQo+ID4gPiA+ID4g
ICBtdXRleF91bmxvY2soJmpwZWctPmxvY2spOw0KPiA+ID4gPiA+ICAgcmV0dXJuIDA7DQo+ID4g
PiA+ID4gfQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IHZvaWQgdjRsMl9tMm1fY3R4X3JlbGVhc2Uo
c3RydWN0IHY0bDJfbTJtX2N0eCAqbTJtX2N0eCkNCj4gPiA+ID4gPiB7DQo+ID4gPiA+ID4gICAv
KiB3YWl0IHVudGlsIHRoZSBjdXJyZW50IGNvbnRleHQgaXMgZGVxdWV1ZWQgZnJvbQ0KPiA+ID4g
PiA+IGpvYl9xdWV1ZSAqLw0KPiA+ID4gPiA+ICAgWzJdIHY0bDJfbTJtX2NhbmNlbF9qb2IobTJt
X2N0eCk7DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gICB2YjJfcXVldWVfcmVsZWFzZSgmbTJtX2N0
eC0+Y2FwX3FfY3R4LnEpOw0KPiA+ID4gPiA+ICAgdmIyX3F1ZXVlX3JlbGVhc2UoJm0ybV9jdHgt
Pm91dF9xX2N0eC5xKTsNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAgIGtmcmVlKG0ybV9jdHgpOw0K
PiA+ID4gPiA+IH0NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBOb3RlIHRoYXQgYWxsIG9mIHRoaXMg
aXMgc3RhdGljIGFuYWx5c2lzLCB3aGljaCBtYXkgYmUgZmFsc2UNCj4gPiA+ID4gPiBwb3NpdGl2
ZS4NCj4gPiA+ID4gPiBGZWVsIGZyZWUgdG8gdGVsbCBtZSBpZiB0aGVyZSBpcyBzb21ldGhpbmcg
SSd2ZSBtaXNzZWQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gUmVnYXJkLA0KPiA+ID4gPiA+IFpo
ZW5nDQo+ID4gPiA+IA0KPiA+ID4gPiBEZWFyIFpoZW5nLA0KPiA+ID4gPiANCj4gPiA+ID4gWW91
IHNldCB1cCBhbiBhcHBsaWNhdGlvbiBzY2VuYXJpbzoNCj4gPiA+ID4gY3B1MSBpcyB1c2luZyB0
aGUgbXRrLWpwZWcgZHJpdmVyIGFuZCB0aW1lb3V0IHdvcmsgaGFzIGJlZW4NCj4gPiA+ID4gc2No
ZWR1bGVkLg0KPiA+ID4gPiBBdCB0aGUgc2FtZSB0aW1lIGNwdTAgd2FudGVkIHRvIHJlbW92ZSB0
aGUgbXRrLWpwZWcgZHJpdmVyLA0KPiA+ID4gPiB3aGljaA0KPiA+ID4gPiBjYXVzZWQgdGhlIFVB
RiBidWcuDQo+ID4gPiA+IEkgd29uZGVyIGlmIHN1Y2ggYW4gaXJyYXRpb25hbCBhcHBsaWNhdGlv
biBzY2VuYXJpbyBjb3VsZA0KPiA+ID4gPiBleGlzdC4NCj4gPiA+ID4gVGhpcw0KPiA+ID4gPiBz
Y2VuYXJpbywgYXMgeW91IGRlc2NyaWJlZCwgbm90IG9ubHkgbGVhZHMgdG8gdGhlIHByb2JsZW1z
IHlvdQ0KPiA+ID4gPiBtZW50aW9uZWQsIGJ1dCBhbHNvIHRvIG91dHB1dCZjYXB0dXJlIG1lbW9y
eSBsZWFrcyBhbmQNCj4gPiA+ID4gdW5yZWxlYXNlZA0KPiA+ID4gPiByZXNvdXJjZXMsIHN1Y2gg
YXMgc3BpbmxvY2suDQo+ID4gPiA+IFR5cGljYWxseSwgaWYgd2Ugd2FudCB0byByZW1vdmUgdGhl
IGRyaXZlciwgd2UgZmlyc3RseSBkbyBzdG9wDQo+ID4gPiA+IHN0cmVhbWluZywgd2hpY2ggZW5z
dXJlcyB0aGF0IHRoZSB3b3JrZXIgaGFzIGJlZW4gY2FuY2VsZWQuDQo+ID4gPiA+IEkgYWdyZWUg
d2l0aCB5b3VyIGNoYW5nZXMgZnJvbSB0aGUgcGVyc3BlY3RpdmUgb2Ygc3RyZW5ndGhlbmluZw0K
PiA+ID4gPiB0aGUNCj4gPiA+ID4gcm9idXN0bmVzcyBvZiB0aGUgZHJpdmVyIGNvZGUuDQo+ID4g
PiA+IA0KPiA+ID4gPiBSZWdhcmRzLA0KPiA+ID4gPiBLeXJpZS4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBJcnVpIFdhbmcgKOeOi+eRnikgPElydWkuV2FuZ0BtZWRpYXRlay5jb20+IOS6jjIwMjPl
ubQz5pyIN+aXpeWRqOS6jCAxODoyM+WGmemBk++8mg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiBEZWFyIEFuZ2VsbyBhbmQgWmhlbmcsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoYW5r
cyBmb3IgeW91ciBwYXRjaCBhbmQgY29tbWVudHMuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IERlYXIgS3lyaWUsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFBsZWFzZSBoZWxwIHRvIGNo
ZWNrIHRoaXMsIHRoYW5rcy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQmVzdCBSZWdhcmRz
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IE9uIFR1ZSwgMjAyMy0wMy0wNyBhdCAxMDo0OSAr
MDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwNCj4gPiA+ID4gPiA+IFJlZ25vDQo+ID4gPiA+ID4g
PiB3cm90ZToNCj4gPiA+ID4gPiA+ID4gSWwgMDcvMDMvMjMgMTA6MjcsIFpoZW5nIEhhY2tlciBo
YSBzY3JpdHRvOg0KPiA+ID4gPiA+ID4gPiA+IEhpLA0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiA+IElzIHRoZXJlIGFueW9uZSB3aG8gY2FuIGhlbHAgd2l0aCB0aGlzPyBJIGNhbiBw
cm92aWRlDQo+ID4gPiA+ID4gPiA+ID4gbW9yZQ0KPiA+ID4gPiA+ID4gPiA+IGRldGFpbHMNCj4g
PiA+ID4gPiA+ID4gPiBsaWtlIGludm9raW5nIGNoYWluIGlmIG5lZWRlZC4NCj4gPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFByb3ZpZGluZyBtb3JlIGRldGFp
bHMgaXMgYWx3YXlzIGdvb2QuIFBsZWFzZSBkby4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+IE1lYW53aGlsZSwgYWRkaW5nIElydWkgV2FuZyB0byB0aGUgbG9vcDogaGUncyBkb2luZyBt
dGstDQo+ID4gPiA+ID4gPiA+IGpwZWcuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBS
ZWdhcmRzLA0KPiA+ID4gPiA+ID4gPiBBbmdlbG8NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
PiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+ID4gPiA+IFpoZW5nDQo+ID4gPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiA+ID4gWmhlbmcgV2FuZyA8enl5dGx6Lnd6QDE2My5jb20+IOS6jjIwMjPlubQz
5pyINuaXpeWRqOS4gCAxNDoyOOWGmemBk++8mg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiA+ID4gPiBJbiBtdGtfanBlZ19wcm9iZSwgJmpwZWctPmpvYl90aW1lb3V0X3dvcmsgaXMg
Ym91bmQNCj4gPiA+ID4gPiA+ID4gPiA+IHdpdGgNCj4gPiA+ID4gPiA+ID4gPiA+IG10a19qcGVn
X2pvYl90aW1lb3V0X3dvcmsuIFRoZW4NCj4gPiA+ID4gPiA+ID4gPiA+IG10a19qcGVnX2RlY19k
ZXZpY2VfcnVuDQo+ID4gPiA+ID4gPiA+ID4gPiBhbmQgbXRrX2pwZWdfZW5jX2RldmljZV9ydW4g
bWF5IGJlIGNhbGxlZCB0byBzdGFydA0KPiA+ID4gPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4g
PiA+ID4gPiB3b3JrLg0KPiA+ID4gPiA+ID4gPiA+ID4gSWYgd2UgcmVtb3ZlIHRoZSBtb2R1bGUg
d2hpY2ggd2lsbCBjYWxsDQo+ID4gPiA+ID4gPiA+ID4gPiBtdGtfanBlZ19yZW1vdmUNCj4gPiA+
ID4gPiA+ID4gPiA+IHRvIG1ha2UgY2xlYW51cCwgdGhlcmUgbWF5IGJlIGEgdW5maW5pc2hlZCB3
b3JrLiBUaGUNCj4gPiA+ID4gPiA+ID4gPiA+IHBvc3NpYmxlIHNlcXVlbmNlIGlzIGFzIGZvbGxv
d3MsIHdoaWNoIHdpbGwgY2F1c2UgYQ0KPiA+ID4gPiA+ID4gPiA+ID4gdHlwaWNhbCBVQUYgYnVn
Lg0KPiA+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gPiBGaXggaXQgYnkgY2FuY2Vs
aW5nIHRoZSB3b3JrIGJlZm9yZSBjbGVhbnVwIGluIHRoZQ0KPiA+ID4gPiA+ID4gPiA+ID4gbXRr
X2pwZWdfcmVtb3ZlDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IENQVTAg
ICAgICAgICAgICAgICAgICBDUFUxDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgIHxtdGtfanBlZ19qb2JfdGltZW91dF93b3JrDQo+ID4g
PiA+ID4gPiA+ID4gPiBtdGtfanBlZ19yZW1vdmUgICAgIHwNCj4gPiA+ID4gPiA+ID4gPiA+ICAg
IHY0bDJfbTJtX3JlbGVhc2UgIHwNCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAga2ZyZWUobTJtX2Rl
dik7IHwNCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiA+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgIHwgdjRsMl9tMm1fZ2V0X2N1cnJfcHJpdg0K
PiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgfCAgIG0ybV9kZXYtPmN1cnJf
Y3R4IC8vdXNlDQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFpoZW5nIFdhbmcgPHp5eXRsei53ekAxNjMuY29tPg0KPiA+ID4gPiA+ID4gPiA+ID4g
LS0tDQo+ID4gPiA+ID4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gPiA+ID4gPiBkcml2ZXJzL21lZGlh
L3BsYXRmb3JtL21lZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS5jDQo+ID4gPiA+ID4gPiA+ID4g
PiB8DQo+ID4gPiA+ID4gPiA+ID4gPiAyICstDQo+ID4gPiA+ID4gPiA+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gPiA+ID4gPiBhL2RyaXZl
cnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLg0KPiA+ID4gPiA+
ID4gPiA+ID4gYw0KPiA+ID4gPiA+ID4gPiA+ID4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21l
ZGlhdGVrL2pwZWcvbXRrX2pwZWdfY29yZS4NCj4gPiA+ID4gPiA+ID4gPiA+IGMNCj4gPiA+ID4g
PiA+ID4gPiA+IGluZGV4IDk2OTUxNmE5NDBiYS4uMzY0NTEzZTc4OTdlIDEwMDY0NA0KPiA+ID4g
PiA+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gPiA+ID4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZv
cm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLg0KPiA+ID4gPiA+ID4gPiA+ID4gYw0KPiA+
ID4gPiA+ID4gPiA+ID4gKysrDQo+ID4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvanBlZy9tdGtfanBlZ19jb3JlLg0KPiA+ID4gPiA+ID4gPiA+ID4gYw0K
PiA+ID4gPiA+ID4gPiA+ID4gQEAgLTE3OTMsNyArMTc5Myw3IEBAIHN0YXRpYyBpbnQNCj4gPiA+
ID4gPiA+ID4gPiA+IG10a19qcGVnX3Byb2JlKHN0cnVjdA0KPiA+ID4gPiA+ID4gPiA+ID4gcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiA+ID4gPiA+ID4gICBzdGF0aWMgaW50IG10a19q
cGVnX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gPiA+ID4gPiA+ID4gPiAqcGRl
dikNCj4gPiA+ID4gPiA+ID4gPiA+ICAgew0KPiA+ID4gPiA+ID4gPiA+ID4gICAgICAgICAgc3Ry
dWN0IG10a19qcGVnX2RldiAqanBlZyA9DQo+ID4gPiA+ID4gPiA+ID4gPiBwbGF0Zm9ybV9nZXRf
ZHJ2ZGF0YShwZGV2KTsNCj4gPiA+ID4gPiA+ID4gPiA+IC0NCj4gPiA+ID4gPiA+ID4gPiA+ICsg
ICAgICAgY2FuY2VsX2RlbGF5ZWRfd29yaygmanBlZy0+am9iX3RpbWVvdXRfd29yayk7DQo+ID4g
PiA+ID4gPiA+ID4gPiAgICAgICAgICBwbV9ydW50aW1lX2Rpc2FibGUoJnBkZXYtPmRldik7DQo+
ID4gPiA+ID4gPiA+ID4gPiAgICAgICAgICB2aWRlb191bnJlZ2lzdGVyX2RldmljZShqcGVnLT52
ZGV2KTsNCj4gPiA+ID4gPiA+ID4gPiA+ICAgICAgICAgIHY0bDJfbTJtX3JlbGVhc2UoanBlZy0+
bTJtX2Rldik7DQo+ID4gPiA+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gPiA+ID4gMi4yNS4x
DQo+ID4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gPiANCg==
