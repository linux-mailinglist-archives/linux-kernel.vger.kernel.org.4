Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0630163D17C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiK3JPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:15:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiK3JPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:15:20 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817B531201;
        Wed, 30 Nov 2022 01:15:13 -0800 (PST)
X-UUID: 4e536982962a4b1ea35fb4acfde7da02-20221130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=JdmGXrUt7INm4Fqts2IH44ZHp0AThElLZhjoibDGKDM=;
        b=mzjzZq6MAIXajom1YSdt3ptxVtJNhB3Lb26CxtUtzsFzZbYuy8QQR1purKXmFyYoEtTBTpMUu3HwNlIhlmpgmv8cLqItdgf/yFc0u/lPeJKYe5W2UikSqu5oOeUBzzYplOuEJFel9MHAo/pbP3hwZUUqxvO0+9Xso8GtjKSrUhc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:09bd8b68-3392-485c-800a-83c5a7e38cde,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-INFO: VERSION:1.1.14,REQID:09bd8b68-3392-485c-800a-83c5a7e38cde,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-5
X-CID-META: VersionHash:dcaaed0,CLOUDID:97a3bb1e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:2211300322461H419ZCJ,BulkQuantity:3,Recheck:0,SF:38|17|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
X-UUID: 4e536982962a4b1ea35fb4acfde7da02-20221130
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <eddie.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2133759042; Wed, 30 Nov 2022 17:15:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 30 Nov 2022 17:15:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 30 Nov 2022 17:15:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azpoITcPNGJeVoSjprIWt8AKv8W10B6uXT/zmfFsZ7f9mwLsjBTMiQNgtx6CurQkj+NhsrxhoCHC4WVv8bZzIWjgwQdMz+K4XNIOT68pOu6bG3rTdoyHwyD86ThM3tCD9Kkad/alImYNPmfjHPND2Kh7rMrDotJN/tIQZ2gABZ4wCmeF0bpQ73If6KRCSqxSMTLRbbkDM99JreDg4QAWGfA0lswEkhbzbmWpHb3ipzlxIhOySGgO4BdvN/W13+Z5L5HyNiVo0ZB9uqxj7T6pXChARC9VST+NAXZQ+q8wIlYwJyC5xVfhq3VFkc7BNegy1R0NRzZ6E2cNpZwR0+Otow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdmGXrUt7INm4Fqts2IH44ZHp0AThElLZhjoibDGKDM=;
 b=iZQC/Ipgll21jOrWCAskNQxZsavyJP6SxobzxCg9B6Ho1uvsaqnB5IqtYo72Flaaum+SccHDQAFa7S7/VTogV4hB8CAcblrClrDOCQChCTobvViWiMI0xZJBYowI1Fzz6pkuS0GY90EL3OpdpCSJABznfUiL9XwfsX5TvRBMy2tptvwgPuIQQvU7pAN8Wc7MmK7vBjhDyntJw86z0qG2z8PaX2VRvvgPtWWaWXUpL5zWX4WhU21hwvwA4tPfFbYijn5exOsTj83DSDJeZ1sp9jJwhRWAUJ3ScqGa4ggIg4GzRmQGaVOjMN+nvEskHgA3GlmKWd5liGl6ayO7sxiwbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdmGXrUt7INm4Fqts2IH44ZHp0AThElLZhjoibDGKDM=;
 b=p5tBzJ0ruCvCUoDuup7710nqR6y6rXZhrQ6mUxiJ5ArQ4d/g9P/CwgNpkdaxEHh09fkgCcQnUmECGLADBIrFXXvRpP79ve3ZPDhiZaSrCBWqH6GBGW1iduOukvWE6MrhmaK4MAJ1eyRmH1MgwGx+wkHB+eEvy0Q/cG7VEBTZPtE=
Received: from PU1PR03MB2795.apcprd03.prod.outlook.com (2603:1096:803:24::12)
 by SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 09:15:05 +0000
Received: from PU1PR03MB2795.apcprd03.prod.outlook.com
 ([fe80::e102:52cd:8a5:8cb9]) by PU1PR03MB2795.apcprd03.prod.outlook.com
 ([fe80::e102:52cd:8a5:8cb9%5]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 09:15:04 +0000
From:   =?utf-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>
To:     "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "j-young.choi@samsung.com" <j-young.choi@samsung.com>,
        "Arthur.Simchaev@wdc.com" <Arthur.Simchaev@wdc.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "daejun7.park@samsung.com" <daejun7.park@samsung.com>,
        "mani@kernel.org" <mani@kernel.org>,
        =?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        "quic_xiaosenh@quicinc.com" <quic_xiaosenh@quicinc.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>
Subject: Re: [PATCH v7 06/16] ufs: core: mcq: Configure resource regions
Thread-Topic: [PATCH v7 06/16] ufs: core: mcq: Configure resource regions
Thread-Index: AQHZBCQ3+GWAKKRy/0iwn3zvXGFMTa5XMC4A
Date:   Wed, 30 Nov 2022 09:15:04 +0000
Message-ID: <37a017a2176fee1da8a7903613f132b22c9741df.camel@mediatek.com>
References: <cover.1669747235.git.quic_asutoshd@quicinc.com>
         <c655d1e62f619818e034f76c90330393cba8c79b.1669747235.git.quic_asutoshd@quicinc.com>
In-Reply-To: <c655d1e62f619818e034f76c90330393cba8c79b.1669747235.git.quic_asutoshd@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PU1PR03MB2795:EE_|SG2PR03MB6279:EE_
x-ms-office365-filtering-correlation-id: 9331dc56-8d6a-4273-807a-08dad2b35e38
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SSAVJZJcZdiilG3SfacjbAJO/UrK+vGF/8dKzyhJKPSUa/ZTxL+s1Nb2MRaWNRu24hY1/xLidVdKfYd2l/guKauGrVNT3lq0rl3NPPGlA0snkMlubvCQrGMoQQTllaYt/8SLNT8zKCtWcwZ2S1DFWjIO/aE+UbWfZIURhn8AjAxJHSYSW8OWzLiuif2LL2jMxsWASkv4WqcPWgQkn9j2xSSQIUB450d8+hY+OfpLokW0k0uAcdkcbu0eQ1cYLiToQwSrvQZcf0ncaI5hhRhQ/xpdcpZu8aSQCa4XycAyJ8Jg9vAOo47Dz1ragICi65z1xOLKeTPPDM/scoNgQ2N68Cq3HOIwktPy+SCy71RasWull0dq0jwQttzso8N9JqEoXOymEQYsuUXwHZzhGXdq1ki52GBSnEUPjyU7tu7vLuEiPs08SpmO+pY7Rcany7lEFDdh092jQR1zVFskmfS+wOCyeuvjobEizQF+rnKSmxX0GityexeaMMw4P9K76/eOiLWQ6NnSyf174mt88Hc1vTOtUHc2tbwO3+yURDUzPn046dSkfAHptD6VPBZbx4wdTHKanF9C70stVD3QafKprdAE9Bu7myPEXk6+bVe0WvzIfeHcyxO24BwzdeCASYDCn3ZobJjzdsobZqFlLYfnoe4y/JvSkHGNiA2iBkFGQwuTaRFYiV/G5Ij1QCI5ECDRChqjgySd/84Z3fYmR2PDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PU1PR03MB2795.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(366004)(39860400002)(346002)(136003)(451199015)(2906002)(4001150100001)(8936002)(316002)(8676002)(41300700001)(7416002)(5660300002)(66946007)(91956017)(66556008)(64756008)(66476007)(76116006)(4326008)(66446008)(54906003)(2616005)(6486002)(85182001)(110136005)(71200400001)(38100700002)(186003)(86362001)(478600001)(26005)(6512007)(6506007)(36756003)(122000001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1hyQTdyeExFajlYTmRQa0tubVdjaFpYN25zdFpzZUxtbEFZVFZUcVh2ZlVJ?=
 =?utf-8?B?Z1FwWG9hajlhSzByNTNnUzZzS1dkcnNNOTVjaFJDL1NvUEpYcjV6WUxqeDRl?=
 =?utf-8?B?WDBvQ1BHZjRneEJ2Z1E3VGh4MjJ0QlBxMFZQUVRuR25ublRaYTRWR1BheXZm?=
 =?utf-8?B?dyt1NkVqWEZROTJyRTlyakVTd2FmcUNFN3JUd1RWeE9xY3JkY3pqelZMOVRn?=
 =?utf-8?B?eHRRdERCVWsxT3NrbmZBdUJTNEhRL3ppYmIyZkZ1bUhMVElGK0luR0x5eVNI?=
 =?utf-8?B?MXdZMmIwNUJtQ1B3cUw5ZUNLbzlYcmF4aFBMb3ZTVkZzYUhJU25EUlpjTlBj?=
 =?utf-8?B?RjE5YWFpZjBiSTdZR2s5Z0daWlpFSDRrMm1hbnRoeVNWNlpkRWsvb3RROW82?=
 =?utf-8?B?Y01TZUN0Ym9QZVNtMnVKYWNvWk5nYjBjV05QUkQwbUF6UU1wQ0tWQWVkbmhW?=
 =?utf-8?B?dWpJRzhkTG5uSkw4Qk1HZ3EyOEtJLzFNSy95UDJvRzJ2R0lrS290K25Yb1VB?=
 =?utf-8?B?cEtiNWMzY0ZSREtMeHhUOUxwbk51VXNlQmE5UlpHZGxEenV6ZEVRUDljVFls?=
 =?utf-8?B?bnBiUTVERjByc01iN1A3T3UzdEFRbTRSMkJadzBUNWRvWE56b2xzN2dtbm9E?=
 =?utf-8?B?SEZKY2J0VXltTDdCdDRTa1I4RVR4VWF0bWs5Yms4bTFpNk9Pem91RmplMHUw?=
 =?utf-8?B?RE84Rk9Cc05rLzFXWWIxZlgyckR1aEhyVk9kM0owem8rWkQ2R0crTmwzSnhh?=
 =?utf-8?B?ZlN1ZVhjVFl5d1ZNWEpqcnRxSmJUSVBwcUw4YW9Dc2R6NlBKaGRQMTk5Q3h2?=
 =?utf-8?B?RW1BVVRmbUJFOWxSWnVzdkwxcnJza3FMdzluWlBLT3c4d3FzK21mRUdXTnJi?=
 =?utf-8?B?cmlNbzRocVpDa0xiODdveWtrOENoS2pDNnN4UmVFOVZRMDhCS0ZwbTlMckZR?=
 =?utf-8?B?MlJ3eDE1SXcxcGxscnZjT3NxNjQxSnpSVkpxcnBnT2Vvd3NOQVBBTUpCTkV0?=
 =?utf-8?B?QVMyU3hNbWFOeUs1VHFHTk1YYkFkb2ZUQnZuaVV6bWpJSHd4bk4zSis0dlN0?=
 =?utf-8?B?MzVMRjNvTm9tZ3pBYWhiT21JaHZsSDMwZVhaUkt3Q00wQ2h5dDNLRDdrdnJn?=
 =?utf-8?B?cHYzenAwRkhLVGFsSGNqWW1kWGUxa0FiZDNSUmQra2FjTjZ0aUgwWTZzU3ds?=
 =?utf-8?B?RXdHY2NTWTNzcURwWTJiWDVrN08wbWYxUy84V3VBaW1nV3JObFYrcjZ0Y29x?=
 =?utf-8?B?cWhoci9ua0FXOU1UaHZ2NHdmY2htNlhKR2lxVUJuKysvdWJKVWlDYTMvUElq?=
 =?utf-8?B?T0JkekQrUm9HWDl2OXg0SFVYc0ZQYXhnVlhTaGZKQ1pUOWxDSlBwSW5aWndH?=
 =?utf-8?B?NHVOWFB3Z040Sks5QmJ5NEw0NlRNZUwvNzloYmw5R0xXNXpCSGg4UjY3Tkhk?=
 =?utf-8?B?eGdPSGplS080MGhNL3JBR1ZGcWE4Z09oc2pjZVdPSlhHQkhBTWNicW9yVjJJ?=
 =?utf-8?B?bmw3bG11Q2V6WmlCRVp0eFExWTdjaUFYOE9XNjJGT1VvZk1Od3Mwb3dxTHhs?=
 =?utf-8?B?UDdkWmI4aklKK1hRcjFLU1BBaDU2ZHpRNmlTVFduS0hXTkNRa21yblltOCta?=
 =?utf-8?B?b1JnZ1BrUFVLNGd1dTl5VlVEcEJxaWNiTEZTVGNOUXlsOW5xMk94di93RlhU?=
 =?utf-8?B?b3dIemFHakdoZ3ozMUdKYjZaZDBuYlJDWDdIc0NTTFEveWw5NFhnblNDSXNH?=
 =?utf-8?B?TnA5aG5xa3NydkhlRWdTZzR3QWEraGhGM0MrYVdnclQ4TU01elpIWXRLdTV5?=
 =?utf-8?B?OU1pTGR0aXNnMS9Sc1hHYU1iRndTNU9wa3dkWitNakhKQ3h1Q1pUdFp5NFg2?=
 =?utf-8?B?L1lKL0UyQ0FacCtBY0pldklockNIQTVybWRZSUxDSHh3a3daZFdJVmtQeS9a?=
 =?utf-8?B?eHdSa1JMMTNWREZYcDY5ajBnLzhrQzBEV1lXbExqSjRzOXVhOHVUK2MxYk1q?=
 =?utf-8?B?WnhZNVo0MU0ySTI0OXkzMHQ4Tk1ZOG91YVc3dDJMVmRUN1hTYkROSkcwUHRV?=
 =?utf-8?B?V1U5aXNyRjBUUGRiRXU0VER3azJjYVdEdzM2blErRWFMWitJdk1JM25SajNN?=
 =?utf-8?B?d0dSb1JTcjZZbUVzTWdJVnMvVi8xQlFPUkNUNCs4ZXpRTXp4S0xGd0VZVXVo?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2E3E0CA400519438AEFBE3BBF5103E6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PU1PR03MB2795.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9331dc56-8d6a-4273-807a-08dad2b35e38
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2022 09:15:04.7774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LZs/cqJoQs/wngbIdKnm65Pd8wn2AeJRxRpKCk4gsEgXsdl2pJlpSropUTnAt4Vp520fJx7pHfYmbD2fjBN4GyMD/D2xwaUSd7eC+sp5Xi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6279
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQXN1dG9zaCwNCg0KT24gVHVlLCAyMDIyLTExLTI5IGF0IDEwOjUzIC0wODAwLCBBc3V0b3No
IERhcyB3cm90ZToNCj4gRGVmaW5lIHRoZSBtY3EgcmVzb3VyY2VzIGFuZCBhZGQgc3VwcG9ydCB0
byBpb3JlbWFwDQo+IHRoZSByZXNvdXJjZSByZWdpb25zLg0KPiANCj4gQ28tZGV2ZWxvcGVkLWJ5
OiBDYW4gR3VvIDxxdWljX2NhbmdAcXVpY2luYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENhbiBH
dW8gPHF1aWNfY2FuZ0BxdWljaW5jLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQXN1dG9zaCBEYXMg
PHF1aWNfYXN1dG9zaGRAcXVpY2luYy5jb20+DQo+IFJldmlld2VkLWJ5OiBNYW5pdmFubmFuIFNh
ZGhhc2l2YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2ZXJzL3Vmcy9jb3JlL3Vm
cy1tY3EuYyAgICAgfCAgIDMgKysNCj4gIGRyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLXByaXYuaCB8
ICAgOCArKysrDQo+ICBkcml2ZXJzL3Vmcy9ob3N0L3Vmcy1xY29tLmMgICAgfCAxMDMNCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGluY2x1ZGUvdWZzL3Vm
c2hjZC5oICAgICAgICAgICB8ICAzMCArKysrKysrKysrKysNCj4gIDQgZmlsZXMgY2hhbmdlZCwg
MTQ0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3JlL3Vm
cy1tY3EuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzLW1jcS5jDQo+IGluZGV4IGJmMDhlYzUuLmQ2
ODA3ZTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzLW1jcS5jDQo+ICsrKyBi
L2RyaXZlcnMvdWZzL2NvcmUvdWZzLW1jcS5jDQo+IEBAIC0xMTksNyArMTE5LDEwIEBAIGludCB1
ZnNoY2RfbWNxX2luaXQoc3RydWN0IHVmc19oYmEgKmhiYSkNCj4gIAlpbnQgcmV0Ow0KPiAgDQo+
ICAJcmV0ID0gdWZzaGNkX21jcV9jb25maWdfbnJfcXVldWVzKGhiYSk7DQo+ICsJaWYgKHJldCkN
Cj4gKwkJcmV0dXJuIHJldDsNCj4gIA0KPiArCXJldCA9IHVmc2hjZF92b3BzX21jcV9jb25maWdf
cmVzb3VyY2UoaGJhKTsNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiAgDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC1wcml2LmgNCj4gYi9kcml2ZXJzL3Vmcy9jb3JlL3Vm
c2hjZC1wcml2LmgNCj4gaW5kZXggOTM2OGJhMi4uNzRjYjE3YjkgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvdWZzL2NvcmUvdWZzaGNkLXByaXYuaA0KPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vm
c2hjZC1wcml2LmgNCj4gQEAgLTIyNyw2ICsyMjcsMTQgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+
IHVmc2hjZF92b3BzX2NvbmZpZ19zY2FsaW5nX3BhcmFtKHN0cnVjdCB1ZnNfaGJhICpoYmEsDQo+
ICAJCWhiYS0+dm9wcy0+Y29uZmlnX3NjYWxpbmdfcGFyYW0oaGJhLCBwLCBkYXRhKTsNCj4gIH0N
Cj4gIA0KPiArc3RhdGljIGlubGluZSBpbnQgdWZzaGNkX3ZvcHNfbWNxX2NvbmZpZ19yZXNvdXJj
ZShzdHJ1Y3QgdWZzX2hiYQ0KPiAqaGJhKQ0KPiArew0KPiArCWlmIChoYmEtPnZvcHMgJiYgaGJh
LT52b3BzLT5tY3FfY29uZmlnX3Jlc291cmNlKQ0KPiArCQloYmEtPnZvcHMtPm1jcV9jb25maWdf
cmVzb3VyY2UoaGJhKTsNCj4gDQoNClBsZWFzZSBjb3JyZWN0Og0KDQpyZXR1cm4gaGJhLT52b3Bz
LT5tY3FfY29uZmlnX3Jlc291cmNlKGhiYSk7DQoNCj4gKw0KPiArCXJldHVybiAtRU9QTk9UU1VQ
UDsNCj4gK30NCj4gKw0KPiANCg0KRXhjZXB0IHRoaXMgaXNzdWUsIEkgdGVzdCB0aGlzIHNlcmll
cyBwYXNzIG9uIG15IHBsYXRmb3JtLiBUaGFua3MgdGhlIA0KcGF0Y2gNCg0KRWRkaWUNCg0K
