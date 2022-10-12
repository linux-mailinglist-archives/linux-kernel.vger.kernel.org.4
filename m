Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5A35FCBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJLT5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 15:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiJLT5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 15:57:06 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE8FBCB89;
        Wed, 12 Oct 2022 12:57:05 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CJEAFx015209;
        Wed, 12 Oct 2022 19:56:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=6Tb2HGkoim4rOqnjGyiNUooyCAeszbcfYsjzXlAbYjY=;
 b=fk+rJIBAPT4wH9BXTg2h6f0rPQ9n+85UM/dBmNHEhLOtVhAW0GeFKNe0YChbk3QY70ha
 B6XZJeMP81RWoJyehDAtw11K9pkTrGWmIIb7XcWiOcX6b4wnr3mwhrWZOASDINp2EDBr
 xfOb/AA7T4LohU7/O+5PCnwlzaOu0B4JtW/Dzo2Yquf/LS2yr8ey3CkKqHFyavT9Vvzt
 3C56kgYZQUA0UexPqoykpsakiKOBPFvI0Ruybd/Yv6uOryIWFvX6ho60luM6KjPR3CuF
 en9/iLCfEIgBFo+/vSO9rpc0ngs4Q+oiaYX+3SKI0pDuCUJlg5E9D+0tpizHlNoWUSLX pA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3k63j808aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Oct 2022 19:56:45 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 0B3C380470B;
        Wed, 12 Oct 2022 19:56:42 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 12 Oct 2022 07:56:28 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 12 Oct 2022 07:56:28 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 12 Oct 2022 07:56:28 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wc1KCW6C/62AVtmMuFtoYPcZtfA/7XkS2R3iXiaHe21mVIqXcyi/9dNIX3WWX2EwUYyL1UqiWottM8coA0ZP9JdvzGT3LmSqgiTagihU8wITgQEHCb2pGf61dMXMgXuPtBMK03Bk/pRPsg7w4ynvjGGsVncmuUv49i6AFJWL9xspdw5BE1Xha0GR8U6vLMC2xtlMiE1kT/ZzoZXLQb930+p+6/Oyv53LdUV2ArWRuzuwBgc2LQQnuGaqWIXfysbWK2MV3viG5T4W83lSI9Qv5k/LMCr5RoZEudLJPp44QbR6iv+YM+6fetCUBqwzErMaD96Md03fdS5z2yTChCO2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Tb2HGkoim4rOqnjGyiNUooyCAeszbcfYsjzXlAbYjY=;
 b=RdKg0nZfC6Ph/oxFdbY+C/uxl7u73Go6zBLqfWe3INLhZRcWoNpZUNKSOpL7wBEv4LtpoCijalnciYfo8rIbwRFv6a/LlBSDi8uBs1mbd2/0xTIXnohlPdcMoEHgybXkJIc1zljORG2IFzJ5K7BwWqFzD8FkcJAPMVuO+Ex8Qt5g+ZZrEwYjbev39ut1uUbDqkPbkBYfGg0qxznBu+p7elLuppn+tCJ6e0W356sTWRfhq7OAGXmHlD31X5P05hsem29Xhxg1ZBth1RqdfJ3Hkb5Dir3AxLlhiWr9SclJFOAiDAXyl2/KWv6WyNmYXDX2G1lwnBLSwgGrwCwxQeYYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1431.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.31; Wed, 12 Oct
 2022 19:56:26 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::f4f4:4c43:9c7c:333c%9]) with mapi id 15.20.5709.022; Wed, 12 Oct 2022
 19:56:26 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Topic: [PATCH v1 2/5] dt-bindings: soc: hpe: Add hpe,gxp-plreg
Thread-Index: AQHY3aMniIVqm01b3kyrrbcxm5Jgf64JpGIAgAGGr3A=
Date:   Wed, 12 Oct 2022 19:56:26 +0000
Message-ID: <DM4PR84MB192795B45639710259E9B19D88229@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
 <20221011185525.94210-3-nick.hawkins@hpe.com>
 <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+xb2Ltfne4mQMXQAde-eHS7TsO73YZ-vhE7nK1Z_M0gw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1431:EE_
x-ms-office365-filtering-correlation-id: b0526edf-2c2f-4b63-87f8-08daac8bd910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SjkxMmtmNE+n5zGt34dJV38L7yfgyE8TngMEzDvsqpd+DZLgfq/phU/eLvoIj+WH0JYrZp2zBGEgmhWnN+FcNVeNpWIHkFJQ8PjQiSJz32Xr2HDjfhZa6gN65xyMFYuFVX+MRJOAagMVOZCoZQ+HDy5RqN+udh5He+1ENJVyiFOgWfB6kD28q+rzsX6N1+8dfoqwuM6q9fljITK6B/IOLosWcigC48brK87f/KZEDC6CvhLBTwJMMEs+e1QwZQdwzqhpNr0qqziCXtDHLooOQgbdsSR23evEB+yaFT0QdmftpSkH4HctYYGo0anUqL6rRv75LIV8mzL0Cp64m6wdRnutInXSjQLadOOOISnm+HiLIVitBx8XFYg/1+9mRhfxotmwUlc1jJ9kOCJuczjKeAPIaD81SItoauvOrfOpZ2Rcub/L++QTUAsaxF4CShIluf0IiYyeoEcvhiPRnf0HsEwXjjOcAI9bFTPX6/UuwvGir0xwmKulOox+mUMy6zvFUmQEIPYSDFCdrIrJ1d6bKyNafdec6XMLpLdMlTYeLcRPMbBtovQKKO/ca3bY8mY3oTLcEiRL1MB8j1tMhXc1ypD1vhErtdsfWC4XTr4IVRAIrkZSL+JLUhJn4WSoSas7uDGSTQPsMAHoNEQQKkZDic9ksiIFzkGXrnlfqFzUl4JEd/YNUJJEla40U+pukPA56kszEM0b08Ir7ZqsftTzQ5yRxw8v8A1ZHDTGsnlDNzFAgB8VglR9o9QrtepDSAIJb9CvDnGiBGYkkpuTnJ6rLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199015)(66946007)(186003)(66446008)(478600001)(66556008)(2906002)(38070700005)(38100700002)(64756008)(66476007)(82960400001)(7696005)(8676002)(6506007)(122000001)(55236004)(4326008)(26005)(76116006)(4744005)(316002)(5660300002)(54906003)(86362001)(33656002)(9686003)(55016003)(52536014)(41300700001)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R292M2tCWVk3U0packpNQUdPb3BnTVhuQmlBY0RTWEhYblhUdk5nVzRYV0xt?=
 =?utf-8?B?TE5KZzBVLzBLSXJ5bGwwUmhwM0lDdmRVaTBMaW53V0NSMDNWOWl0NENrTVVv?=
 =?utf-8?B?RDU1RUZGMXI3TTVaMkQwdEdGRzVjS3BCWDR3MlBWczdWZVJ1S0NWc3NnQmlG?=
 =?utf-8?B?Uk1PVGhjSEVQZGV2bnlqbzVoSEI4TmRBN1lWZ3EzbzB3djRsb2hxQjhIVS8r?=
 =?utf-8?B?NncreE9xbEFlSlVISkpXRCsyLzdmMCt0dGl5VEJBRUk3K3BMT3hQQzJxZEN4?=
 =?utf-8?B?SzNjREg2Y0I5bTFpRDVIcE0xNVRBYnhFYnNzRm9lRTN0c3lrM0pjSUcyc2NJ?=
 =?utf-8?B?VDROdDlYM1dmME80QzAyS1l6ZENQL2d2NU9scFAzZlZwcXpNTG5CTTBJZk0y?=
 =?utf-8?B?NVJKUHRWTG82L05hbEkwOEVXaHNlay9zME1EZ2V0bC9DaEFRN0ptdmZpV0xq?=
 =?utf-8?B?MEZQZ1IxTGR6L1NacEJFWU1lNUtncE5LZHk3bGZCS21XZThBL21CVDVscm5O?=
 =?utf-8?B?dWcxa3haZ2FFUVpZNkNzMGs0aGNwd1JjWnBkSkx4WHFVVmFuWndYeU4wOHZp?=
 =?utf-8?B?bjJLVG5EelRWY05IK1J2dk44bDBmTXBYZVNsSWxWRXJmM3dKb0RadGJHQ05w?=
 =?utf-8?B?ZjJDV1BrSThjVDE1ZXdsRFlva1padnp1NzlVY1hNRTNzTThPbC9SdjVsYjFP?=
 =?utf-8?B?NFV5dnV1SEkzQk9mdGVSV3QwOU9DT1hQeW5yeTdWZmp4U3ZRUnlmaFk5T2lt?=
 =?utf-8?B?TEV6c0hPak5HeUVhbGFyMTVnZm9EQ2FJUW44ZHZxbE40L05PRU9vbEtqdWdU?=
 =?utf-8?B?Wm9CQ1JucDQwSWQ5VVd0K2RqVGpZN2Z0K3ozTk9UQmFZaXFibUhHR2pNeWIw?=
 =?utf-8?B?TGVQQ0lyY1grTDhNbkdUMEQ2KzV2c1g5N1E0YUhUWDBwUnhyeHo4ODR3QzBJ?=
 =?utf-8?B?YWtVODh5V1hXSHNXNkRCMlVnOWZ5RVh4cFdtWVRsODIxNGJnTUJvd3ZOUzVT?=
 =?utf-8?B?OFNYbVNYK2RFYm1sV0RYdWdRejYyUGdRTld4T0kweW13V0ppMG5OaVBRSXhh?=
 =?utf-8?B?RG9aVEsvcEZnYW9aQWZORXdTYWRXcjRxWjRNOXRMcDY2ZVFxbFBDNnEyYU5U?=
 =?utf-8?B?VmVjZDkxMVFrUVJOdUIvQWdROWRGc1ovVjdRZFFKeWVFdEtrL1pwMVBCNUpx?=
 =?utf-8?B?cStLbHBMRUtwMjRnNWJCTVZLb2s2TEtWWUEvbnd2YWpmU0QzUVhkdWpHcnJk?=
 =?utf-8?B?RWdIS2kzbHcrUGxIYUNUd2N5b1Vqemd2TWx5Rno3WmVqRmJnM2pmK1kvUVRI?=
 =?utf-8?B?cGhxZHFNY3BhdGJzeE5xSmI5eU51akgyNFFGVTV2a0JXY2x3dkNkZzJ0R0pj?=
 =?utf-8?B?L2ZVN3ArVkcwNVlFOG9OR0xzQnMwRlhtUEllMVd4Z3p3Vi8zL2hQa3dFZnlE?=
 =?utf-8?B?RVNJYitrazd4OUZYMHFMSzVNdE9vSzVEVHNHSkpuUXRnM0x5RnJTZTcxOU9F?=
 =?utf-8?B?VE1TcWZCTlp2SWZnWll6QmJCMVhZNzlSd3FNME4wUXNVQ013bGlrcEQ2ZDRX?=
 =?utf-8?B?WWh3OCtRWjRBa1V5K2dSNHEwdjVXdUY1QVdweTBhSTVFQ2dUM2RiUU5IcitS?=
 =?utf-8?B?UUxyQ0ZBNUxQVDZMMWNta1FFYk5POEVhVWdybXljc3ZKSnFZOWFBLzZXNWEv?=
 =?utf-8?B?OVhobVE1SXJHK3hZNnYrTWdBT3ZVa2FXUnZ4dUhpTnQ5N1M4dU1CMzBYU0tt?=
 =?utf-8?B?cUU4Q20yQnpKY1RIcThvUVJpK25MVEwzSFJjaDRoQjEzcUUvNmh4YmR6RFZt?=
 =?utf-8?B?akZwRWZRQWNFS3V1S1dpS1g2TEVZdk9GWThPcmc5NGlwYVI0U2NkN3JNYzMw?=
 =?utf-8?B?bURtbTA1Uks0eGl0NnppV2lJcDhhRHJaVW9JWVplMHYxWDFQZzlWRWZIQVpD?=
 =?utf-8?B?SzNVU1lVTFlqaWltV0ZzTTVhbHM3RVZrUStmRG0rYnlzV21KNWNtd1lWTnJn?=
 =?utf-8?B?QUl4bnNJZUtuRkNhSUdkOWtjMXZzSDFNdXZWMXJKeU5IbXVDOStMd3JCa3R2?=
 =?utf-8?B?WDlnSTJUYThFUHk5VkVqQWdXR21KZk90RmFkaFBBelIzeFJPWm9welIwUm9M?=
 =?utf-8?Q?MA8V6qD57mG/Eg1y0bU4gzJG4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b0526edf-2c2f-4b63-87f8-08daac8bd910
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2022 19:56:26.8048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2roDMDR3ONuY4eNYGYm8PLGA2OYX7RoOGGnCKen9QHuzYONNE6rf+C5NwAWk9ONBv/po70khfl9t3Z9eu4qnhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1431
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: BBxmWMB5XZmAeFa0vsxyyv8lMCeTYwTg
X-Proofpoint-ORIG-GUID: BBxmWMB5XZmAeFa0vsxyyv8lMCeTYwTg
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_09,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120127
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgIGNwbGRAMWU3ODkwMDAgew0KPiA+
ICsgICAgICBjb21wYXRpYmxlID0gImhwZSxneHAtcGxyZWciLCAic2ltcGxlLW1mZCIsICJzeXNj
b24iOw0KPiA+ICsgICAgICByZWcgPSA8MHgxZTc4OTAwMCAweDEwMDA+Ow0KPiA+ICsgICAgICBm
YW4xIHsNCj4gPiArICAgICAgICBiaXQgPSA8MHgwMT47DQo+ID4gKyAgICAgICAgaW5zdCA9IDww
eDI3PjsNCj4gPiArICAgICAgICBpZCA9IDwweDJCPjsNCg0KPiBUaGVzZSBwcm9wZXJ0eSBuYW1l
cyBhcmUgd2F5IHRvbyBnZW5lcmljIGZvciBkZXZpY2Ugc3BlY2lmaWMgcHJvcGVydGllcy4gVGhl
cmUgaXMgemVybyBkZXNjcmlwdGlvbiBvZiB3aGF0IHRoZSBoL3cgZG9lcyBhbmQgYW55IG9mIHRo
ZXNlIGNoaWxkIG5vZGVzIHRvIGdpdmUgYW55IGFkdmljZSBvbiBkaXJlY3Rpb24uIEhvd2V2ZXIs
IGEgbm9kZSBwZXIgcmVnaXN0ZXIgb3IgcmVnaXN0ZXIgZmllbGQgaXMgZ2VuZXJhbGx5IHRoZSB3
cm9uZyBkaXJlY3Rpb24uDQoNClRoYW5rIHlvdSBmb3IgeW91ciB2YWx1ZWQgZmVlZGJhY2suIFRo
ZSBnb2FsIEkgd2FzIHRyeWluZyB0byBhY2hpZXZlIGhlcmUgd2FzIG1ha2luZyBvdXIgcHJvZ3Jh
bW1hYmxlIGxvZ2ljIHJlZ2lzdGVyIGRyaXZlciBpbnRlcmZhY2UgaW4gYSBnZW5lcmljIHdheSBh
Y3Jvc3MgbXVsdGlwbGUgcGxhdGZvcm1zIGJhc2VkIG9uIGlucHV0cyB3ZSBwcm92aWRlIHdpdGgg
dGhlIC5kdHMgZmlsZSBmb3IgZWFjaCBwbGF0Zm9ybS4gRm9yIGluc3RhbmNlIGlmIHdlIHdhbnQg
dG8gcmVhZCB0aGUgZmFuIDEgaW5zdGFsbCBzdGF0dXMgb24gcGxhdGZvcm0gWCBpdCB3b3VsZCBi
ZSByZWFkaW5nIGJpdCAweDAxIG9mIGJ5dGUgMHgyNyB3aGVyZSBhcyBvbiBwbGF0Zm9ybSBZIGl0
IGNvdWxkIGJlIGJpdCAweDAyIG9mIGJ5dGUgMHgxNi4gSXMgdGhlcmUgYSBmb3JtYXQgeW91IHdv
dWxkIHJlY29tbWVuZCB0aGF0IEkgY2FuIGFkaGVyZSB0b28/DQoNClRoYW5rcyENCg0KLU5pY2sg
SGF3a2lucw0K
