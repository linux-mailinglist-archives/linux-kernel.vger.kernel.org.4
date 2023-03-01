Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E512C6A6C76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCAMiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 07:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjCAMh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 07:37:56 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF13E3D0A1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 04:37:44 -0800 (PST)
X-UUID: d7078b52b82d11ed945fc101203acc17-20230301
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=sGq+9ko6ftHFwPPpxMpPA89R08pR2lsZHUUCBjo0VpY=;
        b=G1AGMuNvMhyvFeCPgxnQAgVMoRzGnI17JfMMtluSweYR8+qLmFpQBrK62SKRjpEzOP2M1jhpeOCBvzljyruckksE82xl3HlkI8MceCKjrALPPa3mnVcHujh67aaxzxbSv3fQbtelEp/xkKeRHw2mMlof0W2b9WZRLjLwWrIWzmc=;
X-CID-UNFAMILIAR: 1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:360a98e7-08b7-4db0-b2de-32627f562c9b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:4
X-CID-INFO: VERSION:1.1.20,REQID:360a98e7-08b7-4db0-b2de-32627f562c9b,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:r
        elease,TS:4
X-CID-META: VersionHash:25b5999,CLOUDID:d71fff26-564d-42d9-9875-7c868ee415ec,B
        ulkID:230301203735LIXVU66A,BulkQuantity:0,Recheck:0,SF:38|16|19|102,TC:nil
        ,Content:0,EDM:-3,IP:nil,URL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:
        0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: d7078b52b82d11ed945fc101203acc17-20230301
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <cheng-jui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 771782670; Wed, 01 Mar 2023 20:37:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 1 Mar 2023 20:37:32 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 1 Mar 2023 20:37:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MgsHjGVfhZWoXte36pdQnWWYh3sj+pwNcwWTj/ldPvzZUftBSDxjkeMxSxm+oae5SHOPpI2Vej5fiHMrhgW8da2JssTE6lmy6fylf3WnOY9jG9ILjY8fOUEUXTjNP3vkYPccFBwZOwuPILQYSjEu+snzYVlfE4npAnP4Z8z1Yi6NbJuW8qXzPLbEh9fEAmvvYJSfPa/+epAtIdGlb9NxbZhvEnVmZTEcenrhiiu8MYX/JX7FMcJbMLp/Te6hRASiwI6K56ndaulj8h/9s2Tzt/5mTLdSyfScBxNKS6eJhCSA20Bs7AG/Sf8JFR+pqHNiZZb2m601F7BShkzVwaatgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGq+9ko6ftHFwPPpxMpPA89R08pR2lsZHUUCBjo0VpY=;
 b=VcQHDEf5vilH3pVu767JnBBDrugiPXHTbeu/jZgN5MJR/Vt6iqXETEbT2naq4GTitieFA5a9fsDx6r3ihQGE5KWdQfbiJ9X8HAy5TZzx7Wylh8KH/k68LYWb74Dm3iP9sbDaguDeHjYKwki/kUyieRkj8SlLqtlzXnFHZrVHG7Ov3Q4qTG5D+6AjhXeb+NePi44gsb2NX5zyLQ1dmCSxFEUKfoTjznPvzhvMAlaAp5hGe071KHYS0kU6p47z/4wmsVM/ey9rtkA5qi/Kg6kkLA9IAAbwyvZB1HFmUSeKmc1zJwvf4tF51lKMnzTtDHTyc9+kSf4P8cB0e2yr/KoDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGq+9ko6ftHFwPPpxMpPA89R08pR2lsZHUUCBjo0VpY=;
 b=VKq7mNsmiW7+ZNPpV8KKgoPEtyL2/3JC219S8MWOIOBFdNPSHOKYZeAZF/3D85QiC2Kb0ghIrTKx4iilCac3W34RphlIWaaZqBTUA+PDo0+O4McOEKSJ6zwGND6H0KAV5os/yPCL+JS8kF/M7Rwzv/VtljtHIBmF/T12C0ZglPo=
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com (2603:1096:4:17e::8) by
 PUZPR03MB6104.apcprd03.prod.outlook.com (2603:1096:301:bb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.30; Wed, 1 Mar 2023 12:37:29 +0000
Received: from SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::1eeb:dc8d:3117:ad0f]) by SG2PR03MB6415.apcprd03.prod.outlook.com
 ([fe80::1eeb:dc8d:3117:ad0f%5]) with mapi id 15.20.6156.018; Wed, 1 Mar 2023
 12:37:29 +0000
From:   =?utf-8?B?Q2hlbmctSnVpIFdhbmcgKOeOi+ato+edvyk=?= 
        <Cheng-Jui.Wang@mediatek.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "surenb@google.com" <surenb@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        =?utf-8?B?Qm9idWxlIENoYW5nICjlvLXlvJjnvqkp?= 
        <bobule.chang@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>
Subject: Re: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Thread-Topic: [BUG v6.0-rc2] lockdep splat on ct_kernel_enter()
Thread-Index: AQHZTCPsSbY+bDZDiUyH+yg4juwAr67l3OIA
Date:   Wed, 1 Mar 2023 12:37:29 +0000
Message-ID: <833cecca4460ae3c371455cef75b40a1f3922758.camel@mediatek.com>
References: <20220822164404.57952727@gandalf.local.home>
In-Reply-To: <20220822164404.57952727@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SG2PR03MB6415:EE_|PUZPR03MB6104:EE_
x-ms-office365-filtering-correlation-id: a80e9b2f-27b3-4e55-e5c2-08db1a51b8a8
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZR7tE2DmTZQdbXRnHqFwzr/iFtUrkNkmuckEhhB4f78pDA23V71ZXzL9ze5Fxvk+nRLAMaS2YmoN+S4GsbBcQ7XcS1kUl5HZk3XAGVKKN1G/5bWAP1VJvngeOiNKw7QizBbTOsSuIG42bvMw3YfBPNlGrFwVnQDH9S0Rk2XBLCwjrdCWpgYHrdYnGWpEYV6Z4S/5IZJFlIPGQMCxP1PcU05TKuUJed6G1ZOR4fDFAOUTDdS7PhtGATXVM1IUJvdOw/dsNbwCNo07+spQzbWDezGPoL7Gdtf3qgQwOdWbiVxEZLzTmNXUr4pLj8HHsfjlNded0xUVpMwXFy6zj0Sou+Dazq2o8ScelW+FDLZ3kUSiU0wacHCxwQzQWXEjgQLjkndLN+EcUHvNrLmm9oqv8khjscHK8320aiFTg3xreFA23a0JxPpUm56ErA7Fymw12Y+ItULuBDEZD8exhQ7tms9yKkgTj8HvVumlqM8sZpdbffMuLV469oYNRll17rTm8resfwvWcJrYSAH79gp0yyZrTeutOH1BJ/68R/PA0lv+OHsrpuod28SXIL3OwTzFGforPjRX52C2LROMypGUeTHqaSgz6V6D0ZiyiUMsXnJ3zkYmeueXszN6xpC7GdHM9ss4ZJJAiihuSToQLDQEvr+/xYx+Uj8vuOtmJNRGYpbTqAptFbLT158yjgdrw9x7XrMEOmNYAJsEEerqmhhBx/eSB5oSa601CwgEVHeMlA8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR03MB6415.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199018)(85182001)(36756003)(54906003)(110136005)(316002)(83380400001)(478600001)(71200400001)(6506007)(4326008)(6512007)(186003)(2616005)(6486002)(966005)(26005)(2906002)(8936002)(86362001)(38070700005)(66946007)(66556008)(5660300002)(76116006)(41300700001)(8676002)(66446008)(64756008)(66476007)(38100700002)(91956017)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2dDdVV5SGVidldGWDg3OXI1RGRzSnh0VzZGNW0wK1FERzZyc2tPT3NlMTNV?=
 =?utf-8?B?eEhuZ2hvTS9XNG9kNkt4UzhYRVBHYjdzQ1hiRGFhV0hIaUR5VXl5ZDhzVEcv?=
 =?utf-8?B?YlpQZHRWMldFTEZYWVYwZFpGVkpwSlpDc2hRUE8rRmY5eG9kS2NDK3pnbnBV?=
 =?utf-8?B?eit5MDlCenUzVFhsUzBLSlRLVnNvQnZQN09LY1d3R2FPU0NwdSs0aFYwUEFK?=
 =?utf-8?B?ZzhEZmY1eVMxMGI1UC80TkYvcFBwbDhUamJEZWlrREVQdkRhZno2Y2E0Z28y?=
 =?utf-8?B?UlAwaC9wUTYyUFU4T2JSN2RtVk9KeUxzblZUZ1lwS2VEdmZYbHlGUHNSZ3lo?=
 =?utf-8?B?K1RuRzhmVW9rMWNCRFpDY043VC9SZ3p5eGo1ZlI0aFM0VUNzZ3MyMWZTanI5?=
 =?utf-8?B?UFJMVkdpSlBabGlBZ1U5UjNKL0ZnNllPWWNFRmRUOWlBTFQ1UFFUczUwMjJH?=
 =?utf-8?B?R2dwTUVVUGtUb2ZmbFNzbXJ5YjI1ZFRYZXVSb2ExZkdGSkc5amhwRGEvZnRv?=
 =?utf-8?B?MkRwN3hEdCt6Vkxqc3hldEdyTHlwd2hwbjhybm9rd2w1OUVjUG94QzVFcE9q?=
 =?utf-8?B?T0lIMTNSZ0pwY0hFTmt4UFFSNVh2Z0x1Sk5DS3BRaTFJUDF2cUFqV2prZUMw?=
 =?utf-8?B?TEtWTzFJQ0ZlaVBMYnJUSTNsczZCVldaTUNseUw3b0RuMkY2ZHhmbFVOQmNo?=
 =?utf-8?B?QkdSMlJEYzRFUzRaS05rSDV6eW90UmMxQ1VSZXZVWEpVckJtcExCWjV1UlVY?=
 =?utf-8?B?Zyt5RVhqQldDSTFISlRKUk41M2FCMGJsL0hlSmhLNDFDNVNyQnloc29iZUN6?=
 =?utf-8?B?S1JidXF1SGVJVTVUTWJVaWZVeTUxQS9VWUlTdzZjTHVCWFZKWGc1dEd1Q2Ry?=
 =?utf-8?B?NnE3Vkk5cklKWWNsU0xzTFBjQzBGOTQyNnlHamFJMENTajdFNTNuVnZncW1p?=
 =?utf-8?B?REhwaGtEalJXZ3RCUkZmd3V0WGpmMi8zT01oMzk4Y2RZMzVOYjNvSVRFREh6?=
 =?utf-8?B?WTZkRXU0ckN6MStDc0hrZFlQdjJOU2NZVDN0WGxvbC9NNFZScVpxKzgvV1ZG?=
 =?utf-8?B?bEZ4S3pIenVtWGxCTFhEOFI2U2tMWVQ2dTE4R3pjTHJ6dWlkYlR2VEh5ell0?=
 =?utf-8?B?OENkODByMEhPZ3ZCd0pnV1U1TU5nVk50enFaVmlMYVlTMlJqSzRXdElNb0Iy?=
 =?utf-8?B?aS81ZzVXckhLcEtkM01BcmU4bWEzT3VCNjhsbTBWUStXcDh2Q3NGRFVRVGhC?=
 =?utf-8?B?ZlJrWVNvVkpOdlFINHI5N0R1VkQrUEVTV0xpRWhxNXN4d2htV3FPRmpZNjdR?=
 =?utf-8?B?dHo5TVVFL3Zpay9jemI2S21zNlU2YVE0Z0YzbHEyNzVpWS9wTGVjdlU2aWd6?=
 =?utf-8?B?Tjhsd3l1c3ZhWEZGTHhReUk5ZzRLaXJpU3ZNazJqc3pFQUxBMHlEQllYVWxl?=
 =?utf-8?B?cFJFdmhsSk14U2twQXkrSTBWdkl2N3l2cjBuRWd6eFd3czV4bGlQSTZBbU9Y?=
 =?utf-8?B?bXF1TC9ncEFFdG5HZmY4T1RYbXNHRzRhSGtkSW0rdjRSUkZrOXVUK2RzYWNo?=
 =?utf-8?B?K2d5V2l3WWhIUzlTcnYxeVV6RnZ1UHpacllmUGw4Z0RIUzU1ZmI1ak04ZWh2?=
 =?utf-8?B?bGM5N2I5azU0QnBvUHJrTFhNTW1wUFY4T2FoTVZRdFBQVlU4Rnl1RXhjUXVY?=
 =?utf-8?B?SFY0UGdKOTA1S1EyMjN0MWVXZjgyV3pEZUZQb1hCYnl1WlY0dDJtMm9SclVs?=
 =?utf-8?B?cWM5dkJyQVZQaEQ5RXZCcWdEOFVoL3BOU1A4YUNtZXQrUGlzblg1K2xNcldB?=
 =?utf-8?B?d1R1MkxTZ1R3TDRpWlNiVWRuTTVrTTFjWFJNNXVzVjNLWmh6VUZteE1nVzVT?=
 =?utf-8?B?K3RvSEROWk1pN0pZZ1BRcHF3bDk0b2F4S2NjN1NkTzFNOUVBWHY4Y1lzcjZi?=
 =?utf-8?B?OXVpbTlXcVdLVDZMNm1zMWR5bWFKNWpqNFFPcm1ZU2hSWk1YR093dTNvQXlv?=
 =?utf-8?B?QUF3VUpBRDZ6eGg3OVpRVFBpRDBSUWVxTGY1MFplcHZ2SHZrall5NldyQ0w5?=
 =?utf-8?B?WCtkT2tLT2xBSVdiQmlQSHZOeXlUV05Ib3IyeUoxNGM0SFdjOVlMNDY3dW9T?=
 =?utf-8?B?Nlg2dllEak91MTMxYnVFWEl4RWFsdVlrNmtXUkRkZVdocFZyYi9TS1BudHE3?=
 =?utf-8?Q?UvjshlaBrQo9kfPQZHyFBzI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7FDD7B61752AC43819C01CC41937D73@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SG2PR03MB6415.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a80e9b2f-27b3-4e55-e5c2-08db1a51b8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2023 12:37:29.5650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cb4bk5F6lpawTeO+rSmP2301U0JUyhw/qrwlZ5VXGp/mESJOBaeKVobIXQsma4HLXhPUXPkWIqzhVO1/jEG9N8du7rR1FOGwqjzpvO0CKVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6104
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTIyIGF0IDE2OjQ0IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gTXkgdGVzdHMgYXJlIGZhaWxpbmcgYmVjYXVzZSBvZiB0aGlzIHNwbGF0Og0KPiANCj4gWyAg
IDE2LjA3MzY1OV0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgICAx
Ni4wNzQ0MDddIGJ1czogJ3BsYXRmb3JtJzogYWRkIGRyaXZlciBhY3BpLWdlZA0KPiBbICAgMTYu
MDc0NDI0XSBERUJVR19MT0NLU19XQVJOX09OKGxvY2tkZXBfaGFyZGlycXNfZW5hYmxlZCgpKQ0K
PiBbICAgMTYuMDc0NDI0XSBXQVJOSU5HOiBDUFU6IDAgUElEOiAwIGF0DQo+IGtlcm5lbC9sb2Nr
aW5nL2xvY2tkZXAuYzo1NTA2IGNoZWNrX2ZsYWdzKzB4MTE0LzB4MWQwDQoNCj4gWyAgIDE2LjA3
NDQyNF0gIGxvY2tfaXNfaGVsZF90eXBlKzB4NmYvMHgxMzANCj4gWyAgIDE2LjE4NjI4NF0gIHJj
dV9yZWFkX2xvY2tfc2NoZWRfaGVsZCsweDRhLzB4OTANCj4gWyAgIDE2LjE4NjI4NF0gIHRyYWNl
X3JjdV9keW50aWNrKzB4M2EvMHhlMA0KPiBbICAgMTYuMTg2Mjg0XSAgY3Rfa2VybmVsX2VudGVy
LmNvbnN0cHJvcC4wKzB4NjYvMHhhMA0KPiBbICAgMTYuMTg2Mjg0XSAgY3RfaWRsZV9leGl0KzB4
ZC8weDMwDQo+IFsgICAxNi4xODYyODRdICBjcHVpZGxlX2VudGVyX3N0YXRlKzB4MjhhLzB4MzEw
DQo+IFsgICAxNi4xODYyODRdICBjcHVpZGxlX2VudGVyKzB4MmUvMHg1MA0KPiBbICAgMTYuMTg2
Mjg0XSAgZG9faWRsZSsweDFlYy8weDI4MA0KDQpPdXIgdGVzdCBpbiB2Ni4xIHN0YWJsZSBpcyBm
YWlsaW5nIGR1ZSB0byB0aGlzIHNwbGF0IHRvby4gVGhlIHY2LjENCnN0YWJsZSBrZXJuZWwgc3Rp
bGwgaGFzIHRoaXMgc3BsYXQuDQoNClRoaXMgc3BsYXQgY2FuIGJlIGZpeGVkIGJ5IFBldGVyJ3Mg
cGF0Y2ggDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MDgxNDQ1MTYuODA4NDUx
MTkxQGluZnJhZGVhZC5vcmcvDQosIGJ1dCB0aGUgZml4IGlzIHBhcnQgb2YgYSBiaWcgcGF0Y2hz
ZXQgDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMjA2MDgxNDI3MjMuMTAzNTIzMDg5
QGluZnJhZGVhZC5vcmcvDQppbnRyb2R1Y2VkIGluIDYuMi4NCg0KQ291bGQgdGhlIGZpeGVzIGJl
IGJhY2twb3J0ZWQgdG8gdjYuMSBzdGFibGU/DQo=
