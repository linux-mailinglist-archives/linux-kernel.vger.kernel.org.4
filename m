Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2F5ECC98
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiI0TBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbiI0TA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:00:59 -0400
X-Greylist: delayed 147 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Sep 2022 12:00:57 PDT
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F001C00C4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:00:57 -0700 (PDT)
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
        by mx0a-002c1b01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RDjBai016305;
        Tue, 27 Sep 2022 11:58:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint20171006;
 bh=3qsbLax0KC4jvt270DFpJ2ujpLjJeKCIxly0Qgv7RrI=;
 b=2s5T0djRommw1qa/jVEJl5G9peA/F/wIC0pCK22p2FTQ0q8cvbhyKggkO+DtzE3rop4Z
 aVuLsPZQsYMenxuEvpgGYKOyOPXdO+WxzmL5Fo/5hUyRuawxTEZAq4rMD9FCKqqz5/TP
 KX7C7/lTB/KII1VWFPPMex8buUvXmz4k+fmNHTW99WAHZjNrNA7q5MvMmcoSKcb5ukZz
 LXJenuHpc02+qituTjSjDmAcW+ubn9c4XHpdNGxdHK+PCewgVLSbtliaa3+vtEg0wAWT
 /wyF+t9f/sLAgoBZXsA2ZSadkjEuuq8ItC2VuL0SRKmnbJ7L82zp/vn0NJ30pU3R+dJb uQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 3jt1f07et4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 11:58:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K6nBig3XgTjTMY1YuqOL9l8+RkiihXUnJHl10KGl+gLOxfJ0CjcTEihqngBag7G/xBlaWYf9TB1PKn0wvQf6Du7PkvdIqVWonbRXFkYYIoGIMDAPdIPA9WMhITLgMRGE8WER1+hhVDOJAnv3auzqf6Dd2gy2ukUqG0YCguvvaC8dZzZAgTDnzUTso8HK1AmoQyyOsAy1bfugv9g6/X9T6mUi8tAhJlW7NvEH4W7sOZYsDMWLC+N4e9DVnHOz5NxHVATqo+aEby9cfRx6mHvh5OBfiUfceGCCEQsZaTAMrVWASbxfopvTq3zFIMSxicqG9PYJFuIP4aEC5JkxyBo6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qsbLax0KC4jvt270DFpJ2ujpLjJeKCIxly0Qgv7RrI=;
 b=C1ik97Ych2fuodcerMbdRLkA/+IeE8aCiYhrHVU3afyf6BJEwAIz4A+0MnGHguYVfPCqsAHl+UWviqdf6nogHxcUgK7/AedoCOa1E3z8vGJ8pmENXX82WtlU4dXfVeac2g/G9OR97rq0gsISQzw/0xwq9I0W9kUhY07KhfRAfrB1CdDenB6Ce/lMkAP9UyUx3gwV6WQjBB/TjNmino5nCo/k+8/9ihz4Cx5HkmY0CDT4+YhxtMKJNriMd6CLVucvrImpMbpV1XrdmkWSfYhQvseGGhy3G61fp8H1gaPsFt+fguK6/uknzApgf0x7TQbyofF3uxHB1C44Fq8NjHvL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from BYAPR02MB4488.namprd02.prod.outlook.com (2603:10b6:a03:57::28)
 by DS0PR02MB9272.namprd02.prod.outlook.com (2603:10b6:8:131::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Tue, 27 Sep
 2022 18:58:04 +0000
Received: from BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::a5f2:3b2d:143f:9d09]) by BYAPR02MB4488.namprd02.prod.outlook.com
 ([fe80::a5f2:3b2d:143f:9d09%2]) with mapi id 15.20.5632.019; Tue, 27 Sep 2022
 18:58:04 +0000
From:   David Chen <david.chen@nutanix.com>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: RE: "BUG at kernel/entry/common.c:407!" on 5.10.133+
Thread-Topic: "BUG at kernel/entry/common.c:407!" on 5.10.133+
Thread-Index: AdjRzbrqDzx6KHfWRbiX9vEmFvbqjQAdzAaAABd7bLA=
Date:   Tue, 27 Sep 2022 18:58:04 +0000
Message-ID: <BYAPR02MB4488C0F382C7E804AE2F9B1094559@BYAPR02MB4488.namprd02.prod.outlook.com>
References: <BYAPR02MB4488D9DBFE310C9227906E9994529@BYAPR02MB4488.namprd02.prod.outlook.com>
 <9c76f7eb-64f5-ceac-cc4a-610db79c8233@leemhuis.info>
In-Reply-To: <9c76f7eb-64f5-ceac-cc4a-610db79c8233@leemhuis.info>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR02MB4488:EE_|DS0PR02MB9272:EE_
x-ms-office365-filtering-correlation-id: f1ed32f1-03d0-4818-9a15-08daa0ba3578
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OTZzoODIWujZ6wVH9+WJGWoa31u8eiUx9hu3KWVM4iUAjbjIhcfWU58W3z2ol4lmSxi/G8W7JJe1EebPrX3dzYojTClDJfRZcUvNt8BE0tNH8QASqLxCXqb+5g8ClzWeNbsUz5qdMN6+uB20WNVPHAfg48ZLCpBMaQSeI8Qxg+0qeMuCnenQkTXACpWyMHE6FTEwfndLBz5vPGRtaFIJa3mDdaZlTdmfD810GMB8ZLItTYzJ1MwxFlb/5FDXZsvvL0Ax6gxCNwY6xmrV1yB+f+t2OMqSA4fzwzTxsTbTxUHI6bTTt6n0HTZf8oyY7ssAJwJ7st2bCK8S1vh7F5/2MVihQxUhUdHESGO99LDGQyA9/gLugk44yuMZ5GQXZxp1JVPF5gxrvK1cbFWT4lConKbPsnupwlnBETbeaKwjeu0BOnygzLOD5cDXySiXWTjhx20vIm9VxdW5r4qP3U+NAU454C7uXwJmT4AbI+3izyB396Z0PGJMoxWjFPAYZOdE1QKiQELFcN+24v1nDLD++izUunpvY9Ni+OpLyUOYrI8svY4i+6Vjz6QFTbJvznBMtcimqDu6FbG4cQQhg2RTaPaO0rk98wwte5F8IsRdopVLwRMuMCqelCzD+zByxhvNgc/qLrGzKF2xie2bDkW4QeBBamZtPPkPETCMANy35JGajO36pk/SPPQWugwbbGYntYh9okvXgHHDqGrHjNghas+OkWT3kv4gp1qIt86lEYYROo5qdLG4ABiF3TGkYcMzlWcE1ncn0BUp+UMhBtRnQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4488.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199015)(2906002)(122000001)(4326008)(316002)(83380400001)(38100700002)(64756008)(66446008)(110136005)(8936002)(66476007)(52536014)(86362001)(44832011)(8676002)(66946007)(186003)(76116006)(54906003)(5660300002)(66556008)(55016003)(41300700001)(33656002)(26005)(9686003)(478600001)(38070700005)(71200400001)(7696005)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UUt6NEJGOW5abldSVVQ1THhSWmtYRzBUMVNWb09SN2VCSFVGd2FreVBjRFNV?=
 =?utf-8?B?blUyeDl2L20vVDg2QmpEMFNCTWZsaUpXQXlVaTZyTkorMEM2T09JTFF5QXBS?=
 =?utf-8?B?TDJ2bEVaenNrWlJkQmlRampoS0RVWVhlMXJUQWJ6T1dONnNFd1B0NVdCNUpr?=
 =?utf-8?B?WVpTazVYNkdtN0JpSW4rb1dGSFMxUnlzcFBuQzlvbmZiVkVQSlBhNTQyQU9s?=
 =?utf-8?B?V2p3aXllajRkaWJpaUljUG1vK2s1Nmg1NldtWFJHYzhqUnpySnVkKzE1Qi9y?=
 =?utf-8?B?SjQyazRKbFNxOWw0VXNiNXdhODhoVWttU05FbjZidHh4OHB2ZmIwMjJqQUN3?=
 =?utf-8?B?STQzUWxIaXZFYjVGd25VaEJCMlcvK1J4WW9yREEyQnBTa2FJQS84a1VRZFA2?=
 =?utf-8?B?WmFSTndneVg1cTRsRWlHVU5SUWpOVHhRdWlkZmRyQmxvZUM1UTN5RG4xYnBq?=
 =?utf-8?B?c3RWTFlpdmkvZ3l5eG1XSk9Kb3lCTGtOa2I1WVRQN1JYbjk0SE1QaWR1d0Fy?=
 =?utf-8?B?bUdBRlBxcGJSUVR1WTJOcUhCRU9MbFZBcFNZN0lhVmpxZU1oQnJrN3gyK2Fh?=
 =?utf-8?B?b1FpcWk4djVLK0FwbG9BMUVER3AvOVF4YTNOZ042UVREM1RCMjZVcnZOb3ZK?=
 =?utf-8?B?cnlKZ0liNHo0MVZDbFlqVElZMTcvbGxITHo0QXR6VXhydFptRGptemJNVFUv?=
 =?utf-8?B?eGpYdjhKMWIxYzgxUUlHSE5OL3AwMHBmdzErNDVuOFFJTWlNeUNSSzJoZWI4?=
 =?utf-8?B?cFh4cVdCaGM2d0ZMRUh3aTREckZRbWFUcjE3WklVMU1BYXFkYVdkVnJOTHA0?=
 =?utf-8?B?Ukt0TGc2SjhURUY4K0JqTFJoY0JQeWxBUys2eUI5KzAxVHYvdWZ0RU1kdjBK?=
 =?utf-8?B?RndoWm9YYm5HL08yaDI3SU52aU1DeTUyMENIdEE4NE5HbVhQQVlqUlUvM3VI?=
 =?utf-8?B?WUpzbWh6bE5GR2R4b3IveWVpa1dCdFpKUnBuMjJNZzcyTitVTGFmQmk5K3FW?=
 =?utf-8?B?Vll2ZkR2NWV2SVVMdUhMRmlESnRYTXUxczBSbDdCTHBBcC9JTDhHb3g0aGNu?=
 =?utf-8?B?MUxyVmhhSUpDN01lNlRyMkZkMzhyclNjaEIrRUNyR2tNZWRGMHdxMHR5K2NR?=
 =?utf-8?B?aWtUMERNVG80VnhHVVZMM2NremF2SThZc212cTNpV2tPUFdpY2JCYVE4Rmln?=
 =?utf-8?B?cGpvbHFGYmhPUzR1cjlsaUpsa1RXQUJzWjNzVW8xZHc0RVNzQjU0YWVPbEtO?=
 =?utf-8?B?OW93QnJBMWI2OURnVElLM3BndWhELzM5TmhvZTFQRDlFekpmZTlNakRKZkRJ?=
 =?utf-8?B?ek56YzhXRjBnU1g4aEpWUTF4V0VPNWJaTkpEVHdBV3BING90cmIvUlE4WTlC?=
 =?utf-8?B?bi9sNlU3M2IxVkxMWUFrVFcreWY3MlFaSFZZaXlMNVJXay94QWdMMGFWWjVt?=
 =?utf-8?B?cUNtb0RXc3RsWVNvOXVZVXUzMVJPZ0l6TlVQK1dwenhyaW50amVKcysyYWdL?=
 =?utf-8?B?Wm1zelBSaExHRlRQQk1ScUxSd01pbTlSMWZpRXpBRmJzVkN4U1R6ZXN4RE9E?=
 =?utf-8?B?U3RZVUNrK2R2dksrQ2pFU3AzcUNFMmcvZHpWN25CVGNJekNLaDVSNCs3dHV4?=
 =?utf-8?B?Z01iaXd6VHZEN0NnNEVoL1dYazR2K2hLdEJWSDdQelhNZnNZOTBIZ0dWU3Js?=
 =?utf-8?B?TngwZFRaeHhLQnNWNUZmM2d6dUYwMnpiREplWkNleEpIc3ZTMmhhK0U0R0hM?=
 =?utf-8?B?RXhlQnhidjNZNFpCcXNBWXdlYy84L2R4WDRsSzdZNWFITm56NUt1bnFLWWVr?=
 =?utf-8?B?cnQ2cjJEWlRxZEJvd3N2VGF2MXRRUm1TOUtvU2ljQnlpM1V2STFoMDFVeTd3?=
 =?utf-8?B?NUhnSWtDOExnaFluaUxFU3pzUEtuSGdnWWlMMUIvc3pBMElJbzhuSXVkSjNX?=
 =?utf-8?B?MzVwY0tYMVpld0F2WFJ2ODVzcENxdVJFYXhuOGtwd1c1eUU2b3V2M1hJT245?=
 =?utf-8?B?Y3ZJZkVkdytsZWZGQ3pEbDRranBmY2VTVTlrOEJaUnI3bEFRRDRMT3VlTlVB?=
 =?utf-8?B?Q0RpcGFoY1NPZ0N0UnZQMEN6WkJ5Rkg3YTlISGJnaUM2ZjA5U2REa001TjFE?=
 =?utf-8?Q?xfDlqdvTueyJr/VHUbyxdXT26?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4488.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ed32f1-03d0-4818-9a15-08daa0ba3578
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 18:58:04.7178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EFWLJJG1kSA/666a5uAWXOxPjIpVfFY61X44G9Cy87TUBWmm0SiZvR1QF36U0NRSp7Sy2jNqpOWuRNbuhSB9Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR02MB9272
X-Proofpoint-ORIG-GUID: FccK7cv7M6UfmlUt64MTM29o9AzF6DTT
X-Proofpoint-GUID: FccK7cv7M6UfmlUt64MTM29o9AzF6DTT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_09,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVGhvcnN0ZW4gTGVlbWh1
aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJl
ciAyNywgMjAyMiAxMjo0NCBBTQ0KPiBUbzogRGF2aWQgQ2hlbiA8ZGF2aWQuY2hlbkBudXRhbml4
LmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBldGVyIFppamxzdHJh
IDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEJvcmlzbGF2IFBldGtvdiA8YnBAc3VzZS5kZT47IEpv
c2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogIkJVRyBh
dCBrZXJuZWwvZW50cnkvY29tbW9uLmM6NDA3ISIgb24gNS4xMC4xMzMrDQo+IA0KPiBIaSwgdGhp
cyBpcyB5b3VyIExpbnV4IGtlcm5lbCByZWdyZXNzaW9uIHRyYWNrZXIuDQo+IA0KPiBPbiAyNi4w
OS4yMiAxOTo1NywgRGF2aWQgQ2hlbiB3cm90ZToNCj4gPg0KPiA+IE9uIDUuMTAgYnJhbmNoIHN0
YXJ0aW5nIGZyb20gNS4xMC4xMzMsIGlmIEkgZG86DQo+ID4NCj4gPiAgIGVjaG8gMSA+IC9wcm9j
L3N5cy9rZXJuZWwvc3RhY2tfdHJhY2VyX2VuYWJsZWQNCj4gPg0KPiA+IFRoZSBzeXN0ZW0gd2ls
bCBsb2NrIHVwLCBhbmQgdGhlIGNvbnNvbGUgd2lsbCBrZWVwIHNwZXdpbmcNCj4gPiAiQlVHIGF0
IGtlcm5lbC9lbnRyeS9jb21tb24uYzo0MDchIiBpbmRlZmluaXRlbHkuDQo+ID4NCj4gPiBJIGJp
c2VjdCB0aGlzIGlzc3VlIGRvd24gdG8gImM5ZWI1ZGMgeDg2OiBVc2UgcmV0dXJuLXRodW5rIGlu
IGFzbSBjb2RlIi4NCj4gPiBUaG91Z2ggaW50ZXJlc3RpbmdseSwgd2hlbiBJIHRyaWVkIHRoaXMg
b24gNS4xOS4xMSB3aGljaCBhbHNvIGNvbnRhaW5zIHRoZQ0KPiA+IGNoYW5nZSwgdGhlIGlzc3Vl
IGRpZG4ndCBvY2N1ci4gQWxzbyB0aGlzIGlzc3VlIGhhcHBlbnMgb24gYm90aCBLVk0gZ3Vlc3Qg
YW5kDQo+ID4gVmlydHVhbGJveCBndWVzdC4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgYWZmZWN0cyBu
b24tVk0gZm9yIG5vdC4NCj4gPg0KPiA+IEFueSBoZWxwIGlzIGFwcHJlY2lhdGVkLg0KPiANCj4g
UXVpY2sgcXVlc3Rpb246IHdoYXQgd2FzIHRoZSBsYXRlc3QgdmVyc2lvbiB5b3UgdHJpZWQgdG8g
cmVwcm9kdWNlIHRoaXMNCj4gb24/IFRoZXJlIHdlcmUgYSBmZXcgZnRyYWNlIGZpeGVzIHRoYXQg
d2VudCBpbnRvIDUuMTAuMTQ0IChyZWxlYXNlZCBvbmUNCj4gd2VlayBhZ28pLg0KPiANCj4gQ2lh
bywgVGhvcnN0ZW4NCg0KSGksIEkgdGhpbmsgdGhlIGxhc3QgdmVyc2lvbiBJIHRyaWVkIHdhcyA1
LjEwLjE0My4gSSBqdXN0IHRyaWVkIDUuMTAuMTQ1IGFuZCBpdCBzZWVtcw0KdG8gYmUgd29ya2lu
ZyBmaW5lLg0KVGhhbmtzIGEgbG90Lg0KDQpEYXZpZA0K
