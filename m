Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17956C5C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCWB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCWB5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:57:47 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C57922036;
        Wed, 22 Mar 2023 18:57:27 -0700 (PDT)
X-UUID: 0df3887cc91e11eda9a90f0bb45854f4-20230323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uuKJHpbJW8A5H656t34Ih6k6MVLXTWbkzZhXm17oQX0=;
        b=hwqdHoGvkihLJUjc3x/oedQF3dpB+zJBM3TWleCmuYDOpZ14VMP5RHajQRUIdoATS4xmIEZh/vBB+0/jdmnjOejff4UEgxh0gpHY5kinC79qhU0pVXeCl3J3jS8TpWBfsaD0H378soC6gHf3jcQ+THtJ8Trob2Ow7Rxq2bXQuCc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:ff91d2fe-4647-4e78-9928-92891d28e25c,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:bc9914b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 0df3887cc91e11eda9a90f0bb45854f4-20230323
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1695597253; Thu, 23 Mar 2023 09:57:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 23 Mar 2023 09:57:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 09:57:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaR9mrwO+vlKE6Kc9HLgdPVj/AgiBKsp45pg5xAUlqAU2kvYKdp2BTPCo70nxZMO4SLNxhF/642Ogrj1E++ddYk/CEmGuXs/bfquUTpDqG3bO/WVzfEPFsZMoTCFg45mWLjiHIBtfX5jMIMGnlzo7urB50J5O8x8hJQd9cwDUVx3fUEU+VK12h/SNgEfUS9nziIv/UvySP+J/A6xxurdzqRYdr+rHymFOKrRmp9qS90hxFG7ZTe7uvLjY8U4Mo6zzbCYdB5Zj6IKm7cYRozdPgtInBawkX1ziCO8NSDckdwWvYD3OQ4o/DqaBFr+rRK49X0W3FgdyNcI+81aVbGe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuKJHpbJW8A5H656t34Ih6k6MVLXTWbkzZhXm17oQX0=;
 b=aq5xDufMVsFJqN6R8VTyKu2qVJCHHuuesBw2iJnpYdGlow67XeLfSBcr6Hi0GqEc65f9thzB8wITjn7ySQEUw7/U8wXuoPZoYnpAjPbW0NOHiGzE137RBxshHiCdLnQRlrS+dFb0uX8a3bCA57hOyPDIE/BZ+TEMSLi7Jzn7hAV4t6VWzzSxwg/DVmlnEDFRajQr+FOcwkdaeznbb7YLvzW8KR8JswC9BagHhNPW/3R6TBrO+Rt+wW03FJmXGef5kvTgN37W4VueuchgeXrsRaxD3jtrVpvujlJY9lY4ec07xrndqEO1py5UcNM671eoTDj6GWrSUPkxtXvkYKnz4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuKJHpbJW8A5H656t34Ih6k6MVLXTWbkzZhXm17oQX0=;
 b=HtsiAFpQ+eJxcXtUye6d0nsPDRg2CncFxsLuaWn1tepUqtmw9IJYn26qilQSrH+107TTSMomv5IMNubCAK/kN68fMRbaflhkeaL7FQOBhu3zUcM/MJCxANnGRvsj/m1LhLeGhCdgprBSNGd7S6Dr7zSHIrbtYX6sOB5andVaJxQ=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5549.apcprd03.prod.outlook.com (2603:1096:400:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 01:57:20 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 01:57:20 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2,5/7] media: mediatek: vcodec: Get get each instance
 format type
Thread-Topic: [PATCH v2,5/7] media: mediatek: vcodec: Get get each instance
 format type
Thread-Index: AQHZXKNIZX18F2r7OUa3cbZ6HmUJea8GtdgAgADme4A=
Date:   Thu, 23 Mar 2023 01:57:20 +0000
Message-ID: <015ceac36bc15c75334d608a15d9646fbbfa6f8b.camel@mediatek.com>
References: <20230322094617.19410-1-yunfei.dong@mediatek.com>
         <20230322094617.19410-6-yunfei.dong@mediatek.com>
         <66cb5a95-4646-87d1-0acf-ebd473f3c653@collabora.com>
In-Reply-To: <66cb5a95-4646-87d1-0acf-ebd473f3c653@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5549:EE_
x-ms-office365-filtering-correlation-id: d7f6eec0-e515-46ad-5686-08db2b41f035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKpv9MRCEAJka8q3eZN21ULg5/J/iMDWhh0r9fKH9RlS8dc6I6cm08VMEI+RhGU4fcGVP6IKl4OBIMY0k6SADs+k3tNIc6z9hFyISVy4CUsowaXqlU9qiC6v57UUwWil0mjZoyas8x7/wYEeMce9zwjy5VjLsafhA9WQfFkYz9+L0ZXnh3Q8R9PLPzJwWu2TuE4oFFR/dCaD3cPVfFvofTuc+K8AhUzj/k3EVNHnm0Fz4SQnpGOquwOsIA9BCvkv2JCrEV1FAQywkQgz0DzFNqQOlrc0/tug1OZGHWcU/1yyeU7yCHAREwafr7j8hHuKZEnAZDJpB5fgJcWNbVHCoe7DW257ix+LQAGZgu+QqhIeKMY/WM8lDfGvCPTeAUgJv3D1u/R5RycBKAre2YvdRm3qFga5M8u6cbZ41LLHrEzHzEd4zt9pXXOG/+h9QCNUkvBDEJyTMz6f79RSPbCeUxNiJnXCzqLjYLYJzlrZHSbXA+eDHPiZB4Ibc2DVctgjB642vkound2GSO+QcFYgkS4qz8i35f2eebWo4Vf8RWS0PQFoYmOGNZEVYLZmk0B1bkQBCj1X+aPqyGBfpICM5UhrbCxKpiIFMel9A4nsZQpyWZiXEFdnZ3h5mfcLn2ia0Q6/sNwIBOwu/jBwgLI7AcO/wJTQSgTh9nkBMMTzULPCRISogBDq3XXnLoItcCMnbQEzBRsiQjwFFvn1YpAScr97H+vwinQUigiWxYu56jUKrXeCG1gqN6RnAKw3Wuj9fgKL6DEKcXBIwtMV4ceXug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199018)(478600001)(71200400001)(38070700005)(26005)(2616005)(316002)(5660300002)(54906003)(83380400001)(38100700002)(86362001)(8936002)(41300700001)(122000001)(66946007)(36756003)(8676002)(66476007)(4326008)(85182001)(66556008)(64756008)(76116006)(66446008)(91956017)(6512007)(7416002)(186003)(6486002)(110136005)(6506007)(2906002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTY2NnB4T2RwVjdzWm1IZ0I0a0NURzNxb2Eyd2dFYmx0R2Z1NFFaMkJwNXlF?=
 =?utf-8?B?bmxFcmpJb3lReUE5UHdDUkw5dWZobFIxOWcwcFZ6YW1ONlA3MkExTWdTY1dZ?=
 =?utf-8?B?M3Y3dDhmbzdoaHlqNW1JbVkwelZ1OEdiLzRHVXlBMFk5UktNNFc2Nks3QjlJ?=
 =?utf-8?B?azN2WHFHbzB1NmlFaWQ0bDVPY1NxV25MWTN3akhEMmsyVXJ2c21ZY3lSRThP?=
 =?utf-8?B?MTg5Yk1GM0FkT1JtMDR2dzVmNW5HQ0ZYaE1SVDRHN2pFY0kvYjRwci9CUFVy?=
 =?utf-8?B?WmRXbXo1Rm1OczBoV1pBT1BCYy9BL2E2bm9sYTRheXp1UERwb2RHM2dZZFJt?=
 =?utf-8?B?RkY5VjVRWkdBRldUTnViV01palBESnpKWlUzQnVkWDFmemwzYjNQcUlaQWVj?=
 =?utf-8?B?dTFoTngwdWt5aC9hZExKbnRSdjFPQ2c1UjVQYUphc1NaaXV3VkZhbWY3STVV?=
 =?utf-8?B?L2tEN2NzcUJyRDRIbGRCdFN2V0FrRTNWVHcrTWJlYjZrQ3VWbGxjWms3Znc5?=
 =?utf-8?B?aTNxMCtiY2MxdVNxWm51MElVamxhSDZoK0wxTjYwb1lVOEdaaGxyVEJHR2ZP?=
 =?utf-8?B?NlBkck95aG9jWksxdzJsdDBaUWhHSUhoTjlEbmxlZXNWdE9HUktTSytpS1Jh?=
 =?utf-8?B?c1NvUDdKa1dLcG1VdVZsOXNyQ1lJVldUZHY5WE15K1l0NUZYeFBzKzRmYThp?=
 =?utf-8?B?RlhmZ1phNXZ1bGk1RE94UnJaNXc3cENydExYalJlTXhxV2FKWWRPbWVZMnV4?=
 =?utf-8?B?dlBQQXo5b0xBb1lSYmc0MEhnSC9pbXM5VXA0T01NYUhlMS8wRzhkdm9WOUNW?=
 =?utf-8?B?blR0NS9JUk4yWVJSQVp3c3JiRnJneFlhZEJpaEVrcC9qbFYwMXVhdzFWQ0JB?=
 =?utf-8?B?eE5rMVBBT0ZLZ0NEN3FOUkpaL2dOVXJlbVN2UUluTFpFbVlvT2I2cGR6TlAx?=
 =?utf-8?B?SE9RR2oxVXZXSmdicHlpeTRNcmRsMHh1N3hadzVIM1hpdFlZRS9XUHZsYXND?=
 =?utf-8?B?Ync0VnNFZHoyZS9BdUpXWkhaWnpPbGV4SHN0dE94VktXenFLYURaZkYwaEpR?=
 =?utf-8?B?eUtSQ3N2cXVrVVdTVmY3SDVNalUyL0FCMnNHbWk0UGt4STBzVklXMTBCeG5Z?=
 =?utf-8?B?Um1la0g0TVNBaURGdzIvU083KzlSSzNxWkN1eDkzTDBOT2czalltc3hTU1Na?=
 =?utf-8?B?cnFIUVJVNnlMOXlvMCtLeXVySTVCcVR1eWpQZzRmQXFaYUp1bURUdWl5WjIw?=
 =?utf-8?B?eDJpcTVvOU1aZ3ZHaXk1OG9QYUNqaHYrMElyUlVQd2F6amF5SHFsMWFhSExI?=
 =?utf-8?B?bnBOcUNSNDROU1d3VDlnMjFsZU5yK1BtREdqOUNFUVpVUWVlbG9WWi8yd3RF?=
 =?utf-8?B?aTBmcjdkaHBnRElHY0t5YjA4OXdJMDJicWVSeXhFek94ZENNMjRMV3k4c2xJ?=
 =?utf-8?B?WllzU3gzVWpELzNoRTlBcVEyK1B4NzFHRllrOWJTb3UwaXY2cmdMVHp5UlpL?=
 =?utf-8?B?bXNDcjhsTThlRjZBWGFnSDBrNXlqeVJBVks1cWd2QTFLWnBUNGFXSjh1ZjFj?=
 =?utf-8?B?TEdBT09XdjdpZkhDQ3lKMnhabHI2OHNXWXhIdW9EUGg4V09XU1pxZVFwK1Mz?=
 =?utf-8?B?VjhZUExhYVRzTytJUzVJclBOZ3IxWDVWaEJ1eWZ3NDgzUlBDUU92c3ZBY3RJ?=
 =?utf-8?B?L3ZNWUJBK25RcG5XTXRjVm1TOVdNOXlwQ1B0Y0RWY2EvU0VQcSs0K3lHaytF?=
 =?utf-8?B?VzBQZ1dxOGxreEU5QTNhRzlHQSsvRlUycVlUVFMyKzB0eUZMOUFSU0wxWUg0?=
 =?utf-8?B?MFljWWkySm96cEZrLzU4cEp6WUtmdWwzSlRtWURFZkhjdVJEL1hTR3l0ZVZ6?=
 =?utf-8?B?cWtXTjFaM2NKVFVqWG1TOG1jaDNTV2U4M0JEOENTK0Z0Z3F5RUt2TTJFTTZv?=
 =?utf-8?B?UEk1S0IrZGhuNytGbk9KNjg3SWJKM0JHSTFJczY5bTMwdStualZuSDFlUXMv?=
 =?utf-8?B?TnhvZTRMNWxrMmhSSmRadE1uUG9nbTdabmZpRkZ6WWtLYWU4NFA1S2kxS3lz?=
 =?utf-8?B?VUd0WlV2dXNKT0htdCtnTjAyd2dDU29Qb3hxQTNoZUdSTVdWeWlQSzAyRXdp?=
 =?utf-8?B?K3I0QmJxM3c5VWhNYjN2bXpGM3E1K25vekNRcGpjNXE1aDJYV0R2R0pPazQv?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <582BB83D317AAF47AA42306F248A129B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f6eec0-e515-46ad-5686-08db2b41f035
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 01:57:20.5640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y5kwdCL7hOx8PaOoBFzThcGNIuWD1+j/HMKgSjoI2tyXH53w2vwc5h4JOHF9q7t8X3c3jSpxDQzGsrPEhQ8ySHvfwV2iX2H+BnISJQoAv8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5549
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubw0KDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCk9uIFdl
ZCwgMjAyMy0wMy0yMiBhdCAxMzoxMiArMDEwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8g
d3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3Ig
dGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSWwgMjIvMDMvMjMgMTA6NDYsIFl1bmZlaSBEb25nIGhh
IHNjcml0dG86DQo+ID4gQWRkaW5nIGVjaG8gY29tbWFuZCB0byBnZXQgY2FwdHVyZSBhbmQgb3V0
cHV0IHF1ZXVlIGZvcm1hdA0KPiA+IHR5cGU6J2VjaG8gLWZvcm1hdCA+IHZkZWMnDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgIC4uLi9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdmcy5jICAg
ICAgICB8IDQ4DQo+ID4gKysrKysrKysrKysrKysrKysrKw0KPiA+ICAgLi4uL21lZGlhdGVrL3Zj
b2RlYy9tdGtfdmNvZGVjX2RiZ2ZzLmggICAgICAgIHwgIDEgKw0KPiA+ICAgMiBmaWxlcyBjaGFu
Z2VkLCA0OSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvZHJpdmVy
cy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kYmdmcy5jDQo+ID4g
Yi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2Zz
LmMNCj4gPiBpbmRleCAxOWExZGMwNjhlZmQuLjFiMWI0MzAxYTgzZCAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RiZ2Zz
LmMNCj4gPiArKysgYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtf
dmNvZGVjX2RiZ2ZzLmMNCj4gPiBAQCAtMTAsNiArMTAsNDggQEANCj4gPiAgICNpbmNsdWRlICJt
dGtfdmNvZGVjX2Rydi5oIg0KPiA+ICAgI2luY2x1ZGUgIm10a192Y29kZWNfdXRpbC5oIg0KPiA+
IA0KPiA+ICtzdGF0aWMgdm9pZCBtdGtfdmRlY19kYmdmc19nZXRfZm9ybWF0X3R5cGUoc3RydWN0
IG10a192Y29kZWNfY3R4DQo+ID4gKmN0eCwgY2hhciAqYnVmLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICp1c2VkLCBpbnQgdG90YWwpDQo+ID4gK3sN
Cj4gPiArICAgICBpbnQgY3Vycl9sZW47DQo+ID4gKw0KPiA+ICsgICAgIHN3aXRjaCAoY3R4LT5j
dXJyZW50X2NvZGVjKSB7DQo+ID4gKyAgICAgY2FzZSBWNEwyX1BJWF9GTVRfSDI2NF9TTElDRToN
Cj4gPiArICAgICAgICAgICAgIGN1cnJfbGVuID0gc25wcmludGYoYnVmICsgKnVzZWQsIHRvdGFs
IC0gKnVzZWQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJcdG91dHB1
dCBmb3JtYXQ6IGgyNjQgc2xpY2VcbiIpOw0KPiANCj4gSXNuJ3QgdGhpcyB0aGUgc2FtZSBpbmZv
cm1hdGlvbiB0aGF0J3MgYWxzbyBnaXZlbiBieSB0aGUNCj4gVklESU9DX0VOVU1fRk1UIGlvY3Rs
Pw0KPiANCj4gQ2hlY2sgZnVuY3Rpb25zIHY0bF9lbnVtX2ZtdCgpLCB2NGxfZmlsbF9mbXRkZXNj
KCkuDQo+IA0KVGhpcyBwYXRjaCB1c2VkIHRvIGdldCBvdXRwdXQgYW5kIGNhcHR1cmUgZm9ybWF0
IGZvciBlYWNoIGluc3RhbmNlLg0KDQpNYXliZSAyIH4gNDkgaW5zdGFuY2UgdG8gcGFseSB2aWRl
byBhdCB0aGUgc2FtZSB0aW1lLg0KDQpOZWVkIHRvIGtub3cgdGhlIGZvcm1hdCB0eXBlIGZvciBl
YWNoIGluc3RhbmNlLg0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQpCZXN0IFJlZ2FyZHMsDQpZ
dW5mZWkgRG9uZw0KPiANCg==
