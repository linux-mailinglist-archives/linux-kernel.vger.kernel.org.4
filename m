Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10E297296EB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbjFIKcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 06:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241420AbjFIKbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:31:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C059C5;
        Fri,  9 Jun 2023 03:24:11 -0700 (PDT)
X-UUID: c46a576006af11ee9cb5633481061a41-20230609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AsfdJ8osV4ths7Z9qPF6LzeU3iMZ+MF+uMSfR0BKprs=;
        b=QfFRPqx2/BwA42ZCorqi6QTaWxRwSBUEnjDYEezjChl2QnVemEwrizRAKn4nCgKD+eOBOSFpvF+eWO23HnQA7Ib7iROBj8qKk4M1QwJNm4wHFN9nMxtAXIL1FRnpavm11rHOsxD9Hr2r04uGVqRqPeifNEYBfl9Lq4z1vmKCNN8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:6c08f656-ebad-441e-9ff8-d648496877c7,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.26,REQID:6c08f656-ebad-441e-9ff8-d648496877c7,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:cb9a4e1,CLOUDID:1f981e3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230609071057XL1RVHQ7,BulkQuantity:7,Recheck:0,SF:19|48|29|28|17|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,
        TF_CID_SPAM_ULS
X-UUID: c46a576006af11ee9cb5633481061a41-20230609
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <wenbin.mei@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1520771904; Fri, 09 Jun 2023 18:24:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 9 Jun 2023 18:24:06 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 9 Jun 2023 18:24:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klwRdxC3yX9t3NeC7Y26OnSi8K6UC7Sf9BQxjOIbssdRMYlKitfb1ieaQrECniVhLsze8MsUJD/Iy7CygQ3THj45ZHhFUJrRC0dx7+N5IUFSRHQJsdDBirL2r6cQ35JWDe6ZcmDTCFoQB0kBJ6p6SdWGucPOnF3DKRpngZqJwFPnG5XBrP+N5grLeKFcDUUKCMDU6nBAGSpnjHozLLhItCMXMAo3UV2lN8deyUcNjIm6ZTu093Ruv9t5RCcCISV9vcmpPUhbgoULXa2Zi7hgiRcxjzWX+jYGUMHhDVH+BrTdLwGanl1uDTg6GFbaMPP7flKoNQtoVagKMDlerNOM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsfdJ8osV4ths7Z9qPF6LzeU3iMZ+MF+uMSfR0BKprs=;
 b=kSMxIWp56Yko7zRP53QHxaOTpPC8O+aIkr7lsnm8eAgSjoUxoHlkR9zayKfmYcIiKULBvor+OR1hLQokdjqdISUUqOWOhzje1YXDDw/8EU5nLh3FJty37txQRsoTvv/+hvVwaz93D/kMUp65TEz4E7szRl/KcE45gs+qktDDfr84BhfanwUWoad348kzu0GEj6B0iLDGRGanzBQFDGIHrg+z+W0nrS3KTcD0Xr7V3fuUN/0VsZXXSjDjHtMDkZR9fqHEHbd87DVLc9+eQM10ZBBYerx5tEEjYzCcEL9nS/f8Y9o/2E9RZjKgZaHYSCNuImlz9FDna2YveSgIeoWIEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsfdJ8osV4ths7Z9qPF6LzeU3iMZ+MF+uMSfR0BKprs=;
 b=PGc7SXPglp+hV/sSdNp/WPuW4+3ly5DBQMp97pROKvlSidEUMM3xcTMksBJSy3eR6AQKIJ5OeOgOdMx4hT+brPH3CrpfYiIGp9MgSQzAE73h3N+cCmRsA2BzjVnwCSWdHFxWP/azxCoQw93Dw0nu2JpmBPbdxS5NBniRxWklZkQ=
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com (2603:1096:4:17d::11)
 by TYSPR03MB7884.apcprd03.prod.outlook.com (2603:1096:400:47b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Fri, 9 Jun
 2023 10:24:04 +0000
Received: from SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147]) by SG2PR03MB6279.apcprd03.prod.outlook.com
 ([fe80::e205:4140:7b24:3147%9]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 10:24:04 +0000
From:   =?utf-8?B?V2VuYmluIE1laSAo5qKF5paH5b2sKQ==?= 
        <Wenbin.Mei@mediatek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
CC:     "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>,
        =?utf-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= 
        <Chaotian.Jing@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 1/1] mmc: mtk-sd: reduce CIT for better performance
Thread-Topic: [PATCH v5 1/1] mmc: mtk-sd: reduce CIT for better performance
Thread-Index: AQHZmGqj7pMS/kTFSEOwtTS2yQ3SzK+Bi/IAgAC73AA=
Date:   Fri, 9 Jun 2023 10:24:03 +0000
Message-ID: <218629507b7a1b7353e4f58e15e642d5c7463a1c.camel@mediatek.com>
References: <20230606113249.28057-1-wenbin.mei@mediatek.com>
         <20230606113249.28057-2-wenbin.mei@mediatek.com>
         <CAPDyKFoR+0xtmjESCfk5-aUYhsjcc6ATevRoRpw+atCjmz5yrQ@mail.gmail.com>
In-Reply-To: <CAPDyKFoR+0xtmjESCfk5-aUYhsjcc6ATevRoRpw+atCjmz5yrQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6279:EE_|TYSPR03MB7884:EE_
x-ms-office365-filtering-correlation-id: 8e6ef5ac-70d1-4952-5393-08db68d3a63f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xhX52MV74Mb7zfyCF4iQZuNPfvzZr8R0Ch6WFySoTRlqm2qWYp33Can3PSJaGZxA+Fn5p3jxVtErmTkHCiLgAeX5mbB1XLqs7hRRE7TmmIM4D+vF1V5lo3kjjLG8EaMi5iz19gUpxjWQuYx+e71roAEh283VfQ/u3R5kKaR2CiVfqBOttfkql+kjyNQLg5FZMgS0ISuf7kYYUXrSP3yyc2VGUzmfSIKzroF4NUfGLn1ysEvPVYZDbfuswMNMRAn3mWeaBeLULKBs+1lqE6jvO8ZLyr0s2EoeYK/SX9SBiIlp4ydfPr1BBqnGKBy+Wk22aoVODYdSGGgJwG+W2g4pvCk+P/am6npDqL1MwlrLkHTSVqC1GG4Q/QHdPF+HRjxuX4dFFUrU9GUGz1C0iNlTpROWcm8Y9ZvAdCytKsVgg+y07gwROZWXMjMb4pc6MWNA3uF/+UWZ9PwEUUArEfbxI/TtC9lUCG87pdzR1YjS9efWP5O1KnQSCTZxcadwnDhobAOS4b9KlYvWWsJUYApUEpXUXVkYKy2TQeHd6kuQ+kH3pHkRAWWsEvHwxYQP5aKGm32Kg/rXpyAK7a5ojgmFiLBW2Bw/dqA32zGkRbHGSyHpyikux2TN5UBxCXQZvFWsr8UOfMmo81FZsyZD99BgrJ9QrUfklFTBBv+uFc9yzChRdE4vmD7d1WgpZf/Spbo+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6279.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(85182001)(2906002)(36756003)(122000001)(38100700002)(86362001)(5660300002)(186003)(54906003)(6486002)(66556008)(478600001)(71200400001)(8936002)(316002)(64756008)(41300700001)(4326008)(66476007)(66946007)(2616005)(66446008)(83380400001)(6916009)(8676002)(38070700005)(76116006)(6506007)(7416002)(6512007)(26005)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEJIbjMvb3FzREVwY2MrUWF5Z3BNVnhkTVRwNUEwR2NQSFh6YktDM0hpd2U0?=
 =?utf-8?B?ZG1YS1p5K3kwSFdMRUpTRGFScE1kWmdJWG9iWCtPdENtZmUzVmJic294VmtQ?=
 =?utf-8?B?eURIVC9obmdpUzBSZzBNMlR0NEFMdkpVWmpuRlhHWTlOc0RFY2xVak1TbjlS?=
 =?utf-8?B?ZzQzRjgxa0hlK2grWUw3a3FwbHdqU20yYWViUVpTWW9ja3RvK093eXVLbjhQ?=
 =?utf-8?B?NXgyeTE2VE1SUzVaMWRlVUwvcENkSTJSOWd2Um1WYndwYWlVWFBEYys5M3Js?=
 =?utf-8?B?Q3RPTFhIS0d1eEk4TncyNkhyUXkxWCtzUWxlV3ZaSjRlVy8rMFF2YU5zcDN3?=
 =?utf-8?B?WjZxTDMxNk0vUW13eThVRURJb0Qwa0c0NGhMNkxVQmJDblRBZ05GWWQ4REJT?=
 =?utf-8?B?VFhKWWZUTXBxL2JqMUdzNGV3L2Y2MGUxeU8yMk9COWczdkgxd295WFdSZk1u?=
 =?utf-8?B?cVBQdHhFSnNhTHNWUnpZV2dCbzRMakxiRjgrVFNEQTFKMjFlbmc5QjNuWm84?=
 =?utf-8?B?SnpnTDBIMkR1c1IwUEFuYXRpOWgxTlpaMVpaRUtvMUd4dUk5SlhZYTNiayti?=
 =?utf-8?B?MldtQ1BSTStsbjdNM3ZoUkxheUtwNlJwaHI5VkN0L080VDA1bEwrWkFmRVVC?=
 =?utf-8?B?MVA4RDlGcmpPZjNtMGk1YzJEMWhxRmhJcDd2NGZoemJ6VXoyS3ErVzhxTUgw?=
 =?utf-8?B?TnVNZFAzK00raEIrbUpSNDJINHFsUlB0c0tRSGIvelUyQU9scE1JK1hGT2sz?=
 =?utf-8?B?OC82bHVSSXZlR3hoOU9NSnpYaGZBcXVHNHhBSU5wMVlwSGRLaGVOM0haUVox?=
 =?utf-8?B?ckQ0ZEZJcVBRYWZiajdqcU9mbElFUHRWL3lhRlpFTmZOSTAydzFWZjdDaG1C?=
 =?utf-8?B?dHFpcmQ4RW9QYWd4d0xaRFNvVFcxN25nR1NCQVlRd2lIeVFmMXBVT3NWMWhR?=
 =?utf-8?B?Sm1HTWgyYTJZcGtrakp0Z0FvM3pLUnNYUzRsVGhuN0J3eTkwdWdsblQxVVZi?=
 =?utf-8?B?eE4wSUpIOUZEYUV2NGU1K3RZWHU3dEtNSnlvdGJpbEVGL0tIUlEvaWpLOUti?=
 =?utf-8?B?eDVJTHIzRUE0cE1PdWdBdzBkYk1QYmVYTTlhQUxweERyQ3luYUhkNy9ZaC9H?=
 =?utf-8?B?ZEV5SVhNTVE2LzlhMjdyMkorM21SNnNSa0xUOGlQZy85YzdUcGhqY2xWSEtp?=
 =?utf-8?B?Rmt2NEVFT3JEa2pqK0tNT2NQTkpsQnpweXFQbHFTY2VwT3A1VmxvNENqUlhw?=
 =?utf-8?B?MnhaZlpNNWNaZUNoaVBsWHNUVW1JTHRuWnZoekdLS2phRGFwYXZKL3RYYkJM?=
 =?utf-8?B?SE1tbWM5YTBRQkRzNEUwU3V3cVN0M0FPdHNoZzRtL1BqNGdaUWQya0lPaGh0?=
 =?utf-8?B?S3B3bUZXZVpRTkcySnlaOG1xN3QwYU9tM3FZblBISDJQQmRFaEVwWUtCbHdF?=
 =?utf-8?B?dVhoVS9NOExuOGxoQnlqY2d5QlhqbWZsVWxJTU1Fb2RLelFHNDdYYmlSbjdv?=
 =?utf-8?B?Mm9CZnFjRUl1WXFFbzh1c3BXZmhXd2QvaytiL3NHSDhHSk5UeWtETnlWWkYw?=
 =?utf-8?B?ZTZ6cmw4N1BDK0FXKzFQc0ZrUlRlem5sWEV6ZEhBd1lVN0FoeFFMOERFYzRk?=
 =?utf-8?B?WTI0OEFheDNlZXBGb3FWNU9oS3ovVy9MSGs1MFdJa2tmcUNWWTgxZ1BaZEhm?=
 =?utf-8?B?SDZ6YmI5aTAya1lHOGZQSFptT2xOaDI0SGRQdlcwQWtsK2RaVlFiNDVnNUhq?=
 =?utf-8?B?NkI0ZUcvQXQ4T2JId2dtOHpvUW1Xd2habXBldjNkM2RGUzFYcWtKbmdvTmg2?=
 =?utf-8?B?M2FiZ3E4cTV2eWNuNXRnT3lpNGZWbVpZTUhsanBmNWFSWE12aEtqWXAwZFg3?=
 =?utf-8?B?TTc4cS9GWHhhbXg1MzFaQVVwNVZyMER3RVRIRWdRajZOWnRCY3dVMnhZU3JH?=
 =?utf-8?B?M3p6U1dHWUJTTWtMdHdxcFJobXlTN0c4OG83VXBNY2dycTN2c092QVdITDRX?=
 =?utf-8?B?M2x1YS9jS0Z4UGhMbHBKZXNteHBzTnNIOXJwcUtCVEhHcTY0eGxDd0JuUkFv?=
 =?utf-8?B?MFRCaXFMc3hiZVBpSkpsY25CWHRteXRZVDl2c085eDNwQ04yallUUHU4S1ZD?=
 =?utf-8?B?b3lrK0V2NjArOUtiUXEzWStmV0Irdzk4N05QcWhzRkZsc1FNMkRkSGJONWMx?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D8C293672A1304CBB3A3D0526389E9C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6279.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6ef5ac-70d1-4952-5393-08db68d3a63f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 10:24:03.9053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eZS2t+eAvNvoJYxtUPlnpUxmU8uYMAvO4Hb/juLFTK0XtG5fqoVvhdXGsmUFOcTKGQIECQmA1QRmzeUjpzYUDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTA5IGF0IDAxOjEwICswMjAwLCBVbGYgSGFuc3NvbiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiBUdWUsIDYgSnVuIDIwMjMgYXQgMTM6MzIsIFdlbmJpbiBNZWkgPHdl
bmJpbi5tZWlAbWVkaWF0ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IENRSENJX1NTQzEgaW5k
aWNhdGVzIHRvIENRRSB0aGUgcG9sbGluZyBwZXJpb2QgdG8gdXNlIHdoZW4gdXNpbmcNCj4gcGVy
aW9kaWMNCj4gPiBTRU5EX1FVRVVFX1NUQVRVUyhDTUQxMykgcG9sbGluZy4NCj4gPiBTaW5jZSBN
U0RDIENRRSB1c2VzIG1zZGNfaGNsayBhcyBJVENGVkFMLCBzbyBkcml2ZXIgc2hvdWxkIHVzZSBo
Y2xrDQo+ID4gZnJlcXVlbmN5IHRvIGdldCB0aGUgYWN0dWFsIHRpbWUuDQo+ID4gVGhlIGRlZmF1
bHQgdmFsdWUgMHgxMDAwIHRoYXQgY29ycmVzcG9uZHMgdG8gMTUwdXMgZm9yIE1lZGlhVGVrDQo+
IFNvQ3MsIGxldCdzDQo+ID4gZGVjcmVhc2UgaXQgdG8gMHg0MCB0aGF0IGNvcnJlc3BvbmRzIHRv
IDIuMzV1cywgd2hpY2ggY2FuIGltcHJvdmUNCj4gdGhlDQo+ID4gcGVyZm9ybWFuY2Ugb2Ygc29t
ZSBlTU1DIGRldmljZXMuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3Qg
PGxrcEBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VuYmluIE1laSA8d2VuYmluLm1l
aUBtZWRpYXRlay5jb20+DQo+IA0KPiBBcHBsaWVkIGZvciBuZXh0LCB0aGFua3MhDQo+IA0KPiBL
aW5kIHJlZ2FyZHMNCj4gVWZmZQ0KPiANCkhpIFVsZiwNCg0KU29ycnkgZm9yIHRoZSB0cm91Ymxl
Lg0KQmVjYXVzZSB0aGUgdjUgdmVyc2lvbiBidWlsZCBmYWlsZWQsIEkgaGF2ZSB1cGxvYWRlciB0
d28gcGF0Y2hlcywgb25lDQppcyBuZXcgZml4IHBhdGNoLCB0aGUgb3RoZXIgaXMgdjYgdmVyc2lv
bi4NCg0KSWYgeW91IGNob29zZSB0aGUgdjYgdmVyc2lvbiB0byBhcHBseSwgcGxlYXNlIGlnbm9y
ZSB0aGUgZml4IHBhdGNoLg0KVGhhbmtzIQ0KDQpCZWdhcmRzLA0KV2VuYmluDQoNCj4gDQo+ID4g
LS0tDQo+ID4gdGhlIHByZXZpb3VzIHBhdGNoZSBsaW5rOg0KPiA+IHY0OiANCj4gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL3BhdGNoLzIwMjMwNjA1
MTIxNDQyLjIzNjIyLTEtd2VuYmluLm1laUBtZWRpYXRlay5jb20vDQo+ID4gdjM6IA0KPiBodHRw
czovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAy
MzA2MDUwNjAxMDcuMjIwNDQtMS13ZW5iaW4ubWVpQG1lZGlhdGVrLmNvbS8NCj4gPiB2MjogDQo+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRj
aC8yMDIzMDUxMDAxNTg1MS4xMTgzMC0xLXdlbmJpbi5tZWlAbWVkaWF0ZWsuY29tLw0KPiA+IHYx
OiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVr
L3BhdGNoLzIwMjMwNDE5MDYzMDQ4LjEwNTE2LTEtd2VuYmluLm1laUBtZWRpYXRlay5jb20vDQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaCAgfCAgMiArKw0KPiA+ICBkcml2
ZXJzL21tYy9ob3N0L210ay1zZC5jIHwgNDcNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaCBiL2RyaXZlcnMvbW1j
L2hvc3QvY3FoY2kuaA0KPiA+IGluZGV4IGJhOTM4N2VkOTBlYi4uZTM1YzY1NWVkZWZjIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvY3FoY2kuaA0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2hvc3QvY3FoY2kuaA0KPiA+IEBAIC0yMyw2ICsyMyw4IEBADQo+ID4gIC8qIGNhcGFiaWxp
dGllcyAqLw0KPiA+ICAjZGVmaW5lIENRSENJX0NBUCAgICAgICAgICAgICAgICAgICAgICAweDA0
DQo+ID4gICNkZWZpbmUgQ1FIQ0lfQ0FQX0NTICAgICAgICAgICAgICAgICAgIDB4MTAwMDAwMDAg
LyogQ3J5cHRvDQo+IFN1cHBvcnQgKi8NCj4gPiArI2RlZmluZSBDUUhDSV9DQVBfSVRDRk1VTCAg
ICAgICAgICAgICAgR0VOTUFTSygxNSwgMTIpDQo+ID4gKyNkZWZpbmUNCj4gQ1FIQ0lfSVRDRk1V
TCh4KSAgICAgICAgICAgICAgIEZJRUxEX0dFVChDUUhDSV9DQVBfSVRDRk1VTCwgKHgpKQ0KPiA+
DQo+ID4gIC8qIGNvbmZpZ3VyYXRpb24gKi8NCj4gPiAgI2RlZmluZSBDUUhDSV9DRkcgICAgICAg
ICAgICAgICAgICAgICAgMHgwOA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21tYy9ob3N0L210
ay1zZC5jIGIvZHJpdmVycy9tbWMvaG9zdC9tdGstc2QuYw0KPiA+IGluZGV4IDhjZTg2NDE2OTk4
Ni4uYjU4MmYxOWY4MmYyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3QvbXRrLXNk
LmMNCj4gPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L210ay1zZC5jDQo+ID4gQEAgLTQ3Myw2ICs0
NzMsNyBAQCBzdHJ1Y3QgbXNkY19ob3N0IHsNCj4gPiAgICAgICAgIHN0cnVjdCBtc2RjX3R1bmVf
cGFyYSBkZWZfdHVuZV9wYXJhOyAvKiBkZWZhdWx0IHR1bmUNCj4gc2V0dGluZyAqLw0KPiA+ICAg
ICAgICAgc3RydWN0IG1zZGNfdHVuZV9wYXJhIHNhdmVkX3R1bmVfcGFyYTsgLyogdHVuZSByZXN1
bHQgb2YNCj4gQ01EMjEvQ01EMTkgKi8NCj4gPiAgICAgICAgIHN0cnVjdCBjcWhjaV9ob3N0ICpj
cV9ob3N0Ow0KPiA+ICsgICAgICAgdTMyIGNxX3NzYzFfdGltZTsNCj4gPiAgfTsNCj4gPg0KPiA+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbWNfY29tcGF0aWJsZSBtdDI3MDFfY29tcGF0ID0g
ew0KPiA+IEBAIC0yNDUwLDkgKzI0NTEsNTAgQEAgc3RhdGljIHZvaWQNCj4gbXNkY19oczQwMF9l
bmhhbmNlZF9zdHJvYmUoc3RydWN0IG1tY19ob3N0ICptbWMsDQo+ID4gICAgICAgICB9DQo+ID4g
IH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBtc2RjX2NxZV9jaXRfY2FsKHN0cnVjdCBtc2RjX2hv
c3QgKmhvc3QsIHU2NCB0aW1lcl9ucykNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IG1tY19o
b3N0ICptbWMgPSBtbWNfZnJvbV9wcml2KGhvc3QpOw0KPiA+ICsgICAgICAgc3RydWN0IGNxaGNp
X2hvc3QgKmNxX2hvc3QgPSBtbWMtPmNxZV9wcml2YXRlOw0KPiA+ICsgICAgICAgdTggaXRjZm11
bDsNCj4gPiArICAgICAgIHVuc2lnbmVkIGxvbmcgaGNsa19mcmVxOw0KPiA+ICsgICAgICAgdTY0
IHZhbHVlOw0KPiA+ICsNCj4gPiArICAgICAgIC8qDQo+ID4gKyAgICAgICAgKiBPbiBNZWRpYVRl
ayBTb0NzIHRoZSBNU0RDIGNvbnRyb2xsZXIncyBDUUUgdXNlcw0KPiBtc2RjX2hjbGsgYXMgSVRD
RlZBTA0KPiA+ICsgICAgICAgICogc28gd2UgbXVsdGlwbHkvZGl2aWRlIHRoZSBIQ0xLIGZyZXF1
ZW5jeSBieSBJVENGTVVMIHRvDQo+IGNhbGN1bGF0ZSB0aGUNCj4gPiArICAgICAgICAqIFNlbmQg
U3RhdHVzIENvbW1hbmQgSWRsZSBUaW1lciAoQ0lUKSB2YWx1ZS4NCj4gPiArICAgICAgICAqLw0K
PiA+ICsgICAgICAgaGNsa19mcmVxID0gY2xrX2dldF9yYXRlKGhvc3QtPmhfY2xrKTsNCj4gPiAr
ICAgICAgIGl0Y2ZtdWwgPSBDUUhDSV9JVENGTVVMKGNxaGNpX3JlYWRsKGNxX2hvc3QsIENRSENJ
X0NBUCkpOw0KPiA+ICsgICAgICAgc3dpdGNoIChpdGNmbXVsKSB7DQo+ID4gKyAgICAgICBjYXNl
IDB4MDoNCj4gPiArICAgICAgICAgICAgICAgZG9fZGl2KGhjbGtfZnJlcSwgMTAwMCk7DQo+ID4g
KyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgY2FzZSAweDE6DQo+ID4gKyAgICAg
ICAgICAgICAgIGRvX2RpdihoY2xrX2ZyZXEsIDEwMCk7DQo+ID4gKyAgICAgICAgICAgICAgIGJy
ZWFrOw0KPiA+ICsgICAgICAgY2FzZSAweDI6DQo+ID4gKyAgICAgICAgICAgICAgIGRvX2Rpdiho
Y2xrX2ZyZXEsIDEwKTsNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICBj
YXNlIDB4MzoNCj4gPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gKyAgICAgICBjYXNlIDB4
NDoNCj4gPiArICAgICAgICAgICAgICAgaGNsa19mcmVxID0gaGNsa19mcmVxICogMTA7DQo+ID4g
KyAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgZGVmYXVsdDoNCj4gPiArICAgICAg
ICAgICAgICAgaG9zdC0+Y3Ffc3NjMV90aW1lID0gMHg0MDsNCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuOw0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHZhbHVlID0gaGNsa19m
cmVxICogdGltZXJfbnM7DQo+ID4gKyAgICAgICBkb19kaXYodmFsdWUsIDEwMDAwMDAwMDApOw0K
PiA+ICsgICAgICAgaG9zdC0+Y3Ffc3NjMV90aW1lID0gdmFsdWU7DQo+ID4gK30NCj4gPiArDQo+
ID4gIHN0YXRpYyB2b2lkIG1zZGNfY3FlX2VuYWJsZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYykNCj4g
PiAgew0KPiA+ICAgICAgICAgc3RydWN0IG1zZGNfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1tYyk7
DQo+ID4gKyAgICAgICBzdHJ1Y3QgY3FoY2lfaG9zdCAqY3FfaG9zdCA9IG1tYy0+Y3FlX3ByaXZh
dGU7DQo+ID4NCj4gPiAgICAgICAgIC8qIGVuYWJsZSBjbWRxIGlycSAqLw0KPiA+ICAgICAgICAg
d3JpdGVsKE1TRENfSU5UX0NNRFEsIGhvc3QtPmJhc2UgKyBNU0RDX0lOVEVOKTsNCj4gPiBAQCAt
MjQ2Miw2ICsyNTA0LDkgQEAgc3RhdGljIHZvaWQgbXNkY19jcWVfZW5hYmxlKHN0cnVjdCBtbWNf
aG9zdA0KPiAqbW1jKQ0KPiA+ICAgICAgICAgbXNkY19zZXRfYnVzeV90aW1lb3V0KGhvc3QsIDIw
ICogMTAwMDAwMDAwMFVMTCwgMCk7DQo+ID4gICAgICAgICAvKiBkZWZhdWx0IHJlYWQgZGF0YSB0
aW1lb3V0IDFzICovDQo+ID4gICAgICAgICBtc2RjX3NldF90aW1lb3V0KGhvc3QsIDEwMDAwMDAw
MDBVTEwsIDApOw0KPiA+ICsNCj4gPiArICAgICAgIC8qIFNldCB0aGUgc2VuZCBzdGF0dXMgY29t
bWFuZCBpZGxlIHRpbWVyICovDQo+ID4gKyAgICAgICBjcWhjaV93cml0ZWwoY3FfaG9zdCwgaG9z
dC0+Y3Ffc3NjMV90aW1lLCBDUUhDSV9TU0MxKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHN0YXRpYyB2
b2lkIG1zZGNfY3FlX2Rpc2FibGUoc3RydWN0IG1tY19ob3N0ICptbWMsIGJvb2wgcmVjb3Zlcnkp
DQo+ID4gQEAgLTI4MDMsNiArMjg0OCw4IEBAIHN0YXRpYyBpbnQgbXNkY19kcnZfcHJvYmUoc3Ry
dWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgICAgICAgICAgICAgICAgLyogY3Fo
Y2kgMTZiaXQgbGVuZ3RoICovDQo+ID4gICAgICAgICAgICAgICAgIC8qIDAgc2l6ZSwgbWVhbnMg
NjU1MzYgc28gd2UgZG9uJ3QgaGF2ZSB0byAtMSBoZXJlDQo+ICovDQo+ID4gICAgICAgICAgICAg
ICAgIG1tYy0+bWF4X3NlZ19zaXplID0gNjQgKiAxMDI0Ow0KPiA+ICsgICAgICAgICAgICAgICAv
KiBSZWR1Y2UgQ0lUIHRvIDB4NDAgdGhhdCBjb3JyZXNwb25kcyB0byAyLjM1dXMgKi8NCj4gPiAr
ICAgICAgICAgICAgICAgbXNkY19jcWVfY2l0X2NhbChob3N0LCAyMzUwKTsNCj4gPiAgICAgICAg
IH0NCj4gPg0KPiA+ICAgICAgICAgcmV0ID0gZGV2bV9yZXF1ZXN0X2lycSgmcGRldi0+ZGV2LCBo
b3N0LT5pcnEsIG1zZGNfaXJxLA0KPiA+IC0tDQo+ID4gMi4yNS4xDQo+ID4NCg==
