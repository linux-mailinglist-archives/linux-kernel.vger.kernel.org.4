Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241BF745FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGCPcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjGCPcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:32:00 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102FCE49;
        Mon,  3 Jul 2023 08:31:58 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363F7L1I004340;
        Mon, 3 Jul 2023 15:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=kUwdNYFugsP3Fakxd/krr1gLONBqEe2wJfQsS0xz61c=;
 b=a2SRTj5SeCUDsSXXd1W3yz297uBGX9ozApJszj67TKYeIgNtrzjzMeIfiVoBoPGEVhxF
 WZXDc004g884VOjaGUyuwpa7Fi7IDFBODydI+2N22A9vcOd+POu+2On7oyO0Xj5gfJTY
 rrw/ei3L44QrtbMB0xu/+h+QY1yspZysYhzEwgSTojRwdJHAmO9sUMPrni7u0HGXV9Ax
 2lzWtybiTArXvZWEBkS1TuPZrr8GN5JicjH+pRYpPvqTAsqlnWk1T+4oaOB9zQbzY1k+
 3Xrlhvl2fkRBuS3pMgamLi2c+MdsNngifWeVMH6XXxRhzooLsqcuGof+JjrkNNPbGCiW 5g== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3rm0pr05r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 15:31:33 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 714C9D2D1;
        Mon,  3 Jul 2023 15:31:32 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Jul 2023 03:31:16 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 3 Jul 2023 03:31:16 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 3 Jul 2023 03:31:15 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kN0DdgMKjTbJn/5plSLQwtRPhuOkP4Q12qoE9soWd3UZxA6Rv84iJ5Woh8Rq2T8fgEPUWVynx6/2Ts3dfq10mTX2S0ZS0QM/vL+vnhIBSpO3FZ7Nf1XxCAY0TDI1utbAqsnT+Rfr8llRwnv873QMCmfmg/PoOXH//KJmbxWy5lckmI/+xG11ZXgzFBbwbFO4R61+GvoF1TN1SpQuzesrC8rnpzNTtoRt0DcHGpjiazbTFTP3eO8X1oHxctKu+1VAiBZaS6LTXx77mzv8ZHs7ikrrTbmT1V6JQKxNQcrcXUenWDFD5ZaXaA5fej7S9po4BeTVDn8sGRVEmHCu/HkwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUwdNYFugsP3Fakxd/krr1gLONBqEe2wJfQsS0xz61c=;
 b=KbnWx95k8SA7p/Qs7bUS8MfPertKcxmE3QNnlwTUSgGazKQ+0op2qAUuuzBI9Z4d43/WmaKlJgX2UZ5BHojkudYgigoCTlbZC2ZhZwSU6Y/hiK6nd+HZH5por6vrpdZaMFmqffi+All+thBqihbDEU0zIF57xvMR7cVFircj1TbnlAA7QfvjOcR39rQMpDFz4rdne6bJwqHDy5GAsb+ah4Q+KiZHFaE/bNbzNjLG52PHhaJNj4D+IYZ9imci62r0NPJj4SHg1ndyQqzgovUujK+FFFx93saZ7CYOYgBfRtSmKccB5hufT5mg2R3mqQ1c8nfgbGyfo3psPbh0PGXgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 SJ0PR84MB1361.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:a03:381::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Mon, 3 Jul
 2023 15:31:14 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1411:4ecd:1d0:5eab]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::1411:4ecd:1d0:5eab%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 15:31:14 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v4 0/5] ARM: Add GPIO support
Thread-Topic: [PATCH v4 0/5] ARM: Add GPIO support
Thread-Index: AQHZpIhWUlqRq2EHqkqy8AJ2NKb6tK+WaPeAgAurAgA=
Date:   Mon, 3 Jul 2023 15:31:14 +0000
Message-ID: <4961CC2A-1755-4784-B942-EE840F981106@hpe.com>
References: <20230621213115.113266-1-nick.hawkins@hpe.com>
 <CACRpkdazmeFHagwkJ3s6BHRBgFoLPbj8AVnPL2f+vTi9K46Kcg@mail.gmail.com>
In-Reply-To: <CACRpkdazmeFHagwkJ3s6BHRBgFoLPbj8AVnPL2f+vTi9K46Kcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.74.23061800
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|SJ0PR84MB1361:EE_
x-ms-office365-filtering-correlation-id: 7b529604-eca2-4ed5-128e-08db7bda897f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5SORw3jHWstTmcEWUID5JDaJifTfYomBMMA+glurMdrGoDkemwqcfwSGlbIRopfDQ7yKls8+S3z2/aXpY9KbXz6uKrAtdjBCs5xcnXyB7QpAB45BMf2slU7JHei1f5/K54ORFh6I8jQHZb/RHOXtg3XwW9Ie2NUceW4oiWkx4HtniDPyTgXJJlhDhN8IRTIroTWFhg8m1Ja205grjNaWBquN9k+dxo5nt/ckIVNbPHSHWIXCCm3xWTMC0JiMUr5XuuGnh3iYRAU0wbEMpmEEbckMC02k4PIAM2fNxJDqITjTiw+7wDIADEsOKcAz6jWNCBNgyjr77Hfhhp3V6C8GBlKSSeFkh1vUJSCryt8hV1oX/MfbAP0U3gY52ZmCOjm39H9f9Ml8cX2Jb470qDndzlyLAJdyS7LNoUA7v7BN6aqsRZf+1mO9jB4Pm3XvDhAOGnYfqrBOl7NahQRjiE1GzCVvPqDj2zKJBBgz8malHwgvw/y5Dv6qnKMq8gHhBbPLnXqXmde3MncHlydmSXVcr4oa9loKlz3Lv4Jmp9FUJNvTdqcVI862mey0T00GFyddXZwFFExs9qqgTDp4GBvBE5hEsDD1IMumIdMSMnz98qOBGC5DkT2YS5jaSgnIHRO0AhFNBkaKQFjjDCUzc2KAjG3ARqrg2C+wkrk8Z0Zlz1oSi+1/YKI/zwZHnQL3knv7p48H5QAeh+akalKsUkk9TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(2616005)(83380400001)(110136005)(54906003)(8936002)(36756003)(86362001)(41300700001)(8676002)(7416002)(5660300002)(2906002)(33656002)(316002)(66946007)(76116006)(66476007)(64756008)(66446008)(38070700005)(66556008)(6486002)(478600001)(71200400001)(122000001)(38100700002)(82960400001)(91956017)(4326008)(6506007)(6512007)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzJ6djEwd29oay94a25FL0gwLzZlL0NTdGhQanArZzZBOHNqd0tBbUp1emN6?=
 =?utf-8?B?d0xjQkZDUzJnWUhJUGxNMGJzSUpRS3BvK2NGaTlhTWY4Zng5S2dXUXBwWHM2?=
 =?utf-8?B?SFlaUlFQSlZFbk1GWEwyQTY1elpmc3VjZEJxNWhUNWV3UkRkdGxPZWV2NjZP?=
 =?utf-8?B?M3hkL1p1UUdWUlF5dnlKTHNucmFEY0xvcUd4WEdJcllheGtZaWJSbTVFL0xj?=
 =?utf-8?B?YU10cWhZaEpDZXVHQllpcU1yb29Bb1pCM2xRei9TNW9GQU1SRHdLTE1rK0hm?=
 =?utf-8?B?WHF6UXNsSXFLQzdQRVd1eUlmWXZNWFhKcGFuRHVHQWRVRTQ2UEIzQWkyVzhh?=
 =?utf-8?B?MG1pRnNFTkZSZW11NTdmL2tDaWpFWUozbGFtUXhZSjFEWXBnMXU1TDQreTI4?=
 =?utf-8?B?MTgvZG1wREhHY29OZ1JXVEQrc2R4MjN4M1pPT2tKeDVseXVvdjdPcHBMaFQx?=
 =?utf-8?B?aFJYZHNNbFRHRjYrejEyb2ZMQ0JBdWpIaVVVclpwNEo1YmluOW1OQ3JjZThD?=
 =?utf-8?B?SEdiR3JIU0ZVTTBuS0dxUGNkRW1sdjR2WjJ4aFd5Zm9RUWFiQUtqNTdWbGhQ?=
 =?utf-8?B?TTd0Rk83NUZUYXhwcFBld3gyMENHeStpcWRTajhhRkhoam56T3hMNCt1bVNO?=
 =?utf-8?B?cGNiM2llVzFRSFNwZXhzZnR1aDlXUjFUa21PVStIRzJ4enVMM3JtVTN6OHR1?=
 =?utf-8?B?VVhZTkJmK0c3RzJaWkRjRjRYVWw1cG04TnZubDkvVXk3TnpTVzhkM3hKR05T?=
 =?utf-8?B?M0g0QzFDUjBvRkxSZGdqVlJnMFFoK3JIbjZjOTBZeVBBVGFtRTRELzBFc0Z5?=
 =?utf-8?B?VXVYVEUwUUxGK3BrWHgvWGQrWENvLzlRSU5PeFhQaXRackNWNlNaTytPZElF?=
 =?utf-8?B?S2tnVCtwK0hBUnBRMFRkaEhnVDVBWkRVUjlta0pzTGVkc1VqNjVsaVI2UThZ?=
 =?utf-8?B?eWpvNFlqVGkyNU92S3d5ZmRZT0t6dVBJeGNMTHBjQ3JxeGtNeHVHa3BFc056?=
 =?utf-8?B?L01xZTNlZ1JOdEM1LzkyaFByU1dkU2NaSzNjdTBmN1h2SlVIeURGd3JMM1g4?=
 =?utf-8?B?QkNYZ3VscTRlRGQwcjdSVkFReU5sRjNhRGZrN281MmptNkRMd1lud2dvRmpC?=
 =?utf-8?B?MVFWV29ZWUdsYWtuVXFJbjErNEFyV1BmeGJYWWhNM0I5Q09rN0JJMGo4cXZL?=
 =?utf-8?B?dVZ5R0Fld3BWTDdoQ0NKQzMvVHZPOVptaHYrb0tKNmxVcmdacjFIbEpOQURG?=
 =?utf-8?B?WnBmemdVRFpBQ3NQa01Jd2RuNzhnLzRNRFhENjB3Y1BPM2hhbjJRL1UwRjd1?=
 =?utf-8?B?Q1V6dmJFQVZXbVJHKzYzbmtJY0ZrdWFZSnFzakZ1ZU9majRpM0hTNlVVNWNM?=
 =?utf-8?B?aUlNRVh6UWdrcTlIM05nc0tYUjV3TnUyb2JJRWdNai96dFo5RHFoVHRKSGtT?=
 =?utf-8?B?dkZRNTVjM1RSSGt6WjVPNEtKTjd3QkFic1EvVVRGUWEzdnVaUFB5TGdlK2w4?=
 =?utf-8?B?Zm4rdERrc2ZUSFE5VEZBV2xDWlAxNGc2NWZtM0xLbkJTZVEvbnRBdk1PVkgw?=
 =?utf-8?B?U3BpZm1lbHFjOStSOG95M2J4blJqZjh5Q08xUGNWSmY1bmZiRVhLV3k4VU1p?=
 =?utf-8?B?bzFiQlhBYmVXVWxCdTBON2RMRTBhM0JjRXJObDFJdkxzbGtlQWU5U2JJdVVa?=
 =?utf-8?B?bGZkdWVxZGp6MTRwTWVFRXVKT1pieVhkcGhrQXFOcHRsQ1dKZk9Cd2Y5cm5B?=
 =?utf-8?B?MFBOY1dsZjhFejB0RHJ1MW5ySStBeVEvOGNXN2pxejQ1SkVnZFFaam1tSDZW?=
 =?utf-8?B?Vm5aUUNCUGg0VTVmU1VDOEVLcWxVWDRGRDZaQzZhemMzL3hTUXpYd05KTWcz?=
 =?utf-8?B?c0p6L1p3Wk52dFMrQVdQTG95Y3N4ajg5ZUhFeCs1dUxhdG12UWRIMDMyRUsv?=
 =?utf-8?B?Z28zSnZqcnBhcjlTS0x4UGxuVWlhYjNDclNaWkNiZE5JRjRRTEplV2gzWENh?=
 =?utf-8?B?Y3hJdi9qR1BXL1hKODJsNXo4WXFxVjJLWWtVQStCSWFOWVRsMUl5Z2VCYmpY?=
 =?utf-8?B?bjZIcStiZjMyZjdyb1huNXpJVUZheTlYTnoxTFhrK1dpVzlBaEF2WUhkVlIv?=
 =?utf-8?B?Tm8rMFlNSjhPZFRYaGZyT0ZlRDQxc044bFF0eCtvWWRRVHRXdFI5dkdOQkNh?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <87DBD8E5D98E2D49B89DA07F1B9C0C2B@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b529604-eca2-4ed5-128e-08db7bda897f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 15:31:14.2552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rSoP9QI9s7GdABmBNnp6NyYWB4GjLw7LRQTsdSuFgoNhasVAVSUUunP+BAFjDWUHAMW72mVasC9DEXWbRFoTRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR84MB1361
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: Cb-ulGwAUTVoDtxPfSiQp87vCmcs-iHq
X-Proofpoint-GUID: Cb-ulGwAUTVoDtxPfSiQp87vCmcs-iHq
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=979 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJIHVuZGVyc3RhbmQgdGhlIGFwcHJvYWNoIHN1Y2ggdGhhdCB5b3UgaGF2ZSBhbHNvIGNvbnN0
cnVjdGVkIGENCj4gdXNlcnNwYWNlIGNvb2xpbmcgZGFlbW9uIHRoYXQgd2lsbCBjb25zdW1lIHRo
ZSBmYW4gYW5kIEdQSU8NCj4gaW5mb3JtYXRpb24gdG8gZHJpdmUgdGhlIGhhcmR3YXJlIG1vbml0
b3JpbmcgYW5kIHRoYXQgaXMgd2hhdCB5b3UNCj4gbWVhbiB3aGVuIHlvdSBzYXkgInRoZSBob3N0
IiB3aWxsIGRvIGl0Lg0KDQoNCg0KDQo+IFRoaXMgaXMgYSAqYmFkIGlkZWEqLg0KDQoNCg0KDQo+
IFdoaWxlIEkgY2FuJ3Qgc3RvcCB5b3Ugc2luY2UgdGhlc2UgYXJlIGluZGVlZCB1c2Vyc3BhY2Ug
aW50ZXJmYWNlcyB3ZQ0KPiBwcm92aWRlLCBJIHVyZ2UgeW91IHRvIGxvb2sgaW50byBteSBlYXJs
aWVyIHByb3Bvc2FsIHRvIHVzZSBhIHRoZXJtYWwNCj4gem9uZSB0byBtYW5hZ2UgdGhlIGNvb2xp
bmcgaW5zaWRlIHRoZSBrZXJuZWwgYW5kIGdldCByaWQgb2YgYWxsIHRoYXQNCj4gY3VzdG9tIHVz
ZXJzcGFjZS4NCg0KDQoNCg0KPiBUaGUga2VybmVsIGhhcyBhbGwgdGhhdCBpcyBuZWVkZWQgdG8g
cmVndWxhdGUgdGhlIHRoZXJtYWwgem9uZSB3aXRoDQo+IFBJRCBhbmQgb24vb2ZmIHJlZ3VsYXRp
b24uIEl0IHdpbGwgd29yayBldmVuIGlmIHRoZSB1c2Vyc3BhY2UgY3Jhc2hlcw0KPiBjb21wbGV0
ZWx5LCB3aGljaCBpcyB3aGF0IHlvdSB3YW50LiBUaGUgY29kZSBpcyByZXZpZXdlZCBieSBhIGxh
cmdlDQo+IGNvbW11bml0eSBhbmQgdmVyeSB3ZWxsIHRlc3RlZC4NCg0KDQoNCg0KPiBJIHRoaW5r
IEkgc2hvd2VkIHRoaXMgZXhhbXBsZSBiZWZvcmUgZnJvbQ0KPiBhcmNoL2FybS9ib290L2R0cy9n
ZW1pbmktZGxpbmstZG5zLTMxMy5kdHM6DQoNCg0KDQoNCj4gdGhlcm1hbC16b25lcyB7DQo+IGNo
YXNzaXMtdGhlcm1hbCB7DQo+IC8qIFBvbGwgZXZlcnkgMjAgc2Vjb25kcyAqLw0KPiBwb2xsaW5n
LWRlbGF5ID0gPDIwMDAwPjsNCj4gLyogUG9sbCBldmVyeSAybmQgc2Vjb25kIHdoZW4gY29vbGlu
ZyAqLw0KPiBwb2xsaW5nLWRlbGF5LXBhc3NpdmUgPSA8MjAwMD47DQoNCg0KDQoNCj4gdGhlcm1h
bC1zZW5zb3JzID0gPCZnNzUxPjsNCg0KDQoNCg0KPiAvKiBUcmlwcGluZyBwb2ludHMgZnJvbSB0
aGUgZmFuLnNjcmlwdCBpbiB0aGUgcm9vdGZzICovDQo+IHRyaXBzIHsNCj4gY2hhc3Npc19hbGVy
dDA6IGNoYXNzaXMtYWxlcnQwIHsNCj4gLyogQXQgNDMgZGVncmVlcyB0dXJuIG9uIGxvdyBzcGVl
ZCAqLw0KPiB0ZW1wZXJhdHVyZSA9IDw0MzAwMD47DQo+IGh5c3RlcmVzaXMgPSA8MzAwMD47DQo+
IHR5cGUgPSAiYWN0aXZlIjsNCj4gfTsNCj4gY2hhc3Npc19hbGVydDE6IGNoYXNzaXMtYWxlcnQx
IHsNCj4gLyogQXQgNDcgZGVncmVlcyB0dXJuIG9uIGhpZ2ggc3BlZWQgKi8NCj4gdGVtcGVyYXR1
cmUgPSA8NDcwMDA+Ow0KPiBoeXN0ZXJlc2lzID0gPDMwMDA+Ow0KPiB0eXBlID0gImFjdGl2ZSI7
DQo+IH07DQo+IGNoYXNzaXNfY3JpdDogY2hhc3Npcy1jcml0IHsNCj4gLyogSnVzdCBzaHV0IGRv
d24gYXQgNjAgZGVncmVlcyAqLw0KPiB0ZW1wZXJhdHVyZSA9IDw2MDAwMD47DQo+IGh5c3RlcmVz
aXMgPSA8MjAwMD47DQo+IHR5cGUgPSAiY3JpdGljYWwiOw0KPiB9Ow0KPiB9Ow0KDQoNCg0KDQo+
IGNvb2xpbmctbWFwcyB7DQo+IG1hcDAgew0KPiB0cmlwID0gPCZjaGFzc2lzX2FsZXJ0MD47DQo+
IGNvb2xpbmctZGV2aWNlID0gPCZmYW4wIDEgMT47DQo+IH07DQo+IG1hcDEgew0KPiB0cmlwID0g
PCZjaGFzc2lzX2FsZXJ0MT47DQo+IGNvb2xpbmctZGV2aWNlID0gPCZmYW4wIDIgMj47DQo+IH07
DQo+IH07DQo+IH07DQo+IH07DQoNCg0KDQoNCj4gVGhpcyB1c2VzIGEgdGhlcm1hbCBzZW5zb3Ig
YW5kIGEgZmFuIHdpdGggdHdvIHNwZWVkcy4NCg0KDQoNCg0KPiBBZGRpbmcgYSAicHJlc2VuY2Ui
IEdQSU8gdG8gdGhlIHRoZXJtYWwgem9uZSBjb3JlIHRvIGVuYWJsZSBhbmQNCj4gZGlzYWJsZSBp
dCB3aGljaCBpcyB3aGF0IHlvdXIgdXNlIGNhc2UgbmVlZHMgc2hvdWxkIGJlIHByZXR0eSB0cml2
aWFsLg0KDQoNCkdyZWV0aW5ncyBMaW51cywNCg0KQXMgYWx3YXlzIHRoYW5rIHlvdSBmb3IgeW91
ciBmZWVkYmFjayBhbmQgc3VnZ2VzdGlvbnMuIFNvcnJ5IGZvciB0aGUNCmRlbGF5ZWQgcmVzcG9u
c2UuIEkgd2lsbCBicmluZyB0aGlzIGNvbmNlcHQgdG8gbXkgdGVhbSB0byBkaXNjdXNzLg0KQSBw
b3NzaWJsZSBpc3N1ZSB3aXRoIHRoaXMgY291bGQgYmUgaG93IG91ciBjb29saW5nIHByb2ZpbGUg
dmFyaWVzDQpiYXNlZCBvbiBvcHRpb25zIHByZXNlbnQgc3VjaCBhcyBleHRyYSBESU1NUywgQ1BV
LCBzdG9yYWdlLA0KbmV0d29yayAuLi4gZXRjLg0KDQpUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMN
Cg0KDQoNCg0KDQo=
