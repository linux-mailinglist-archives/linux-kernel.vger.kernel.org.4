Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A8727C21
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjFHKDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235418AbjFHKDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:03:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC9926BA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:03:27 -0700 (PDT)
X-UUID: b2c258c205e311ee9cb5633481061a41-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=etnYbr7Vr//7o5S8QLr5t8gXceiS52sINPiM8qQ4m5Q=;
        b=hMLyy6F660sUsL8yHG/TPPqtobUfwpZcfuYtnbqaA1wx3otWpEAcCstTpIFSagpi1bBywYlV3Cgfvp8Q2o2wLbdHXG8MqLoGykDhjhhHuDlTIwxFo/nvAcjEuNhhrFnoHMhcALKy5ARAl/PdVsXF/Ax42EgqeGWjUAJjnr4TvBo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:3b01dce1-c734-4862-9d1c-cbaa606ab472,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:73
X-CID-INFO: VERSION:1.1.26,REQID:3b01dce1-c734-4862-9d1c-cbaa606ab472,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:73
X-CID-META: VersionHash:cb9a4e1,CLOUDID:3a0fcc3d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230608175739MU8QUYHM,BulkQuantity:15,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,
        TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM
X-UUID: b2c258c205e311ee9cb5633481061a41-20230608
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1895313152; Thu, 08 Jun 2023 18:03:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 18:03:20 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 18:03:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nrbHCh5ZcDN4zWiRcMarh/A2p2aTQ5NTm5k5YC2PpMqyuxHAl66wSx2BOwnt6yFYNmwwN+R10D0YGMt2ReHDNckjERE24ZiUk3lTtoY3nfqZSV1o1H3jXwMih7INDhU07ddQCJFFtevln4U6WMAtEUncij9Y6IkNT81jRYj6UORwF9vPCpG8W/DHUzMnaKuI2Lv8QHGSZU5om9rGNpG8K9ZbrXo51t8tmsVAxrlNDxBFiq4byTXMA387R78I44E2PsEs6xyyK1+NRYCZ/WawmNGfGLXVcKK7a2eLRtMnV1m7uDE585tgYnmzU6sVcAl6ao58qSuX0p+GORSmhvZ88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etnYbr7Vr//7o5S8QLr5t8gXceiS52sINPiM8qQ4m5Q=;
 b=RQ2/Xa+4m1Kf35RzZSD9Pfh3MWCJRLufRT25apayXw3XL2jYEM+L5iydW4nScINU6151jA0v5BMNUAMHHgFCQ3zilUfPgBso0k/+oC4bVgWk4pgqydq1+nTlbJ5i2AKIlq3gDoAiqpvHEPN0tlIDkjQeFI6GvkgqAz2ucOeS9rMsAsndA/axj0GYi5b9VDW5OvZ9rAy+bmE90KI9fC/M5MhMQbw1L2qJGGn1mx8qmUofB5JIaU7cEX8fg/+sJ8R6josJmk8+bPsCivEm32U31lsw4+qHrUmdRYqheezxAGDKHsqOP74Cen7UIVkDlmnXouhCaFag4+JW081CVj9TWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etnYbr7Vr//7o5S8QLr5t8gXceiS52sINPiM8qQ4m5Q=;
 b=ZvEHSgDuUCzsTNh/gmteTXDEDaoXToKZi1+27DL/gthTr94JK8LstrLoYwKTy+kn4rFVndZE9F7JpNyGRXE515bfgQY9uo0RLgXpzm3mzCx0DlbnGWEK2zsrabWBtW2phfhVrloK7On0vOyHbkx9l0IHOSyNxRiwI3BIJwpyPMs=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYZPR03MB5678.apcprd03.prod.outlook.com (2603:1096:400:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 10:03:18 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 10:03:18 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>
Subject: Re: [PATCH 5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros
 for registers
Thread-Topic: [PATCH 5/5] ASoC: mediatek: mt8188-mt6359: Use bitfield macros
 for registers
Thread-Index: AQHZmeXp4zfNsUjaO0GaDbveqYC3ca+ArRiA
Date:   Thu, 8 Jun 2023 10:03:18 +0000
Message-ID: <c05be93415b3a04db2bc0f86010e14a286ecded2.camel@mediatek.com>
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
         <20230608084727.74403-6-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230608084727.74403-6-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYZPR03MB5678:EE_
x-ms-office365-filtering-correlation-id: 94dbb29b-d5f9-4140-03a7-08db68079561
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJlAehrSmsBv5iyy/nDhr5gUWYfyVhs6YCWxD8rr2McQqZe3zVyaCBZl+F7rGQ99tW2OgWzy34DH11eonpLyAlXqGT4FT9TxSzteq3t8i+sLN5Eq9PED8UQPw0Ssrc7ydGOCf4O9kpDfpOqWYSUTAYnaqIIj1Hssw0/jxrkcGIOrXaWgk4P/wAAxp+DHMG4H9wncr3rYCwkoJqTtsCgwkmPtTRftxq2cZvpO5lGFFDuh24OVWrlDAmnpbWHAudi3Xug91u9Cs5CPYUJ59k9kdrGaVX7lFWNzeh1cLVKd0ws3/3D0JzKiDJKXZIz7AiJsVQQwbu2NlaGe3+YGGWC17giJAc+tpEnZRZNbNA0dl6FfHgEA4lbHv/Y/wwyVlwz/QE4y7UK/tawlPP3+N3Dfe0aSmCugsVaQH/syOoZaQOVipqmBBfFis6k3gwCb82+/4bBJQAisieppBMqtKK8nthJCV02TnV/SbZ7asnR6XO189cIgl9bNWrEy6qht51Lt5UeX8YEnxpvb0Ayvdrp0mOw7DDXLdaYQgNCKEi8KBNcePJGRujUxFGmWSha0N1oD57qScD8mVv7j8fL5oj5RlgL9vMV6Eh4TayJbC0hQ2SRzIVd3xgmQKoZ3eRvaQWKKcDzN0cwV/zmNXXHpKMgMeyWKGzRq+bqq62QCcWdZozrLauoVhte78bv/sR9/L5hu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(451199021)(110136005)(54906003)(2906002)(478600001)(66446008)(8676002)(8936002)(5660300002)(7416002)(4326008)(85182001)(36756003)(38070700005)(86362001)(76116006)(66556008)(66476007)(122000001)(316002)(66946007)(71200400001)(64756008)(38100700002)(83380400001)(41300700001)(6506007)(6512007)(2616005)(26005)(186003)(6486002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVVuZTJyZFU2aFZrbkdiNGg1bWs3OWU5SzdGSE1OOHJmUENmT0R0S2RGd0di?=
 =?utf-8?B?ak04SnpxNEVWRXNCbUVESGx0WTByVTZLUTBEdktySGdsWjI2bE80T1hSTnRw?=
 =?utf-8?B?V0VtbUN2cjNaV1FLaVVtYk5ZcXA0WmZYbE55b21wR3BzQzNmMCtheitvcFp6?=
 =?utf-8?B?VEh5eHhrODVJamZQSkQ1Zy9pc0EvQWlyTG9iMzNEMHVhNFlSL2pPeFl6U3Uy?=
 =?utf-8?B?alJiajdqU29ROGVRdHU4dFpDN3NVNXdZWXlwR0ZndGRYck4zR1dCMXhSaW1B?=
 =?utf-8?B?V0Z3T2p0NE5JN2lPV3F2WFg3M1lyWTlkRmlFQ0l6SlhyREo3eDM5K0hDaDhl?=
 =?utf-8?B?ckJubkJTZ1VQZml6d3VIOSswRUNHaVZIdE5GaEl5dkFhVHZrQzV2V2JjWGVY?=
 =?utf-8?B?cFE1WFdjNGhPYTFxL2ZrZlZ3cCt3YUtsVUQ5aFA4V1NqUDFra1RoeWljdnM5?=
 =?utf-8?B?WHBCN2FBNnFKY2dDMTdwTFc4SzlDQ1hmZWk1aUNobTVQYVhFMzYzS0VnOGRM?=
 =?utf-8?B?UDJtR20vRHNocDE0dDlONHNtWitZV2Y5ZE9ubFQ1K0hYSEd5ZUp6MlViRlI0?=
 =?utf-8?B?UnYrK2JLYk5MTUNTZGRJcmhFTHNtejJUQnFMUml2THZRT3V2YjREU083bHpu?=
 =?utf-8?B?U1Faa3NRdGoyT1ZpQkp0YVlTWVM5bmQ2RnYwMU9aYitGd2hsOGk1NVloZEJq?=
 =?utf-8?B?b1RLZ2J3aXVwVXQ5Q1NvTDY4M2NRNUVBank5S2tiQlJ2aEw2T3NjWmdZS0d4?=
 =?utf-8?B?enhtRklnZVFsTDNVR2E5MkI2MWd3cmMzdkttRnI2MXllbHFBK2JmWm55UWkz?=
 =?utf-8?B?d0Yrbnl2cE55NnNhQkZQR0FjZ2Exa2FSTFg3MUw0dTZYWkpEZ21GVHpEM0ZQ?=
 =?utf-8?B?Y0liVjNoM29GLzdVSE5tODRpYWxoL1hHcklCMnFuQzFMeUo1RnN3MDJpSm1j?=
 =?utf-8?B?WlAwMXVlSERiM0xYSGZPZHR0UmVid2tleGZRelFJN2ZTU1BGOHYxak0zek5Q?=
 =?utf-8?B?QmkyQit4QVhQMHUrWStqOUIzbFJqRWl2SEo4d25iaEtKalVrOEJpUXJDMkJR?=
 =?utf-8?B?d1hGWXBDbVBVdVVjbXVOV0lUMk1Wd0pXRWU4OWdxeTJ5OFIwS2UxRjhSNUtv?=
 =?utf-8?B?VE1LbTZqVFk5aGxrYW9PWHJJNU5VZy9VelkzQ0ZkWTgvblFxcnpsQi9wK2NW?=
 =?utf-8?B?aEN4cG4xVE1jT1ZkYm1xUENOT0hPRHBiVHNDLytVb2hmbEtaQ1FSRGRBSDVr?=
 =?utf-8?B?TXNnOVRRK3pLM3FEWm45aElPSXVRWXZ6WStNcExjMy9RaC9LbGNzT3ZSNW0y?=
 =?utf-8?B?dFRuK2o4Z09TMWJ5R0RzZlN0QUtub0U5N2lzYUM2TGlsUFg0TGd4c1dxRW84?=
 =?utf-8?B?Mk1La3c1MzFGa0cvbVE2K24zNTJxOEV0MFRzS3FnVnRkb3l5dmVCVGxKN0xn?=
 =?utf-8?B?ZHBKS0ZzTG9OMkdrSGZCOHFxbm5PWGdOb3lXUGF3V1NvU01EWVFsSlVoMU9p?=
 =?utf-8?B?a1VVQkRyUUhucnlFV1JZUVlVSjNGejNPWHRSakU4WFpSQXVDc0tRcnhDbmpu?=
 =?utf-8?B?eTkxZzc1QmtTb2hacWs5c3lHSDlMMmlMN0htTTdPeGJpRjFjWkU3QTBicFBS?=
 =?utf-8?B?aUJHMmJPR0N1VktqRkdGZFVMdnFMZVJVYnVqdzlQclc4S29udWtMUUtuSkJl?=
 =?utf-8?B?SmdSazd0aXdDbEZkZTZZVnJvRDA0S0lWbFA2R1hzcDhSbTY5cmVrZ3k2SXBC?=
 =?utf-8?B?Z2oxckNsS0wvWW44T0xSMVBmZU81NUplMGVWVWNBclBRcXBXeThwYjVuNFNa?=
 =?utf-8?B?U3hTMWFWM3djT0NhNTZGbHdndzA2OFlhRFFMVmFsTGVHVDl6THFlMnNETS9C?=
 =?utf-8?B?ajc3NnFWYUk3RnFnaUxUeWlaem9jN3dPTjQxS2lVODZUQ24yVjRobjdPVW85?=
 =?utf-8?B?UFhrVWc2UVZOakZ5cTFOSml6d0Fibmx6WGlhMzMyRjNPc1BObnh1SEVkN1Mx?=
 =?utf-8?B?bGt1Nm5uZHhlQktCNCtialhIamhQT05mY0U3V2RvZmxDcitlZXV2eFlibDJi?=
 =?utf-8?B?bjhwZEsrUEdrMjMxcFBSMGxNMTZJczJWVGJINEhobStkRFZBK3UrcDdxUXkw?=
 =?utf-8?B?UnVzZ1JIcHB5a3dtTTZjeE5TdlBSYk1PbktQRGpqMTlUQlNtbjdIVTZveUwv?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85FF91FDCF8FDC4E9422458F9D719973@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dbb29b-d5f9-4140-03a7-08db68079561
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 10:03:18.2732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ekliyBy18vqXBVbHV5Aawn5oRKtOpSEkkawZk2Yap+Y+Vax4foQQr1zZuyIfGCrSElYq6qqhwp9Am4IPGqphQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5678
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA2LTA4IGF0IDEwOjQ3ICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCg0KPiAgUmVwbGFjZSBvcGVuIGNvZGVkIGluc3RhbmNlcyBvZiBGSUVMRF9H
RVQoKSB3aXRoIGl0LCBtb3ZlIHJlZ2lzdGVyDQo+IGRlZmluaXRpb25zIGF0IHRoZSB0b3Agb2Yg
dGhlIGZpbGUgYW5kIGFsc28gcmVwbGFjZSBtYWdpYyBudW1iZXJzDQo+IHdpdGggcmVnaXN0ZXIg
ZGVmaW5pdGlvbnMuDQo+IA0KPiBXaGlsZSBhdCBpdCwgYWxzbyBjaGFuZ2UgYSByZWdtYXBfdXBk
YXRlX2JpdHMoKSBjYWxsIHRvDQo+IHJlZ21hcF93cml0ZSgpDQo+IGJlY2F1c2UgdGhlIHRvcCAy
OSBiaXRzIG9mIEFVRF9UT1BfQ0ZHICgzMTozKSBhcmUgcmVzZXJ2ZWQgKHVudXNlZCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFuZ2Vsb2dp
b2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2MvbWVk
aWF0ZWsvbXQ4MTg4L210ODE4OC1tdDYzNTkuYyB8IDMyICsrKysrKysrKysrKysrLS0tLS0tLQ0K
PiAtLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10
NjM1OS5jDQo+IGIvc291bmQvc29jL21lZGlhdGVrL210ODE4OC9tdDgxODgtbXQ2MzU5LmMNCj4g
aW5kZXggNWIyNjYwMTM5NDIxLi5hYzY5YzIzZTBkYTEgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3Nv
Yy9tZWRpYXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+ICsrKyBiL3NvdW5kL3NvYy9tZWRp
YXRlay9tdDgxODgvbXQ4MTg4LW10NjM1OS5jDQo+IEBAIC02LDYgKzYsNyBAQA0KPiAgICogQXV0
aG9yOiBUcmV2b3IgV3UgPHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ICAgKi8NCj4gIA0KPiAr
I2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvaW5wdXQuaD4N
Cj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZp
Y2UuaD4NCj4gQEAgLTE5LDYgKzIwLDE1IEBADQo+ICAjaW5jbHVkZSAiLi4vY29tbW9uL210ay1h
ZmUtcGxhdGZvcm0tZHJpdmVyLmgiDQo+ICAjaW5jbHVkZSAiLi4vY29tbW9uL210ay1zb3VuZGNh
cmQtZHJpdmVyLmgiDQo+ICANCj4gKyNkZWZpbmUgQ0tTWVNfQVVEX1RPUF9DRkcJMHgwMzJjDQo+
ICsgI2RlZmluZSBSR19URVNUX09OCQlCSVQoMCkNCj4gKyAjZGVmaW5lIFJHX1RFU1RfVFlQRQkJ
QklUKDIpDQo+ICsjZGVmaW5lIENLU1lTX0FVRF9UT1BfTU9OCTB4MDMzMA0KPiArICNkZWZpbmUg
VEVTVF9NSVNPX0NPVU5UXzEJR0VOTUFTSygzLCAwKQ0KPiArICNkZWZpbmUgVEVTVF9NSVNPX0NP
VU5UXzIJR0VOTUFTSyg3LCA0KQ0KPiArICNkZWZpbmUgVEVTVF9NSVNPX0RPTkVfMQlCSVQoMjgp
DQo+ICsgI2RlZmluZSBURVNUX01JU09fRE9ORV8yCUJJVCgyOSkNCj4gKw0KPiAgI2RlZmluZSBO
QVU4ODI1X0hTX1BSRVNFTlQJQklUKDApDQo+ICANCj4gIC8qDQo+IEBAIC0yNTEsOSArMjYxLDYg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRfa2NvbnRyb2xfbmV3DQo+IG10ODE4OF9uYXU4ODI1
X2NvbnRyb2xzW10gPSB7DQo+ICAJU09DX0RBUE1fUElOX1NXSVRDSCgiSGVhZHBob25lIEphY2si
KSwNCj4gIH07DQo+ICANCj4gLSNkZWZpbmUgQ0tTWVNfQVVEX1RPUF9DRkcgMHgwMzJjDQo+IC0j
ZGVmaW5lIENLU1lTX0FVRF9UT1BfTU9OIDB4MDMzMA0KPiAtDQo+ICBzdGF0aWMgaW50IG10ODE4
OF9tdDYzNTlfbXRrYWlmX2NhbGlicmF0aW9uKHN0cnVjdA0KPiBzbmRfc29jX3BjbV9ydW50aW1l
ICpydGQpDQo+ICB7DQo+ICAJc3RydWN0IHNuZF9zb2NfY29tcG9uZW50ICpjbXBudF9hZmUgPQ0K
PiBAQCAtMjY1LDEzICsyNzIsMTMgQEAgc3RhdGljIGludA0KPiBtdDgxODhfbXQ2MzU5X210a2Fp
Zl9jYWxpYnJhdGlvbihzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGltZSAqcnRkKQ0KPiAgCXN0cnVj
dCBtdGthaWZfcGFyYW0gKnBhcmFtOw0KPiAgCWludCBjaG9zZW5fcGhhc2VfMSwgY2hvc2VuX3Bo
YXNlXzI7DQo+ICAJaW50IHByZXZfY3ljbGVfMSwgcHJldl9jeWNsZV8yOw0KPiAtCWludCB0ZXN0
X2RvbmVfMSwgdGVzdF9kb25lXzI7DQo+ICsJdTggdGVzdF9kb25lXzEsIHRlc3RfZG9uZV8yOw0K
PiAgCWludCBjeWNsZV8xLCBjeWNsZV8yOw0KPiAgCWludCBtdGthaWZfY2hvc2VuX3BoYXNlW01U
ODE4OF9NVEtBSUZfTUlTT19OVU1dOw0KPiAgCWludCBtdGthaWZfcGhhc2VfY3ljbGVbTVQ4MTg4
X01US0FJRl9NSVNPX05VTV07DQo+ICAJaW50IG10a2FpZl9jYWxpYnJhdGlvbl9udW1fcGhhc2U7
DQo+ICAJYm9vbCBtdGthaWZfY2FsaWJyYXRpb25fb2s7DQo+IC0JdW5zaWduZWQgaW50IG1vbml0
b3IgPSAwOw0KPiArCXUzMiBtb25pdG9yID0gMDsNCj4gIAlpbnQgY291bnRlcjsNCj4gIAlpbnQg
cGhhc2U7DQo+ICAJaW50IGk7DQo+IEBAIC0zMDMsOCArMzEwLDcgQEAgc3RhdGljIGludA0KPiBt
dDgxODhfbXQ2MzU5X210a2FpZl9jYWxpYnJhdGlvbihzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGlt
ZSAqcnRkKQ0KPiAgCW10NjM1OV9tdGthaWZfY2FsaWJyYXRpb25fZW5hYmxlKGNtcG50X2NvZGVj
KTsNCj4gIA0KPiAgCS8qIHNldCB0ZXN0IHR5cGUgdG8gc3luY2hyb25pemVyIHB1bHNlICovDQo+
IC0JcmVnbWFwX3VwZGF0ZV9iaXRzKGFmZV9wcml2LT50b3Bja2dlbiwNCj4gLQkJCSAgIENLU1lT
X0FVRF9UT1BfQ0ZHLCAweGZmZmYsIDB4NCk7DQo+ICsJcmVnbWFwX3dyaXRlKGFmZV9wcml2LT50
b3Bja2dlbiwgQ0tTWVNfQVVEX1RPUF9DRkcsDQo+IFJHX1RFU1RfVFlQRSk7DQoNCkhpIEFuZ2Vs
bywNCg0KQmVjYXVzZSBDS1NZU19BVURfVE9QX0NGRyBpcyBhIDMyYml0IHJlZ2lzdGVyLCBpdCBz
aG91bGQgYmUgYmV0dGVyIHRvDQp1c2UgcmVnbWFwX3NldF9iaXRzIGluc3RlYWQuDQoNCnJlZ21h
cF9zZXRfYml0cyhhZmVfcHJpdi0+dG9wY2tnZW4sIENLU1lTX0FVRF9UT1BfQ0ZHLCBSR19URVNU
X1RZUEUpOw0KDQpUaGFua3MsDQpUcmV2b3INCg0KDQo+ICAgCW10a2FpZl9jYWxpYnJhdGlvbl9u
dW1fcGhhc2UgPSA0MjsJLyogbXQ2MzU5OiAwIH4gNDIgKi8NCj4gIAltdGthaWZfY2FsaWJyYXRp
b25fb2sgPSB0cnVlOw0KPiAgDQo+IEBAIC0zMTQsNyArMzIwLDcgQEAgc3RhdGljIGludA0KPiBt
dDgxODhfbXQ2MzU5X210a2FpZl9jYWxpYnJhdGlvbihzdHJ1Y3Qgc25kX3NvY19wY21fcnVudGlt
ZSAqcnRkKQ0KPiAgCQltdDYzNTlfc2V0X210a2FpZl9jYWxpYnJhdGlvbl9waGFzZShjbXBudF9j
b2RlYywNCj4gIAkJCQkJCSAgICBwaGFzZSwgcGhhc2UsDQo+IHBoYXNlKTsNCj4gIA0KPiAtCQly
ZWdtYXBfc2V0X2JpdHMoYWZlX3ByaXYtPnRvcGNrZ2VuLCBDS1NZU19BVURfVE9QX0NGRywNCj4g
MHgxKTsNCj4gKwkJcmVnbWFwX3NldF9iaXRzKGFmZV9wcml2LT50b3Bja2dlbiwgQ0tTWVNfQVVE
X1RPUF9DRkcsDQo+IFJHX1RFU1RfT04pOw0KPiAgDQo+ICAJCXRlc3RfZG9uZV8xID0gMDsNCj4g
IAkJdGVzdF9kb25lXzIgPSAwOw0KPiBAQCAtMzI2LDE0ICszMzIsMTQgQEAgc3RhdGljIGludA0K
PiBtdDgxODhfbXQ2MzU5X210a2FpZl9jYWxpYnJhdGlvbihzdHJ1Y3Qgc25kX3NvY19wY21fcnVu
dGltZSAqcnRkKQ0KPiAgCQl3aGlsZSAoISh0ZXN0X2RvbmVfMSAmIHRlc3RfZG9uZV8yKSkgew0K
PiAgCQkJcmVnbWFwX3JlYWQoYWZlX3ByaXYtPnRvcGNrZ2VuLA0KPiAgCQkJCSAgICBDS1NZU19B
VURfVE9QX01PTiwgJm1vbml0b3IpOw0KPiAtCQkJdGVzdF9kb25lXzEgPSAobW9uaXRvciA+PiAy
OCkgJiAweDE7DQo+IC0JCQl0ZXN0X2RvbmVfMiA9IChtb25pdG9yID4+IDI5KSAmIDB4MTsNCj4g
KwkJCXRlc3RfZG9uZV8xID0gRklFTERfR0VUKFRFU1RfTUlTT19ET05FXzEsDQo+IG1vbml0b3Ip
Ow0KPiArCQkJdGVzdF9kb25lXzIgPSBGSUVMRF9HRVQoVEVTVF9NSVNPX0RPTkVfMiwNCj4gbW9u
aXRvcik7DQo+ICANCj4gIAkJCWlmICh0ZXN0X2RvbmVfMSA9PSAxKQ0KPiAtCQkJCWN5Y2xlXzEg
PSBtb25pdG9yICYgMHhmOw0KPiArCQkJCWN5Y2xlXzEgPSBGSUVMRF9HRVQoVEVTVF9NSVNPX0NP
VU5UXzEsDQo+IG1vbml0b3IpOw0KPiAgDQo+ICAJCQlpZiAodGVzdF9kb25lXzIgPT0gMSkNCj4g
LQkJCQljeWNsZV8yID0gKG1vbml0b3IgPj4gNCkgJiAweGY7DQo+ICsJCQkJY3ljbGVfMiA9IEZJ
RUxEX0dFVChURVNUX01JU09fQ09VTlRfMiwNCj4gbW9uaXRvcik7DQo+ICANCj4gIAkJCS8qIGhh
bmRsZSBpZiBuZXZlciB0ZXN0IGRvbmUgKi8NCj4gIAkJCWlmICgrK2NvdW50ZXIgPiAxMDAwMCkg
ew0KPiBAQCAtMzYxLDcgKzM2Nyw3IEBAIHN0YXRpYyBpbnQNCj4gbXQ4MTg4X210NjM1OV9tdGth
aWZfY2FsaWJyYXRpb24oc3RydWN0IHNuZF9zb2NfcGNtX3J1bnRpbWUgKnJ0ZCkNCj4gIAkJCW10
a2FpZl9waGFzZV9jeWNsZVtNVDgxODhfTVRLQUlGX01JU09fMV0gPQ0KPiBwcmV2X2N5Y2xlXzI7
DQo+ICAJCX0NCj4gIA0KPiAtCQlyZWdtYXBfY2xlYXJfYml0cyhhZmVfcHJpdi0+dG9wY2tnZW4s
DQo+IENLU1lTX0FVRF9UT1BfQ0ZHLCAweDEpOw0KPiArCQlyZWdtYXBfY2xlYXJfYml0cyhhZmVf
cHJpdi0+dG9wY2tnZW4sDQo+IENLU1lTX0FVRF9UT1BfQ0ZHLCBSR19URVNUX09OKTsNCj4gIA0K
PiAgCQlpZiAobXRrYWlmX2Nob3Nlbl9waGFzZVtNVDgxODhfTVRLQUlGX01JU09fMF0gPj0gMCAm
Jg0KPiAgCQkgICAgbXRrYWlmX2Nob3Nlbl9waGFzZVtNVDgxODhfTVRLQUlGX01JU09fMV0gPj0g
MCkNCj4gLS0gDQo+IDIuNDAuMQ0K
