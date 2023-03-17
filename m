Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E036BDF47
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 04:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCQDIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 23:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjCQDHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 23:07:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6C5ADD1;
        Thu, 16 Mar 2023 20:06:22 -0700 (PDT)
X-UUID: ade4865ec47011ed91027fb02e0f1d65-20230317
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=xCAtiUv62oRheeexKIXCKEztwpg+A6HxqGJgj3r6Fa4=;
        b=Bn33ckP2aZjQaW9hthP1+K8U4N0Uq7g62LKBvaNh20ElfXpHm7P545ATIuClk7/2w5mXBG2YQ85BSJvpusKIELFJIh1U7MqaLTSznJyn81F7d9xA4pde93pxtNnaFUkuXI6vTe0Xh1bQ64Za0skGw0Spt98uq+D+5hVsGIZmCTs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:b45e6cf7-6794-40dd-955c-0fd54b26df68,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:83295aa,CLOUDID:d40311f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: ade4865ec47011ed91027fb02e0f1d65-20230317
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1623338612; Fri, 17 Mar 2023 11:06:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Fri, 17 Mar 2023 11:06:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 17 Mar 2023 11:06:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hmi8EETLX3XiVyrVj9nknsTFtZOcc65FI7DNOXNxIco2p/HIBlj2pOk3maxbVK4VT2LO7er+kV8eRTwfJaLJ3+rEGVQHIYvMqFW2ou0PTONB6HiOuFp6N5G5+sYqvlDd9D0wuYlyBzHgemW5MhJiP+VkDu9Zsdeb0RV8U2DpgH2TSUwSz7oNsHQe34B+yQHsz1/JQIoCf7HNCVs+cj9MLLu73NGEmu/2ddSpbn1mNx/hyKs+ZovhHrxM73F0C8pcgS8FyZEQ+RkLQzsQ7mOqM+oqgpyOejDCFRYvlss6d2mEaW3QpXLJsqzSnPIWAojXFE3Ls9MZCsrfiPEMfiYcMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCAtiUv62oRheeexKIXCKEztwpg+A6HxqGJgj3r6Fa4=;
 b=njEHY/FIdmXqVAMhPHJ3FTjigWDqzj0cdaEwJPutUZPjL+Xm+H7qQ5i76ZcXVcGtmjF9DLRWZUNag9lbwAt9TQqpXII+enuO448cd4ARZ4YyLWNwQH7RgDpSOjEB7HPmLpaBwfFYEiBMoXiwaFpGw+An5rtfOt+IU9/+o3mYHckSoHA4/hwgHNNPjEjGYEzGa6SzHNhF4LBWN7kvbp3Yj9k+voQeOlOhE1o1N2hC7P3Zpdj5giPhbA3ktOMO5oSqXJlWDMNIEKZ0aE89/gUGmxCBcDhtoD4P0WPh44m5qEKsXAADrw/0JKf9h0r+0x/DWfoe6lm/f79qIy8a5BT33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCAtiUv62oRheeexKIXCKEztwpg+A6HxqGJgj3r6Fa4=;
 b=O+zHnLayYxvysEnCSWRQhl0af8tD2PcJ0wYkpqyq4b0Y2s+PtfyqYAWMUovc3Z4/t0WYznMO5MtaKZUpHJOk5imGFdJ/IiytS0YhqgvVyFu1Fq3BZjh7zXRb8Oo4/Q2YRINzxO/t/HMxcDjmMMNR3wt/7/Vh0C4r5R6553SR5xc=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by TYZPR03MB5213.apcprd03.prod.outlook.com (2603:1096:405:6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.33; Fri, 17 Mar
 2023 03:06:11 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.033; Fri, 17 Mar 2023
 03:06:11 +0000
From:   =?utf-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>
To:     "nfraprado@collabora.com" <nfraprado@collabora.com>
CC:     "nicolas@ndufresne.ca" <nicolas@ndufresne.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "stevecho@chromium.org" <stevecho@chromium.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "benjamin.gaignard@collabora.com" <benjamin.gaignard@collabora.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3] media: mediatek: vcodec: Force capture queue format to
 MM21
Thread-Topic: [PATCH v3] media: mediatek: vcodec: Force capture queue format
 to MM21
Thread-Index: AQHZVkZTwKjbLXkbmE6C0rhMdARylK795aoAgABooYA=
Date:   Fri, 17 Mar 2023 03:06:11 +0000
Message-ID: <a07360437c160baaec3ca624588bef90a499ca25.camel@mediatek.com>
References: <20230314072557.29669-1-yunfei.dong@mediatek.com>
         <20230316205140.sjkdwrpj2xwquho2@notapiano>
In-Reply-To: <20230316205140.sjkdwrpj2xwquho2@notapiano>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|TYZPR03MB5213:EE_
x-ms-office365-filtering-correlation-id: 634cb6d9-74c8-4371-a408-08db26948fc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsKyPEjHuSwck3V7V5y9oqorB2ix9Luu132LnXwTt3ylfn3rVH41Q2l2TNd3J0ZGeYGTwBOpZHkFxS/AIrFQ5GGmUu2QR0uXCHEa5ADGXiC/CBLLafgVTa8BNLMW0F5ID1wVOqQtBC9M8zbV/mhzmwDYYN4NYume7sR+cFXTlJiPl4SKPzj9v5WxvQkunV/O/3AIeEVcyJIDLGJ7TCUFNlXKFuDGkQIyQ81d/IlShMv52ebuHAKmFRA3HO9S64DOE658D086jhdUa/2RS0yl4DfeyyweXgpOtqceP10v7il/gGUQ13FWYcyOQEWBJH9WcdNALEnZEZU4PwKFiPhMiPEuTJuQls2vVT2zXI4U14Ez7kyHtQpmLyewXzDDMHYy1H3J1CW13KHwgoQVLtRqlEXIu4XAZt+jaSTfEtsbqTWJ188ETFoe8W52SCt50RGAiSq0EkZryvbSGNxXoAaU89k4nGL7o0naR7uyisqxE5hfUz6hPnyrmsxsFAmlPbcsDdM2NpNxb8KqkO+sijeA4LR0K+HASRRNky8DpfD7t5nYlhtfu06d3xpw1Q42cDVhzj29mBFdd+/T2gL0ksPVGuWOUdkl3hUcN4nTIkSmJk1i52DcjhW2hqINJviBRjeGqt/1ao23UzbYf86VwcMgedU87Eiy4wLeSjuGOsUEYImkTqk5T95RGNlJErX1prVdrP1JtGiWAMNUQLRp5Fm1EjdGeGHDfIMbRedNuMZ4PIY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199018)(122000001)(38100700002)(66946007)(6916009)(66476007)(8676002)(64756008)(66446008)(66556008)(4326008)(41300700001)(54906003)(316002)(91956017)(76116006)(83380400001)(8936002)(38070700005)(2616005)(71200400001)(5660300002)(7416002)(478600001)(26005)(6506007)(6512007)(36756003)(86362001)(66574015)(186003)(2906002)(6486002)(85182001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGxwOWFTamJvaW1Ib0dhT0kyVDEyS3RKL0VNRFRKb0pzOGd4bitjTEN1cG91?=
 =?utf-8?B?azhId2dUNG9IVDdpcXIrVW4wbmNaa1pTZTN6Sndhbk1sbllENU9uaDRPb0I0?=
 =?utf-8?B?SUR3OXRLOEJZSm10WnJBZlBUZE1rTmFIS0JYbDNmK0RJb2ZxVE9XRFJXVmlZ?=
 =?utf-8?B?UmFhYXk1clhIdjAzYkQvVnBOeXlJUTlXTFNZRnhIS2tYbTkraTJJcnZZaFhR?=
 =?utf-8?B?Smw0cUdTL09IL3gzK1hnVksyZDNGT2RBNm5wT0VGSFAxbHNCSGJBVmloNFk5?=
 =?utf-8?B?VGNmVytZUjI5YVdxVkRoZHpzY1kzc1NHTEVnQjZqTGZzeEdMWks3akcrcStL?=
 =?utf-8?B?VjlZQXBSS05wcmo3M0VpQ05yR1doOFBWQ3lYUlFZZGtyY21GRGJSRHR6dE95?=
 =?utf-8?B?a1MzSDd1S1lXbnU2dEdXS2lvbTVDK3l4cWk2QkRHRmpLK3hSYUlsY3FFSkx5?=
 =?utf-8?B?TldBNXp0NlJWZUIyWlY2RVlBOTNna2ZjRDNLVHR5T3dpbjFjSE4vbVRvZk9E?=
 =?utf-8?B?UXBlb2dDV0puZjIvUVZOay9DT0NvNk93VHlsdzJ4T1ZxbHcxY1BxRjFNaFkw?=
 =?utf-8?B?Y3EwdmwzR0ZiSlhwdG1McEF5Ym15a1lYN2swNEJMakMvOE1WTWJ1TWErcmhZ?=
 =?utf-8?B?SkZtNGQvV2hVYThmcmVidWdVZlo3SDBrNlcrRjQxVHpXNnNrdmRjcHNTSEpY?=
 =?utf-8?B?dnhwWUVQYldvYjRDZC91WHd1WTZpS3RDaWJGV2w3MWRFUVJXRDZXZWJmSzFX?=
 =?utf-8?B?ZXpuMU9BVk9SVlduTUgxa2ZYb29BSTBEaFd5L24rNzBSUm1wRXJOZDFNL0Zu?=
 =?utf-8?B?QXBEMm0vNnJ4Zm80enZINDh0cUNvcGZob3dwTzFwUDZsbGRCY1BMUkdWTU80?=
 =?utf-8?B?MWhaQ3lPaGh4Umh0cGJlN21pbVA3c2pYalJPZEgrUUdkbTdhYUVadTlQT3B0?=
 =?utf-8?B?UmxxemxOQU8xN2UzclpyRjlmYUxnYnVLNG9VZVFWSmRUY1c3OUlOL0hCSHpT?=
 =?utf-8?B?cjIyV3RpYmhDY1A3ckpwTmZPREYyZ002ZXZad25xaEY5eVJia1ZiTzNLZzBr?=
 =?utf-8?B?NGtIbjk2czRQaUxmWGpTb0EyM1RwZXlUbHRFQ0s3YXZzT3NRd1RPTnhNVzNy?=
 =?utf-8?B?d2lrbUpvRkV5MmZ3NHpzREQ1Y2ZEdkRIV1NzZ0RVSk5WblJPc0JrUUFiKzBR?=
 =?utf-8?B?R1RlRkE0TVFUcHQ3b2RpdWc0cU0yWHJIMDA3amFDU0dVTkVkS2RLMVB0UFVO?=
 =?utf-8?B?czJQNXZnRU5DZXpoSStvZzdjaXQ5ZUE4T3hKR2VMaFNxUGFpV1VaWjcxNW9Z?=
 =?utf-8?B?cUUyTFJtZmszdlFrWmllMFlwZjBOWnhmWStodHZqSm13dTBhUStRUzBtc3hh?=
 =?utf-8?B?empadTIwTDFvYkNMdWhDdndiUG15cnBPVEZEa0YydVl2YWVmRHg2MUQ2eGZ0?=
 =?utf-8?B?cGVXMEZ6dWpWNlZFbkJZNTBjODNQUmd3a2VNQlpCNUtHOU9DdlVmUERyR3JJ?=
 =?utf-8?B?NS96Wkw0a1dNMGVOenB3cWhBT3EwdDJvWlJwWmJSL1RFRmVQMjlYcHVGWmZT?=
 =?utf-8?B?QndTWWFlT0M4OXhCVldMWXpEMmlNS05ydThWd0F4ZEhwMFNHZjRENnRYcXNo?=
 =?utf-8?B?SVhiVkFHQjB5TW90VFFsV0tWaHg4ajZ4bjR6WmdMNXp4K2lvVzE2dDJsZUpa?=
 =?utf-8?B?ZVV0am1JcHNhUjJqY2F0NUdJeUpwcWJwN0YwVGpIbnMxR0RrRmRTL01wc2Ry?=
 =?utf-8?B?WkN4cDZvMlBpcFpMbUFvMmhVcjRzdy9iQ0VFR1dkOGpEcmJScmF6R1NZSDNW?=
 =?utf-8?B?UXVOZVpKOEREWXRoNnE2YzlER1pZWi9NZGR1eGZ1SEliV0Q4Tml6aUhXUlZi?=
 =?utf-8?B?dGhNRnkrU0lKREpMRzcyc1JGblo4SFBTa1ZST0NkWi8wcDFvVGxxNzdLU3lB?=
 =?utf-8?B?WmR5cjQ4aXM5Mk1QTkZqOWZGY1RJc3dnN0N5L3p1YVFFaXBaU2xxVlN3Z3Na?=
 =?utf-8?B?MFYvdTNuRURocXEvNXlRQnpxQlk3VTFGa2ZIZWtiWW5ET2tYYU1NWklTVm9w?=
 =?utf-8?B?dlBKQkYva1Y3RzFWazhacVl2a014NzRuakpKT1MveTM1MzFQdlFqeHNCS0NY?=
 =?utf-8?B?OExrWkJYdUloeTFBVWVNd1B4UnBKNmFSbVVGUHdsZHZFTVhLWDk0MjZkOS9W?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD051B1E31445146871E7748CAB88A53@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634cb6d9-74c8-4371-a408-08db26948fc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 03:06:11.1763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8ayAZZ/9kULETIDunxLdt6aTbGjuiuDN7b6Q95xO4L/imevfSGvcR0k0FYVbGtHOLgWSRyOCovdA1e7E9ug+DYqcYuazZUdNLKRbj28asM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5213
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24uDQpPbiBUaHUsIDIwMjMt
MDMtMTYgYXQgMTY6NTEgLTA0MDAsIE7DrWNvbGFzIEYuIFIuIEEuIFByYWRvIHdyb3RlOg0KPiBI
aSBZdW5mZWksDQo+IA0KPiB0aGFua3MgZm9yIHRoZSBwYXRjaC4NCj4gDQo+IE9uIFR1ZSwgTWFy
IDE0LCAyMDIzIGF0IDAzOjI1OjU3UE0gKzA4MDAsIFl1bmZlaSBEb25nIHdyb3RlOg0KPiA+IExp
Ynl1diBpcyBvbmUgc29mdHdhcmUgbGlicmFyeSB1c2VkIHRvIGNvdmVydCBmb3JtYXQuIE9ubHkg
Y292ZXJ0DQo+ID4gbWVkaWF0ZWsgdW5jb21wcmVzc2VkIG1vZGUgTU0yMSB0byBzdGFuZGFyZCB5
dXY0MjAgZm9yIE1UMjEgaXMNCj4gPiBjb21wcmVzc2VkIG1vZGUuIE5lZWQgdG8gc2V0IGNhcHR1
cmUgcXVldWUgZm9ybWF0IHRvIE1NMjEgaW4gb3JkZXINCj4gPiB0byB1c2UgTGlieXV2IHdoZW4g
c2NwIGZpcm13YXJlIHN1cHBvcnQgTU0yMSBhbmQgTVQyMS4NCj4gDQo+IFRoaXMgY29tbWl0IG1l
c3NhZ2UgaXMgYSBiaXQgY29uZnVzaW5nIHN0aWxsLiBIZXJlJ3MgYSBzdWdnZXN0aW9uOg0KPiAN
Cj4gCVdoaWxlIHRoZSBkZWNvZGVyIGNhbiBwcm9kdWNlIGZyYW1lcyBpbiBib3RoIE1NMjEgYW5k
IE1UMjFDDQo+IGZvcm1hdHMsIG9ubHkgTU0yMQ0KPiAJaXMgY3VycmVudGx5IHN1cHBvcnRlZCBi
eSB1c2Vyc3BhY2UgdG9vbHMgKGxpa2UgZ3N0cmVhbWVyIGFuZA0KPiBsaWJ5dXYpLiBJbiBvcmRl
cg0KPiAJdG8gZW5zdXJlIHVzZXJzcGFjZSBrZWVwcyB3b3JraW5nIGFmdGVyIHRoZSBTQ1AgZmly
bXdhcmUgaXMNCj4gdXBkYXRlZCB0byBzdXBwb3J0DQo+IAlib3RoIE1NMjEgYW5kIE1UMjFDIGZv
cm1hdHMsIGZvcmNlIHRoZSBNTTIxIGZvcm1hdCBmb3IgdGhlDQo+IGNhcHR1cmUgcXVldWUuDQo+
IA0KPiAJVGhpcyBpcyBtZWFudCBhcyBhIHN0b3BnYXAgc29sdXRpb24gd2hpbGUgZHluYW1pYyBm
b3JtYXQNCj4gc3dpdGNoaW5nIGJldHdlZW4gDQo+IAlNTTIxIGFuZCBNVDIxQyBpc24ndCBpbXBs
ZW1lbnRlZCBpbiB0aGUgZHJpdmVyLg0KPiANCldpbGwgY2hhbmdlIGl0IGxpa2UgdGhpcy4NCj4g
PiANCj4gPiBGaXhlczogNzUwMWVkZWY2YjFmICgibWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IERp
ZmZlcmVudCBjb2RlYw0KPiA+IHVzaW5nIGRpZmZlcmVudCBjYXB0dXJlIGZvcm1hdCIpDQo+ID4g
U2lnbmVkLW9mZi1ieTogWXVuZmVpIERvbmcgPHl1bmZlaS5kb25nQG1lZGlhdGVrLmNvbT4NCj4g
PiAtLS0NCj4gPiBjaGFuZ2VkIHdpdGggdjI6DQo+ID4gLSByZS13cml0ZSBjb21taXQgbWVzc2Fn
ZS4NCj4gPiAtIGNoYW5nZSB0aGUgZHJpdmVyIGZsb3cuDQo+ID4gY2hhbmdlZCB3aXRoIHYxOg0K
PiA+IC0gYWRkIEZpeGVzIHRhZy4NCj4gPiAtLS0NCj4gPiAgLi4uL3BsYXRmb3JtL21lZGlhdGVr
L3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jIHwgMjQgKysrLS0tLS0tLS0tLQ0KPiA+IC0tLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlvbnMoLSkNCj4g
PiANCj4gDQo+IFdoaWxlIHRoaXMgY2hhbmdlIHdvcmtzICh0aGF0IGlzLCBJJ20gYWJsZSB0byBy
dW4gZmx1c3RlciB0ZXN0cyBvbg0KPiBib3RoIE1UODE5Mg0KPiBhbmQgTVQ4MTk1IHVzaW5nIHRo
ZSBuZXcgTU0yMStNVDIxQyBmaXJtd2FyZSksIGl0IGNhdXNlcyBhIHJlZ3Jlc3Npb24NCj4gb24N
Cj4gdjRsMi1jb21wbGlhbmNlOg0KPiANCj4gCVsuLl0NCj4gCUZvcm1hdCBpb2N0bHM6DQo+IAlb
Li5dDQo+IAkJCWZhaWw6IHY0bDItdGVzdC1mb3JtYXRzLmNwcCg0NzgpOiBwaXhlbGZvcm1hdA0K
PiAzMTMyNTQ0ZCAoTVQyMSkgZm9yIGJ1ZnR5cGUgOSBub3QgcmVwb3J0ZWQgYnkgRU5VTV9GTVQN
Cj4gCQl0ZXN0IFZJRElPQ19HX0ZNVDogRkFJTA0KPiAJCQlmYWlsOiB2NGwyLXRlc3QtZm9ybWF0
cy5jcHAoNDc4KTogcGl4ZWxmb3JtYXQNCj4gMzEzMjU0NGQgKE1UMjEpIGZvciBidWZ0eXBlIDkg
bm90IHJlcG9ydGVkIGJ5IEVOVU1fRk1UDQo+IAkJdGVzdCBWSURJT0NfVFJZX0ZNVDogRkFJTA0K
PiAJCQlmYWlsOiB2NGwyLXRlc3QtZm9ybWF0cy5jcHAoNDc4KTogcGl4ZWxmb3JtYXQNCj4gMzEz
MjU0NGQgKE1UMjEpIGZvciBidWZ0eXBlIDkgbm90IHJlcG9ydGVkIGJ5IEVOVU1fRk1UDQo+IAkJ
dGVzdCBWSURJT0NfU19GTVQ6IEZBSUwNCj4gCVsuLl0NCj4gCVRvdGFsIGZvciBtdGstdmNvZGVj
LWRlYyBkZXZpY2UgL2Rldi92aWRlbzI6IDQ2LCBTdWNjZWVkZWQ6IDQzLA0KPiBGYWlsZWQ6IDMs
IFdhcm5pbmdzOiAwDQo+IA0KTmVlZCB0byBhZGQgb25lIHBhdGNoIHRvIGNoYW5nZSBNTTIxIGFz
IHRoZSBkZWZhdWx0IGNhcHR1cmUgcXVldWUNCmZvcm1hdC4NCg0KQmVzdCBSZWdhcmRzLA0KWXVu
ZmVpIERvbmcNCj4gVGhlIHBhdGNoIG1ha2VzIG9ubHkgTU0yMSBzaG93IGluIFZJRElPQ19FTlVN
X0ZNVCwgYnV0IFZJRElPQ19TX0ZNVCwNCj4gVklESU9DX0dfRk1UIGFuZCBWSURJT0NfVFJZX0ZN
VCBzdGlsbCBzaG93IE1UMjEuIFNvIEkgdGhpbmsgeW91IG5lZWQNCj4gdG8gZG8gdGhlDQo+IHNh
bWUgZm9yY2luZyBvZiBNTTIxIGZvciB0aG9zZSBpb2N0bHMuDQo+IA0KPiBUaGFua3MsDQo+IE7D
rWNvbGFzDQo+IA0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL2RyaXZlcnMvbWVkaWEvcGxhdGZvcm0v
bWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBiL2RyaXZlcnMvbWVkaWEvcGxh
dGZvcm0vbWVkaWF0ZWsvdmNvZGVjL210a192Y29kZWNfZGVjLmMNCj4gPiBpbmRleCA2NDFmNTMz
YzQxN2YuLmM5OTcwNTY4MWEwMyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL3BsYXRm
b3JtL21lZGlhdGVrL3Zjb2RlYy9tdGtfdmNvZGVjX2RlYy5jDQo+ID4gKysrIGIvZHJpdmVycy9t
ZWRpYS9wbGF0Zm9ybS9tZWRpYXRlay92Y29kZWMvbXRrX3Zjb2RlY19kZWMuYw0KPiA+IEBAIC0z
OSwxMCArMzksOSBAQCBzdGF0aWMgYm9vbCBtdGtfdmRlY19nZXRfY2FwX2ZtdChzdHJ1Y3QNCj4g
PiBtdGtfdmNvZGVjX2N0eCAqY3R4LCBpbnQgZm9ybWF0X2luZGV4KQ0KPiA+ICB7DQo+ID4gIAlj
b25zdCBzdHJ1Y3QgbXRrX3Zjb2RlY19kZWNfcGRhdGEgKmRlY19wZGF0YSA9IGN0eC0+ZGV2LQ0K
PiA+ID52ZGVjX3BkYXRhOw0KPiA+ICAJY29uc3Qgc3RydWN0IG10a192aWRlb19mbXQgKmZtdDsN
Cj4gPiAtCXN0cnVjdCBtdGtfcV9kYXRhICpxX2RhdGE7DQo+ID4gIAlpbnQgbnVtX2ZyYW1lX2Nv
dW50ID0gMCwgaTsNCj4gPiAtCWJvb2wgcmV0ID0gdHJ1ZTsNCj4gPiAgDQo+ID4gKwlmbXQgPSAm
ZGVjX3BkYXRhLT52ZGVjX2Zvcm1hdHNbZm9ybWF0X2luZGV4XTsNCj4gPiAgCWZvciAoaSA9IDA7
IGkgPCAqZGVjX3BkYXRhLT5udW1fZm9ybWF0czsgaSsrKSB7DQo+ID4gIAkJaWYgKGRlY19wZGF0
YS0+dmRlY19mb3JtYXRzW2ldLnR5cGUgIT0gTVRLX0ZNVF9GUkFNRSkNCj4gPiAgCQkJY29udGlu
dWU7DQo+ID4gQEAgLTUwLDI3ICs0OSwxMCBAQCBzdGF0aWMgYm9vbCBtdGtfdmRlY19nZXRfY2Fw
X2ZtdChzdHJ1Y3QNCj4gPiBtdGtfdmNvZGVjX2N0eCAqY3R4LCBpbnQgZm9ybWF0X2luZGV4KQ0K
PiA+ICAJCW51bV9mcmFtZV9jb3VudCsrOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiAtCWlmIChudW1f
ZnJhbWVfY291bnQgPT0gMSkNCj4gPiArCWlmIChudW1fZnJhbWVfY291bnQgPT0gMSB8fCBmbXQt
PmZvdXJjYyA9PSBWNEwyX1BJWF9GTVRfTU0yMSkNCj4gPiAgCQlyZXR1cm4gdHJ1ZTsNCj4gPiAg
DQo+ID4gLQlmbXQgPSAmZGVjX3BkYXRhLT52ZGVjX2Zvcm1hdHNbZm9ybWF0X2luZGV4XTsNCj4g
PiAtCXFfZGF0YSA9ICZjdHgtPnFfZGF0YVtNVEtfUV9EQVRBX1NSQ107DQo+ID4gLQlzd2l0Y2gg
KHFfZGF0YS0+Zm10LT5mb3VyY2MpIHsNCj4gPiAtCWNhc2UgVjRMMl9QSVhfRk1UX1ZQOF9GUkFN
RToNCj4gPiAtCQlpZiAoZm10LT5mb3VyY2MgPT0gVjRMMl9QSVhfRk1UX01NMjEpDQo+ID4gLQkJ
CXJldCA9IHRydWU7DQo+ID4gLQkJYnJlYWs7DQo+ID4gLQljYXNlIFY0TDJfUElYX0ZNVF9IMjY0
X1NMSUNFOg0KPiA+IC0JY2FzZSBWNEwyX1BJWF9GTVRfVlA5X0ZSQU1FOg0KPiA+IC0JCWlmIChm
bXQtPmZvdXJjYyA9PSBWNEwyX1BJWF9GTVRfTU0yMSkNCj4gPiAtCQkJcmV0ID0gZmFsc2U7DQo+
ID4gLQkJYnJlYWs7DQo+ID4gLQlkZWZhdWx0Og0KPiA+IC0JCXJldCA9IHRydWU7DQo+ID4gLQkJ
YnJlYWs7DQo+ID4gLQl9DQo+ID4gLQ0KPiA+IC0JcmV0dXJuIHJldDsNCj4gPiArCXJldHVybiBm
YWxzZTsNCj4gPiAgfQ0KPiA+ICANCj4gPiAgc3RhdGljIHN0cnVjdCBtdGtfcV9kYXRhICptdGtf
dmRlY19nZXRfcV9kYXRhKHN0cnVjdA0KPiA+IG10a192Y29kZWNfY3R4ICpjdHgsDQo+ID4gLS0g
DQo+ID4gMi4yNS4xDQo+ID4gDQo+IA0KPiANCg==
