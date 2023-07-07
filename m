Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A02D74B020
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjGGLpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjGGLpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:45:13 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA2F12A
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 04:45:09 -0700 (PDT)
X-UUID: b5e115721cbb11eeb20a276fd37b9834-20230707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:To:From; bh=P6YZViuglW9K3Vzht5NgWPt8PCTpca78K1BK6HiezMI=;
        b=QbrM4swBISwSsG2PRZaW9kuYeAdJEf1elCMGMOGXU2tUB8qourUQfgWOolZCmPSnqRtkbqluiY2QCEQ5viYzcBt1J/qA3T+T5ZsME7NxGS6hicY42fzUYPjbF6SrW6VyIZqcSzQGgrYZdWatuLfQLh44PKcHaYUuVYwUs3F94cM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:226483d2-f0fc-4933-904a-725dd343c062,IP:0,U
        RL:0,TC:0,Content:24,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:49
X-CID-META: VersionHash:01c9525,CLOUDID:b79bfa0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:3|11,EDM:5,IP:nil
        ,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:N
        O
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b5e115721cbb11eeb20a276fd37b9834-20230707
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <chunhui.li@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1856770253; Fri, 07 Jul 2023 19:45:03 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 7 Jul 2023 19:45:02 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 7 Jul 2023 19:45:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcxPN3U1z8pCJj18RxO+h8r2lNtprnT69hcENCtrlKIz7gDhjB6hWCHsNVopzbFaev/xYa0Enwvaln4GZd4A96Qqo4RtEdqcIC0cRUAafHDp2YXV0BPUGaxnB0N56f7Gsot784q+gPtGsHGBCCBCnEwK3di0Boa6f4h4xtYJuvLn4PMjbRQKKqngBi1p+DnI5K4PVuSg20sKYgJxCIrNQMX3UhqRz1F7ubg5HE4yh0v2m5WOEla29RIQALghxCIiKuWDukJOWNQsL0wMPIJXpCNI8oaUQ2q7V9RQk5JZw1U7JYgIrTBG2MmQc86+ajrrv4PW9Htcv+h0nyTQc8j8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6YZViuglW9K3Vzht5NgWPt8PCTpca78K1BK6HiezMI=;
 b=MPkBa3cKaGilqbgcOXyUBfEyvOyMS9g4Y1GxivcQDa0i9FhqOSc6FhrN3Y/bEa57CPNefkFi5+KMo1vABN9XkPyV3YGc8VsDIB8waQhRENYvkG6kPvYVawK6m4f5b7KX96CJYVR/duepbUiO03hvf07YMKB5NRZnKkn1dmXzcE80Ssy+U34zcbLO4c0KUWABj6+NiuyX5k9V8jAJmc/A4MQHGfIut2CSgE9B7cVSvCQV4PnfbiW3wUQQHMa+Bcf6b3v8jdPIXvNiDMkRUfOqGFVLVf2Vf0pi2Pd2XxYbab8zIA3cLlGP8vyrk6Y1PQSrZMpSef4zwBQQqzIxBfDPmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6YZViuglW9K3Vzht5NgWPt8PCTpca78K1BK6HiezMI=;
 b=nbWUXdrHcqPD39Y+PK66r2zVXB5WPxCF2X0VtUPslmQG65iO0cuNbcCQ69AZCpktjtjlJLW1VyhLbgLkrPWA2RT8mqijvxOS/dpn7auD0E2ozJXrW/6JWF0oXmCV9DMsIt05SbSM2ywSqdr11UgUFBFDsT2lAY97OyCbPxazPF4=
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com (2603:1096:301:4f::5)
 by KL1PR03MB6085.apcprd03.prod.outlook.com (2603:1096:820:90::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 11:45:00 +0000
Received: from PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::4515:dfa8:2091:30d7]) by PSAPR03MB5528.apcprd03.prod.outlook.com
 ([fe80::4515:dfa8:2091:30d7%6]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 11:45:00 +0000
From:   =?gb2312?B?Q2h1bmh1aSBMaSAowO60urvUKQ==?= <chunhui.li@mediatek.com>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        =?gb2312?B?SGFua3MgQ2hlbiAo6pCPqc2iKQ==?= <Hanks.Chen@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "20230704123436.127449-1-lpieralisi@kernel.org" 
        <20230704123436.127449-1-lpieralisi@kernel.org>,
        =?gb2312?B?Q2hlbmctWXVoIFd1ICiFx9X+1kkp?= 
        <Cheng-Yuh.Wu@mediatek.com>, "maz@kernel.org" <maz@kernel.org>
Subject: Re: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Topic: [PATCH] irqchip/gic-v3: Workaround for GIC-700 erratum 2941627
Thread-Index: AQHZsMh19U4TBESV3k+wMlI1eEiQiQ==
Date:   Fri, 7 Jul 2023 11:45:00 +0000
Message-ID: <c822781a6ca937a50b93abc61c8b9cfc8fbc7b1e.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5528:EE_|KL1PR03MB6085:EE_
x-ms-office365-filtering-correlation-id: 130f3174-1aa2-49d5-2b74-08db7edf985f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cB8kTzj+O+M9/Xw9KtXvhHjYCUsf5g60aArNcWcdHa14mdLWYrpKAIs46MlZry2Vo2XOZNac4WjtW6488maAJPyCFvoXJS/WcqPw31VtcWGpIQ2oFjCLtrbcCoJjhMxFAtT8aj4HoOGJfdvfFiODic/f4BcM/8YlwpVqVF1mGbLyxQAcUobKchUlP0dAx+rrYefSsvKrbbAtT6xdPff1iLUsZZ5UA8gtvBv3RDCWczgaflINGgfUfT8PZyP0lUF7xnt+8EMb4IEwZ+1X4MuOXC1XI0KjcwnoSmCtc3Y1pAQtPXFCfFzxNGdOnh0vjiMnWYfnn7j6nGG5GsmncFpEWKNO2OiW4CBbx3RXrXmFnsTMfhoVmzSQoFdHZ2kTUnHzGbyvXX6xzaUXIHvh2EILJ6Y29LjhAM9xojWbM0qetDfwLyuCS5dILJrLgLrq1GK6AcyHAaiV6ZkCtVHfnvmmXPj6TL8lFkSiJNEDnPZ09t04z1cRGZZ8cmhK0crWEP0Qh2LsKHf4Kh8KmdK45N11kU7gn7pFGAXbAyb8xbW2AECo86codPJ17h1wt3586PpuKgfEbEZEJYFRxY/HAIc0KQ7TW3pqykFrk11jv0sstKYZTlk2BpYf1mbOpmX40r6w29ByX3nMTyw4acZ4z3lEdfnC44cq8Rl1oGA4VCU/7lw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5528.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(122000001)(110136005)(71200400001)(478600001)(6486002)(8676002)(5660300002)(19618925003)(85182001)(2906002)(8936002)(36756003)(38070700005)(86362001)(558084003)(66946007)(64756008)(91956017)(76116006)(66446008)(66556008)(38100700002)(66476007)(316002)(41300700001)(6506007)(26005)(2616005)(186003)(4270600006)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?b0NxTnlSUEhkYURxMnI0U2l4SXZTcGxla2tMMXF4dEpsR01xVkd2aHlkcmpQ?=
 =?gb2312?B?ZDBSc3gyU01WQk1GTnhibG42aklLUy90UE1uTW1TOXRVMVc1cC9PRTB3QWt5?=
 =?gb2312?B?OGN3VFV3REwwLzdPMDdrRk5kQWl6N0R2QklwNjR3Q005aDlCZ0Z1QlI3U043?=
 =?gb2312?B?REcvRVB3ODBleUJXYmhhenNuR2JETjM3Sys3WEI5NDRJU2F0ekp0ZmJuVDly?=
 =?gb2312?B?cTNRd0Q3NGFGTEYxUFd5STNUQlU3NmZnTGJZcWlvMWx5SklITURiQVNWMFVK?=
 =?gb2312?B?Z2FoZHlFVG5ta2dCcU5KaVA1bGlZcGZLTkVFU3dqczhQcnNNZjZNbjhZRU5z?=
 =?gb2312?B?WDBDTGdKS2lkQWdiTmFGRUlBNDlSa3lQUXV2YUJqQ0ZxNElzbDlkTFBJTW5N?=
 =?gb2312?B?QzRyNkp6UERtNElXY2doY3cxVXNFVXZyVVFKTWF6MmlvNW5acVhkTE5Tb1FZ?=
 =?gb2312?B?VlhtRUNISDJvTDVoTmRhdzJFSFl2djdGQXVPZWJtMzJTQlg5OHNndW9LQ0ZP?=
 =?gb2312?B?bTRhcldWRElNeUVQOFhPVHZPakM4TjdvM1NPLzZ3dHo4QjR6TTkwMjMyRDNq?=
 =?gb2312?B?L2kvRUxrZ3p2WEt4d3JNOCtSUHpsMmxYUWZQN1REY2FiNEtVYkMvRURDVFpt?=
 =?gb2312?B?bURQQ01nUWlHMmtUZXlvdzFla0FNL2ZxcFQzM0lvcTBTSTVSNU9ZeW9laXpS?=
 =?gb2312?B?anpsYjJ4R0lGZWNwVVFtWDl4aXFmZmtzUnFPSWVPNUFNMXIvUXN0NkJFWFNj?=
 =?gb2312?B?bndhNDVyMHEvcWpMR2UwUGdhQTcvN1hFWUdZcjBxeUM3RmdyTUIzSEppTmQ4?=
 =?gb2312?B?OGhUcHIwQVg3ZkRHV002NnBPb1dVeWZXWXBFNUM1eGtYVXBFNm9CUWt1K0pB?=
 =?gb2312?B?RS9TcDJIYUpOMWtEOFU3Y05JS3I5Qkp3aXU1cEdBWGU1UHlxQ1c2Y2ovNTV0?=
 =?gb2312?B?RERveGVqU2ZYZWpRYnVuVTZuVUp2MTA1UU1vbzQ0MWFhLzRleVFmaWtQSkRq?=
 =?gb2312?B?QUdTTEpTQnhUWHp3RVBkZjBqYjcydFRJUXp3Q2N4Wi80dGVzaVJ2ZUp5b240?=
 =?gb2312?B?N2ZaV0wrLytzV1ZRMmNLQmQ1VkJoMkVhUW5TRHB1Mmg2YndZS1c2aGFZUFZz?=
 =?gb2312?B?ZlJnaGRjbUcvcUQwY2lHVjFPczhycmJxeElnQ2tQZ3ZBOTlISVVma20vMTZz?=
 =?gb2312?B?UmlIUGVRQi9lemcvVlRpaVNqTUdNTXlNNUxCbDhmdzZvdzJwQ2VETGpHZERX?=
 =?gb2312?B?dk5iVm4xUWVGUERla1Zxa0ZzbUltc0hFNWlUNlJRVmY5RVFaYlVBT3JFa2Zy?=
 =?gb2312?B?SXFkS2duendqdlp4Y3l1bkhNU0s2YTQ2TlN5Nm1UalNEZEtLRmNGUi91WU1s?=
 =?gb2312?B?RDdMMkdRaEpPY3dvdjFSSHRiSjBWRFVHZkFWdWhNUHljV0tLNFdIT3N4QW1R?=
 =?gb2312?B?anhINHJSOWFsMXcwU1laQ1hJL3dRVW5vQ2ZRTW0xZHBZdytSUThqWjc1UERy?=
 =?gb2312?B?bFNuenN5NG5DRUtpTG1VeE43QjVPMHFLQlUvVUFZbVJKeEhrSDNCZExxdmZK?=
 =?gb2312?B?ajNTYkFTUmIrV3NZT0lUeXExelR1TjViQzdkY09UbWV6Ry9SanpvRVcrb2Iy?=
 =?gb2312?B?bXhaYWFDWVRRWDRsYVlKUnI3OW1hMm9zM0dROWVpMXdzV3pDeU5XWmVDbjdu?=
 =?gb2312?B?RzR0ZVpmT1VRRHJ1QlRiUWJicUdzcDlYdWFaOWZYWDFXanl0WGNMbDBhOGF6?=
 =?gb2312?B?emMrWVhuV0tGa0JrNFBPZFRrSmZOR2o0WWxnRVFtSzRnWjVnSlpzYmw2azlp?=
 =?gb2312?B?dm1hQ1dBaDJqRnp1UzhYb2dqNm0vOHZSVEFnOHRwdFJhYVowR3g1UW95UGtV?=
 =?gb2312?B?NnZHbWZMdWQ2YVNYL21DVUxMRlVTY1V4ekdtOUYwdS9UZEgvYklkYlE1NkN6?=
 =?gb2312?B?akdlRlBWWno5WUQyZG1peG02ZlkwQnJWSCtKZnBsNllTQmRCZWxXcGhSK2th?=
 =?gb2312?B?T1BWWkFzTzRWMnVSQXhPaHlzWDRrdGh2SzRMbE5BWnNSZEYvSXgyUUZKR1VP?=
 =?gb2312?B?dGFzZzJqalFvQU5YNDF1ZTNVREJaeXRkK1pnMGx5cmdoQmxMUjNyZ3UraXlj?=
 =?gb2312?B?UnhqNjF1dmlKYUJKcGZiOUpYN2VPb3BRam5sSnhiU1plYjZLVmI3WGdRMlFk?=
 =?gb2312?B?dGc9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5528.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 130f3174-1aa2-49d5-2b74-08db7edf985f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 11:45:00.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lcJ0QnXTslGXTdcFjLVxrxeYZmUJ46x5kICOlIBSzUNZ3VDTyBzxiO7QokWffLSKQXyYl/Mpiv5tRNE3Vvpfzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6085
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGVzdGVkLWJ5OiBIYW5rcyBDaGVuIDxoYW5rcy5jaGVuQG1lZGlhdGVrLmNvbT4NCg==
