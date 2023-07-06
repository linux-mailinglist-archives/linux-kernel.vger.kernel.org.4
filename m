Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC6749EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjGFONM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGFOMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:12:54 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C2DB;
        Thu,  6 Jul 2023 07:12:53 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366Dwq1B021584;
        Thu, 6 Jul 2023 14:12:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=831iS6f9SCotHaed91Gz4L5x57KDlOBsWJmRw3i+lAM=;
 b=HlqHzO2Nz1hHunMVLLTXerS4yNMufNj3I7hjit/F+4DyBy0XM3eyeXdjIQrduYzxMJlD
 Ed0meMQgZ3rlT+QnGmLyJyAWn6T/ZwGjB6NFBYelBGD11AJtcMgyPoj6wbAoFSSgyNWc
 jh4YAX6HFyqCw4S2MUxW5PlRvnFOh1jDii/hV9hDiRNyqOAwH/qjI2+o31333ZyfXCxE
 Gm3EgSxy+vM0xeGUfvN6hUTuYLEB2inL00Cjc1F1hACdxagWbp7ldvRUzHFBlsexOkVo
 bR4rrNWO97wPN6a4PFS0tu8MwbLWrKfu83bsFtfAkRKFX30hgUhRGZjCjXotZQmrnteV Rg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3rnxyeg43h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 14:12:34 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A1D6514793;
        Thu,  6 Jul 2023 14:12:32 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Jul 2023 02:12:16 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 6 Jul 2023 02:12:16 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 6 Jul 2023 02:12:14 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgnSw5mpDd7PfNRcXIMhLeIkigb17XQeXOo0oUIDlZ9IQGyxt5h9ziTCsJ77fMG8q3qJyzbGZjJe0zPPlpMz22cuGHBidG042qH0Ywxm3nQolq07/9pllHv3Ak8+B2ONRy4pf75hdP23/vwXXFsGm2Z1W2dh+V6ZQ8qCuma4kSupUGS7+amStN29lR8TpMgX8dDN7ttb9bD/s0IGz4ECfpKgHEkO/C+gjGokxc0/Rw4ZUopnjvXLgmZCoWsAZ9R5lqymnScUaC4UK5xEIpVT7RWpZ2Ck6JSfZSsuOWGWQqwAC6QvwOb2LIQ5eDJyUg2fwJYoShJETAIjZdJZjPQpQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=831iS6f9SCotHaed91Gz4L5x57KDlOBsWJmRw3i+lAM=;
 b=Vfh2ud2YvawYUbbsapFLURDTF/GCXKqCvzmVabHgkPxT9v6jwOpFMbu8F4nduXO8wFWrLAFZALyUajn1SVtPkVlaOuf9O8Y0iWuE914WE5Hcj5molpb0IjamRuq2TLEmWP60kf2+0fYF59DzM/VjF3nCgJq43xGpCo80Do/igGqxWxq/KaFJ1RRLk/AZoJJjxayyFlse5thIeDkIhExXxzscykUcEYr09d2cAIf3fcPxUSVA4OgCJcjTfuWUpnu6BsWcRoS5NxIOUkbGt4ahUCGeC5VPudztjPFD45JpYuUARJ6qU5yeFfHqbiEWBbs9t/JSjt+92PIS3boF113JSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::9)
 by MW4PR84MB1540.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 14:12:13 +0000
Received: from MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20ab:a8e1:4161:10]) by MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::20ab:a8e1:4161:10%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 14:12:13 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
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
Subject: Re: [PATCH v5 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Thread-Topic: [PATCH v5 1/5] dt-bindings: gpio: Add HPE GXP GPIO
Thread-Index: AQHZr3nnMgWTJWGaz0SonsnicJTD9a+sRaOAgAAvTYA=
Date:   Thu, 6 Jul 2023 14:12:12 +0000
Message-ID: <31F41D4F-D386-48B5-B941-D5B7C691280A@hpe.com>
References: <20230705194544.100370-1-nick.hawkins@hpe.com>
 <20230705194544.100370-2-nick.hawkins@hpe.com>
 <046d4744-9521-7b5d-759c-6dedbafd9205@linaro.org>
In-Reply-To: <046d4744-9521-7b5d-759c-6dedbafd9205@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.74.23061800
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1914:EE_|MW4PR84MB1540:EE_
x-ms-office365-filtering-correlation-id: a1a7cca6-89ec-4725-851e-08db7e2afebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOxcKhazXU4DJ6T1wudOcs2VLK4QHY0+rSotHiv2pZE/RIhxyK3He7H9wxf2hkKSGKQHH9ClSC7qu3XEkp1tj0l8zhhX8C0CKyJ1l4CS/JhUM/SqLzfof3AzCWibP7v77x0SvOjTfmVfUhMYwn6DyGvEIJq2a+vc+Vz4AgT6rV3uXuTl2JEv++NSb94Ib4fOi6rY38h53kijmHCyjGZuyj+CAWmKnA91HEay3t1YaCgVzJrEewbpIlcsr81P8Rv0ovrRYM+wFSJ4ygPX8sAgEGhA7tL30OFXUwm2Ewn2O4l42cY+VSrohnISVGldziq+0yLNFQ+pmbUTNqo0Cd/busMHv6QMxI4qjfs0SFY7Ywn8Tf5ysuP+0YywO9nrtyT1XnKLFYumbcN5vdXw6fxnMvdUMCvAzW2DtRa6UtUP7pwwqeceELPMSgJJ/vtN9D9h538sVVbxTa+lnBMQXApauz5McW/GN2sUgvMEF+pYtocBJw8lYdZP2jIUUMvaQblsKcuxpzRuU8Fz+xyzNkd2AN/nEK4/y2OYKj5Fl/90s2lKfOa6sLRA37JJaybfHf4EZ2+zm5f+nAZjr/2R9WRPnEBBs+3GGgyDsecYlY3D5kfNyoXCi+iUjPvufjIiKbTJZMvn59AC/U87hr0ZgbWs4WpGqJCRtnUZohZmjLcMjm4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(8936002)(2906002)(8676002)(2616005)(76116006)(5660300002)(6506007)(7416002)(186003)(4744005)(41300700001)(64756008)(921005)(122000001)(71200400001)(6486002)(82960400001)(66556008)(66446008)(91956017)(66476007)(316002)(33656002)(36756003)(66946007)(110136005)(38070700005)(478600001)(6512007)(38100700002)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QWgwbGh3SkRZRVFwQ1J0K2l3MVg4UjJxYVM1bm5obkx6MGpRNUc0eDFPOER3?=
 =?utf-8?B?NFRrKzJxN21aTy9jWmlud3ZCQm5RYWJueStoZWRZajBtU0srdExMWEkveVNQ?=
 =?utf-8?B?VkdSM1ZiM05GTTBFNERCdFQ4bHZoRkhhOEYwM25ZNkkrOGtGT09jdHBKbEJi?=
 =?utf-8?B?bFI5Wmg2TndZSVRUMGVwajZ2VlJQTUxFKzM1V0lpd3A5Q3hlektCUnhpTGVY?=
 =?utf-8?B?RzAzZ0d1dnIwU01sNTFPVmhaYjZhYVBOUFA5eGFHbUp1RkF0ZzV1VktBNW9D?=
 =?utf-8?B?cVRGK0p2RWlYSnQrdi96QXVJMEZQZVNLeXo4ZEcvZmlqMENPZldXOEVuZ2Ru?=
 =?utf-8?B?OFNoeXN5Mjh2bHJGKzJRSU1HbitSeFdvd3ZRMkMraDc4WGpNQzBWQmtXNnRU?=
 =?utf-8?B?cGVPWENTUVNza2JDemtweDJtQnYyS0hhV29yTWpuRmtBdERUcHgzN2l6SEJ4?=
 =?utf-8?B?RUdHUjkzQXBISlpDWTJ1aWlRQXorODFxRzU1REdkajFBYzR6aXA1WDg5Qkln?=
 =?utf-8?B?Sk11N1lsWXN0cUhyL1ZZS0hGckV5eEFINStXQWRCZXhFcWpoL2tSWkVFZEk1?=
 =?utf-8?B?a2NwdlJTUkI1cGpvcHdleDdVMHp1SVJRUHdGMFlwSEVISVRzR0xOSWxEbmFo?=
 =?utf-8?B?bHdzNjJMNWRkZGM0c1BlV2JXSnBVSzIya2d4OEdlVllRMHBlZUtnSEdLandD?=
 =?utf-8?B?WUMrREF4SVpCMHJUVG82d2Z3dFNObC9jOVlYYmluMHNkWGV6WkpQNElhYVpW?=
 =?utf-8?B?cVZnc05UWnR3WnBjNmhYNzI4bzlZbmd0djdhSlo1Zk9Eb0tnY0UzZktNa2JS?=
 =?utf-8?B?TnprdFQyMmREZURoY0lmZE55OUI0aTFNSVNBaG43SFR1V1dVUXJSZFliNGNN?=
 =?utf-8?B?QWpXbDJVbFc1dEVteW1FR2NFOHN1am5RbnZPT1plNkVaTXpRZ0x3ZTcxN1Rs?=
 =?utf-8?B?bVJWOE1QdDhJTE9ON1FiY0cxN05Fb2J6QU51S1ZHUnl0ZHdramdHNmdHbmM2?=
 =?utf-8?B?L3Ywai9MWUl1MGdsY0RyKzFtK2tIelV0cG92Y3B0d0FwWjFmajFlaDEwRUEv?=
 =?utf-8?B?TmVQT0Vla0JyWnFmMWZuaS9ZVGdBT1QvRjluYkUwS2JHczVCMEZQL2dScmNv?=
 =?utf-8?B?THhKSGRzZFhCU2FDM21PTWtac1ZtRDVaR1RFZHBIRlgwL0ZVZGVCWmlJdnBh?=
 =?utf-8?B?TGdJcEpDV1pOc2J0UGNqL1ZOR1ZwK21hTkpaMU9heWRBR2xPd1BEUU9nakJo?=
 =?utf-8?B?OVliZmdrZUd0aXFzL3ppSy8xT1YwS2ZES3JqSXRiUnJIUFRsQTVGeVpLM2JW?=
 =?utf-8?B?cS82UW1GV3JUaXRyckFUbll5UmphZXFOTURxTGRDUFpQYXd3NTRUY0I5ZXhk?=
 =?utf-8?B?eWd2aXY3YXFYaVJaUWUwSklrVWNHYVJSSW5CY1VGMnBZOTBiRlBKWThPVEFX?=
 =?utf-8?B?eGEzTDRKUWE2QzZpWnV1TW5LUjVnbWVpZDg3eGRPUGZpa1Z5QS9xMllSM0hY?=
 =?utf-8?B?dlJBSmZQQU9HL3BDd0tvbng4NmRDVm9yVklNY3lZTWx4WE1xdEhvNnc1RFRC?=
 =?utf-8?B?RlNoUTdyNTBrb2Y2RE1DdXZJNm1rQ1ZkaC9CbGRwQ2l2MmF1dkRuYWFOVjVV?=
 =?utf-8?B?T1V2eGNYc3BBRzRNWkl0clQ5UnE5ZDdOVFBsN01HUE5zcFIrQ242OXB3ZkRh?=
 =?utf-8?B?eFhySEwwRjZaS3pjRHZFa0I3cWlpQzhXdGJ5Z1NOT08xU0M0MEVIcTNiSHdE?=
 =?utf-8?B?dmhLSXk3OFQ3c0d0UnQ3cGFRSTdPeVpIOHJVZlhyb25mdS9Va096aGdzTG9Y?=
 =?utf-8?B?RUFDSjN0M2VSYmtEblo3cWtJZ2pRcHpNRlBkb1k0RFA1MWVsRlpJK1UxMFhL?=
 =?utf-8?B?YjQxY2NKN1h6bG1SNkFzRitsK0pYdDNJRXN3ZGEwQzY1QXNCck1KVnhQWEV0?=
 =?utf-8?B?SE1WQUdMRHNoUXVSak1kUVJSNWI2VVRNZzlZVFIvdDFsbVhkdWwzZmVJUGJT?=
 =?utf-8?B?RXZsTE0wS092N0xhRXp0VFNwdW1hTUJtcHNBV1QwNHRjZTJQYUtuZnMwbEU3?=
 =?utf-8?B?R241UVBid0Y1WS9ET3MyZldFaTVNOFEvbml5QzEyUytYSjVIUDkyMXdyQ0R4?=
 =?utf-8?B?LzAzbkpaUzkrVGxHYUNUVVVGajFMdDducFFiUmw2OHFYbEl0RjZVb1VJOTQr?=
 =?utf-8?B?RWZSNCs4QnE3RC9PMmJDeTVEZFUwcVd5MUtmRGIwbzZoUXNUQnJtMi9JZEZp?=
 =?utf-8?B?VmRneWo4RFM4T1RtWkt6SlI1T2ZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <907D8377817F3341A7652A4C4BC9F8A4@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1914.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a1a7cca6-89ec-4725-851e-08db7e2afebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 14:12:13.0047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vQ5+dyH6zdB0GyuLMZSc7rz3MpjNi/EhMeZxVMaqblftk4bVSH7KuQdqDr9+Q5moG2dl8FfD0bwb0auQIV5CDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR84MB1540
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 3kSD1fL4gfiJb3se09I12vP6ngpM0GsQ
X-Proofpoint-GUID: 3kSD1fL4gfiJb3se09I12vP6ngpM0GsQ
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_10,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 mlxlogscore=621 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060126
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R3JlZXRpbmdzIEtyenlzenRvZiwNCg0KVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suIEkgc2Vl
IHRoYXQgZHVlIHRvIGEgcGF0Y2ggY29uZmxpY3QgSQ0KcmVpbnRyb2R1Y2VkIHNvbWUgb2YgdGhl
IGFsaWdubWVudCBpc3N1ZXMgeW91IGhhZCBtZSBmaXggaW4NCmEgcHJldmlvdXMgdmVyc2lvbi4g
VGhpcyB3YXMgYSBtaXN0YWtlIGFuZCBJIHdpbGwgY29ycmVjdCB0aGlzLg0KDQo+ID4gdjU6DQo+
ID4gKlJlbW92ZWQgdXNlIG9mIGdwaW8tZ3hwIGluIGZhdm9yIG9mIGp1c3Qgc3VwcG9ydGluZw0K
PiA+IGhwZSxneHAtZ3Bpby1wbCBmb3Igbm93IGFzIHRoZSBmdWxsIGdwaW8tZ3hwIHdpbGwNCj4g
PiByZXF1aXJlIGEgbXVjaCBsYXJnZXIgcGF0Y2hzZXQNCg0KPiBCaW5kaW5ncyBkZXNjcmliZSBo
YXJkd2FyZSwgbm90IGRyaXZlcnMsIGFuZCBzaG91bGQgYmUgcmF0aGVyIGNvbXBsZXRlLg0KDQpU
aGlzIHBhdGNoIGlzIGludGVuZGVkIHRvIHN0aWxsIGNvdmVyIHRoZSBoYXJkd2FyZSBpbnRlcmZh
Y2UgYmV0d2VlbiBvdXINCkJNQyBhbmQgb3VyIENQTEQgd2hpY2ggZ2F0aGVycyBHUElPIGZvciB1
cy4gVGhlIHBhcnQgb2YgdGhlIGJpbmRpbmcgSQ0KcmVtb3ZlZCB3YXMgYSBjb21wbGV0ZWx5IHNl
cGFyYXRlIGludGVyZmFjZSB3aXRoIGRpZmZlcmVudCBtZWNoYW5pc21zDQpmb3IgcmVhZGluZyBH
UElPcy4gV2l0aCB0aGF0IHNhaWQgSSBjb3VsZCBrZWVwIHRoZXNlIHR3byBpbnRlcmZhY2VzDQpz
ZXBhcmF0ZSBpbiB5YW1sIGZpbGVzOiBIYXZpbmcgYSB5YW1sIGZvciBocGUsZ3hwLWdwaW8gYW5k
IGFub3RoZXIgZm9yDQpocGUsZ3hwLWdwaW8tcGwuIFdvdWxkIHRoaXMgYmUgYSBiZXR0ZXIgYXBw
cm9hY2g/DQoNClRoYW5rIHlvdSwNCg0KLU5pY2sgSGF3a2lucw0KDQo=
