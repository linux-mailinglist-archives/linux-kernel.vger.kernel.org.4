Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90EB76C6309
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 10:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjCWJNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 05:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbjCWJNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 05:13:22 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835D51C311;
        Thu, 23 Mar 2023 02:13:18 -0700 (PDT)
X-UUID: eff19926c95a11eda9a90f0bb45854f4-20230323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Ql5z3sXxJ+UWfdXfIu9yk8Rt2ka6f/FyWgBmB0B+6sA=;
        b=iFbZ8mxL+0nnnQBRbQsgdcdR6Yqtw/9QCBvfyEqWeurNRl1GfdZOQopMw4Zh0LYCqM4+kBVrzuLm1Kg+6+8EjoarAB+5Zn0zIwkfXXDlGDsjC9U6rcyMqsagrYzUYcOpbDq25QV6xGCM/qI6ljqWug5uwkxHkWkXySQlhHKSaLw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:2d1c3157-519d-4cb7-92cc-7fcc5b7a2562,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:32a0b0f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 5,DFT
X-CID-BAS: 5,DFT,0,_
X-UUID: eff19926c95a11eda9a90f0bb45854f4-20230323
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1142929182; Thu, 23 Mar 2023 17:13:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 23 Mar 2023 17:13:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 23 Mar 2023 17:13:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkeCt777SW/RUSEB4cB0nql63kY/8j6IWFquS+kAnhrBfNCOBMn6SG6bjhIq0EuW1Yc0PIaCZe9NRs+GN10ycUPI/ByYW/CvR/P3Euf/H8+d6M1frcWwOLNI7i8c761hqGTCyNEdjuSQzK9srlf8uHpgnnPLWWXcts4TN7FdWxV+s0mIngtF74sNzUU++zFmFPE0xrZLKkY3U8t96nKrxgy2S62rX5sOrjHaqIKhdzBKu6uefigpzruckbpJYVLhczhCsHzSaEXbtYr7NavEFlzw7u3/GKs33+pl0FrFozO+OyGDe3bywK6DbKQJIdlIXL+9ZB85+Fz9TUkd0NAj3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ql5z3sXxJ+UWfdXfIu9yk8Rt2ka6f/FyWgBmB0B+6sA=;
 b=Qv+0PpdM6hahOkSE26c+0JO71Z11ysEaD1os2zOzj6R1Odm8m9TyD4xT3r6XWYbiqJQ+Shv3CkO4QGBGwMfmj6mTWT+0TPQi1AJSIP/Y8/7xl/oYNDBlHI2mfkylf5A6WMri1egqo7RmBQFatji2gMGJzqivosnf1bCU0CkE84Pd/iNUHnbGLFcpnqQntpKroFNzvGhUrpnVjw+6X90jI+TyRWCIuMJYXw0K/zwP0i6bZOLrVVgTtR2OiGDcWJ6Qm6cqAbn4y5VlsAURQWB0t8skD/c2NTWqRz1RuvOOsWA9r+LF9uuujJnUdnrPeu6dgl1y2CnvTdiJC2syWvDJSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ql5z3sXxJ+UWfdXfIu9yk8Rt2ka6f/FyWgBmB0B+6sA=;
 b=ElHNsI+v35+LiM7EImOCHxEPYA8VQM+ibVY+qFD4MhZgZdLk62Jt3o189D7PNZ6YW74dpYUU6ekrMaI0W3CYmyrnSveSDi5AXgjCeppF2JLaIeTD2cxENf5qo0eTkr4vyBt9TA/vELYjdTRtXtEKtUX3uC6h/hpRryde7cTLSNc=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB6508.apcprd03.prod.outlook.com (2603:1096:101:55::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 09:13:09 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::4298:a8e4:7328:6bb1%5]) with mapi id 15.20.6178.037; Thu, 23 Mar 2023
 09:13:09 +0000
From:   =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To:     "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "yong.wu@mediatek.org" <yong.wu@mediatek.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
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
Subject: Re: [PATCH 1/2] media: mediatek: vcodec: Remove decoder 'dma-ranges'
 conditon when set dma mask
Thread-Topic: [PATCH 1/2] media: mediatek: vcodec: Remove decoder 'dma-ranges'
 conditon when set dma mask
Thread-Index: AQHZXWMIYwua/6t4P0Wnz7B9mSuUJa8IDi8AgAAGYIA=
Date:   Thu, 23 Mar 2023 09:13:09 +0000
Message-ID: <7e25543e8aff9f15e0baddb2b88c3fcb1d8d3b1a.camel@mediatek.com>
References: <20230323083810.21912-1-yunfei.dong@mediatek.com>
         <5202922d-9cc3-8aac-4193-ee463b255846@collabora.com>
In-Reply-To: <5202922d-9cc3-8aac-4193-ee463b255846@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB6508:EE_
x-ms-office365-filtering-correlation-id: d4649f68-7894-4ba2-4428-08db2b7ed227
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KDEq4mrGZ6qTOA8dXx2ABn91NwNqntOoDpn8GoVblimpu4AJStvuszpDVjr4uEA7ic3rOizx3Fuia5bJCpWLUMyEiTk0US53ikZBSCCA5/tP6Sf6cVcqeiJvfJrFEuEntM/rnKLXy/E/xA4lAx9Y6Tw6vTTywMwbUOVRctfS5G5MxnEyuw80fGqVSDwCnMiqo1rqCujIHv0mjblQhtpgNWIXeWOD7NB54/uhnEetwR4ZdIfAq4/w7bRl6N8zkvjaMhxfRr9KObLjZMxG3s5T9YHOwg7JefeS/ffRrH1/8Mvvhy5FF7+7GZhRcn9vSGj24TX8SfRUR6FqzVO2C7ew9vm0YL4XWrX1rQxK9waghm4jgEydb+3r80COqQ7GtK2HBj6rBrYFI7T2VUcglaD+UmA2IQercFbRm985WuZXqVP2VKExaciWzeKuSgS4f1TkAaHss7hfCGC+/Pur7jkK3SEFMJ6AmLwK2v9qyboYS6OfDgW5XSNX5Cxq9uX6nMxmWMOAWTt4+VbIWApIdsCE3hIhrJh3gJWsDX3nyKBHbf6pyHg2SCnCoOtP0CK6kvPM1aj2QUtCCsv9PgLyjX+cYfjP2Myr/G889TxyZJd2Jf1SPz5uJk7IzHZ6hBNcTUoRErKYjgcIP4aNdWZfMtcNswYppERZJ+ur8FUXuSLLcdu9npibF7R0bdBjZGUI1MCdmw6ZxUbjziv3j79wugqaNlG4HofJ3ttm4gBD13PBY5WKc7v/2W3IT/v4ZsZ7IVlpbe33/tWYCsrr2qsXI8cawg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(376002)(366004)(39860400002)(136003)(451199018)(2616005)(478600001)(71200400001)(6506007)(6486002)(83380400001)(66446008)(66476007)(316002)(66556008)(8676002)(66946007)(64756008)(26005)(54906003)(76116006)(110136005)(186003)(7416002)(8936002)(5660300002)(6512007)(41300700001)(122000001)(4326008)(2906002)(38100700002)(36756003)(85182001)(38070700005)(86362001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MldvdDR0SDdlWjRwaWpNV3ovUlFyZkcyQ24xYi9EenlCR3hZUWFiZmtGRmJv?=
 =?utf-8?B?Q1ZCd243V2hXVU81aUJqVkQ5aXV5NHd6YlJNTVBFSVJvZk9SUU00cW9xQUl6?=
 =?utf-8?B?VFF5TG1va043U2pudHdCU280T2Z4NStTcTFTZ09XRDhMbzhCWDZkTkcwakJQ?=
 =?utf-8?B?ZTU2VmhOa21XcnRqaFU3MkpUT3BCWkpQZU5jbmtaUktJZ3BHMzkwb0d0UCtT?=
 =?utf-8?B?akRRSU1kZ3hzOFJVQVg1MVhreCtKTDc3ZXNKUjdRbjIySzJ1Q2FCdFp1dFd1?=
 =?utf-8?B?TjQ1Wloyd3g3UHAxQmtYejc3OFJHdjZzbkVYcFluREoveFIzRjE3QWFGaFUy?=
 =?utf-8?B?RDgyZDZRMU5iWkNBMGd6UG5aWXh4Wk8wcWtESmxuR1BxMlRCZTBDOHVuZDkr?=
 =?utf-8?B?V1M2NjBtUDQwZlphYXRZRHdYK0ZtT3lnK3RESnZSaTRKc1g4OFNaSUc0cUhs?=
 =?utf-8?B?Z0xsWWFvSUVrUVBsOEh6TVE5anZuSWhrQjFBMmJiU0YvZUFNL2pjQkxTYkMx?=
 =?utf-8?B?bWgzQTNwZ2d3SkNDN3lpc1BrTFFuRmhmTXAxRnV2empLZ0F2VlM4WjJtdXJW?=
 =?utf-8?B?RktOZDgxbUdpYjRUWHNXVy9vR2ZhVGhxVlFhT0dZcnptTHFzV2UxRU5YcEdQ?=
 =?utf-8?B?aW50eHc0bkNJRGZUbUtraWdFNHV1bThwOXlLLzY1Tmd0bEU5NDBveDB1d05G?=
 =?utf-8?B?V2ZlZVFVQjJoY0oxc24zRGNlMk93dVlTTlZDNTh3STlZcXNtanJlUURZVVNj?=
 =?utf-8?B?REdrejdoRUVWV21mQnluUGlHMnJYMlhQa3Ezd25xRkZvVEhCa0d3bnA3LzUy?=
 =?utf-8?B?bXVGdDVpSlVPclovbk5GK0xqQzl0Y3AvN29GU280ZjlyV2hKWGF4YU5kamFp?=
 =?utf-8?B?OW12N1JNRVFocThCUGRXamlXRHlWK2FCT3ZjWUF3QTJ3aXdDaXZVT3h6R0V5?=
 =?utf-8?B?UGt0Q04vd1VnL3VxdEtPeTNiNm1tUXRwa2JYY1ZXL3BXMVBYSFltQnZIUEE4?=
 =?utf-8?B?NCtEdEVib1FPRW53V1NoYUk3a2hQSGdvSEV4SjRJd2d6YTN1VFgxcTU1aENL?=
 =?utf-8?B?NWh0ZDYrK3J4ZktCOGloSnVKanRxKzJEVUVjMEhSeHZJSXROMmVBanRLQjgr?=
 =?utf-8?B?bFJ0TERsSjl0UVFkMnk4RWlQcnJZZUFqa0JkVlhvUlRzMVY0WGNkNlBEVklt?=
 =?utf-8?B?UGV5MWNCWkd0Nk9qbjA4U2FSd2JzN2xLcVdxMG84RFRtTWN2dmhLZVpTRTA5?=
 =?utf-8?B?MGs4NTYwK2tWdkRYOURtcElSWG40UnAxQnZINFh6T0MySTBCK0ZjZU5jdzVG?=
 =?utf-8?B?ZUppcUNNQzgveHRmMHJLdzNKWFZQdzB0enJEU1M1L0pEMi83dzF6RVVsSlp0?=
 =?utf-8?B?NzRscHpOem92dkFublU2b3JURTBXektHM0xncFM4c3FTUEJBWThmSTVGSlhS?=
 =?utf-8?B?Um92d29OdzcrTGEzZmhhRGZWbWRBMm9nWWYrTUFxT3JaQ3pERHN2N0FiT1hs?=
 =?utf-8?B?ZHdYMDdiRDNUdU0rY2FvdGxZU2VNMmlJdDZWcWhZVzJNRzVNY0NRM3dZa1Ur?=
 =?utf-8?B?OTdoUkJSb1hKS1hJMTUwTzlxVEs2V1lyUGJvdC9UQVV1YjBvV3d1UTZXZTZs?=
 =?utf-8?B?bys2MUJRUU5zb3hLeEJuRCtEYTBPdktTZjJBMGtPbC9acmFjR0RaRVUzUzlV?=
 =?utf-8?B?eGVBK1BJZEdZSnN0bWZrQncxQk9UMXB6R28rSC96NWdkTkRuSGptY2ZSV3Bm?=
 =?utf-8?B?ejRtenY0U05iQVRUUlBjcUh6Z1NqSVJ4WUlsSlZSL3BqdEdtUXQ5dWNVajNZ?=
 =?utf-8?B?Q3EvRG41cDFTa21nc3k0K0lqSUNFM1JsSU83RWdCVTJvWmtHQmwzc2RTV21i?=
 =?utf-8?B?VFZoWnNnK0E2L1BQZ0xCakVWQ29yRVpzWndPL3JNTWFDNjFGMjJRZHpMYjBB?=
 =?utf-8?B?MTV6UWhkMkJSRThEODlLTisySXNrc0hXMm9ObzVaZUNsTDA3YnJRc2FmZ3Rv?=
 =?utf-8?B?SDJQdkg4ek1lK2ZwM3lQQXozRjByeURpYXZQZitFUU5INlZLdGpCSzcxcWt3?=
 =?utf-8?B?SktOOXBaVWttUlNnNnlWSllpRHp2ZFgvT2tLdGRFcW0rQlZ3bkxaaFFkSFAz?=
 =?utf-8?B?dkdMcm1FY21EekpqS3JtMnl4aVpwQmFSL3EvVVM3b25BalRYbnpBUWdWclhq?=
 =?utf-8?B?c0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B542FBE8701D1746B215E32EA3713CEF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4649f68-7894-4ba2-4428-08db2b7ed227
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 09:13:09.4081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bIsyZ4GU8k+D8duvkyXVqmKtAIgWzpTRgniI79VRzabLc8lpdbEK243pVWOKh+pbBDxtgb29NRcar4UA7Rv7Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6508
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

T24gVGh1LCAyMDIzLTAzLTIzIGF0IDA5OjUwICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMjMvMDMvMjMgMDk6MzgsIFl1bmZlaSBEb25nIGhhIHNjcml0dG86
DQo+ID4gQWZ0ZXIgY29tbWl0IGYxYWQ1MzM4YTRkNSgib2Y6IEZpeCAiZG1hLXJhbmdlcyIgaGFu
ZGxpbmcgZm9yIGJ1cw0KPiA+IGNvbnRyb2xsZXJzIiksDQo+ID4gdGhlIGRtYS1yYW5nZXMgaXMg
bm90IGFsbG93ZWQgaW4gZGVjb2RlciBkdHMgbm9kZS4gQnV0IHRoZSBkcml2ZXINCj4gPiBzdGls
bCBuZWVkDQo+ID4gdG8gc2V0IGRtYSBtYXNrLCByZW1vdmUgImRtYS1yYW5nZXMiIGNvbmRpdGlv
biBpbiBwcm9iIGZ1bmN0aW9uLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmZlaSBEb25n
IDx5dW5mZWkuZG9uZ0BtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gUmVmZXJlbmNlIHNlcmll
czoNCj4gPiBbMV06IHY1IG9mIHRoaXMgc2VyaWVzIGlzIHByZXNlbnQgYnkgWW9uZyBXdS4NCj4g
PiAgICAgICAyMDIzMDMwNzAyMzUwNy4xMzMwNi0xLXlvbmcud3VAbWVkaWF0ZWsuY29tDQo+ID4g
LS0tDQo+ID4gICAuLi4vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjX2Rydi5jICAgICAg
fCAyNCArKysrKysrKysrKysrLQ0KPiA+IC0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMTcg
aW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4g
YS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlY19k
cnYuYw0KPiA+IGIvZHJpdmVycy9tZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zj
b2RlY19kZWNfZHJ2LmMNCj4gPiBpbmRleCBiYmE3YjkzMmY0ZmEuLjJjM2E0YzJjZGFlZSAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRmb3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtf
dmNvZGVjX2RlY19kcnYuYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0vbWVkaWF0
ZWsvdmNvZGVjL210a192Y29kZWNfZGVjX2Rydi5jDQo+ID4gQEAgLTEzNyw2ICsxMzcsMjAgQEAg
c3RhdGljIGludA0KPiA+IG10a192Y29kZWNfaW5pdF9kZWNfcmVzb3VyY2VzKHN0cnVjdCBtdGtf
dmNvZGVjX2RldiAqZGV2KQ0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ICAgfQ0KPiA+IA0KPiA+
ICtzdGF0aWMgaW50IG10a192Y29kZWNfZGVjX3NldF9kbWFfbWFzayhzdHJ1Y3QgZGV2aWNlICpk
ZXYpDQo+ID4gK3sNCj4gPiArICAgICBpbnQgcmV0ID0gMDsNCj4gPiArDQo+ID4gKyAgICAgcmV0
dXJuICEob2ZfZGV2aWNlX2lzX2NvbXBhdGlibGUoZGV2LT5vZl9ub2RlLA0KPiA+ICJtZWRpYXRl
ayxtdDgxNzMtdmNvZGVjLWRlYyIpIHx8DQo+ID4gKyAgICAgICAgICAgIG9mX2RldmljZV9pc19j
b21wYXRpYmxlKGRldi0+b2Zfbm9kZSwNCj4gPiAibWVkaWF0ZWssbXQ4MTgzLXZjb2RlYy1kZWMi
KSk7DQo+IA0KPiBMaWtlIHRoYXQsIHlvdSdyZSBuZXZlciByZWFjaGluZyB0aGUgY29kZSBiZWxv
dy4uLg0KPiANCj4gQW55d2F5LCBhdCBhIGZpcnN0IGdsYW5jZSwgaXQgbG9va2VkIGxpa2UgeW91
IHdlcmUgc2VuZGluZyB0aGUgc2FtZQ0KPiBjb21taXQgdHdpY2UsDQo+IGJ1dCB0aGVuIEkgbm90
aWNlZC4uLiBzby4uLiBJIHdvdWxkIHByb3Bvc2UgdG8gY2hhbmdlIHRoZSBjb21taXQNCj4gdGl0
bGUocykgdG8gZm9sbG93DQo+IHRoaXMgZm9ybWF0Og0KPiANCj4gbWVkaWE6IG1lZGlhdGVrOiB2
Y29kZWM6IGVuYzogU2V0IERNQSBtYXNrIG9ubHkgZm9yIE1UODE3MyBhbmQgTVQ4MTgzDQo+IA0K
PiAoYnV0IHRoZW4sIHdoeSBtdDgxNzMvODMgYW5kIG5vdCB0aGUgb3RoZXJzPyB0aGlzIGRlc2Vy
dmVzIGFuDQo+IGV4cGxhbmF0aW9uLi4uKQ0KDQpUaGlzIHNob3VsZCBiZSBtdDgxNzMvODMgZG9u
J3QgbmVlZCB0aGlzLiBBZnRlciBjb25maXJtaW5nIHdpdGggeXVuZmVpLA0KSSB3aWxsIGZpeCB0
aGUgInJldHVybiIgYWJvdmUgYW5kIGNvbnRhaW4gdGhpcyB0d28gcGF0Y2hlcyBhbmQgYSBqcGVn
DQpmaXggcGF0Y2ggaW50byB0aGUgcGF0Y2hzZXQgb2YgIkFkanVzdCB0aGUgZG1hLXJhbmdlcyBm
b3IgTVRLIElPTU1VIi4NClRoaXMgaXNzdWUgd2FzIGludHJvZHVjZWQgYnkgdGhhdCBvbmUgc2lu
Y2UgSSByZW1vdmVkICJkbWEtcmFuZ2VzIiBmb3INCnRoZW0uIHRoZXkgc2hvdWxkIGJlIGEgdG9w
aWMuDQoNCj4gDQo+IA0KPiBSZWdhcmRzLA0KPiBBbmdlbG8NCj4gDQo+IA0K
