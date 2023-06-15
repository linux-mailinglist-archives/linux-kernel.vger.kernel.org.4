Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242B7730D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 04:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbjFOC1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 22:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjFOC1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 22:27:08 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0854D1FC7;
        Wed, 14 Jun 2023 19:27:05 -0700 (PDT)
X-UUID: 1c1173fe0b2411ee9cb5633481061a41-20230615
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:To:From; bh=at9bxj35r127Lgx5VhK5HfXT9gaL+zk0Ic3dMLdPG7I=;
        b=mbUEx0tUFubwjt1duiTSAzZdGo2FDIEi+7/Qh3zv7z6s0S+vDUuGTTqvAkN6kzvDavODPhXtujcp9dUwui74rBKY0asrQy4yo6V7I6VdEa8q3ho705JCLl5p1fwdGiftGcDHRiov8ZOVh7u+44JgiLxIBd23WVlEQQ119IMlogQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:0ad410cf-50e4-4d8c-bd9a-f47cccb40465,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Release_Ham,ACTIO
        N:release,TS:79
X-CID-INFO: VERSION:1.1.26,REQID:0ad410cf-50e4-4d8c-bd9a-f47cccb40465,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:28,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:79
X-CID-META: VersionHash:cb9a4e1,CLOUDID:3017a93e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230613165153OC2057HH,BulkQuantity:50,Recheck:0,SF:38|29|28|17|19|48|
        102,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40|20,QS:nil,BEC:ni
        l,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_OBB,TF_CID_SPAM_FCD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS
X-UUID: 1c1173fe0b2411ee9cb5633481061a41-20230615
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 220726591; Thu, 15 Jun 2023 10:27:01 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Jun 2023 10:27:00 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Jun 2023 10:27:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAs2xXfZ3/N/WAaNut5YC93t+6BrwWDWbvLza4z3gia9QAfzUUBBltfgZweF7MeGobb6gSY2KhMEDjYbL4Q9F2Iyk+kdxZnf3dc1rDUaXeBYDOWfl5jrK8kroKvAiFUTbxGfpUvoeEnfOrj80F/voHchoEVqwPKk/g1Xc/VT2Khkdaf6WZ/wsaQxqX75UvICGKHhO2ItZaaONXVYT/8XOk7E9kZupDh5ZfDrvIwEc/pZ1y7Z3ezF+rkWZipJNtM1+9csequub01MayZY6RWZt2OOuvHozAlxXfjohkTBbksJhsXegjaANyUYoygD2gymQdPU99X9SB5QEmqwiZasaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=at9bxj35r127Lgx5VhK5HfXT9gaL+zk0Ic3dMLdPG7I=;
 b=Qwd4NicsTXTcMCtnTLD52DLGUMFW9hHLxiNWrKkCjJyedRfZGWO4hpHWQfvfNUD/7SEcsamhM2pXm7KKej2Nhj4umT/aenMOIppycnUcrDYQziYWcUmwXJCZMvZEKO82NO+BXnnCJ1EYGIdJkChbhshM674dwuTTHdEB2K/9Tl39i+iwjVIORj6TbAjiqGbzjv7aNi7CY3m5OzEYQu0SpiflaswXw+FmBQ7jGW1oeY/hy9fMi6fCx3ANS/RcoCYwc9its37M43mgYM+CN50xn7ObpvhXtcyBcaMIjVXU022/k6zWGTdNTX64Hrq6HxnLqO10I5eJ9I6SLWvHdApwBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=at9bxj35r127Lgx5VhK5HfXT9gaL+zk0Ic3dMLdPG7I=;
 b=jrMqZVXM+7s37BNwo7xudfz8IJ8nI/jaFOl0N6JYVEHgV+jDY1w27dHegGNtH8DozhCtqtfChgi6lgwhcWmHg8D5gNmUDTAEjapm8UA2MmNnKffLdEJzgOI7gEJTLj0TEA7/Umv6FrxJDbQhLXXi1HgNl65HCILaLwpBV06Vkpg=
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com (2603:1096:820:94::13)
 by PSAPR03MB5655.apcprd03.prod.outlook.com (2603:1096:301:8a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 02:26:58 +0000
Received: from KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d]) by KL1PR03MB6389.apcprd03.prod.outlook.com
 ([fe80::cf4d:1ca0:d375:a32d%4]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 02:26:57 +0000
From:   =?utf-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        =?utf-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?utf-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Thread-Topic: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio
 afe document
Thread-Index: AQHZnRwwFFXmmj8e60u4F1KEKx4v7q+IblCAgAE08ICAADcngIAAEWUAgAAMWQCAABA/gIAAEqOAgAEMdQA=
Date:   Thu, 15 Jun 2023 02:26:57 +0000
Message-ID: <0e440369465369421f64ce00ee83b46b23c358de.camel@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
         <20230612105250.15441-8-maso.huang@mediatek.com>
         <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
         <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
         <d6289232-6276-a2d3-c059-1edcef6a1b6f@kernel.org>
         <a338bf978dfa0af84a6728ab66dc51e45a20c7c4.camel@mediatek.com>
         <4305b7f0-bbc8-f913-d9b1-d7b492df7ef4@kernel.org>
         <0977c72a4f63132104736b9de8aa8246abb34894.camel@mediatek.com>
         <645989de-7a61-29e7-9cf8-f473b9b384fe@kernel.org>
In-Reply-To: <645989de-7a61-29e7-9cf8-f473b9b384fe@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6389:EE_|PSAPR03MB5655:EE_
x-ms-office365-filtering-correlation-id: 096fb687-98d1-40b6-d411-08db6d47fe33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHRJnCZ+/2wcmRhX2swhwfw6R+fiTpCHI9kJEYUd4lakT9gU2TbTD/RnVtgaT2dssfUwJvCN5uwh35GxLiL1f1C0xgoCyo/i++Fq1FKJazYMOr1GPdIn3WKZOCxuwpB/ar5t/PDAAm9wbRdKyrzE4HQa7l0GVNfr3wUC0/V2+8zi1YprDGKKoTNSvFm3010Pa2+wYv7s8A5rt1fvYUTAbgSGtrtCvbcUCoozmiBupqQmRijVcPkzahRvn9uIqEEvQ1aLliOtLPQMyhgxZg7kxjmrOwK123JQEq1ygQbvtRxIE8pi7owMwWyz5Zk6mOJTTA7xgKR+VOe3wQW6zZAUEktyBuH6UGxdNEeDI/PwR1ITiFZMNzUsydvsm1kuyGWh893fVy5dUcq9CyXOfPksNTTORjBT8VrI+ZZByco+ZRDiNmxgMFc698APqAgI09t83ddEWru7o6a0ugV3zr0JkSFr2+LV4u0O7N3H0A0fns8Qr9/mX0Ap8LAVvlnLIijp+5HkW+h0iqIFUXSD7vG4dX428upliBuLDnJFzLtMG33Lq56StvrZEnPPe63xko8zick07sREtcGZ/LmX0RS0AOEaE5t178tycHyMYtDlnJ0YU1rX1gnBYA3BhyLztpHI4IxEqISFxV9pt8+kI1xrQXz2cU4joCnX+N1JfVV97fFAky2X/64EjBqG2ibIDVsR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6389.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199021)(6512007)(186003)(26005)(6506007)(53546011)(2906002)(66556008)(6636002)(76116006)(91956017)(66946007)(64756008)(66476007)(66446008)(83380400001)(2616005)(86362001)(85182001)(36756003)(6486002)(41300700001)(5660300002)(8936002)(8676002)(7416002)(316002)(38100700002)(38070700005)(122000001)(921005)(110136005)(71200400001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1Z5K3lGdDliaklDSVcvcXc1cUFYOGRtdlZCMlh4eGk1L05XY2d5QmJ5WEt2?=
 =?utf-8?B?ZlVOUWUrTm53eDRiMUVzU0xzVTNFeG9uS2tuWW1BNmpyUmp3cC9lZFpjSUox?=
 =?utf-8?B?NEJlUXppN3JVWk40ZGNObENnbTExc1loWHd5aVdRd0ZPZlJRMkJxaDR0QmxB?=
 =?utf-8?B?UEZmZHNQS2tLTkRLblJ3T1pBQ1BEdDNYNm00Q1F4dHd6NkVndEIwWFcxaVg1?=
 =?utf-8?B?bTh3SHRXWHVBbFVwWEQwVmQ0T3VqTjMyd0ZXSElwYlRFMTNMZXpKV1RMQjFU?=
 =?utf-8?B?eDFRUlp4MzFrcGlOWmN5NlZTaFpZem9jZEd2dXpBd0hPMUtWQm9jMjhHRWtq?=
 =?utf-8?B?V2pwdUtrejZlTnZuaFVGaExySjJ3M1ZFT01lZSswOFV6MEowcERjdDVZVXdV?=
 =?utf-8?B?M3BCQlJHcWxiODhRb2pBU0poeU1oNTJBek5jNUM0T3FsbkIvTk5ra3hlemdx?=
 =?utf-8?B?MkVJVHJMbUIxQXJNVFVBUVEwV2w2SlJ5eEcrNDRnOXZMV3RVNzRTdllwaXFk?=
 =?utf-8?B?QjY2NmpOSlNGbkpnSWVkcTBUdE4vMlh2TzJVN2Roc1U1VC92RGYrSUFXa2du?=
 =?utf-8?B?VE9hd3lKSlJrQ1oyc1RGQkwySzMvMW1TSmtrSXN6NGZKTkdTWGpDSnZTcDJx?=
 =?utf-8?B?d0t4MHpOcmdIR3VjTEp2N1EwWTkwNnBrZGhsMHhJckpTdGRWZktEYUczZ0s2?=
 =?utf-8?B?NkR6WWxHZ2hlVGZNT1RYa2dBRi9YUVBWT1MrUzI5T0g3blQ0QnA3d1JRdHlO?=
 =?utf-8?B?RlpYSWgwVWhlL1pYQzlQbml3Qk1oQzY2VEQyT2lndzhZbUtEbExPR2d3QVZv?=
 =?utf-8?B?QUg5akNoWDdYQkRpMEJQRGx4OXRHR2FTWEVyTmJQZ3BpcGdhN3RNbVMvUCs3?=
 =?utf-8?B?cHI1ZDNkSExYWnJ1RDMwNHYrcGlNMWgrRDBDQmhRbldoWnYzWGZ1V2NVNHhT?=
 =?utf-8?B?M0dOUzYyWDVZVExuOVBZaHlQN3JxaUpxNTFWcThsZ1had3B5aXcydytIOXlh?=
 =?utf-8?B?c2JNSUh6SzNuZU9VTVBqU0ljb1J1RStVcGh0cGJKYWhQdTNkQlQ2elcrMWVP?=
 =?utf-8?B?d2NoYXFDck5WKzY0ZWQ0d2kvYUdGMCtBZVJyTVd5S0JuRVJ3dmQ3Z2kyeTVw?=
 =?utf-8?B?ZHBPbGhMdXNoZklZaUQzUVEyQkdWTC9PdFFtdVJ1TUYxWGh1MFhMaGNxVlpz?=
 =?utf-8?B?UXhCUlRidzZrYWcrMDVKQmdzZkNvd3AyQ2lTZDgxMzQrTW56S2l3ZjhnNjcr?=
 =?utf-8?B?SFNLQWdYSmVVRjd6WVF0bENNRUsvM090cktVM0ZTMzBBeSt2VWx0L0N0WkRn?=
 =?utf-8?B?ck15MG9XRTRna3FTRmZCZEE1UE1WMzUwZVliVUtJQnJpV01UYTBPZHVFUlRK?=
 =?utf-8?B?cGFMY1hpM3JzQ1EyRUlkb1FSUVFYU2JtTzI1R1hGUmtaN004cnZsS0RZcEJF?=
 =?utf-8?B?MmRGdnlOOTRrdldBb3VSU2F6aVYxcEJ3OWVQVGRITjFaKzFMQ1BXSEFWZHZ3?=
 =?utf-8?B?SEh2S1dmVFdVSUJPNE00NlBIdWZZdEYwZjE0VkZnQ3JrKzQ0OTd0dUNVd1Ns?=
 =?utf-8?B?M2cwbDJyOEFuaGdLYkxCOEg2clVXSE5oMC92ZC9NV05PT0NZZSszbUZpZ0xq?=
 =?utf-8?B?QzNvb1dPYlk3NCtlNG5tZ2Rmc0JrbHpZMUNaRndiTkdkQ3dJYWhmWVJJa3Uv?=
 =?utf-8?B?b0tidlorSlJuenJhSTBFclNES2ZmTjJOaXF4WTJGVEl6eFVVdFBJc2tONlk2?=
 =?utf-8?B?OW1NTXZTYUpzM3Q0RTB2dEVCL2FxaGk0WDBGMTE3WXhJNHJoUTBWOVdpTGZI?=
 =?utf-8?B?QmdZU2J4d3p6QzhYeFhoWU1uTnlZVElVcFNvdnRpYkQ2aXBESkFZVWF4WlE2?=
 =?utf-8?B?c1BjVURRUkgyNlpiekoxYVp2eTZUaFZBc1JEd25VRlAwVko1UGQ4a2ZYRTl5?=
 =?utf-8?B?QWpwTWhTZVRTSmxkUklhbTEySXExZDhHZTI0b09UWjNMMjNCakMremthbzY1?=
 =?utf-8?B?ckhpbUdTeEIzeWU1Rlo4eHVJbGVUQkZ0ak9DNFhPaDJ5L1FObWpldU5BbTN0?=
 =?utf-8?B?UVFqRjlJeStwUENFc2FZdHRLRnpWVDJCdjJVblFBZWVYZTR1a1l5T2RJMFJF?=
 =?utf-8?B?YmU4MzlwUjJrbVZ5QmxKcC9waTdpdElYbWNMM2phcytJcHpydi9jN3J0VVFp?=
 =?utf-8?B?QXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D49B57A4867527488D203D77EAD26E61@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6389.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096fb687-98d1-40b6-d411-08db6d47fe33
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2023 02:26:57.7436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5ZbBLnZysQVjGaK6sxZovR/kmLmaIGpDCjE5mLnoR3XIDku1I8Wu1lag84QSK3SpCy//PeHwkvEoJAENJDx4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5655
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTA2LTE0IGF0IDEyOjI2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDE0LzA2LzIwMjMgMTE6MTksIE1hc28gSHVhbmcgKOm7
g+WKoOeruSkgd3JvdGU6DQo+ID4gT24gV2VkLCAyMDIzLTA2LTE0IGF0IDEwOjIxICswMjAwLCBL
cnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+PiAgIA0KPiA+PiBFeHRlcm5hbCBlbWFpbCA6
IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiB1bnRpbA0K
PiA+PiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiA+PiAg
T24gMTQvMDYvMjAyMyAwOTozNywgTWFzbyBIdWFuZyAo6buD5Yqg56u5KSB3cm90ZToNCj4gPj4+
Pj4+IEkgYWxyZWFkeSBzYXcgQUZFLCB3aHkgaXQgY2Fubm90IGJlIHBhcnQgb2YgZXhpc3Rpbmcg
YmluZGluZ3M/DQo+ID4+Pj4NCj4gPj4+PiBDYW4geW91IGFuc3dlciB0aGlzPw0KPiA+Pj4+DQo+
ID4+Pg0KPiA+Pj4gRGlkIHlvdSBtZWFuIG10ay1hZmUtcGNtLnR4dD8NCj4gPj4+IElmIHllcywg
SSdsbCBtb2RpZnkgbXRrLWFmZS1wY20udHh0IHRvIHlhbWwgZm9ybWF0LCBhbmQgYWRkDQo+IG10
Nzk4Ng0KPiA+PiB0bw0KPiA+Pj4gaXRzIGNvbXBhdGlibGUgbGlzdC4NCj4gPj4+DQo+ID4+DQo+
ID4+IE5vLCBJIG1lYW50IG1lZGlhdGVrLG10ODE4OC1hZmUueWFtbC4NCj4gPj4NCj4gPj4gQXJl
bid0IHlvdSB3b3JraW5nIG9uIHNvbWUgb2xkIHRyZWU/IElmIHNvLCBwbGVhc2UgZG9uJ3QuLi4N
Cj4gPj4NCj4gPj4gQmVzdCByZWdhcmRzLA0KPiA+PiBLcnp5c3p0b2YNCj4gPj4NCj4gPiANCj4g
PiBIaSBLcnp5c3p0b2YsDQo+ID4gQUZFIGlzIGNvbW1vbiBuYW1lIGZvciBvdXIgYXVkaW8gaGFy
ZHdhcmUsIGFuZCB0aGUgZGVzaWduIG1pZ2h0IGJlDQo+ID4gZGlmZmVyZW50IGZvciBzb2MsIGxp
a2UgY2xvY2suDQo+ID4gDQo+ID4gQW5kIHRoZSBkZXNpZ24gaXMgdGhlIHNhbWUgZm9yIG10Nzk4
MS9tdDc5ODYvbXQ3OTg4Lg0KPiA+IElzIGl0IGJldHRlciB0byBjcmVhdGUgYSBuZXcgZHRiaW5k
aW5nIGZpbGUgbWVkaWF0ayxtdDc5ODYtDQo+IGFmZS55YW1sPw0KPiANCj4gSXMgaXQgZGlmZmVy
ZW50PyBUaGF0IHdhcyBteSBxdWVzdGlvbiB3aGV0aGVyIGl0IGNhbiBiZSBwYXJ0IG9mDQo+IGV4
aXN0aW5nDQo+IGJpbmRpbmdzLg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K
WWVzLCB0aGUgZGVzaWduIGlzIGRpZmZlcmVudCwgSSdtIGFmcmFpZCB0aGF0IGl0IHdvdWxkIGJl
IGhhcmQgdG8gYmUNCnBhcnQgb2YgbXQ4MTg4IGJpbmRpbmdzLg0KDQpCZXN0IHJlZ2FyZHMsDQpN
YXNvDQo=
