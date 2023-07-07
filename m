Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228D574B085
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjGGMOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGGMOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:14:45 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A901BEE
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:14:40 -0700 (PDT)
X-UUID: d533745c1cbf11eeb20a276fd37b9834-20230707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From; bh=zxzTHIUPP7BbyXUUZo/MWVTEivDZdCcQ993SDt39MGQ=;
        b=pnUuUJ4Fdd5j7K534zG5Kxe0uebJUtwFSwzSoN/mbv0Thu949h35f7ZU5vy9d+0WIWodBYhIhS6sNK8KSJvq6J3dGMNuESKophz993eOzLrDh+3d510CtGIClDMJ48Xy3av/5rh6a2OeG04Yt9/MLAiajSfaXUOjJmjrrCycmbY=;
X-CID-P-RULE: Spam_GS6885AD
X-CID-O-INFO: VERSION:1.1.27,REQID:4ef482c6-184f-4541-b127-a60d73f41370,IP:0,U
        RL:0,TC:0,Content:34,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS6885AD,AC
        TION:quarantine,TS:134
X-CID-INFO: VERSION:1.1.27,REQID:4ef482c6-184f-4541-b127-a60d73f41370,IP:0,URL
        :0,TC:0,Content:34,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:134
X-CID-META: VersionHash:01c9525,CLOUDID:b9b3ae0d-26a8-467f-b838-f99719a9c083,B
        ulkID:2307071945064NACNQMP,BulkQuantity:2,Recheck:0,SF:33|29|28|17|19|48,T
        C:nil,Content:3|11,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,
        COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ERI,TF_CID_SPAM_ULN,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: d533745c1cbf11eeb20a276fd37b9834-20230707
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 812149334; Fri, 07 Jul 2023 20:14:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Jul 2023 20:14:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 7 Jul 2023 20:14:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+aqzeGST557atnriAJI9Tp0IQXFzOUNX+wM3VuTEuRUxLnZ9EN8EbRC02BzZC+LRgotoyGKZb8wEoBlzizIo2Ypb54QTefiB/N2bmV4G5NO4/cmdZ5v9JUYWrP7AyZdj9SF26/fBwsihzUguPxcTHM+7nsYaFiLsrqYDGbqLBaJpfwkJEwBaYq5d2f2v9kuSGL4Jzzzsy/t6XPsi0r/QDnz/w6Dj2gHYuquTPLQKZpx3XTgrKkAuTrrzVCRiAdxYCnBtr4JUEYouCG31netSm9/Yk+U3j0fwY32m5Z3NjZbloDaoQWWFhxSMfemCIqkhv+HNDmrFcM4VCPv+s+WKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxzTHIUPP7BbyXUUZo/MWVTEivDZdCcQ993SDt39MGQ=;
 b=O47XfN8rpbqFmAABZmwX4inducBr/jNqHz4MHU0Ix90qt2l97ZzROC72hnLNI34FjHIMzeyYe3naWCacMyjs8ns8vTjRXShy1Wcwhv7kz/NsQOxWita8bREp6DsBqxu7N1mfTHF9n1Hep6qTExZ9z6gR/KCwJ7ioiFOM9eFNdcOZR6V9G4+L2UUUEInXb3hMKy3oPtDz/lA0GsdIJdlDlq+/88zM3Y+jaC7yWz6IjUWJNpSfAcXALGJp13fu7lnYTayBrNIRT2QwHrolsPT9dl8M+CwzESEru97IQqOi8Pd+YxiqcVUoN4Z60nCzNHuig0JLQaDZiDSc2wsmz9kDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zxzTHIUPP7BbyXUUZo/MWVTEivDZdCcQ993SDt39MGQ=;
 b=ZtaDVw1oHt/DuX9bKkZ8zg7Jn6AEupnxjDSiZR4o8AdvgGpeXz9WuyslorUCzXL4LCf5F+bI3nBRpgAozr9QNoPbqLYsTkBZHLLMFCSbQ46lD83UA2w4CkW8zIbmw2hvUwNSPK7QHO1EX/eYev1R0lwSel+jYrh7sxipZz9vrhc=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by KL1PR03MB6969.apcprd03.prod.outlook.com (2603:1096:820:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 12:14:30 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::4515:dfa8:2091:30d7]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::4515:dfa8:2091:30d7%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 12:14:30 +0000
From:   =?gb2312?B?Q2h1bmh1aSBMaSAowO60urvUKQ==?= <chunhui.li@mediatek.com>
To:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "maz@kernel.org" <maz@kernel.org>,
        =?gb2312?B?SGFua3MgQ2hlbiAo6pCPqc2iKQ==?= <Hanks.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?Q2hlbmctWXVoIFd1ICiFx9X+1kkp?= 
        <Cheng-Yuh.Wu@mediatek.com>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Topic: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Index: AQHZsMyUsn+UkcBx202tmPRCTRWnVw==
Date:   Fri, 7 Jul 2023 12:14:30 +0000
Message-ID: <ed3c5fe3f7ed42d58d98e77b3513d6eabf2ad6cd.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|KL1PR03MB6969:EE_
x-ms-office365-filtering-correlation-id: d28ecda9-d251-4885-f384-08db7ee3b760
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7hl22IeN8HP4sYF+o/FQ1aD0FMNkY9s2LdsP6Q448V+DU5ksXkpFpxAZd7C4qnH0CE6LiOqf5cUgJdEyv0h8J7ANmy+Mq57Y5Rrk3/zRdXlnXZiSCJ1XgXTbKanw6Uri25UqWYpu2VqKSpGo4sxSNiYWc69PwVTv29qfbukZYnzDquetnBdkxJ1XkGwiPIYLfn/8n81R//VCLPQhQMvYUeqaqff0ym4YMvKoKiFU9Yb+gyJRuVLXqhtzRIbFW1elPlkA4WQak3Fd47J6GPIwiOonx9ZRkJA2gycJ1ASmvkMkolsT533NaHz/hjWCZ/weiRmVsWSxilwcgc5rJ8IhEmrA4pSaqTf5UZRyv9pSIpZyGwxo1FG5Ozm6L4cpA9FwHHiMLkiAYmcvGPYsZb7x697seL9RKxhQOXGqPE6ShSpF3jptqsD9i3WfxU85PdWDreVnihEHx5fm9/tIF++TPlJV+UQyRmNQwCfMIGoM/u8ZimeSEvFhgn7cnVWYCgS4lJKwsND6v6IY7uGErkFH4DvMLOr4f4XP7fiaBpAzyosknPQUNFyfpaANcpBXCtgDAGc8Xfu6zGjJXCEwHDNT82RssbJNDish6lSroW/hJk6kngsWyMFI2TDbsmYkxNHunsDrfaWOctMnbJau9C1ryjhBJIyUHoxc/AJsGSATnZk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199021)(4326008)(5660300002)(66946007)(91956017)(38100700002)(122000001)(6506007)(26005)(4270600006)(107886003)(6512007)(186003)(71200400001)(2616005)(76116006)(6916009)(316002)(66556008)(64756008)(19618925003)(66476007)(66446008)(41300700001)(54906003)(6486002)(2906002)(8936002)(8676002)(85182001)(36756003)(86362001)(38070700005)(478600001)(558084003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?SlBCdzNqVllHMWNHZnBXQmhHd1hmQmc1V2tWVjlVQUJZZ3pVMEllT2pzYXRU?=
 =?gb2312?B?NnViTDZ1c2Q3YUVXLzdjZ0huMU92ZmQxWi9RQWNxaXJZMU9HcEgrb1FtSnVX?=
 =?gb2312?B?WCtYbnVUdVBnMnFCeHFuL3AvTnB1WjM5K3ptV2JjNjV4U3lodnBxV1B6M1FV?=
 =?gb2312?B?c3g0VjExLzFwZFdFRXROWHZEYmRFS0huRlZKU25KOTRCamE5WURQdEZxSHdv?=
 =?gb2312?B?ZW5ZMUdVeHhtQzgxYys1VlpqUXg5dG5SR083UDNmb2ZxRWNMb3IzOVdNVUdu?=
 =?gb2312?B?TnFXa1JGV1ZjZFdEeUVDNGVHa2I0MUREODM3THBTV1B5UUhUcjZrY1V4VG5C?=
 =?gb2312?B?UGFReEhINFFMQys0QnJEaFhudmpqais4d1ZpczR4dHNDUkNoR1dWaVc2Yzhk?=
 =?gb2312?B?M3Z2MzBHaUZDN0dCU3U4YWJHU3NSTExsVVhmWnZwSEtVWUhhVnE4d1owM2lO?=
 =?gb2312?B?ekQyeW1LRGpDZlBWRWtUQnVLczE2RUFpM3Q3MWFLOGFzLzJCTWMwNzJ2SVU4?=
 =?gb2312?B?YmZIRkFRekVqWUlWSGtVN3hQQVV4Q0pEa29LaTBKejAwemp3WFlIRjJkcmhj?=
 =?gb2312?B?R0YrdGVnalZtdXkvbEk3RmR2cnUxZEtXTGJ6YituaDdnV3VYUXJzT1RrT1hR?=
 =?gb2312?B?YUhVQ2xhWjBtTDU2RHp2cGxDRDZ5VlZXOE5Qa2xUMEJqbXZINFQ1MmtMMGRv?=
 =?gb2312?B?OFJ2NU4zQzNSdHVoajVCNXZXRUU3d3NWelRVQnk0S3c4U3QxSmtTZjBydTl6?=
 =?gb2312?B?Y2RaMDM2MVpXdG1STUViSTBZaGtXdnhRRmVXb3dIZXFHdnIxcXJjTmlVU2Fq?=
 =?gb2312?B?QXo1dDdTaCs2Q0ZxcGFILzNuSzJtbmFNOEd6MWhGWW5Sd2oxenVWN2M4TER3?=
 =?gb2312?B?TDFhZTZGYitjUGhNS1BTWEwyTklXQURNenN2dHpmaFBNaGwzUDJIT3BrS2hi?=
 =?gb2312?B?WXJFamFyWTZuS3hXWDhjV0VqR2FQa2d6bW4rMklWaEg1SlZyMVdJZUhEa21o?=
 =?gb2312?B?b1dhaE0ySDFJdUxzTTZxWFZRd2RDblBtU08zVzNWRnNpYWs3WktTdFhMblRZ?=
 =?gb2312?B?TE4yMzBMdzVTdkw1cVRSU1hVNVBQbm5pWkpuQ2luU0hTeml6Mm9DNkRmQmlW?=
 =?gb2312?B?Wk9INDY0WjMwLzhpa2FoTzBGN0d0L214U29UN2owSE9kN0JncjI3UDVoTFFk?=
 =?gb2312?B?Uk1ERzRCRk5Ob1FPZkR3QmhEMmxpcEVGNjczRHBJSU1TenRNQmlCU2EwMGh5?=
 =?gb2312?B?aTdiYmFQSG1IVjU0S3JCTktZY2owYitCZFdCdTFleTNzKzJSTlp2dzZHcHEz?=
 =?gb2312?B?ZjVEaXJRMUlkR2pVOHFBekJRSDRqMUxRS3dPQSt0bk1CdkRYZjN4LzM2UTJU?=
 =?gb2312?B?bGMzVm02b2o4TFVCa3BnekQ0a0c2Z3VlN0lyak83LzNMZWRPMmx4QUdwSUxG?=
 =?gb2312?B?UTdLVWJmSXdmY09ybXRObVdMQ0lWb2hHRlBROTY5L0UyRWRpditkNmZwRXhs?=
 =?gb2312?B?UDh4TTlaSHgrTm5PdERSNlE4dFZzRVI0T01TOVJKdTlXbXF2b0M4YWRoVDFZ?=
 =?gb2312?B?VkdIU0p1akg2S21aVHdFRzkvaG5yR2Z6bDllTE5EUExwTTJWT1ZaNFlsM2pq?=
 =?gb2312?B?amJGb0VnT0g5bXQwbjBIVm91a2pGQ1JoVnE0NWYvWUtaSXRKQkpYeDRFWWxI?=
 =?gb2312?B?UTcxV25qSlZBekVhVWY1dmpuZWdkNHlUVTJraXMwREo1eUMzek5KT0M1MkFX?=
 =?gb2312?B?ZzVoelVHSSt6eFNGS0dMOTA3SzBNaTcrR3lsMlRGVXpOMmZuWFMyUXNPSjFj?=
 =?gb2312?B?VWlPOW45bDhWTUxlTmRPREI3MS9VQW9CQVZxZjlxMzNZaW9uL2RBb2lXVXFM?=
 =?gb2312?B?TmxtNlRKNTI4aEtKTUZWSzArVENUU0pvMGExYzFCaTJOVnJrS0lETHRnRFFo?=
 =?gb2312?B?dVNoc2d5RGZwL285bGh1OENPblVha3N6SUtsemZpZ0RQWll4c0pabjdlc0lu?=
 =?gb2312?B?S0UyTHp1Wm9CYm9EZUR1L0JJdDJjMVY3S2FRZGd5OW4zZmp3a1BHSHovR0lO?=
 =?gb2312?B?K1paWStsUEdBd09KNkNCVHRyeVEzMFFqcmoxbUhKOVh6WnVzaHViKy9FWXAy?=
 =?gb2312?B?RC8vcXExcVFCVjE0ZGpEUXQ5czlaSC9hM2VFaldlMlVLNy9pazRXZjdzdSt1?=
 =?gb2312?B?RXc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d28ecda9-d251-4885-f384-08db7ee3b760
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 12:14:30.1962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R40D1EoNtfW97vvuTSqOn7cHCPcTNljLm+VROIZTnKtNMZ7Z0IQ8+ODcdXQQvtxgSoUhR23EsAOzN25M6TxGlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6969
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkLWJ5OiBDaHVuaHVpIExpIDxjaHVuaHVpLmxpQG1lZGlhdGVrLmNvbT4NCg==
