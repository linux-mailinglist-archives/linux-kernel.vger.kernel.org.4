Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A0A720543
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236317AbjFBPDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236338AbjFBPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:02:53 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657CFE78;
        Fri,  2 Jun 2023 08:02:37 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352AvioG002212;
        Fri, 2 Jun 2023 15:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=I4jT3z3eoGyIX7qiGm4VyK5ShLGUDmzAVB8sztxAyGY=;
 b=aubGfdMkKw6YskgC5cyoB4UwfoPEkVWhTp/m2wO1Z3Wy2zmxu2zzYCjo5I4EwMQ/cTyE
 iaE4K/6SZHtJQRJ/cQeZm7n55TnriFAHWUBUOo6TmyT+azJKXdhmKH1SfIf222sytBfY
 oCHLQguPWT0nZzLXqxWcmMqUFcruMvJICNiJcbkHnMfSdC4UZLlYFLle84GiErV0Nyp1
 JNHIyhLB5FveKLmTOMS3SlXjFFpIlTtk73AUCT0s/dwJya0eFrkvExi8eems8Kuj9klG
 Nd2y4pTQpaXYaSodDh+lRM7R/C8UOFrLLYhCT7V5sENs8lnkTZPwHED9FzR1YUU1BUnM 5Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3qye17txfe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 15:02:16 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8B374800192;
        Fri,  2 Jun 2023 15:02:15 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 03:02:12 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Fri, 2 Jun 2023 03:02:12 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Fri, 2 Jun 2023 03:02:10 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br5Xqf+9ZX98gpWoRKi2nVI2R7Vz0zGUGyaCq0f/Y00Dny1D0Or+NDHibRTdsIBuy/brjpH5hrY94TWYza/0Clq3C55EA8xEXeCZYbFR7FRtq2RKD2Tbz2Qjr47Kwo9sjMYQNGY4IDJcaSv5z0Tlu4kccrFyABOpeqKhvI5FqYsK5eWxLmoN5nuzVDaVg37ST7+iTe6Ejomdywdvk2wzMMVx8XzGenaogHEkUgIjRINumckYL95gFSnyYBzc02JllES2JaWl3qr1Lg7YlOxeEQIMy++CbnCQpBbi8ApYArYNou083+rSbFhAKwQP68vl3GJINJKDoQCIyy5LKwrDIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4jT3z3eoGyIX7qiGm4VyK5ShLGUDmzAVB8sztxAyGY=;
 b=A8jrsa7jMHyxk411WEBnCrkmB14J02+YzsvwGz71OgzanGgUFYtkD/miEq4NduTDCPfSHrctdY9ppiu7ikX48MG+9KXzGJXspbHPhkD/SSByhafPSmSJWU99MLhTDQPJ5FS3yiTaYJWtXCyr2h8qXw2Cs5cWbVhCFcVw9crNZTLCmGP0w68CNGWCcY5DldloDNtvyMPLFjop4JwLQOAO/3TKc2e3yt5BIZ5oORuGaw6HXOBI+Woo4aAl+btLFO6QJNA1Fzve7HQvDjJb0sY+EV5e9Go5nEm4sZkFXnxUkT8+nHLcO0hRGuqI2m4Jyzw3sx+d0QSHKUMLDQJ2k5sLhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1669.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Fri, 2 Jun
 2023 15:02:07 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%5]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 15:02:05 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Topic: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Index: AQHZk9PWKQUBcQjeO0mLSJz9z8PkXK90ljUAgAAVFxCAABXlgIABVANQgAAbQwCAAAmAAIABEPEA
Date:   Fri, 2 Jun 2023 15:02:05 +0000
Message-ID: <306CAF4C-214B-4BAD-B859-BAF6F43B2775@hpe.com>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-5-nick.hawkins@hpe.com>
 <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
 <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <b1d8f851-4e87-333c-229c-b9dc37ea3c40@roeck-us.net>
 <DM4PR84MB19273A008BB11589CEEF697188499@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CACRpkdarJCSCif+r1e_jXbbAgv03OgGAO6pkW9x-yiYZJxdGeQ@mail.gmail.com>
 <8bd7d122-18b5-b9b4-0090-6344caf903fd@roeck-us.net>
In-Reply-To: <8bd7d122-18b5-b9b4-0090-6344caf903fd@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.73.23052000
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1669:EE_
x-ms-office365-filtering-correlation-id: abefc885-2e51-4e88-cc6a-08db637a545a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lPBAAeaVqBEKKjAI5jFQn1cz5rK2THc1kcycVZOyCE93qnEDLqWdZMqOWLozNlhPFu2cLWOP9k2tyeEDPOzsgTUd4X364JM2crFqrkggmv3OuvYhCAi46e9xdO6yzZRImZN6Ok1FrznSGSeLlr91JeOR5lPdduL0G3PbYSa03zjN/X5i1gP4sgXAnMZuGUoq9kaLNCrWgNvsXQZuxYL8GmerEGJtQp/21RhJnTBbxXBZxlBL22HL2qM1jFeuoAHeNQYXpwF9LgXt9/MspT07KY73HJgk8bHtN7Kh9tmPBltlaXWGfYBStb8OaB1SFP9Y2fFEvOYutTvt9L1xAedcPOzl9fW0NSZ9nZverV9eZeSu3xVu7wbUJ3m5aGJDUiZAp4tEw6a0EVYAuklfMzW3u7DO4+wlahSBygIbL0g/UyZ4aacA4CeYxduUKoFtTPp2o0BXDsRv8awoDBZ2DCobmJGDt6SH05soJI2VBtIlbthIULHU8a9xhbLMRN540eSMekj6KVbk/ktc+GTrAtMyCeRlztWRI1vCLQHDHh8aqcG1fHImlQwA8Z6hFuzX3BNgNDPMyBWWvkAT06sYq39+1x4TGrq+SuFP7DicKHeynJ1Z/CuVjA5iOCo+y3jrBxP4rZL8LuhJ6nVzOUSczIYEbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(41300700001)(316002)(122000001)(6512007)(38070700005)(82960400001)(4326008)(71200400001)(33656002)(8676002)(2906002)(8936002)(6486002)(86362001)(2616005)(91956017)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(36756003)(110136005)(54906003)(7416002)(6506007)(26005)(38100700002)(478600001)(5660300002)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dzd5UG1TYldSK3ViU0xTS0h0aytVbFJ2SjJ5Zy9RQVVvKy9DaWowTlNCVGV2?=
 =?utf-8?B?N1hPV1BJcWpxaks4b0liSDc5K0N6TXdCNEtvYXRZQzFvVjV4RWpBeHY5VTNX?=
 =?utf-8?B?TUFBS25yWUpXK1pXZzhJTVM2c3lVd1NnY2tVMXYxM3VZZnBNZ3h0cWczZ2RF?=
 =?utf-8?B?amhWVFkwYXVNQnhGSWRRdlQ2ZE9ienMyeHE2UzdabGhWeHBGVVNuWjFCMHpT?=
 =?utf-8?B?enNuM2FVWEdLWjYzRStmM2JqNXJRMjlBamZDaGw2cTV5eHVhMmlWenViNHg0?=
 =?utf-8?B?a1N5SEpVV0NsVGtwa1RleTNpWExBa0QxN1QyT3Y1czJmU2xIcXc0WVppeHJW?=
 =?utf-8?B?RmVNcHZBVHlMOElRUEtvRlphYzF2bEZZdU1LYTR0b0MzR010U2VvLy9IUUJs?=
 =?utf-8?B?ZVlYcWpiYlV6b2hCdDZNS3VUdWExTytKbEdhZDN0NXRBTmpFWURPTS9pelNP?=
 =?utf-8?B?ZFhlbkhzajVhN1BsdVV6b3lEOVlJL0tOQTMrRkVKOTdJenM1eTFnbDJSTExY?=
 =?utf-8?B?RkY1R0t1amhVeHlUK1QvSkREcTQzQkNHZkJTcndQRnVCTDh5Y3dkakFtbkp5?=
 =?utf-8?B?ZWpuRFBMYjg0Q2ZoM1FKRVdKS0NOSzJwLzZEaGR4Umh1REVCeXVCNSt5M2pU?=
 =?utf-8?B?YTZNN2FIUTFTa1haZjFqdGlsWWN5MTYwVjBwMWc2SEd6U0pwOUlVVjVTN0tL?=
 =?utf-8?B?VERsTkxTTy9BRHJGbDh2RTVwd3FSTDA0SExFdnI4LzNVRWM2NkNmR0pKVVBt?=
 =?utf-8?B?amdWRVJlRXlOSitoamtNSlBtUDdkZzVFRU5FYytKY0RkMFRNNyt2bFNBNi9S?=
 =?utf-8?B?R1RCSjRCSkRqc21PYmFIV3MzV3dWK0ZnL2F6YllITmIySEVkU0VhVmsrVURm?=
 =?utf-8?B?TThNTWxibkdYbGhzNk5QM200aWVBc2k4NEV5d1JSUTFYSFM4QXZ1ay9tY2Jx?=
 =?utf-8?B?enZlUkV5YzhsSVcwL2lxNDdjVDBiVUUyUTFKNmFtak0rUDdaUU9wUzN3UFov?=
 =?utf-8?B?SVVCYkI2NjhMK2FHczZ2WStJUGZFQktCb1R3c3FrM0V0K3lRQ2xpbFlHdTFt?=
 =?utf-8?B?a2F0Nlc5cEJoMGVveWExcURwQ2hnV3AwZTRtM0xmcjRNSytQUHFMYUViRmlF?=
 =?utf-8?B?cm9BMFlzZklTVWczQ0wxL3pZcVR1Y012MlRIQjExUUdSSTNDV1V6WldoTElO?=
 =?utf-8?B?Z2IwWC9LQXdWem45cmpjamNDWFVIQ3dDck9UbFpMRjU3eFhvM20xcDNYY1U2?=
 =?utf-8?B?c08wYlhMcExNN2FNdlpiVGdPWTF3NHBCSjM4U3ZQVjg1bUdnRUNKc2MxUURh?=
 =?utf-8?B?azY1SlFvMTZSeGV3dis0aHRmRHdhdnlWb3RndmVpWVhoRUJSckZJK3d4cWh3?=
 =?utf-8?B?a2EvSU5BVTUzaDlaR1VnQit5a1hSb2RaaGlFMGxwd1BxVU1CbVYyaXdtbE1n?=
 =?utf-8?B?eUdLRTVsWXRyYXRZVG8xbktmNzlJemRxZGxuZjROQVRMS1BBbm9zL3JLb0VK?=
 =?utf-8?B?SXU2RHNRZkRycTEvd3hWRWVzN3BmYk5pNzU1bzRJSXB3b01HbS9uSUdlbVZt?=
 =?utf-8?B?cDkzcWovTENxSmhnY295UVhCMGRQdlJLWlhFbU5OL25ZR2t6YTcyNnQ4cVhi?=
 =?utf-8?B?dFhuN1ZZWkVJeUErMExpaENZdGRHTUxVWnVObXRINWZia0FCVFhyTG9tUE1J?=
 =?utf-8?B?bCtPZDZEQ2hKMld1NGF0RFZYM3Q2OWpROFBOZ0RHd2tNbzdoa0JsVXNMN3B2?=
 =?utf-8?B?KzNwVXoxT3hPMmFBYWJicTJxZzg3TmNRNTJwOXF2UkdlUmtncWNyTCtVdDNK?=
 =?utf-8?B?b000TTVqNWlwcjVxclVXRWdBTlJTTlhPaDVwWXhoTVovNzluYlJMei9nbnlJ?=
 =?utf-8?B?STJLVEd2TnYvWUZpTGxjVlFxOWlsa3pBdThHOWVaNU5QbzlhVjk2MmNyWVZx?=
 =?utf-8?B?N3ovR0xmLzRhNkVJcER0RUF4MHY1K3F5VjI5dHBUbVVUVHlYVUtnMXJod3Ns?=
 =?utf-8?B?RTRkRFRzWG1vdWM1SC81c1ZmUm1lbXJIWW81cVpoL2txTVJ2Z0lFWFJmTDJR?=
 =?utf-8?B?Zi8rZ2dmSkdBWjRpdGp5S0JzRGZaM3I4Q1JYOXpzbFRUTjcwaGRhRzB2THhj?=
 =?utf-8?Q?mCdqdG9nhOBOPOdNH7gADMnQ1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1CC064DCE748954FB77418EFB2F5A632@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: abefc885-2e51-4e88-cc6a-08db637a545a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 15:02:05.5050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 12xRCN8QUEH757OfbTyb0qIKwEWaywhJnygDt5DvJGNMFnBie/Sb2lif9xvn2z2HK0GihnFk716eNt4+zc3UjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1669
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: sg4EY7KK_84AJ2QaQwtob_6oNyfPvdt9
X-Proofpoint-ORIG-GUID: sg4EY7KK_84AJ2QaQwtob_6oNyfPvdt9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_11,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxlogscore=464 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020113
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IA0KPiA+IFRoaXMgY2FuIGJlIGRvbmUgc2V2ZXJhbCB3YXlzLCB0aGUgbW9zdCBzdHJhaWdo
dC1mb3J3YXJkIGlzIG5vdGlmaWVycy4NCj4gPiBpbmNsdWRlL2xpbnV4L25vdGlmaWVyLmgNCj4g
PiANCg0KDQo+IFRoaXMgaXMgYWxsIHVubmVjZXNzYXJ5LiBUaGUgaHdtb24gZHJpdmVyIGNvdWxk
IHJlZ2lzdGVyIGEgZ3BpbyBwaW4sDQo+IGluY2x1ZGluZyBpbnRlcnJ1cHQsIGFuZCB0aGVuIHJl
cG9ydCBzdGF0ZSBjaGFuZ2VzIHRvIHVzZXJzcGFjZSB3aXRoDQo+IHN5c2ZzIG9yIHVkZXYgZXZl
bnRzIG9uIHRoZSByZWdpc3RlcmVkIGh3bW9uIHN5c2ZzIGF0dHJpYnV0ZXMuDQoNCg0KPiBJZiB0
aGV5IHJlYWxseSB3YW50IHRvIHVzZSB1c2Vyc3BhY2UgZm9yIGV2ZXJ5dGhpbmcsIHRoZXkgc2hv
dWxkDQo+IGp1c3QgdXNlIHVzZXJzcGFjZSBmb3IgZXZlcnl0aGluZyBhbmQgbm90IGJvdGhlciB3
aXRoIGEga2VybmVsIGRyaXZlci4NCg0KR3JlZXRpbmdzIEd1ZW50ZXIgYW5kIExpbnVzLA0KDQpU
aGFuayB5b3UgZm9yIHlvdXIgZmVlZGJhY2sgYW5kIGFzc2lzdGFuY2UuIEkgZGlzY3Vzc2VkIHRo
aXMgd2l0aCBteQ0KdGVhbSBhbmQgdGhlIGRpcmVjdGlvbiB0aGV5IGFyZSBsZWFuaW5nIGlzIHRo
YXQgdGhleSB3YW50IHRvIG93biB0aGUNCkdQSU9zIGluIHVzZXIgc3BhY2UuIFRoZSBmYW4gZHJp
dmVyIGl0IHdvdWxkIHN0aWxsIG5lZWQgdG8gYmUgdXNlZA0KdG8gc2V0IGFuZCByZWFkIFBXTXMg
YXMgdGhleSBhcmUga2VybmVsIHByb3RlY3RlZCByZWdpc3RlcnMuIEl0IHdpbGwNCmFsc28gbmVl
ZCB0byBiZSB0aGVyZSB0byBjb29yZGluYXRlIHRoZSBwcm9wZXIgb2Zmc2V0IGluIHRoZSBHWFAN
CnJlZ2lzdGVycyB0byBjb250cm9sIGEgcGFydGljdWxhciBmYW5zIFBXTS4NCg0KRm9yIGhvdCBw
bHVnZ2FibGUgZGV2aWNlcyBzdWNoIGFzIGZhbnMgYW5kIHBzdSB0aGV5IHdpbGwgbmVlZCB0bw0K
YmluZC91bmJpbmQgdGhlIGh3bW9uIGRyaXZlciBvZiB0aGUgZGV2aWNlIGFzIGl0IGlzIGluc2Vy
dGVkL3JlbW92ZWQuDQoNCklzIHRoaXMgYW4gYWNjZXB0YWJsZSBwYXRoIGZvcndhcmQ/DQoNCklm
IGl0IGlzIEkgd2lsbCByZXZpc2UgdGhpcyBwYXRjaHNldCBvbmNlIG1vcmUgdG8gbWFrZSB0aGUg
ZmFuIGluZGVwZW5kZW50DQpvZiB0aGUgR1BJTyBkcml2ZXIuDQoNClRoYW5rcyBhZ2FpbiBmb3Ig
YWxsIHRoZSBndWlkYW5jZSwNCg0KLU5pY2sgSGF3a2lucw0KDQo=
