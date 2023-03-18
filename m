Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D34E6BF79B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 04:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCRDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 23:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRDsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 23:48:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2701234F4;
        Fri, 17 Mar 2023 20:48:12 -0700 (PDT)
X-UUID: af95df28c53f11ed91027fb02e0f1d65-20230318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=RMsIvrO7WJXo800bdQhr6Cd3mUl6G9OJ4WZFm7iXMOo=;
        b=GH/LTm2pR4aA/8ph2xwo9otUxHuw8xrens+CV1W6IXPEBJjAe5CzOHxzGIY3yncOQondCethTKNv8WI4ji8LFAX0hJYWw+yDtCUjWLoKTGFoxkKVRuu6esQfvwXv2RzQnFLRvJcCu9qQY0v1qdeI1xtPi3C7GJQt1BuFpUvGlqw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.21,REQID:de63066b-3b45-49c5-a241-a46823a8a2db,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:83295aa,CLOUDID:def129f6-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: af95df28c53f11ed91027fb02e0f1d65-20230318
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 863269495; Sat, 18 Mar 2023 11:48:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Sat, 18 Mar 2023 11:48:02 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Sat, 18 Mar 2023 11:48:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ja9PC+578CqVRRMbaneWwF8j+x9TiJIKaJv3fiKOyZcO+YeIfCh3d0NIrTeX/nolimLy4Txcyo+4xA4h0MRoMDlJJakdFuFMgblV9KsiKrZZSuupqgPr7eZE4CRe5rbGIYXD+oIXgjh7q2lG7EybifJ9rSbybcq+8lHNiIXvbV+K4g5i+Xxxp3cSNgVTWKsXo+JaaSXOZgTqsfkp9UiwHQS+lsaTCin3fnML9A+W23/vBrmxcZx7yHoyWTHORGGzWvzKnKDjDwWb3/7I1L9AvL9rKLLXco8o61QxoEPlHJQvfZixW+rrX5ON1BNcxv1bWwzrTjcYoejVVT5riW58Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMsIvrO7WJXo800bdQhr6Cd3mUl6G9OJ4WZFm7iXMOo=;
 b=VlwtuOE5wExiegC4qx3abs1gvsN+8XdgU67ljh+2TyqKDO7o6sIWqmo8j6UmgeErTM+QO69YbyWM7B1rCvPrBpfzZDJaTG1jkK99X7OulwgSAWnQ7UYIng3ww06AkE5649hz42ZE/GanBKUYidl+jR1OO28Ym24B6hDFQBQIYG5InHLlmiVWp/mH54tIH2O+ey1VedQLtBWFWfbHBxcHKKTGv+eYpLONgyClBjf/oodOlLJkX+n8wuXogdRI7GOqcsel8pCX2rpuAh5cS5uylsvU4h4EK4RajriCK7KMwvSxDtV4jzwDluW8BLWL3/rN4DypIGusfJYaE5m0StHoPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMsIvrO7WJXo800bdQhr6Cd3mUl6G9OJ4WZFm7iXMOo=;
 b=avQegxJlfEIelDRIg75Dxz0+ittovPbY55ieEgDBmRupxYtUIBK2IjaOHama+DzZ1Yd7nAI9HbPvSVUVZQMAueCqsRZyDUt9MebsHsRT0uBUpmHgTu/kl01YW81CdoFsoAXGtM0nHsJ3EDmEP4FBep4e/yeIkSJp/O5AiUP+JDE=
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com (2603:1096:100:4e::10)
 by PUZPR03MB7134.apcprd03.prod.outlook.com (2603:1096:301:11f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.31; Sat, 18 Mar
 2023 03:47:59 +0000
Received: from SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2]) by SL2PR03MB4153.apcprd03.prod.outlook.com
 ([fe80::be91:ad71:bc02:f8f2%5]) with mapi id 15.20.6178.035; Sat, 18 Mar 2023
 03:47:59 +0000
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
Subject: Re: [PATCH v4,2/2] media: mediatek: vcodec: Using MM21 as the default
 capture format
Thread-Topic: [PATCH v4,2/2] media: mediatek: vcodec: Using MM21 as the
 default capture format
Thread-Index: AQHZWH3uUFw6pTFC9Uaz+3NZdRwxlK7/JqiAgADBNoA=
Date:   Sat, 18 Mar 2023 03:47:58 +0000
Message-ID: <771f84f81eddee63a8f4887d00eb0f10f6573525.camel@mediatek.com>
References: <20230317030833.16836-1-yunfei.dong@mediatek.com>
         <20230317030833.16836-2-yunfei.dong@mediatek.com>
         <20230317161625.x6hm6cxr36hnhmcz@notapiano>
In-Reply-To: <20230317161625.x6hm6cxr36hnhmcz@notapiano>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SL2PR03MB4153:EE_|PUZPR03MB7134:EE_
x-ms-office365-filtering-correlation-id: 0df025d7-289d-46ee-fb2a-08db27639084
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d5s8Xx2mclccZaWDehQJ5O+rMCV4rllmqqRZt/qZEtn+3bh6pp+qV1ABqY179SFHfFZziGDRlUh+fh3thr9apJ1U4tZXT0H9i+HrC4v1X1sffRT8RfLk96+q330IJLPy+5XXnD1lM+EYlMsffX6H0CwjIOp8vgVfJkWxQZLilTcNLlsuTYVWDLe62khaoYlkzbVSLqQlrq6RC6XwaNn9fDZKUBPes/HTDF7gJuu9gE0yeNntCc+j6XIeHGkfYgIZYwJZj+hUHk4KQu4LY+4M8A/0b7sl0Ydq6Z/OKeyjAf36VLEkXT+ZA5zRKdW7GyEEDzLh+Q+mk4qqZeF8kLey23e7khtVAmD34iKPzhKFREhxsMLBpnPW1exwXBp48DHWH3Te7n7Bvk7xBamcWZnkiTphOrNUgicWNXGPI19j5OVZJ2thWbJGGXHEj0994A62uqKXw5uILXp+GQNtWMv8PNQdVWrqS7PwI1naMb57pvJpcRzpiFf8+5Bi9l2SXMvQcI/Lh4WjU9RlLpmF+jJeT1DLBlK0CX2QDo2oNv+GXSdnxC3+DHkOMI9/rGSDa8kb2QgxRl86u/99oJ3izKbi9JBqSL9CPLqMt2NCB24rMvuV+RYvFf+Vc2I1FaXVc3aKTDUokzXUQUOhpVNq5vjWnbmFyZkHNvKIG18NrT9vrAgkVtOhgAGztXqL3x+ITX2aRQ3Z7KVQflwDvcZozz/KvQWdjzsDCjJyiJ1pEADik6o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199018)(36756003)(122000001)(6916009)(6486002)(85182001)(6512007)(186003)(83380400001)(5660300002)(41300700001)(4326008)(86362001)(26005)(2616005)(7416002)(91956017)(316002)(66446008)(478600001)(76116006)(6506007)(66476007)(66946007)(38100700002)(8676002)(2906002)(54906003)(71200400001)(8936002)(66556008)(38070700005)(64756008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NRVm1tNnhYV0ozcXZzVGNiMEVSeHIvQkFmT1Vqakw0a3JwVTlaTEg1dkZQ?=
 =?utf-8?B?SXgzaG9Ud2lrTVNYMExzaVM3YWVqVE90K2V3R2V5MXBGR0l5NE1SL0NaQUJP?=
 =?utf-8?B?cU9KeXVvZm9GcCs5eGVGS2JWcFRjRWR4S3g1ZUIyWU5HcmhuMjBwUFBkUExH?=
 =?utf-8?B?My93VGFjNVVjQkRva2dGbVZLOEJSMGpOWFVmcW9oWTB3a2N1bEZRNVFzOXU3?=
 =?utf-8?B?QnFGTVVyQThoOWdpOGUrZEZkdmExMGJMcGwxWDdsSTNFd0E5aVY0U1dkeFU0?=
 =?utf-8?B?M2E3Q2g4WFBOWFptMU51dXgyQ2xTbDFyODV3OGlTUGhHaDhUQmlpT3hDSHBo?=
 =?utf-8?B?NFREazQ0RC9UT2tEbUR5aVJBUmxFS1BFVm1IMlhuWVdjZjQzSVBXeWpON1pB?=
 =?utf-8?B?WVA0ZkJKbmlGc2VqcTlMLzZKUGtidExJam92Sk5QTm52NkZjS2p4djlqYzFi?=
 =?utf-8?B?eUxGajlPWTE4UDRhT1AzdzNuYTFhSjcwTnFHdnRacWduczJ1bVd1Qmwwbk00?=
 =?utf-8?B?M0VvOXVXWUc5OUhFZy9OK0RqUEtYeTlyMEtNUU1GbVRSWTJwb0I5N0x2OWtY?=
 =?utf-8?B?c1gveXVFRVRLMkpLUlRkVHRkWkpHcUJQWEV3S01qT25neWRtTklVa0FMaGRI?=
 =?utf-8?B?YlNSaWVTL0RWaWZJZnptalBjQ1FMbjRxRGhCaW55OVdMcnE1OS9zZWJualVr?=
 =?utf-8?B?alFaUFlRUU41TGtaZ3NOWTlGZ0c0Q05Rb2Z2MVlKUWowZk1JV3N3T2U2REdI?=
 =?utf-8?B?UWsreFZYdCtlZDdBRllQMGo0bkhUeVdyWjkrWThPdk5JWVJvcXRpdWVPVS9r?=
 =?utf-8?B?ZTJ0TXQ3ajlXeFVGcmNOYUN5NStsWW9OZ3lSTXlqWndpL0VjMzlRc3F5VklR?=
 =?utf-8?B?KzR4eDNGQkIxVlJXTEFrNk1GWlVpQkFXTHhZVjYreS92M1UxalRzcEdXR0hI?=
 =?utf-8?B?Y1FQUS8vMElQSERHUjNwaUFPVTN6ZnFsUXRIbDgrZGxobW9OMnBaN3N1RUU1?=
 =?utf-8?B?ZlA0YnZpQ0tXdnJxRVRSRmxwQmdBMGFzS2dkSGhieXFWYmwxblFVRmd1c3Y4?=
 =?utf-8?B?TG9QY1pHZ0l6YUNFbmxwZVRKeFlhVEZiQ1lMb0wvdjBOMkFSRzVaNlF5NEF1?=
 =?utf-8?B?eVRxOHNYSE1PelgrVmd4TTFSZC9vSWpYbmpnbERGVnJIZzE2QVUrZ3Y1VThE?=
 =?utf-8?B?Rms5b1M2S1NMWktWcnZjU2g0eTBjS3ZZdGFFWFJmdllRdjE5eWJmNkhYNmdy?=
 =?utf-8?B?NzYyYjhiZlFyYmI4bE1BMnpVSWo1WHRmb2c3dExYZnA0VWRRSGtaTmtGSEJO?=
 =?utf-8?B?NzJLSDNJR2RYa2VYSXNhcVpJRXBQVlV1NEJ4VjRIR3FTdGZmTFY5bS9hcW9M?=
 =?utf-8?B?MFN0OUZRbG5aT1FDQnQvZWRwUUVKQkJwS3l2bEExN0VCM29EZENMLzd6ZEVR?=
 =?utf-8?B?Qk9MVG1tWU42NVU4dGZOK0tXYllTUlF5a1E0eFduNDkwQ2xkVWhJOGFSLzRy?=
 =?utf-8?B?RHlZNHExMXRJVm56R2c5RDlUVk5qQVA4ai96YTlDeFEwUXJWd29nZUJsNFZp?=
 =?utf-8?B?L1hwS0ZXNmpEc3U2TEFpdlF4NzNHMkVOalkrQlRCNDlDZUovZG1GMSsyY1B2?=
 =?utf-8?B?SzcvMm83SGJLZlBjb0hkVDB2T1lrakoxRk9KRXRadDZSTk9OUkVOZHIwWEE5?=
 =?utf-8?B?Q3NnV2tnZTZaNzZJYmFaTVZuZ0RRNzlBMDR1ZnZTZngxL3p0Y295dmxWLzdL?=
 =?utf-8?B?MTBYRXFvNHRtdzZoUEYwRENqNWpBclZ6UWZ0MTJtbGU2YnhwbHFQNWdJVy9o?=
 =?utf-8?B?a3gvQ2txRWcwU1lCcE02MkpvTldFSDdNMlE5Qnh1SFp6bW1WRDVxYlo3MmRv?=
 =?utf-8?B?Z3VTQXNPbkUzYzlqekxEaExxcFh3YjcxaWNhekFUZm1OajV2bTlQYmt2WWJu?=
 =?utf-8?B?QUtZMTNtbitqYUFGNnpjQm9jWkdOQi9CcWlLdkJUekV3amJrRW0raUwzQVI4?=
 =?utf-8?B?Y3JFWldEQzJQZmEreTFuMkZWUXM5c0hBM0RDN3NBRENmMjJ4UzEzRGdWNTV0?=
 =?utf-8?B?L0l5V01tMnFIYWUxOTNvVk4rbDFVeXY5Yy9STjY0VHoweUZJbXRWVTBzazhS?=
 =?utf-8?B?dSthWDRMTWhSUDVWRExoYWl2ZXFaM3dNT3hFSkNXaUV1cXNwNVYrMmhTN0tZ?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6752E375D2AD54489FF239821242113C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0df025d7-289d-46ee-fb2a-08db27639084
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2023 03:47:58.2624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oCgbr2klq8xzdVodpuTNNCsQ2/3cgxG8RXqAhCFbwc+o6Wi+UC/mLwQ0fIFM4EXJGZg9SnMilme3nRsXXXydeu7tPGYCJkhyTc/VJXwWys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7134
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

SGkgTmljb2xhcywNCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24gYW5kIHRlc3QgcmVzdWx0
Lg0KT24gRnJpLCAyMDIzLTAzLTE3IGF0IDEyOjE2IC0wNDAwLCBOw61jb2xhcyBGLiBSLiBBLiBQ
cmFkbyB3cm90ZToNCj4gSGkgWXVuZmVpLA0KPiANCj4gdGhhbmtzIGZvciB0aGUgcGF0Y2guDQo+
IA0KPiBUaGUgY29tbWl0IHRpdGxlIHNob3VsZCBiZSBpbiBpbXBlcmF0aXZlLCBzbyBJIHN1Z2dl
c3Q6DQo+IA0KPiAJbWVkaWE6IG1lZGlhdGVrOiB2Y29kZWM6IE1ha2UgTU0yMSB0aGUgZGVmYXVs
dCBjYXB0dXJlIGZvcm1hdA0KPiANCkFjY2VwdGVkIGluIG5leHQgcGF0Y2ggdjQuDQo+IE9uIEZy
aSwgTWFyIDE3LCAyMDIzIGF0IDExOjA4OjMzQU0gKzA4MDAsIFl1bmZlaSBEb25nIHdyb3RlOg0K
PiA+IEZvciB0aGUgY2FwdHVyZSBxdWV1ZSBvbmx5IHN1cHBvcnQgTU0yMSBmb3JtYXQgd2l0aCBM
aWJZdXYsIG5lZWQgdG8NCj4gPiBzZXQgTU0yMSBhcyB0aGUNCj4gPiBkZWZhdWx0IGZvcm1hdC4N
Cj4gDQo+IEFnYWluLCBJIHRoaW5rIHRoaXMgY29tbWl0IG1lc3NhZ2UgY291bGQgYmUgaW1wcm92
ZWQgYSBiaXQuIEhlcmUncyBhDQo+IHN1Z2dlc3Rpb246DQo+IA0KPiAJR2l2ZW4gdGhhdCBvbmx5
IHRoZSBNTTIxIGNhcHR1cmUgZm9ybWF0IGlzIHN1cHBvcnRlZCBieQ0KPiB1c2Vyc3BhY2UgdG9v
bHMgKGxpa2UNCj4gCWdzdHJlYW1lciBhbmQgbGlieXV2KSwgbWFrZSBpdCB0aGUgZGVmYXVsdCBj
YXB0dXJlIGZvcm1hdC4NCj4gDQo+IAlUaGlzIGFsbG93cyB1cyB0byBmb3JjZSB0aGUgTU0yMSBm
b3JtYXQgZXZlbiB3aGVuIGEgTU0yMSBhbmQNCj4gTVQyMUMgY2FwYWJsZQ0KPiAJZmlybXdhcmUg
aXMgYXZhaWxhYmxlICh3aGljaCBpcyBuZWVkZWQgd2hpbGUgZHluYW1pYyBmb3JtYXQNCj4gc3dp
dGNoaW5nIGlzbid0DQo+IAlpbXBsZW1lbnRlZCBpbiB0aGUgZHJpdmVyKSwgd2l0aG91dCBjYXVz
aW5nIHRoZSBmb2xsb3dpbmcNCj4gcmVncmVzc2lvbnMgb24NCj4gCXY0bDItY29tcGxpYW5jZToN
Cj4gDQo+IAkJCQlmYWlsOiB2NGwyLXRlc3QtZm9ybWF0cy5jcHAoNDc4KToNCj4gcGl4ZWxmb3Jt
YXQgMzEzMjU0NGQgKE1UMjEpIGZvciBidWZ0eXBlIDkgbm90IHJlcG9ydGVkIGJ5IEVOVU1fRk1U
DQo+IAkJCXRlc3QgVklESU9DX0dfRk1UOiBGQUlMDQo+IAkJCQlmYWlsOiB2NGwyLXRlc3QtZm9y
bWF0cy5jcHAoNDc4KToNCj4gcGl4ZWxmb3JtYXQgMzEzMjU0NGQgKE1UMjEpIGZvciBidWZ0eXBl
IDkgbm90IHJlcG9ydGVkIGJ5IEVOVU1fRk1UDQo+IAkJCXRlc3QgVklESU9DX1RSWV9GTVQ6IEZB
SUwNCj4gCQkJCWZhaWw6IHY0bDItdGVzdC1mb3JtYXRzLmNwcCg0NzgpOg0KPiBwaXhlbGZvcm1h
dCAzMTMyNTQ0ZCAoTVQyMSkgZm9yIGJ1ZnR5cGUgOSBub3QgcmVwb3J0ZWQgYnkgRU5VTV9GTVQN
Cj4gCQkJdGVzdCBWSURJT0NfU19GTVQ6IEZBSUwNCj4gDQo+IEFsc28sIEkgdGhpbmsgaXQgd291
bGQgYmUgc2xpZ2h0bHkgYmV0dGVyIGlmIHRoaXMgd2FzIHRoZSBmaXJzdCBwYXRjaA0KPiBpbiB0
aGUNCj4gc2VyaWVzLCBzbyB0aGF0IHY0bDItY29tcGxpYW5jZSBkb2Vzbid0IGZhaWwgaW4gYmV0
d2VlbiB0aGUgcGF0Y2hlcy4NCj4gDQpBY2NlcHRlZCBpbiBuZXh0IHBhdGNoIHY0Lg0KDQpCZXN0
IFJlZ2FyZHMsDQpZdW5mZWkgRG9uZw0KPiA+IA0KPiA+IEZpeGVzOiA3NTAxZWRlZjZiMWYgKCJt
ZWRpYTogbWVkaWF0ZWs6IHZjb2RlYzogRGlmZmVyZW50IGNvZGVjDQo+ID4gdXNpbmcgZGlmZmVy
ZW50IGNhcHR1cmUgZm9ybWF0IikNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZdW5mZWkgRG9uZyA8eXVu
ZmVpLmRvbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gV2l0aCB0aGlzIGNoYW5nZSBJJ3ZlIGNvbmZp
cm1lZCB0aGF0IGFsbCB2NGwyLWNvbXBsaWFuY2UgdGVzdHMgYXJlDQo+IHBhc3NpbmcgYWdhaW46
DQo+IA0KPiBUb3RhbCBmb3IgbXRrLXZjb2RlYy1kZWMgZGV2aWNlIC9kZXYvdmlkZW8yOiA0Niwg
U3VjY2VlZGVkOiA0NiwNCj4gRmFpbGVkOiAwLCBXYXJuaW5nczogMA0KPiANCj4gU28sIGFmdGVy
IHRoZSBhYm92ZSBjb21tZW50cyBhcmUgYWRkcmVzc2VkLA0KPiANCj4gUmV2aWV3ZWQtYnk6IE7D
rWNvbGFzIEYuIFIuIEEuIFByYWRvIDxuZnJhcHJhZG9AY29sbGFib3JhLmNvbT4NCj4gVGVzdGVk
LWJ5OiBOw61jb2xhcyBGLiBSLiBBLiBQcmFkbyA8bmZyYXByYWRvQGNvbGxhYm9yYS5jb20+DQo+
IA0KPiBUaGFua3MsDQo+IE7DrWNvbGFzDQo=
