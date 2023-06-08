Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1267278C4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjFHH2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjFHH2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:28:10 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4ED1B9;
        Thu,  8 Jun 2023 00:28:03 -0700 (PDT)
X-UUID: fe0de5c805cd11eeb20a276fd37b9834-20230608
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=NO8DnA9eaHDQKD9tcOHpOOqODBziiuudwvkRoIHP1Hs=;
        b=TslgWW8FDrAvMmiwlLDUuVMNiXH5h7YisqikW710Dl737ByXFkXmrmmo9Sb3dzRvENVxOxlRP7lGMKtbYi0UH1q0I8CjncNO/Omqmax4V2zMoSfmSFlOgGrZ/Tzzd3SUIWHu+O8LJUc2d9nzoyxbryCnmI1c+zKNRBKNTgp8BYI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:6cb68da9-af37-4080-8009-aff2ee9eb2eb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:437af73d-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe0de5c805cd11eeb20a276fd37b9834-20230608
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 830458685; Thu, 08 Jun 2023 15:27:58 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 8 Jun 2023 15:27:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 8 Jun 2023 15:27:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk4znHpIgCWg6k7rWZ4r9WyHFC1c0O2bcvJIqg+Nh0dDeSiPQzq1nGcz7jDwgIVEuudBW+IWBLYgMrrd8UmvLp2CW9nL7hWnCe/FOP+pZTTa1AFefoBUYpfuzFXD5IJpT3TCAR5dKSatonUThWqpMU/o7vEzwb+SRlh15u3RPVLbJDKeWXhLRTa0CMWZg88zkpN6p9aTWcvih4CZr0OwEUV1soQLseTwfqc1GN5pP50dj5syUeZEnq+XgBA+Qs+R6WcdT0UecCYiI4byp/RVLJwSVemPFeu1jlYPgrNSXGlRa597DNhyZL5V1ojLX2oAWoNw3BXjF7352sYf85hD5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO8DnA9eaHDQKD9tcOHpOOqODBziiuudwvkRoIHP1Hs=;
 b=lE90z6QxubquuPKTBfgyVQc1GLYKYYeTmBCmvkqNztCRZsyqPhGR/UpjBCSjQVqvSKuPI6l+1HAxETWxGTCgK7FjEfqYTdlg8ptOLikv7LULMQF5qJVN8gsBsZrmbC04YEUh04L/LB0E1C6UXiQmyOSvCweB3qDFkqhOAF+Kx5yKGovIAZFX3+OWRQW2iQiGYfGciR7dTE+DvXI0OE+Z7xF0ebhrx4VCXRO0kJXYirpmIRL4MI6K/0dVISrrAiD+XKIw2jO0HA9zetJ81cszHfiNWR8BLrqMNVB1SfAZfRGW+pHGh0HvL9RmI3Q7mLYGLYwXEzoWJ9ZSwfP80YzQZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO8DnA9eaHDQKD9tcOHpOOqODBziiuudwvkRoIHP1Hs=;
 b=dq0cJ/fM4bDKPN52mCbqZnJ/4bOH7eszAitflhqJ6Y3I5a2TlSIRCTK8YRkH4LufdcRz2iTxhWtORnSh/QKjJZxbpe4YN4WK2uvtsnDLBY5o1O5qnZfHHYw49QKTEvDjmIxJHwa7vRD0wniWm7dDQ6+cMzsMM85GFdSaXjV7m5Q=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by KL1PR0302MB5393.apcprd03.prod.outlook.com (2603:1096:820:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 8 Jun
 2023 07:27:52 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::8fce:558a:2511:c41b%4]) with mapi id 15.20.6477.016; Thu, 8 Jun 2023
 07:27:52 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nhebert@chromium.org" <nhebert@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nicolas.dufresne@collabora.com" <nicolas.dufresne@collabora.com>,
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
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2,04/10] media: mediatek: vcodec: remove the dependency
 of debug log
Thread-Topic: [PATCH v2,04/10] media: mediatek: vcodec: remove the dependency
 of debug log
Thread-Index: AQHZmR0jmQkpnXgRrkqIvSc9R6kUVa+AImQAgABg2IA=
Date:   Thu, 8 Jun 2023 07:27:52 +0000
Message-ID: <6bb7e4b283332f1b76c1550347cb245a57eee90b.camel@mediatek.com>
References: <20230607084901.28021-1-yunfei.dong@mediatek.com>
         <20230607084901.28021-5-yunfei.dong@mediatek.com>
         <ad28c125d9efca1f7e422fffe42dd56cef66b349.camel@collabora.com>
In-Reply-To: <ad28c125d9efca1f7e422fffe42dd56cef66b349.camel@collabora.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|KL1PR0302MB5393:EE_
x-ms-office365-filtering-correlation-id: cf2920ff-1aac-4271-29f4-08db67f1de7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9bHqCYenx5Fqvq8GadcKncG8wJ5wqUgBDNjuxbsRTgha0DH9zdRZ3eWAy4nOZCv7GHJAKX+DvcTptSVghR19fLZCjAJZjg0yy05dR8UWvU0WqV+PDLeZzuzhD19CvNHT7j3peeUQ3xDqVhRoC5qUQ5CqZd5x3S0T/rlORNrgb3Uc+AgDz+hLT6mDOEIDW2qA9Wi2rse1guAxmRwDrJq3+agIcOFBbzIIshfSIUFYDKT0Yqw9Oh66u9Qb2136jXNuG0nkv6RVswQEYY5kDEOgqPha6LvtZef10d9+F00ihwfXfHYqLToel20IiKGrKWGHgx60tO06xrjaSuI7Z+5Vuy6ALucTk6ffosAhYXdcxbBnN4X3OzyPDdi5bXKyJkchmMzEvL4LNogBv1Mrl9qpT8zGKJ5xR1cq9tzukUZ+t6BFnKtQvoGHQJ7UTiUUq0DNhkI5juKCpXko5OXXNCq/PWPeqhTdYRKfZlKU2qMl2lXv2Vb2bBtyak5iuQYB76jEhKC7FQBNQVGWyqyMdX5GH+3N9a3ebpU7U2cYVOjRbehklBTdcid7XbJjDQ6FonHDwYVTW8rylVQVzJ2HOQsoQOQHnLfB2PYkmnIRDAokkoWcTM4sEsfOo5aegyYA2IDflosoApY5KTKvvd+Gxj/dwDCFNFr4X13fBwLGvC36qj5/8UGp8kJcACWoq5ZcZbQh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199021)(66574015)(76116006)(2616005)(26005)(66446008)(6506007)(6512007)(316002)(83380400001)(64756008)(66556008)(4326008)(122000001)(91956017)(66476007)(66946007)(6486002)(186003)(478600001)(71200400001)(85182001)(110136005)(36756003)(54906003)(38070700005)(2906002)(5660300002)(8676002)(8936002)(86362001)(7416002)(41300700001)(38100700002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFVSZEtTcGZQdlBOZm1uSzUxUFZGZHYrZW1Kb3JCQ3p3Um43cEJrWGZXWmlh?=
 =?utf-8?B?TVRoeVViL3pTcTBlMnZHMXF4WGpURUVibjlaK2V4Y1NOTXB5cGlnMUVhc2Rj?=
 =?utf-8?B?V040ZEhKeXR6ZG1pN1huNld2bWRuSTBGRStGV2JXSlo3V0F6U0k5QlpTSCtM?=
 =?utf-8?B?dXF1ekNGSEJxYnBoYThHMGJCRCtRZlZkdnpnUDc3UG00ck1qeWw2dTRjZjhu?=
 =?utf-8?B?bkMrSFFSYlhFeVRrMm5HV2dYbFhPTzB5d1pUaUFpTSt5ejNWSXh1THM3Rkt0?=
 =?utf-8?B?ZTQvRW5zWGhBNVplN1BySzQ2bitmV3NuWkJPQzJtTHVqYzlLYk1iN2hyZnFY?=
 =?utf-8?B?UisrUnBHbTYxTFlvREVMTnBJUi9QWS81UElxUWhHSTUzUCtoUVRKR3QwendS?=
 =?utf-8?B?dXFoVmdONnU4TDhpZHRUOW5nck5SaUhVWVdhWFV4dklHK25QUm9QUllRdmRv?=
 =?utf-8?B?OEpSRk93Q2FyYStLMnowNUMxbzhwQ2ppckg1N0h5cFpKbXh1Tjg0MHN0aE1j?=
 =?utf-8?B?RkhQQjZYSkNkYjNOUFBKRXJEMDdxczk1eVJ1Qi9jZC9xeldjb2owUk1UOU81?=
 =?utf-8?B?YnNKaWtsdld0WGxvdlBoVll2bHVPdnNQa3l1emtMcUdGc3crdENGNzRENFhH?=
 =?utf-8?B?a1ZKaDVmc3Jsa0pQSHNYc1pMc3FEak11R3BHY2dNUXJwYkY2U1J2TmpsRU5J?=
 =?utf-8?B?WlZEWk5NYWp2d1BLbmJLS1d5Y3I5d3REV3RMODczVVd3d09ZVSswZ2wxSU4x?=
 =?utf-8?B?QW5IU2dCUTNqL2t4UjEwUjNSNHlOeCsrN05WVEpubVZiNTZka084a2pCMnhM?=
 =?utf-8?B?citFcmluRmE1dUFDUzJtaHU4R3VLVG85Q0RxRTFhQWlyQ3liNGpqclNqbVov?=
 =?utf-8?B?cXdyOGNJUkYxZUJJTTI0ZEpic3M4U3hIcDJRU0tsdm9wUG4yVjRlUE1DQVFL?=
 =?utf-8?B?N2xNcXNwT0Z5aDNxQVR3ak1tQ2Z1bUc4WHNQTW5pMStWSnRWYkk4SENGSjFI?=
 =?utf-8?B?NEdqOEYvbVJma1gvQ2NUVmpMck9jQzlXTmd5VWhFTURJWTFmcnpHOVJJTFlV?=
 =?utf-8?B?cEdRdUJGenF6azJyZ090a3pDcmMwb0ZuQWJTcGtKOVFkRElPeTErb0hLajli?=
 =?utf-8?B?M080ZHlpRlV1N084TVdHRkR3RlY0T3piN1gxL0t0RlJDTFR5OEVHMTEzNVcz?=
 =?utf-8?B?OUh4SVhKSm5zamFnaXN3ZFA4dGdIa1o0N1FQbGJndmtLdktNNTFBNGJuWndT?=
 =?utf-8?B?bWF3YnlMS0VDVS9kMnRBMldBVzUzdXZsblNzYzRQdnBJSUVRbDhoQ29qY1l0?=
 =?utf-8?B?U2tmZm12RjBQZFdOMzN1ODJTaGYwZzRYYWwyWEtCRGxLUHRLbWNUT1lzS0hj?=
 =?utf-8?B?U3J4YTNMbVpqejNkTWtqZ1V5YkhZVFFOQUYvUXJZV0d0RFY0cldrUDlMSCtD?=
 =?utf-8?B?cGtna2hqZXZZZEVSL2hIV2xyV3hrRmEwS0hlclFvOXR4ZkE2eHpEQ3pVWG5h?=
 =?utf-8?B?bk0zVzBxZS9Ya2p3RHZ4bGpta29rTXlFc0labDFRa24wMUhtTllLSStLMVRk?=
 =?utf-8?B?K3V5MGhjZ29zYWM4ekoyRHlNdUNXTnRkQkhZWWNKbDczVDZUUG5xZXZtbmk4?=
 =?utf-8?B?N3NCUE81YlBtVFhtcHBwSEZlbnFQYUZsay9MZnIyR1QrTXRZNUdscHBjZ24z?=
 =?utf-8?B?dkJUZUIvSDd1S3h2Qnc0NW8ra1IrYUY2SENHWEpEeldjWHJSZmJiaHh6QlYv?=
 =?utf-8?B?UUdSa1UwcmdzejY5YVFWcXQ2WjJZak8wa3BENEJuZ1VCbkNHSU1NTEs0ay8v?=
 =?utf-8?B?bGJOTm1lRkFlcTdRaGZlTXhkNkI5R1BEVVJSSWpaU0IzR2daVnFoWUxHRTJX?=
 =?utf-8?B?NFRJS2NGS3pYVFJiME9raWRIMUwwd3Q0TU5iOWFvb3JqTkUrL0FkYTJ1UHd1?=
 =?utf-8?B?M2d6Nlh3NXIxazdvdTU4VDBCTmdBaThHZzArTmREWk1VbkpYK00yOVRxNDZl?=
 =?utf-8?B?M295bnF4SmlIa0NvM0ZOZnp3bFRzVmlxTFZwZGdDK0d5cTI5QUVQNlFHcmZB?=
 =?utf-8?B?SGpiT08yVGp1NWVTbkxDR3d3ampaUU5rQWVVMjBmaHdCNGtWTTQ5UUFmL0xN?=
 =?utf-8?B?NU5JcG5SZkdXalJVNGtjNzFkaFRudlN5VTBvd2E5L3g3S3hvdmdnTTErOG84?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6916056996FEAD4BBC14F03D2A79FC50@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2920ff-1aac-4271-29f4-08db67f1de7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 07:27:52.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bgzBJd4dnXxoLLWyUpqXkOyIyD6Dun0da3U/Su1tuIbynlk8ck6lzaU7Wd4snZQE4m/YtdGKpU2TeeHuazruHEbyQImlfcpRr+aoX1ZJ8pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0302MB5393
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

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCk9uIFdlZCwgMjAyMy0wNi0w
NyBhdCAyMTo0MSAtMDQwMCwgTmljb2xhcyBEdWZyZXNuZSB3cm90ZToNCj4gIAkgDQo+IEV4dGVy
bmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+
ICBIaSBZdW5mZWksDQo+IA0KPiBMZSBtZXJjcmVkaSAwNyBqdWluIDIwMjMgw6AgMTY6NDggKzA4
MDAsIFl1bmZlaSBEb25nIGEgw6ljcml0IDoNCj4gPiAnbXRrX3Zjb2RlY19kZWJ1ZycgYW5kICdt
dGtfdmNvZGVjX2VycicgZGVwZW5kcyBvbiAnbXRrX3Zjb2RlY19jdHgnDQo+ID4gdG8gZ2V0IHRo
ZSBpbmRleCBvZiBlYWNoIGluc3RhbmNlLCB1c2luZyB0aGUgaW5kZXggZGlyZWN0bHkgaW5zdGVh
ZA0KPiA+IG9mIHdpdGggJ210a192Y29kZWNfY3R4Jy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5
OiBZdW5mZWkgRG9uZyA8eXVuZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAu
Li4vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRpbC5oICAgICAgICAgfCAgMjYgKystDQo+
ID4gIC4uLi92Y29kZWMvdmRlYy92ZGVjX2F2MV9yZXFfbGF0X2lmLmMgICAgICAgICB8IDEwNSAr
KysrKysrLS0tLS0NCj4gPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfaDI2NF9pZi5j
ICAgICAgIHwgIDYyICsrKystLS0NCj4gPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNf
aDI2NF9yZXFfaWYuYyAgIHwgIDM5ICsrKy0tDQo+ID4gIC4uLi92Y29kZWMvdmRlYy92ZGVjX2gy
NjRfcmVxX211bHRpX2lmLmMgICAgICB8ICA4MCArKysrKy0tLS0NCj4gPiAgLi4uL3Zjb2RlYy92
ZGVjL3ZkZWNfaGV2Y19yZXFfbXVsdGlfaWYuYyAgICAgIHwgIDY3ICsrKystLS0tDQo+ID4gIC4u
Li9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX3ZwOF9pZi5jICAgICAgICB8ICA1NCArKysrLS0t
DQo+ID4gIC4uLi9tZWRpYXRlay92Y29kZWMvdmRlYy92ZGVjX3ZwOF9yZXFfaWYuYyAgICB8ICA0
NiArKystLS0NCj4gPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZGVjL3ZkZWNfdnA5X2lmLmMgICAg
ICAgIHwgMTUyICsrKysrKysrKystLQ0KPiAtLS0tLS0NCj4gPiAgLi4uL3Zjb2RlYy92ZGVjL3Zk
ZWNfdnA5X3JlcV9sYXRfaWYuYyAgICAgICAgIHwgIDg0ICsrKysrKy0tLS0NCj4gPiAgLi4uL3Bs
YXRmb3JtL21lZGlhdGVrL3Zjb2RlYy92ZGVjX3ZwdV9pZi5jICAgIHwgIDU5ICsrKystLS0NCj4g
PiAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZW5jL3ZlbmNfaDI2NF9pZi5jICAgICAgIHwgIDg2ICsr
KysrLS0tLS0NCj4gPiAgLi4uL21lZGlhdGVrL3Zjb2RlYy92ZW5jL3ZlbmNfdnA4X2lmLmMgICAg
ICAgIHwgIDQ4ICsrKy0tLQ0KPiA+ICAuLi4vcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL3ZlbmNf
dnB1X2lmLmMgICAgfCAgNjQgKysrKy0tLS0NCj4gPiAgMTQgZmlsZXMgY2hhbmdlZCwgNTY1IGlu
c2VydGlvbnMoKyksIDQwNyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+IGEv
ZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY191dGlsLmgN
Cj4gYi9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX3V0
aWwuaA0KPiA+IGluZGV4IGVjYjBiZGYzYTRmNC4uZGRjMTJjM2UyOTgzIDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfdXRp
bC5oDQo+ID4gKysrIGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRr
X3Zjb2RlY191dGlsLmgNCj4gPiBAQCAtMzEsOSArMzEsOCBAQCBzdHJ1Y3QgbXRrX3Zjb2RlY19k
ZXY7DQo+ID4gICNkZWZpbmUgbXRrX3Y0bDJfZXJyKGZtdCwgYXJncy4uLikgICAgICAgICAgICAg
ICAgXA0KPiA+ICBwcl9lcnIoIltNVEtfVjRMMl1bRVJST1JdICIgZm10ICJcbiIsICMjYXJncykN
Cj4gPiAgDQo+ID4gLSNkZWZpbmUgbXRrX3Zjb2RlY19lcnIoaCwgZm10LCBhcmdzLi4uKVwNCj4g
PiAtcHJfZXJyKCJbTVRLX1ZDT0RFQ11bRVJST1JdWyVkXTogIiBmbXQgIlxuIixcDQo+ID4gLSAg
ICAgICAoKHN0cnVjdCBtdGtfdmNvZGVjX2N0eCAqKShoKS0+Y3R4KS0+aWQsICMjYXJncykNCj4g
PiArI2RlZmluZSBtdGtfdmNvZGVjX2VycihwbGF0X2RldiwgaW5zdF9pZCwgZm10LA0KPiBhcmdz
Li4uKSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiArZGV2X2VycigmKHBs
YXRfZGV2KS0+ZGV2LCAiW01US19WQ09ERUNdW0VSUk9SXVslZF06ICIgZm10ICJcbiIsDQo+IGlu
c3RfaWQsICMjYXJncykNCj4gPiAgDQo+ID4gICNpZiBkZWZpbmVkKENPTkZJR19ERUJVR19GUykN
Cj4gPiAgZXh0ZXJuIGludCBtdGtfdjRsMl9kYmdfbGV2ZWw7DQo+ID4gQEAgLTQ2LDI3ICs0NSwy
NCBAQCBleHRlcm4gaW50IG10a192Y29kZWNfZGJnOw0KPiA+ICAgX19mdW5jX18sIF9fTElORV9f
LCAjI2FyZ3MpOyAgICAgICAgXA0KPiA+ICB9IHdoaWxlICgwKQ0KPiA+ICANCj4gPiAtI2RlZmlu
ZSBtdGtfdmNvZGVjX2RlYnVnKGgsIGZtdCwgYXJncy4uLikgICAgICAgICAgICAgICAgICAgICAg
XA0KPiA+IC1kbyB7ICAgICAgICAgICAgICAgICAgICAgIFwNCj4gPiAtaWYgKG10a192Y29kZWNf
ZGJnKSAgICAgICAgICAgICAgICAgICAgICBcDQo+ID4gLWRldl9kYmcoJigoKHN0cnVjdCBtdGtf
dmNvZGVjX2N0eCAqKShoKS0+Y3R4KS0+ZGV2LT5wbGF0X2Rldi0NCj4gPmRldiksICAgXA0KPiA+
IC0iW01US19WQ09ERUNdWyVkXTogJXMsICVkICIgZm10ICJcbiIsICAgICAgICAgICAgICAgICAg
ICAgICAgIFwNCj4gPiAtKChzdHJ1Y3QgbXRrX3Zjb2RlY19jdHggKikoaCktPmN0eCktPmlkLCAg
ICAgICAgICAgICAgICAgICAgICBcDQo+ID4gLV9fZnVuY19fLCBfX0xJTkVfXywgIyNhcmdzKTsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXA0KPiA+ICsjZGVmaW5lIG10a192Y29k
ZWNfZGVidWcocGxhdF9kZXYsIGluc3RfaWQsIGZtdCwNCj4gYXJncy4uLikgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgXA0KPiA+ICtkbw0KPiB7ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCj4gICAgICAgICBc
DQo+ID4gK2lmDQo+IChtdGtfdmNvZGVjX2RiZykgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIA0KPiBcDQo+ID4gK2Rldl9kYmcoJihwbGF0X2Rldikt
PmRldiwgIltNVEtfVkNPREVDXVslZF06ICVzLCAlZCAiIGZtdCAiXG4iLCBcDQo+IA0KPiBBdCBs
ZWFzdCBpbiB0aGlzIHBhdGNoLCB5b3Ugc3lzdGVtYXRpY2FsbHkgcGFzcyBwbGF0X2RldiBhcw0K
PiA8c29tZXRoaW5nPi0+Y3R4LT5kZXYtPnBsYXRfZGV2LCB3aGljaCBpcyBxdWl0ZSBsb25nIGFu
ZCB2ZXJib3NlLCBhbnkNCj4gcmVhc29uIHdlDQo+IGNhbid0IGp1c3QgcGFzcyB0aGF0IDxzb21l
dGhpbmc+IGhlcmUgPyBXZSBjYW4gZm9sbG93IHRoZSBzYW1lDQo+IHN0cnVjdHVyZSBwYXRoDQo+
IGZvciBib3RoIGVuY29kZXIvZGVjb2RlciA/DQo+IA0KDQpJbiBvcmRlciB0byBzZXBhcmF0ZSBl
bmNvZGUgYW5kIGRlY29kZXIsIG5lZWQgdG8gZGVmaW5lIHR3byBkaWZmZXJlbnQNCnN0cnVjdCBt
dGtfdmNvZGVjX2RlY19jdHggYW5kIHN0cnVjdCBtdGtfdmNvZGVjX2VuY19jdHguDQoNCnN0cnVj
dCBtdGtfdmNvZGVjX2N0eCB3b24ndCBiZSB1c2VkIGFnYWluLCBuZWVkIHRvIHVzZSBwbGF0Zm9y
bSBkZXZpY2UNCnRvIHByaW50IGRldl9kYmcgYW5kIGRldl9lcnIuDQoNCmVuY29kZXIgYW5kIGRl
Y29kZXIgdXNpbmcgdGhlIHNhbWUgaW50ZXJmYWNlIHRvIHByaW50IGxvZyBtZXNzYWdlLg0KDQpC
ZXN0IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiA+ICtpbnN0X2lkLCBfX2Z1bmNfXywgX19MSU5F
X18sICMjYXJncyk7ICAgICAgICAgICAgICAgICAgIFwNCj4gPiAgfSB3aGlsZSAoMCkNCj4gPiAg
I2Vsc2UNCj4gPiAgI2RlZmluZSBtdGtfdjRsMl9kZWJ1ZyhsZXZlbCwgZm10LCBhcmdzLi4uKSBw
cl9kZWJ1ZyhmbXQsICMjYXJncykNCj4gPiAgDQo+ID4gLSNkZWZpbmUgbXRrX3Zjb2RlY19kZWJ1
ZyhoLCBmbXQsIGFyZ3MuLi4pXA0KPiA+IC1wcl9kZWJ1ZygiW01US19WQ09ERUNdWyVkXTogIiBm
bXQgIlxuIixcDQo+IA0KLi4uc25pcC4uLg0K
