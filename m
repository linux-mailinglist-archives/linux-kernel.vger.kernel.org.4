Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A6861A1DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiKDUFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiKDUE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:04:59 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0649B68;
        Fri,  4 Nov 2022 13:04:03 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4FcQhs010745;
        Fri, 4 Nov 2022 20:03:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=HjW2Xo+uTTXwJuDQA+KNbXPx+ULLzTFC/3fMMTZjrSM=;
 b=j228JkT3I+ojj/VnO4n6TODXa1kuOeEV780OYdxyS8hmYifPHxBl0a+c5OIAO5NrC5IE
 OG1XYtU6yInAVkwJJfEeBtSNzfP6rR4etp7XtU7v1mP5pzcoo6zZUO8NIupk8n94JTPD
 gQRd0XBY/TJJdACq+FqIU459GUwhfLq7E92nWeLgn2PXNhk1mW6Ku5IX6dAhpo8KcPDd
 UnQ9TU0x15g8UQHAph3vDvR5+6yC3KBlsCElmZuVAptIY7EFQE6kA8x3RD0WQ49vYXzm
 PleyOA3FBZzoAVfGGgEQZnZhRvRssw1ip5EZTVxd2O66b5pul0gtrNqfNAsrA7goecg8 xA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3kn4nv2f4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 20:03:51 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 7F7898040C8;
        Fri,  4 Nov 2022 20:03:50 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 4 Nov 2022 08:03:50 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 4 Nov 2022 08:03:50 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 4 Nov 2022 20:03:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STmKbh/t7fZEq/q4HC5OAT0MNeOiuFS6paE+anRd6IRlORpma4h232BDb2FKNwwT52OZQJYryEGF5GPMJTRlzlVf1WQl9vlcSEJl63Fk+b3Izs1ODNlquRfMaqxMGttzPVUyChgUeAtSukH6xHSm6PBGEd9hkfhx/11VXldDwypbZ5ab77Q8CAtk4xAmHRzCeo0irjqUFnr+I0hfzxJCUXTeE3Q36eezq0xWduoRzoyi2vozBMxy5rHf72wMKL558DZNeamO+Wq+LmaLd8ILIpmtE814G+uN3JvSHHSbMRM/IvrGSrf2/zw5xQYnwjY+9ATvo0gPJDJd73YYtTvaGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JKMzqYMjCJFaDDYcNNX+j/lSIfjtdvwHcZ3miSr4gs=;
 b=OV+ExuiEtHMflMB4cn3NrlUOvmKZtzP2lr+zjNpD5s9dxlLYA+d9rLYKAJJ/9a+NtjhaXKrzMJwaEXuXgpXa+OruyLjeVpIYLYmyJwbCVrSt2Q5+1bU/Bv0q3CwBwqc8Rpuncf29lIJ/GPnIu7mn6dc4f6IvgjknV8dbk8CPjzL80tw+Ek2K4wg1tbPnsYrYefxVU4ic0mCBYLL5chHDO8EnGVZc6rcl2hWO5SBTLHeJoWGFmuVsYIYiAgnu7jX6M0pmkzPj9Mm3/aKV42GBIKG8uAlyP9VcTQ/D4M3YT3EVDboO6rgL9sMBhTZ1f7QQe0tkyhvM2228/vGJJVAYRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:434::14)
 by SJ0PR84MB1776.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:436::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 4 Nov
 2022 20:03:48 +0000
Received: from SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f0:1823:3295:df46]) by SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f0:1823:3295:df46%9]) with mapi id 15.20.5769.019; Fri, 4 Nov 2022
 20:03:48 +0000
From:   "Yu, Richard" <richard.yu@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Chang, Clay" <clayc@hpe.com>
Subject: RE: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for gxp
 gadget
Thread-Topic: [PATCH v1 2/7] dt-bindings: usb: hpe,gxp-udc: Add binding for
 gxp gadget
Thread-Index: AQHY755tsrsf1u+J3EmTaEhUe3W7664tY7+AgAG14/A=
Date:   Fri, 4 Nov 2022 20:03:48 +0000
Message-ID: <SJ0PR84MB2085A64D47E00077EFF8BFE18D3B9@SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221103160625.15574-1-richard.yu@hpe.com>
 <20221103160625.15574-3-richard.yu@hpe.com>
 <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
In-Reply-To: <b85230d4-8fce-ba49-0d6b-8c4d20132cda@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR84MB2085:EE_|SJ0PR84MB1776:EE_
x-ms-office365-filtering-correlation-id: 0095ef44-e955-45d5-d2d3-08dabe9fafdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cjIdG0bTXa1+YvMNS/GqjCD5gtzQsMBba7BtXVz2Oqr3JdAeNXh/wbCkeUHc+Ejiy2uxbm7m9TGvdhOwU/c/vX8HtTUWRijsUtJTxzVI045eiirqmYLqzUp1RhV5kMFLpUjl7nMJNXXOvm6pc3WUUfJz9CMwke2icqkJrWwzwi64F1E3aTR6U4Ev58ntlOKin6ieN3dIjOTZHMDf63rh9mVIulWkAG9bhcQClQm4JYcSfTJWfy4gf+Wsfbe8JNno8QK/szjZ+pzr6ekxVSAQoCZXzTcD2TigeMGz2tigbWlXxpwV23Lppc+HXqCUilcHGj0c5P9kbKxpaWR2Wdwyu+N8ubMhu8RRfSVFQBzKCaZF5nm2u+4aRjXbe/NE9A/WPRxcDayOj5RS3RcMk7ctbPCmny+Wa9i+oN8uZNQ2u5JeuHPpW+TiU08YclxR5lAz4/cMLutES9jQtwl0fvE1XeDW82O0ICw/UsK3Rp0yM4BSV3UXDzV2WQD52yizbW92TpyOSeeUOhP0pFj53Ll9QSNYNu62ljrQyz685UtDCT/IBVNbYga9o7sBaX6Wolhi9N/7zlEuQ3uVBFjuHBpuOhMGS5h4dweeab1Q3nBoFKZfKpIRUX6nYMkl4CcgWaKWW/hgdaQwXebUSHpfkNBUmy7R2MFY/3ymvybEiq8AgkkVvSeildQyZe58+DgYX43sSITwulLQ/rC4hmaeIgn6QNgEOr4halms1yOFggngkH5F95ah51zuGH4fTc3M8NJtt3PrcgByHa2B12q5VqioObJkR3K1xAx0KnzQQwUFJ2XXjZn7Brj0APcYQLWxvUetE6R8Y69a2jt93es6DJj+MJfqSsG8FOJHPJBAkHzgKhU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199015)(186003)(82960400001)(7696005)(83380400001)(55016003)(316002)(6506007)(26005)(110136005)(38100700002)(921005)(38070700005)(2906002)(6636002)(76116006)(33656002)(9686003)(66446008)(86362001)(8676002)(8936002)(66946007)(64756008)(53546011)(66476007)(122000001)(66556008)(41300700001)(5660300002)(478600001)(71200400001)(7416002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEUwN3Z2VWN4U3EyTnNkSUJabmp4K0orR2hqQ0ZSVnNIKzhjQmM3YTliZW81?=
 =?utf-8?B?bTUrZXJhT0dkTlE0dVo5RkNSMFNzdmMzWm94aDFsUE1ZU042Y090OXRtbTNK?=
 =?utf-8?B?cjdVdS9SQjNYMUdDWnBWRkxlMU1leElsUHhtYUxqMlJMOWdvemhhdWpXbWpC?=
 =?utf-8?B?emIybVU1RWlsa2dMWFVCYlA3YjU4a1NuL041amsrSHg2ekc2L2E4Z0pYY0Fv?=
 =?utf-8?B?Y0lnOG1oV1VLZmo4SWVEV0VSR3p2VGFPWEZXUEFtYkhRTXpSNUllbTVSTVZK?=
 =?utf-8?B?STQ2d3AxTVlwVlRBS1N2ekxVenp3aWRtT3QwdDdaNFl6cUMrYVpOYlhmbGxo?=
 =?utf-8?B?T3JWYUdzTExwOXRCQ2xuRmp4WE9MaE1mTVJaalRCZ2FtUCtRS3RSMTFSNC9V?=
 =?utf-8?B?NURUcFQyeHQxcEtTWEZMWW5qQVZtYlFjbUlNNWJyLzBYUlpUTU93RFhybTlL?=
 =?utf-8?B?R2Z1QndRNWJHQzYvU2ozamRLV1cyOHRQaDJGc2JNTDVBWTJiSkx5ejdIV2Nk?=
 =?utf-8?B?MjdHb0Z2M1N3ZTZ0MDJld0lSQis5ajFZQkRQc0k0c2dYa203VTAxOGdvU0hJ?=
 =?utf-8?B?cndCZDJuV0pDYnQ1RmZEaUQyQkZac21mNWllYnU5V2NmYkI3b0lRQ3Zldk90?=
 =?utf-8?B?QUIxZjdsbjFZazJ0VHBzaUJOdThKK2ZETFY5QXZCc2Y4V0daYnNvdXcxT1Jl?=
 =?utf-8?B?MXJ0S0s1UERtMkltVi9BbFUrMjRxdGYwQmpFdGZWRHpqdW9WZHhkQ3NNeW1Y?=
 =?utf-8?B?YjZuUHpVYW9yd25McDUvVU9xSEFNRmZNY1kwVXJOVFZMWkdTbE9OWDF5bmxK?=
 =?utf-8?B?NGVBMjhQWHI3OTEyeTVFdTQ2bnNlYjJqMlB5eko0ZnRGek1sblZaZWgrcllk?=
 =?utf-8?B?dDRITTZsNUowTkJWMmZvVUVVOWViNFg4L1E0UmtQRnpWOE0zZmpBTGViWTZT?=
 =?utf-8?B?TVh2b1R4aHhCc1RTdks3QTl5dzlLS1pvTzRCMk01V1cvVWVWQjlPb05yeEJX?=
 =?utf-8?B?Qk4zK2I3bWVqUUcxRHZ5aU0zbUl3NHBPcXZwTWZBWEhkK2FZaHh4NkpLR0xs?=
 =?utf-8?B?OHpwUjVDakNxdDRaZFdzZENPUzhINUkzZ0MwOG9zZ0Rqb3EyM2JzcGlzSnlN?=
 =?utf-8?B?N1d4Y0lrRXdUNng4czNJN0hBTXEzSmlaTzVDVFEzVkplbmhDTTh0VkI0ZUd0?=
 =?utf-8?B?d3dXQk93eDBFTHVUR1cxTmF3Q2FpS1dTdjA0WnlhZFF2bzdaK2FsZHNCUnZi?=
 =?utf-8?B?NVNpeWZaN1FvWk5DVkZCMmVYZUpxNkd2aFEvRG9wNmtHaE42TnM0YVdkb2VG?=
 =?utf-8?B?Z0FzREs0djYwRzVIb29zV093OEJ2NGpDT21YMi91UUFyaVdvZFFCZ1ZSZ1Rn?=
 =?utf-8?B?VGllMElYSFEraHo1azRHWkxia0tsekMycFRVOThBL0VRUmduY2M5VzJwd2pY?=
 =?utf-8?B?QzFPR05jQjVsb1hyWWI3RWJ0KzVPUnRNY3lUeFM5QURScGp1YkZqSk0xWHNV?=
 =?utf-8?B?TXc0bXVyWTZtVUhQRTRWZ29tSC9TYm4vbWVBVm4zTkNHMUhEUUZ0T09UQndK?=
 =?utf-8?B?Ky9vT1NMVy9yL2ZLUG9SOEIrdGNzMWNWNTNVMWx0L0xlRm9lcU1seGRJMTRr?=
 =?utf-8?B?MVVHS2V6bWhJSlpTQUgyQnRGbWJyUHFJajFpMDlheXczWDFQcjhESGMydyti?=
 =?utf-8?B?VmpaVENNMHhJS2dJRHJ3N0ZORWpsWDRyQkNDMnVoUndsS3pnRVVhN0hybWNE?=
 =?utf-8?B?bFBUV1VCRmt0UDc1dE9VL1pxN3N1NU1sT1dZRzZER3EvSzk2NEdqNDZCZHQ2?=
 =?utf-8?B?QzdrQ3hReG91eXVQbEpnQnZpMHFFbmRlbW1LZXBVd2VvK3JXMUlmTjQwOEwr?=
 =?utf-8?B?ck5WYXVxZHRhQnFzdzhCK0tsaEJKUUNTRzdZOUtON0N4M0hHQnRoMFRTamNh?=
 =?utf-8?B?OXIrU0d2UWlxOTE0YnU4UlZOdFNHSGFzY0JMLy9TZlY3RzBMVHFEM3BQSWJD?=
 =?utf-8?B?ZlpLUm1jRVlPaEM3a2VPQUV0MWVxcXh1am5LcGZZNlRaNjkzVjA4YnpPZ1FP?=
 =?utf-8?B?NWd1SmpDSGJOOU5zSUlxZlpXdTNKaTdRZUk2ejl5NVMyMGVHWDU1TjIxYnZk?=
 =?utf-8?Q?G2mP+UJlmVP7xiZ0i/EuS9ty7?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR84MB2085.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0095ef44-e955-45d5-d2d3-08dabe9fafdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 20:03:48.5661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: McKNlzgK9lA/XobmWoZS/dN4FX8BiBlJIKm8EAtClwDEK9r66D5j9ydp9aUmqVNWxrA1FsK5iLJZEiB6yxpBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1776
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: ubIZy1hbxnKF1sLQv3kUu11yD-Hs3rvp
X-Proofpoint-GUID: ubIZy1hbxnKF1sLQv3kUu11yD-Hs3rvp
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_11,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 clxscore=1011
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211040123
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTXIuIEtvemxvd3NraSwNCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBxdWljayBy
ZXZpZXcgYW5kIGZlZWRiYWNrcy4NCg0KSSB3aWxsIG1vZGlmeSB0aGUgcGF0Y2hlcyBiYXNlZCBv
biB5b3VyIGZlZWRiYWNrIGFjY29yZGluZ2x5Lg0KDQpPbiB0aGlzIHNwZWNpZmljIHBhdGNoLCB5
b3UgaGF2ZSBxdWVzdGlvbnMgb24gaG93IHdlIGRlZmluZWQgdGhlIGRldmljZS9nYWRnZXQgY29u
ZmlndXJhdGlvbnM6IHZkZXZudW0gYW5kIGZlcG51bS4NCg0KUGxlYXNlIHNlZSBteSBhbnN3ZXJz
IGZvbGxvd2luZyB0aGUgcXVlc3Rpb25zOg0KDQo+ICsgIHZkZXZudW06DQo+ICsgICAgZGVzY3Jp
cHRpb246DQo+ICsgICAgICB2aXJ0dWFsIGRldmljZSBudW1iZXIuDQoNClRoYXQncyB1bnVzdWFs
IHByb3BlcnR5Li4uIFdoeSBudW1iZXJpbmcgZGV2aWNlcyBpcyBwYXJ0IG9mIERUIChoYXJkd2Fy
ZSBkZXNjcmlwdGlvbik/DQoNCj4+IFJpY2hhcmQ6IEluIEhQRSBHWFAgdmlydHVhbCBFSENJIGNv
bnRyb2xsZXIgY2hpcHNldCwgaXQgY2FuIHN1cHBvcnQgdXAgdG8gOCB2aXJ0dWFsIGRldmljZXMo
Z2FkZ2V0cykuIEVhY2ggZGV2aWNlL2dhZGdldCB3aWxsIGJlIHJlcHJlc2VudGVkIGJ5IGEgYml0
IGluIDggYml0cyByZWdpc3Rlci4gRm9yIGV4YW1wbGUsIHRoZSBpbnRlcnJ1cHQgcmVnaXN0ZXIg
Yml0IDAgaW5kaWNhdGVzIHRoZSBpbnRlcnJ1cHQgZnJvbSBkZXZpY2UgMCwgYml0IDEgZm9yIGRl
dmljZSAxIC4uLiBzbyBvbi4gIFdoZW4gYW4gdXNlciBkZWZpbmVzIGEgZGV2aWNlL2dhZGdldCwg
aGUvc2hlIGNhbiBkZWZpbmUgdGhlIGRldmljZSBudW1iZXIgYXMgYmV0d2VlbiAwIGFuZCA3LiBU
aHVzLCB0aGUgZHJpdmVyIGNhbiB1cCB0byB0aGUgYml0IHBvc2l0aW9uLiBUaGF0IGlzIHdoeSB3
ZSBoYXZlIG51bWJlcmluZyBkZXZpY2VzIGFzIHBvcnQgb2YgRFQuDQoNCj4gKw0KPiArICBmZXBu
dW06DQo+ICsgICAgZGVzY3JpcHRpb246DQo+ICsgICAgICBudW1iZXIgb2YgdGhlIGZsZXhpYmxl
IGVuZC1wb2ludHMgdGhpcyBkZXZpY2UgaXMgbmVlZGVkLg0KDQpTaW1pbGFyIHF1ZXN0aW9uLg0K
DQo+PlJpY2hhcmQ6IEluIEhQRSBHWFAgdmlydHVhbCBFSENJIENvbnRyb2xsZXIgY2hpcHNldCwg
dGhlcmUgaXMgYSBmbGV4aWJsZSBFUCBwb29sLiBFYWNoIGZsZXhpYmxlIEVQIGhhcyBpdHMgb3du
IG1hcHBpbmcgcmVnaXN0ZXIuIFRoZSBtYXBwaW5nIHJlZ2lzdGVyIGJpdCAwIHRvIDMgaXMgZm9y
IGRldmljZSBudW1iZXIgKHZkZXZudW0pIGFuZCBiaXQgNCB0byA3IGlzIGZvciBFUCBudW1iZXIg
aW5zaWRlIHRoZSBkZXZpY2UuIFRoZSBkZXZpY2UgZHJpdmVyIGNvbmZpZ3VyZXMgdGhlIG1hcHBp
bmcgcmVnaXN0ZXIgdG8gYXNzaWduIGEgZmxleGlibGUgRVAgdG8gYSBzcGVjaWZpYyBkZXZpY2Uu
ICBIZXJlLCAiZmVwbnVtIiBpcyB0aGUgaW5wdXQgbGV0dGluZyB0aGUgZHJpdmVyIGtub3cgaG93
IG1hbnkgRVAgaXMgbmVlZGVkIGZvciB0aGlzIGRldmljZS9nYWRnZXQuDQoNCkhvcGUgSSBoYXZl
IGFuc3dlcmVkIHlvdXIgcXVlc3Rpb25zIG9uICJ2ZGV2bnVtIiBhbmQgImZlcG51bSIuIA0KDQpJ
IHdpbGwgbW9kaWZ5IHRoaXMgcGF0Y2ggdG8gYWRkcmVzcyB5b3VyIG90aGVyIHJldmlldyBmZWVk
YmFjay4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBhZ2Fpbi4NCg0KUmljaGFyZC4NCg0KLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAbGluYXJvLm9yZz4gDQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMywgMjAy
MiAxMTozMCBBTQ0KVG86IFl1LCBSaWNoYXJkIDxyaWNoYXJkLnl1QGhwZS5jb20+OyBWZXJkdW4s
IEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29tPjsgSGF3a2lucywgTmljayA8bmljay5oYXdraW5z
QGhwZS5jb20+OyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7IGxpbnV4QGFybWxpbnV4Lm9yZy51
azsgYmFsYmlAa2VybmVsLm9yZzsgbGludXgtdXNiQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCB2MSAyLzdd
IGR0LWJpbmRpbmdzOiB1c2I6IGhwZSxneHAtdWRjOiBBZGQgYmluZGluZyBmb3IgZ3hwIGdhZGdl
dA0KDQpPbiAwMy8xMS8yMDIyIDEyOjA2LCByaWNoYXJkLnl1QGhwZS5jb20gd3JvdGU6DQo+IEZy
b206IFJpY2hhcmQgWXUgPHJpY2hhcmQueXVAaHBlLmNvbT4NCj4gDQoNClN1YmplY3Q6IERyb3Ag
cmVkdW5kYW50IHNlY29uZCAiYmluZGluZyIgd29yZC4NCg0KPiBDcmVhdGUgZG9jdW1lbnRhdGlv
biBmb3IgdGhlIGhwZSxneHAtdWRjIGJpbmRpbmcgdG8gc3VwcG9ydCBhY2Nlc3MgdG8gDQo+IHRo
ZSB2aXJ0dWFsIFVTQiBkZXZpY2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFl1IDxy
aWNoYXJkLnl1QGhwZS5jb20+DQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L2hwZSxneHAtdWRjLnlhbWwgIHwgNTcgDQo+ICsrKysrKysrKysrKysrKysrKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCA1NyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgDQo+IERv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvaHBlLGd4cC11ZGMueWFtbA0KPiAN
Cj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvaHBl
LGd4cC11ZGMueWFtbCANCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L2hwZSxneHAtdWRjLnlhbWwNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAwLi5mMWVjNGRmOGMzZDMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2hwZSxneHAtdWRjLnlhbWwNCj4gQEAgLTAsMCAr
MSw1NyBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5IE9SIEJT
RC0yLUNsYXVzZSAlWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOiANCj4gK0lOVkFMSUQgVVJJIFJF
TU9WRUQNCj4gKy11ZGMueWFtbCpfXztJdyEhTnB4UiFsS0RNV0VfVzM4S0xZMmdYSDBkWTFyRy1i
VTRKd0l5bWVfRE16ZXBwWU85RFExUw0KPiArd3ZYZUlEM1JERUV1S0JTRzgxX2hzRDVnbnRGX2Vs
WmhDOXlpWFQtTXZGQSQNCj4gKyRzY2hlbWE6IA0KPiArSU5WQUxJRCBVUkkgUkVNT1ZFRA0KPiAr
YW1sKl9fO0l3ISFOcHhSIWxLRE1XRV9XMzhLTFkyZ1hIMGRZMXJHLWJVNEp3SXltZV9ETXplcHBZ
TzlEUTFTd3ZYZUlEDQo+ICszUkRFRXVLQlNHODFfaHNENWdudEZfZWxaaEM5eWkzVlgtZ1BnJA0K
PiArDQo+ICt0aXRsZTogSFBFIEdYUCBHYWRnZXQgVW5pdmVyc2FsIERldmljZSBDb250cm9sbGVy
IChVREMpDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIFJpY2hhcmQgWXUgPHJpY2hhcmQu
eXVAaHBlLmNvbT4NCj4gKyAgLSBKZWFuLU1hcmllIFZlcmR1biA8dmVyZHVuQGhwZS5jb20+DQo+
ICsgIC0gTmljayBIYXdraW5zIDxuaWNrLmhhd2tpbnNAaHBlLmNvbT4NCj4gKw0KPiArcHJvcGVy
dGllczoNCj4gKyAgY29tcGF0aWJsZToNCj4gKyAgICBjb25zdDogaHBlLGd4cC11ZGMNCj4gKw0K
PiArICByZWc6DQo+ICsgICAgbWF4SXRlbXM6IDENCj4gKw0KPiArICBpbnRlcnJ1cHRzOg0KPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ICsNCj4gKyAgdmRldm51bToNCj4gKyAgICBkZXNjcmlwdGlvbjoN
Cj4gKyAgICAgIHZpcnR1YWwgZGV2aWNlIG51bWJlci4NCg0KVGhhdCdzIHVudXN1YWwgcHJvcGVy
dHkuLi4gV2h5IG51bWJlcmluZyBkZXZpY2VzIGlzIHBhcnQgb2YgRFQgKGhhcmR3YXJlIGRlc2Ny
aXB0aW9uKT8NCg0KPiArDQo+ICsgIGZlcG51bToNCj4gKyAgICBkZXNjcmlwdGlvbjoNCj4gKyAg
ICAgIG51bWJlciBvZiB0aGUgZmxleGlibGUgZW5kLXBvaW50cyB0aGlzIGRldmljZSBpcyBuZWVk
ZWQuDQoNClNpbWlsYXIgcXVlc3Rpb24uDQoNCkJUVywgaWYgeW91IGVuZCBzZW50ZW5jZSB3aXRo
ICcuJywgaXQgbWVhbnMgaXQgaXMgYW4gc2VudGVuY2UsIHNvIHlvdSBuZWVkIHRvIHN0YXJ0IGl0
IHdpdGggY2FwaXRhbCBsZXR0ZXIuDQoNCj4gKw0KPiArICBocGUsc3lzY29uLXBoYW5kbGU6DQoN
CnBoYW5kbGUgaXMgcmVkdWRhbnQuIFlvdSBuZWVkIHJhdGhlciBzcGVjaWZpYyBuYW1lLCBzbyAi
aHBlLGVoY2ktc3lzY29uIg0Kb3Igd2hhdGV2ZXIgaXQgaXMuDQoNCg0KPiArICAgICRyZWY6ICcv
c2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlJw0KDQoNCk5vIHF1b3Rlcy4N
Cg0KPiArICAgIGRlc2NyaXB0aW9uOg0KPiArICAgICAgUGhhbmRsZSB0byB0aGUgZ3hwIHZFSENJ
IGNvbnRyb2xsZXIgYWNjZXNzIHZEZXZpY2UgcmVnaXN0ZXJzLg0KDQpEcm9wICJQaGFuZGxlIHRv
Ig0KDQpJc24ndCAiZ3hwIiBhIEdYUD8NCg0KPiArDQo+ICtyZXF1aXJlZDoNCj4gKyAgLSBjb21w
YXRpYmxlDQo+ICsgIC0gcmVnDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIHZkZXZudW0NCj4g
KyAgLSBmZXBudW0NCj4gKyAgLSBocGUsc3lzY29uLXBoYW5kbGUNCj4gKw0KPiArYWRkaXRpb25h
bFByb3BlcnRpZXM6IGZhbHNlDQo+ICsNCj4gK2V4YW1wbGVzOg0KPiArICAtIHwNCj4gKyAgICB1
ZGNAODA0MDEwMDAgew0KDQpOb2RlIG5hbWUgInVzYiIsIEkgdGhpbmsgaXQgaXMgbW9yZSBwb3B1
bGFyIGZvciBVU0IgY29udHJvbGxlcnMuDQoNCj4gKyAgICAgIGNvbXBhdGlibGUgPSAiaHBlLGd4
cC11ZGMiOw0KPiArICAgICAgcmVnID0gPDB4ODA0MDEwMDAgMHgxMDAwPjsNCj4gKyAgICAgIGlu
dGVycnVwdHMgPSA8MTM+Ow0KPiArICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmdmljMT47DQo+
ICsgICAgICB2ZGV2bnVtID0gPDA+Ow0KPiArICAgICAgZmVwbnVtID0gPDc+Ow0KPiArICAgICAg
aHBlLHN5c2Nvbi1waGFuZGxlID0gPCZ1ZGNfc3lzdGVtX2NvbnRyb2xsZXI+Ow0KPiArICAgIH07
DQoNCkJlc3QgcmVnYXJkcywNCktyenlzenRvZg0KDQo=
