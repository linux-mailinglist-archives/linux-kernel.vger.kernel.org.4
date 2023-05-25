Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BAD71034F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 05:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjEYDaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 23:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEYDaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 23:30:00 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC22E2;
        Wed, 24 May 2023 20:29:57 -0700 (PDT)
X-UUID: 69ced90cfaac11ed9cb5633481061a41-20230525
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=L2Ro0w3ex7Mj/dHV1z8xSIAjVtZ4GNdTcfI1G7FBDq4=;
        b=avX0usfltKBCcCHEkGq2cZ5VypVzxuzmLDVwyWYPWMdUTdmyXs/2t+fm0ZAkk63yp22UnNHNvciBQqAgKtMFQvzKQAj12Hb+GNRJH8icNbkbB5r3DP6ippG44L3dZdBrMBJyDn++u+47/txlxpKrPPgM/8mp4FZWl1EcemQaNXY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:96d759be-881f-4a0b-9802-f2dc7a808382,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:4b1aef6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 69ced90cfaac11ed9cb5633481061a41-20230525
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 636051768; Thu, 25 May 2023 11:29:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 May 2023 11:29:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 May 2023 11:29:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bxESsKktlkoSChL6TjS8hAomkj+pAkIKsvi69v1BmQxBm/8mdBA41RKA2WBpzMMTqUs4Fd63rZFYpT6QEm732k2yv1MWlBYmuhs1jiqW4mMTzPAHwDJhzBaULVU7vue/4fNge7SylPqBsn1MRKJNJTwT35hDjPobsbaVDjt46CGLIvcAr82Qs88VRVBxfbPtCDcVgYC+qtkrVe+CzzitO98t8ERK2cs+nQ8HA0LSIUCUBP2EBG40qmr1x4hznPwI6qj7PX8TsPKUwaMp6sCLiyLgcRdNtL0LLKoJiMjdAX7H9yj2s9TV3Bv1hPq2TRz2RUoSkOzLzp/1IOd1oMjloQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2Ro0w3ex7Mj/dHV1z8xSIAjVtZ4GNdTcfI1G7FBDq4=;
 b=n++Y8pw4E59JlnId7+rs5cYyX0mUElr/syx5odgml54QiUeEOjRUpoMhyzISE7Hsh3O/vlMm/zHg1njYbm7vyxHXGhM/iTKY8vaqQP5ZSZFLQO1DomAznOahHsHbNd58zkcjRi8LXkbhpjC0U+KrXkhDDZRxavLQcTyaeYkmsA9iv+/uPST0aGds8MkNBAaec1KDQmxbIbunckjlNR13G7VVJmS7UVaCDP6cHEdGnzWbsV3i1VsZOF+5iIXIgWufK4lP42vfYALMvxpJYrFNiRTd3jMs8nMvoosmrkjWeTUVStODTk87085UZGZlC6KDBGe96+uYoyYBlAHU2B7XPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2Ro0w3ex7Mj/dHV1z8xSIAjVtZ4GNdTcfI1G7FBDq4=;
 b=pSmzx6ChFSu9REgBAAvJ/mSVOwEkoIltNcRZuH5Dj+HI1c7V6nrplE7cM9t9BTd6XOupSUp+lFXTfl478vtmBoS5xaovPqbD3R7C7Bb3v9x2dtwXKDmD14We9RNZDNDKptsvcxJLqeZboFZZt75TpA5rcuLmxgFEkLcPyArW1Gs=
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com (2603:1096:4:1e9::14)
 by TYSPR03MB8027.apcprd03.prod.outlook.com (2603:1096:400:478::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.14; Thu, 25 May
 2023 03:20:40 +0000
Received: from SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de]) by SI2PR03MB6686.apcprd03.prod.outlook.com
 ([fe80::bfa:5a41:b6e1:63de%3]) with mapi id 15.20.6411.031; Thu, 25 May 2023
 03:20:40 +0000
From:   =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amergnat@baylibre.com" <amergnat@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Thread-Topic: [PATCH v2 2/7] ASoC: dt-bindings: mediatek,mt8188-mt6359: remove
 ADDA_BE from link-name
Thread-Index: AQHZjR0FfmF6vQnyyUC64/q6ES0fra9oDFOAgACnk4CAALkrAIAABNeAgAARBICAANKcgA==
Date:   Thu, 25 May 2023 03:20:40 +0000
Message-ID: <522f9f04f3a7dc98845e01a6761d2dddb96c5ad8.camel@mediatek.com>
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
         <20230523021933.3422-3-trevor.wu@mediatek.com>
         <cb69dbab-0966-8ecb-d9b9-017f430fd7ea@baylibre.com>
         <b9eecdf886b6496131e51e1e2f49536c782c3b67.camel@mediatek.com>
         <56b892cd-977e-5b24-55f0-df25e187308b@baylibre.com>
         <e0fb6da4974407726cdf668577fe0d40e6e6e9e2.camel@mediatek.com>
         <e7d82e49-340c-5eb1-27e3-e6cde900fcf2@baylibre.com>
In-Reply-To: <e7d82e49-340c-5eb1-27e3-e6cde900fcf2@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB6686:EE_|TYSPR03MB8027:EE_
x-ms-office365-filtering-correlation-id: b7f0171a-a6eb-4e4d-6b95-08db5ccf0488
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNJo3VdekMnqIRdOvEV4hG0kKYox+eovl/sonrSJFd++mY5M9kCqBM1gVHTBSucYIEH9z5384UEZcfsID6AXjdD7/0Aej2YtxHsDQVT7mbgIYFiX17k8CbdibnR5QnULw+1GME4URgHKRdHWqN3B9wVRH75VrIFhZZfOhRmqm4cRuWXnCs7Bi+XS27E8M5CetNE/ojb0BCwFAnrSlAvrHNoxrGs5C+6NiV9T4P1PdlQZtHRbVxm4S9Wiyrpa0B8uy4c6QDdODsHLSVL9Wj/PgQT3iUYTJ75rWtZY/uROSf1p5nagSSa6RDVoUIEPsQLMd7UeU3Jh2n0A1G4M+seoBrjfsN7zz1tvWrXXxcHZu2zSN4hRCIGvwAbZgDzmZwoKn9DmOK4m2L7xAnTel28713ebWpeyV90JV/NONNrrV+MhZMIgYFAqS8bSbGTnvoPESRi5m65NZvGCifhIObbBubg/16KImusv0qmFBh8Go2SZy0IPfqE+Q10pgO1pm4OUusyJXo5ipMKNuyktYCsdPhF4FbBPiattl+Arc94OfAsYpGQpDsrlUnicoq7VEd1Y5sRUYcb+uEfK0GLxB/cYzi4bO/mK884NSno1JCcPbowJlu/BIKp7MRJLG16I88Q4OOItv/jwOy8jRWrMfhqI20t8BC+OKrvSHUEKbzGBLlY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB6686.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(451199021)(2906002)(91956017)(6512007)(6506007)(26005)(71200400001)(41300700001)(110136005)(54906003)(66446008)(66946007)(76116006)(4326008)(64756008)(66476007)(66556008)(478600001)(6486002)(122000001)(38100700002)(53546011)(86362001)(83380400001)(186003)(2616005)(38070700005)(8676002)(5660300002)(36756003)(8936002)(7416002)(85182001)(316002)(921005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHBGYjRZNW4vVHVXOFZuWENWc0RraEVUU1Y0Wnp4Qm9Dc2lHeWNJQm96d0Rz?=
 =?utf-8?B?RFVRUlp1ZUdDdm16ODZIMGU0MzA1T2phT0hDcThLOTFJRk1GVGFLVWpGaGZ0?=
 =?utf-8?B?YitZYUlzejFtUENwSlgzSmRuNWQzcEpxSWJSdERBZDNLNWpmcENmRFNkaXZ4?=
 =?utf-8?B?NXhSRUpDa3BPbDFaUWRvSTNoUGRRcXd3aVdWRVg4VFFuY1FRS0ducFVqWURo?=
 =?utf-8?B?ZDZSenRpcHg2L0hMV004Nlp1ZnNZWkpnbktCU1B6b1JXSEdDOWpUWnFqcnF0?=
 =?utf-8?B?VGMvVDNnNG45T3U3dGVQM1daM1JFNE5mNFhnbmt1dk94VWJURS9wRUovZVVW?=
 =?utf-8?B?MVhsaEpJLzZjTlNzdkk3ZzNVUHIrbFVxQkwyNkI2b25GV25jMTNhRTFWMTV3?=
 =?utf-8?B?MEd5MHFFV0hOY0ZQaFdDT1dsMTM2d2pMWU5kbVdNdXA1RDVIaG95UEJubnYy?=
 =?utf-8?B?RmVZb3ltNll1djJoSTgxMy9qNG1UR293SzZ4amJndm1HUzVXSVZhZlFTSWVR?=
 =?utf-8?B?UHpDMGVSclZ0SWJUS21GTU5JYjlmQnRGVTJRZWFDalAvZTFSczBHTnN4bkhh?=
 =?utf-8?B?dVNwbnhXd0pxV0V6K1VyM2JKTEtjVVNwZmZnbjRFdXVaQ0tMaTZrd21EUG5N?=
 =?utf-8?B?OWVsaUtCUGhUVUJURGlGRXptczBZSFBaWkRlMHF4cVBiWXJNZkh4VHcrdWFt?=
 =?utf-8?B?amZqQVJuWU1Fekh6WVMxOWx1T2ZOV0pYMTBUMkFIWkpqSTFtSUpjd2NyZTFM?=
 =?utf-8?B?WHlHaWl6MDlzc0VtMTVKSHFWQlY0NTNQS1dxTDBPeG1yUnF3emhZbWlFc2Z3?=
 =?utf-8?B?MWh1TDMrSG91MjVMczJ1b0FBNWxLNEZHVjBMZUNCWVNTV3BTWmFHWmpVWmFS?=
 =?utf-8?B?ZFVKblhLQnZyUFVKdXFwMVVUc1JmRFZ0UGQ5VisvRUplalYwK0ZWV0pxU1du?=
 =?utf-8?B?aytoSTV6UFM1ejJ0SlRxeU5OUW1JN0lXVUE2L0NqZGZQMklzeUJZcDdLeWJB?=
 =?utf-8?B?OW0wOW9JV2dxSzErb1k3ZHBFYzJXeVkvdldmd0pXbnlBYUQyazFjVlUyZXhU?=
 =?utf-8?B?c3R1OXZhWFRWSjJmMmtUTWRMaC9pRmRJUnJPRzBQS2VZTU5vWTYyaHBUaWRt?=
 =?utf-8?B?NWxiUllFWFozSDJvNU9SMEYxQldCbHlPZ1JmV3A4QjlDbklVdHAva3ZUM01j?=
 =?utf-8?B?bFNXVm8wKzk1RU51TURJUkZ5a0hkODYyUzFIdmpyQ0pNaFhhRkczckJUWTFa?=
 =?utf-8?B?eWVrK0trTU9ubGlaS1ZDcko4RG9NVkVoRGd4ckFlYzRwZitCcERaWHB2Tmpv?=
 =?utf-8?B?M1dyU1RCemY1TjdwUzk4UFBaV1hFZUNCb0c4VU13MnZSWXh3Smd0T0c3K2Zr?=
 =?utf-8?B?dlUrTzQ5c09Ga29aZ2YxSytseGcxQVU2ZU5oRHVhRGRjcHl5T0gwM2JnUVpQ?=
 =?utf-8?B?LzE3SDMrZG14cGxUUGo0dFVybkNKcTNHNHUwS3U3THNQYk5xK0toWmpiaktS?=
 =?utf-8?B?SEMwd3JqRXNGcHNIOUVMejliczl4L2ZsVGNPM3dzbm9LbFdyTitOTmk1UW5k?=
 =?utf-8?B?R2JFYzZ4Z1pMN1IvREo2Y2dsSmZncFh5MzBqTVVnQVBNdmgyMW56dDBWUGlh?=
 =?utf-8?B?S1RKUkpVbmJXdytHRm1UcDZjSWx0T0huQTl3YVJ4ZUtDelpsWlVzMzhNbklo?=
 =?utf-8?B?eGpPVTc3U0JuTkJtK0V1QnBSdVFRQmUrL3RCcWlEcUFaeUFmdUxWVm82V2VH?=
 =?utf-8?B?YTBvQ0FrSHpkK1FLU01yZnFJSUVJWjBHT0hjaEdRTDhERno5L2RmaEJXVWV2?=
 =?utf-8?B?d1pGdWxmcFA1dW9tYVB0M0FTMzMydGYvK0wrOVBJb1BuV0tWZ0x5QnlDZmlR?=
 =?utf-8?B?MVV1N2Mvamdvc0JrcDhRcUcxeU1DNkdFQnRWWjhDdzZMYXJndzhuU244UjlZ?=
 =?utf-8?B?dVI4ZmdPY3dYSVgvRGF3T2tJQ3NJaHJVOTRLWlk2VG9SUzNMT3JhcDl3RmdE?=
 =?utf-8?B?M3YwTjJXbi9zaWJZbjBZZTF2dXk3NWRPOVM5ZkpSQ3NZazZkVndTd3NjOUkv?=
 =?utf-8?B?MXAzaFdPb3FkSUwyd0JmdGRUTDlFZEJwU3VacXFxcWhrZzBrRlJKOE5jcGNU?=
 =?utf-8?B?R0MzWERDdXdVUGVkbUVSWU1lM1RtMXZMbTFuamFxaTBMN2pEY0JPM05mM2s0?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91F7BFBE8C4E3B459BEB6DCF17A24AE1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB6686.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f0171a-a6eb-4e4d-6b95-08db5ccf0488
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 03:20:40.6532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bU32mNfs8G3UiErTZYqMoE9pNHCrNfCNlQUUCrTQ9JEl6iBs9XY8EKvnk1NmOGxIqmw82TLA2kwUYmYxkrWesw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8027
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA1LTI0IGF0IDE2OjQ2ICswMjAwLCBBbGV4YW5kcmUgTWVyZ25hdCB3cm90
ZToNCj4gT24gMjQvMDUvMjAyMyAxNTo0NSwgVHJldm9yIFd1ICjlkLPmlofoia8pIHdyb3RlOg0K
PiA+IE9uIFdlZCwgMjAyMy0wNS0yNCBhdCAxNToyOCArMDIwMCwgQWxleGFuZHJlIE1lcmduYXQg
d3JvdGU6DQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mg
b3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gT24gMjQv
MDUvMjAyMyAwNDoyNSwgVHJldm9yIFd1ICjlkLPmlofoia8pIHdyb3RlOg0KPiA+ID4gPiBPbiBU
dWUsIDIwMjMtMDUtMjMgYXQgMTg6MjYgKzAyMDAsIEFsZXhhbmRyZSBNZXJnbmF0IHdyb3RlOg0K
PiA+ID4gPiA+IE9uIDIzLzA1LzIwMjMgMDQ6MTksIFRyZXZvciBXdSB3cm90ZToNCj4gPiA+ID4g
PiA+IEFEREFfQkUgaXMgdXNlZCB0byBjb25uZWN0IHRvIG10NjM1OS4gRm9yIG1hY2hpbmUgbXQ4
MTg4LQ0KPiA+ID4gPiA+ID4gbXQ2MzU5LA0KPiA+ID4gPiA+ID4gY29kZWMNCj4gPiA+ID4gPiA+
IGZvciBBRERBX0JFIG11c3QgYmUgbXQ2MzU5IHdoaWNoIGFyZSBjb25maWd1cmVkIG9uIHRoZQ0K
PiA+ID4gPiA+ID4gbWFjaGluZQ0KPiA+ID4gPiA+ID4gZHJpdmVyLg0KPiA+ID4gPiA+ID4gQmVz
aWRlcywgQUREQV9CRSBpcyBkaXZpZGVkIGludG8gdHdvIGRhaXMsIFVMX1NSQ19CRSBhbmQNCj4g
PiA+ID4gPiA+IERMX1NSQ19CRS4NCj4gPiA+ID4gPiA+IEFzIGEgcmVzdWx0LCByZW1vdmUgQURE
QV9CRSBmcm9tIGl0ZW1zIG9mIGxpbmstbmFtZS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogVHJldm9yIFd1PHRyZXZvci53dUBtZWRpYXRlay5jb20+DQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gSSBkb24ndCB1bmRlcnN0YW5kIGhvdyAiRExfU1JDX0JFIiBhbmQgIlVM
X1NSQ19CRSIgbGlua3MgYXJlDQo+ID4gPiA+ID4gZG9uZS4NCj4gPiA+ID4gPiBXaHkgdGhlc2Ug
ZGFpcyBkb24ndCByZXBsYWNlICJBRERBX0JFIiBpbiB0aGlzIGJpbmRpbmcgPw0KPiA+ID4gPiA+
IA0KPiA+ID4gPiA+IFJlZ2FyZHMsDQo+ID4gPiA+ID4gQWxleGFuZHJlDQo+ID4gPiA+ID4gDQo+
ID4gPiA+IA0KPiA+ID4gPiBIaSBBbGV4YW5kcmUsDQo+ID4gPiA+IA0KPiA+ID4gPiBCZWNhdXNl
IHRoZSBzb3VuZCBjYXJkIGlzIG10ODE4OC1tdDYzNTksIHRoZSBjb2RlYyBmb3IgdGhlc2UNCj4g
PiA+ID4gdHdvDQo+ID4gPiA+IGxpbmtzDQo+ID4gPiA+IG11c3QgYmUgbXQ2MzU5LiBUaHVzLCBJ
IHNwZWNpZml5IHRoZSBjb2RlYyBpbiBtYWNoaW5lIGRyaXZlcg0KPiA+ID4gPiBkaXJlY3RseS4N
Cj4gPiA+ID4gSWYgdGhlIGNvZGVjIGlzIGNoYW5nZWQsIHRoZXJlIHdpbGwgYmUgYSBuZXcgc291
bmQgY2FyZCBhbmQNCj4gPiA+ID4gYmluZGluZw0KPiA+ID4gPiBmaWxlLiBJbiBjb25jbHVzaW9u
LCB0aGUgY29kZWMgd29uJ3QgYmUgdXBkYXRlZCB2aWEgZHRzLCBhbmQNCj4gPiA+ID4gdGhhdCdz
DQo+ID4gPiA+IHdoeQ0KPiA+ID4gPiBJIGRvbid0IGp1c3QgcmVwbGFjZSBBRERBX0JFIGluIHRo
aXMgYmluZGluZy4NCj4gPiA+ID4gDQo+ID4gPiA+IERvIHlvdSBzdWdnZXN0IG1lIGFkZCBzb21l
IGluZm9ybWF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZT8NCj4gPiA+IA0KPiA+ID4gTm8gaXQn
cyBmaW5lLCBJJ20ganVzdCB0cnlpbmcgdG8gdW5kZXJzdGFuZC4NCj4gPiA+IA0KPiA+ID4gV2hl
biB5b3Ugc2F5ICJJIHNwZWNpZml5IHRoZSBjb2RlYyBpbiBtYWNoaW5lIGRyaXZlciBkaXJlY3Rs
eSIsDQo+ID4gPiB5b3UNCj4gPiA+IGFyZSB0YWxraW5nIGFib3V0IHRoaXMgY2hhbmdlID8NCj4g
PiA+IA0KPiA+ID4gKyAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoc3RyY21wKGRhaV9saW5rLT5u
YW1lLCAiRExfU1JDX0JFIikgPT0NCj4gPiA+IDANCj4gPiA+ID4gPiANCj4gPiA+IA0KPiA+ID4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgc3RyY21wKGRhaV9saW5rLT5uYW1lLCAiVUxfU1JD
X0JFIikgPT0NCj4gPiA+IDApDQo+ID4gPiB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICBpZiAoIWluaXRfbXQ2MzU5KSB7DQo+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGRhaV9saW5rLT5pbml0ID0NCj4gPiA+IG10ODE4OF9tdDYzNTlfaW5pdDsNCj4gPiA+IA0K
PiA+ID4gSSdtIGFza2luZyBiZWNhdXNlIHRoZSBlcXVpdmFsZW50IHdhcyBkb25lIGhlcmU6DQo+
ID4gPiANCj4gPiA+IC0gICAgICAgW0RBSV9MSU5LX0FEREFfQkVdID0gew0KPiA+ID4gLSAgICAg
ICAgICAgICAgIC5uYW1lID0gIkFEREFfQkUiLA0KPiA+ID4gKyAgICAgICBbREFJX0xJTktfRExf
U1JDX0JFXSA9IHsNCj4gPiA+ICsgICAgICAgICAgICAgICAubmFtZSA9ICJETF9TUkNfQkUiLA0K
PiA+ID4gICAgICAgICAgICAgICAgICAubm9fcGNtID0gMSwNCj4gPiA+ICAgICAgICAgICAgICAg
ICAgLmRwY21fcGxheWJhY2sgPSAxLA0KPiA+ID4gLSAgICAgICAgICAgICAgIC5kcGNtX2NhcHR1
cmUgPSAxLA0KPiA+ID4gLSAgICAgICAgICAgICAgIC5pbml0ID0gbXQ4MTg4X210NjM1OV9pbml0
LA0KPiA+ID4gLSAgICAgICAgICAgICAgIFNORF9TT0NfREFJTElOS19SRUcoYWRkYSksDQo+ID4g
PiArICAgICAgICAgICAgICAgU05EX1NPQ19EQUlMSU5LX1JFRyhkbF9zcmMpLA0KPiA+ID4gDQo+
ID4gPiBTbyBJJ20gd29uZGVyaW5nIHdoeSAiQUREQV9CRSIgJiAiRFBUWF9CRSIgJiAiRVRETTNf
T1VUX0JFIiBhcmUNCj4gPiA+IGluDQo+ID4gPiB0aGUNCj4gPiA+IGVudW0gbGlzdCBvZiB0aGUg
YmluZGluZyBzaW5jZSB0aGUgY29kZWMgaXMgYWxyZWFkeSBzcGVjaWZpZWQgaW4NCj4gPiA+IG1h
Y2hpbmUgZHJpdmVyIHRvby4gSSBwcm9iYWJseSBtaXNzIHNvbWV0aGluZyBidXQgSSBkb24ndCBr
bm93DQo+ID4gPiB3aGF0Lg0KPiA+ID4gDQo+ID4gPiANCj4gPiANCj4gPiANCj4gPiBUaGUgZm9s
bG93aW5nIGNvZGUgc25pcHBldCBpcyBjdXQgZnJvbSBbUEFUQ0ggdjIgMS83XS4NCj4gPiANCj4g
PiAgIC8qIEJFICovDQo+ID4gLVNORF9TT0NfREFJTElOS19ERUZTKGFkZGEsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgREFJTElOS19DT01QX0FSUkFZKENPTVBfQ1BVKCJBRERBIikpLA0KPiA+
ICtTTkRfU09DX0RBSUxJTktfREVGUyhkbF9zcmMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
REFJTElOS19DT01QX0FSUkFZKENPTVBfQ1BVKCJETF9TUkMiKSksDQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgIERBSUxJTktfQ09NUF9BUlJBWShDT01QX0NPREVDKCJtdDYzNTktc291bmQiLA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
bXQ2MzU5LXNuZC0NCj4gPiBjb2RlYy0NCj4gPiBhaWYxIikpLA0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICBEQUlMSU5LX0NPTVBfQVJSQVkoQ09NUF9FTVBUWSgpKSk7DQo+ID4gQEAgLTE0MCw2
ICsxNDAsMTIgQEAgU05EX1NPQ19EQUlMSU5LX0RFRlMocGNtMSwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgREFJTElOS19DT01QX0FSUkFZKENPTVBfRFVNTVkoKSksDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgIERBSUxJTktfQ09NUF9BUlJBWShDT01QX0VNUFRZKCkpKTsNCj4gPiANCj4g
PiArU05EX1NPQ19EQUlMSU5LX0RFRlModWxfc3JjLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
IERBSUxJTktfQ09NUF9BUlJBWShDT01QX0NQVSgiVUxfU1JDIikpLA0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgIERBSUxJTktfQ09NUF9BUlJBWShDT01QX0NPREVDKCJtdDYzNTktc291bmQiLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJt
dDYzNTktc25kLQ0KPiA+IGNvZGVjLQ0KPiA+IGFpZjEiKSksDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgREFJTElOS19DT01QX0FSUkFZKENPTVBfRU1QVFkoKSkpOw0KPiA+IA0KPiA+IA0KPiA+
IFRoaXMgaXMgd2h5IEkgdGFsayBhYm91dCBzcGVjaWZ5aW5nIHRoZSBjb2RlYyBpdCBjb25uZWN0
cyBpbiB0aGUNCj4gPiBtYWNoaW5lIGRyaXZlci4NCj4gPiBJZiB5b3UgY2hlY2sgb3RoZXIgZGFp
LWxpbmtzLCB5b3Ugd291bGQgc2VlIENPTVBfRFVNTVkoKSBpbiB0aGUNCj4gPiBDT01QX0NPREVD
KCkgZmllbGQuDQo+IA0KPiBPayB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbi4gSWYgSSB1bmRl
cnN0YW5kIHdlbGwsIEFEREFfQkUgY291bGQNCj4gaGF2ZQ0KPiBiZWVuIHJlbW92ZWQgZnJvbSB0
aGUgZW51bSBsaXN0IGJlZm9yZSB5b3VyIHNlcmllIGJlY2F1c2UgdGhlIGNvZGVjDQo+IHdhcw0K
PiBhbHJlYWR5IHNwZWNpZmllZCBmb3IgQUREQV9CRS4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4
YW5kcmUgTWVyZ25hdCA8YW1lcmduYXRAYmF5bGlicmUuY29tPg0KPiANCg0KDQpBY3R1YWxseSwg
aXQncyBhbGxvd2VkIHRvIGJlIG92ZXJ3cml0dGVuIGJ5IERUUyBjb25maWd1cmF0aW9uLiBUaGF0
J3MNCndoeSBJIGxpc3RlZCBBRERBX0JFIGluIHRoZSBlbnVtIGxpc3QgYmVmb3JlLiBIb3dldmVy
LCBJIGZvdW5kIHRoZQ0KYmluZGluZyBhbmQgbWFjaGluZSBkcml2ZXIgd2FzIGltcGxlbWVudGVk
IGZvciBtdDYzNTksIHNvIEkgdGhpbmsgaXQncw0KbW9yZSByZWFzb25hYmxlIHRvIHJlbW92ZSBp
dCBmcm9tIHRoZSBsaXN0Lg0KDQpUaGFua3MsDQpUcmV2b3INCg==
