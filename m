Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41F56F07BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 16:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbjD0OyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjD0OyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:54:15 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696911B8;
        Thu, 27 Apr 2023 07:54:14 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RDaI1C032070;
        Thu, 27 Apr 2023 14:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=+22X9iUPW39IiNaX2MGvDaHByUZ+6j4eFANB4YmGesE=;
 b=AZpF+nU3t/30rQnwTTL7ZgLk9lSoiZdxvETp6FQbFIDP38TdzFFpr15DDsZ+RGB/qcK/
 LdrRzgz/pv9NhB+TlDmA0BaJIJuVKP+x+Krgaabe4J5FfkumQlLuh1mqBH3UQGvO9d8/
 Ap3KRE7X24plhLQPoNhh20O+miBwM7bKslh+tMkE42YcpfFLyPYLWhLILQbgUEQgOPNq
 qAmSn8PNFqJcJDi65w7r8p3MyZ8v7X8XzVY2xVdghch+8rG7sUIXUhT9dAIR6k86Wn6d
 LxY0m0kUr2tju+D+tTmCuOUAxvHPpXSYjb+3RJvshGIzUn0LxLLSPVjq+pgMfjTH20vH VA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3q7t33rvpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 14:53:23 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 1DEA9801AE6;
        Thu, 27 Apr 2023 14:53:22 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 02:53:10 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 27 Apr 2023 02:53:10 -1200
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 27 Apr 2023 02:53:10 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHaj8LH/yQ4Ilsk25erkSVyWHTUKVdF2lAxwYwAsC6q8I1vxISKFkG8yxS6qxL+uIjB18jmQicl+Kenm9YovHDA4F94X7FHOQPeACfpwlTvKZ0HEgZGWitkDoUQ+5pdCm8svRkbDES90y8uJhuMpmscvxXbf9L4IGbriwIkjvEq/mj4+jKbQLuSsi1zVdlabBowfBfUyMgWdk+1KswnPWwbowAZBVyHhe2kvp6a/tTozh7m3Y4jF0AFqUi9KMMtuyTCNHu/XXJbj1AwpPCcfBDdkcuNWc2N1a4GqDgqhPF0B3nf6+kmRDFySz8DAu0mFTvgslnvlnlKLiHYxrCBYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+22X9iUPW39IiNaX2MGvDaHByUZ+6j4eFANB4YmGesE=;
 b=ZIwJiA7BX9jywRc/cBiL0ygXJqC7GIkreZTukhTizUNoSbVOQfuEuaTpTyhzAk2L/OvKk4nEZqJy6s4Cj9+k4zH6LGSrlgv2XGBQOg7EUZILXXPnHCIz7S5wL0d5Q+4UbjHUW8F6pHYrJKpwLPUhGLcGl+2Z9C7Gc3zjIgnSNqeY4EncNIqgi17dICCTX+MAZ8Ks8IL+qODAvrIvF/zw40w4nCAELPlyMzS+SSorzJ/0q2apex5VYlYe/tdvVxw0Kifa8El+SrxCTeGz1Wh2zoryJmvNBpqDIePK0qKCJNQf1NDMX2vNdKgCyHb29Q198w6ZHHG9wao2y3+i2Sh0zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1809.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 14:53:08 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%7]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 14:53:07 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v1 1/9] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZcgrpODxMvy9ha06K9TX/iHoHda8xT0MAgA36FZA=
Date:   Thu, 27 Apr 2023 14:53:07 +0000
Message-ID: <DM4PR84MB1927C9D3C5CC5B001713CE57886A9@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230418152824.110823-1-nick.hawkins@hpe.com>
 <20230418152824.110823-2-nick.hawkins@hpe.com>
 <c27e07d2-8eb1-16a8-4619-280967fc0de9@roeck-us.net>
In-Reply-To: <c27e07d2-8eb1-16a8-4619-280967fc0de9@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1809:EE_
x-ms-office365-filtering-correlation-id: dcf09345-63a8-4bea-46a9-08db472f1cfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YeNo9jrfTXo0rD2WaKGfay84u+n8oVsZUCODcbmlqvIG4AbWCSdKiMdKHjrirS7wuwiXcP2ST6cY+39LEoSfpTnIVXqb8+a2MkxgCht90HJjaVtQ82iF1NTGcgooI2ciB3Nt8EngoHvs1UHwDVdJjzN6yFhNwKukwCwUBbbCxUTpiC5oqFqQ9khl1Z5hgnENSIiSnY+ORraZbu1XUMXf8Ai1VsTJhn5XnjthxhFOt6OutcRynWxXATEELiHnNBD1WIdNTVlbm9j5FsYG7R9s6nsPQF6epKQ62Bej53YtSKVpyZNgY1d+h3dZV5rQ4B4bl3isQ+Dx6SzZA+crRraJf4FlUia1NwjhPOTdFgyZFtLumEcXWryg/g2QUk8wS+I+DDwVh2m5WpR0MZGkFJki6GKjxuU2MW6arSCPlhk+2kB7HiRX3t2MG6PsqeUrWms+J9o9YYI6tKQblJ5lqsZgj9whvAdZZLvQAS2PukJxioFfHiwRzgXnJuruV0XvWyYoa0pkQRCmUkxBXvvMWqVb6pArGCcgls6/h8djYzqXIXuyAm2Pn6IVd4Z92CuPp+kCLtlkABh7dNYkXm3lVP/2yC3l4zdv47/V4XK/C0Fv6ftVLiyGbDZ29CzO/oBz/rNaC2NOpj8RtduHffCPoinBKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(366004)(39860400002)(451199021)(110136005)(86362001)(186003)(71200400001)(33656002)(55016003)(478600001)(6506007)(26005)(55236004)(9686003)(7696005)(8676002)(122000001)(8936002)(38100700002)(921005)(41300700001)(38070700005)(2906002)(4744005)(7416002)(5660300002)(52536014)(64756008)(66476007)(66446008)(66556008)(316002)(76116006)(66946007)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkZETnNYdTUwUVdJZ1pmNTNxSG8raDJPRlVLcUxrYjBkaTVUWW9ZNmNjUkNl?=
 =?utf-8?B?MU1UWHVyS043LytiZGJyNkNITkNsMjd6b0VRQWJIYThNUjVhRXBtZ2w5MDI5?=
 =?utf-8?B?NVNlK3F4R2lJUCs4bDJ3dTVJMGVGbVh0YlBCZnZ1SStJNnhlYk1tbkRUWTIr?=
 =?utf-8?B?MVl1UUo0THB1Wm95NERnVHBxQUdCd0o3QVh4ZEMzUVdWMkZmY3FUbnMwZXA4?=
 =?utf-8?B?QnhXMEkvQkpBQytJYTU2TkZES1dOOHNHc25vZ0RmUlVHOXlEZHhRa2lxbXFV?=
 =?utf-8?B?SnBDSGFheEkxUVZmcE1NSko5S3ZVNlg3NlMyR0RkUmtoeDd5NUZKOUZaQytr?=
 =?utf-8?B?T3ZwaW9QZUdOWTB1c2VkTTRaNFk4azVac1lQTVZHbitrWTlWWVR2T1Y2dVh4?=
 =?utf-8?B?TUtGU3ZKWE1kZ24xUzBpYTZGalhjSGl1WnZ2c1ZKeWtUNkJNUnVKellLUmFS?=
 =?utf-8?B?d2tqWG1FM0pzQVRWQnJMbXo0VjZkQW1OQXRTdE5xUkZzVyt6bzBrZHVhamk4?=
 =?utf-8?B?UW1aaXNaL0YvekFIbVBTRFhHSEV2ZE14SjhRSmQrYXVSM0txK0JRWjBxWUVX?=
 =?utf-8?B?eURQTjA2L0Q4T2gvKzRnU2pKVi9DMitQdnZYTDBoMGg3THJLU2lTL2YzV3VT?=
 =?utf-8?B?S3BTbE03T1hCZTh6VlBFWURlUy8xL01SYlJuZkRGY2JlOEhIUUQ3RDErbmVk?=
 =?utf-8?B?eW5jMjZuejZjRWltOFgxeWdrMWdrNVNMRHJzZWgzSVJZbWYzZjQ3YjFKQURQ?=
 =?utf-8?B?ZGRKYXBRVGM3cDJ2MWkvOHNiWXNwbzhoSWlKSTc2dHAxT0NwVFdsYTRUaGZj?=
 =?utf-8?B?UHBuUklmME4xcWJQa25XL3FaZGNuRXNXWnJmWWROMGdGYlpNNWtpUnJHM210?=
 =?utf-8?B?ZnJpdHBVcDVZckNySm4ra2dNOXAzSEd6RFNYUVJaVjVxMVlXWnBkRjhhelVz?=
 =?utf-8?B?UFA2UTFvaVlVVkxaSVdxNEMvaTFNRHVaNTRmV0ZrWi9hS3lQUlhkamRMcTNy?=
 =?utf-8?B?SHZ4RmM5Qll1U083c0JYRURvZ3VjZHpLQ0c5UTZ3ZGZnZkFFbU9yRWRWOHln?=
 =?utf-8?B?a2l2N1FpR1ZQdFVrQmJ6OXNyeGRnL1VjdTdBKzRvaFpRK1VyeU9sbHJua09a?=
 =?utf-8?B?UTVNUGYwUUdpTUtmVmU2YS9DY2M3VHQ5QVVqVVVWNlhYUGpFdWlkZzJXS3pP?=
 =?utf-8?B?bjZkZlJFYlBCdWRSMkVoL3pCQVl2cVVXMzNoQlJUTHNIelRZY2ZGdy82Wlhz?=
 =?utf-8?B?alVPQmJwNUl2VkF3YjUxOE55ejY4eVRvckJkaFIvUkdLRnRvSjJMSmk1RHcv?=
 =?utf-8?B?WUh0Ykd5bWh0LzR0RXA2eHg0TFNPeWZTbVk1Ni9XVGtTazJCS2o2T0VMZnVt?=
 =?utf-8?B?NUpaemtjSTNyakNVQ1BMeFlWUWNxeVM0dlUrYWV4cldVaC84bzhyM1NreTRX?=
 =?utf-8?B?K3JrdUtGUkZZaXlTbjdZNGk4WXJ5bGxXbXFUWHVOM0R0NGVha1N3Q1BSY3N5?=
 =?utf-8?B?UVF5YkxpbklkUnJUQzlxRmdXT29zb3VMclcrNjRJbjBGd3h6RzQ1eWNXbUFy?=
 =?utf-8?B?ajNqbGVYL1dxMFhZMTA0NHlrMHpJTDlmL3orYkF5VzYwaEsvbWw4U1psSnBy?=
 =?utf-8?B?eUsxZ2hCV00wWCtmaDBmemV5eVVBR3kyOFhwUW05UUxDdEJFM1NxT2xiSG5S?=
 =?utf-8?B?djZDSmJSb3lGR2s4eXpxeDJZTHlCZzMwamUvUkJIM2QxenptcmRsSW8zb0VP?=
 =?utf-8?B?M3Z0MG1oRlM5SkgvcXRiTDNRc3JZL29OV1ZNVDMxVlgveXNGZXEyODI5Si8x?=
 =?utf-8?B?eS85ZU54VHNsZWplTVNSaW92OUcyV3M5d0hDWk5hTlJtc3Rmc1FGNndFQmtO?=
 =?utf-8?B?V0xDeHByQ1VJYjNTT0s5L3pSZUIvL1dBNU9RTUs1alVXcHRXR2JVSXdqQ0VB?=
 =?utf-8?B?dTlnaFdUWVZuUk5NUkNxVjJqZGlNOXU3RjY3SG9zSW9OZXZwUEU0dktkZUk2?=
 =?utf-8?B?WFphaEp1SGhqM2VPZVYweFNsSHJoZW1xNmdweURoN00vdVJyelpkTXRXSitL?=
 =?utf-8?B?OFQ3SmltelNYNnFBcFBxM1pmTXZJYk9SZnZMR0VRVmdDWDNzZWI5RlhITkph?=
 =?utf-8?Q?4oHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf09345-63a8-4bea-46a9-08db472f1cfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2023 14:53:07.8221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uhxlB2qtjtnyUCkRnlqkauDnQdn1+AYhqNbjElktW5paWHGXSWV1mrAl3y7p5z3rP7johQTEU4sm0KYOfovjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1809
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: sPhKrJ3fGZk1Ysp8eQzwPqM1JdtSeW9M
X-Proofpoint-GUID: sPhKrJ3fGZk1Ysp8eQzwPqM1JdtSeW9M
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=684 spamscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304270129
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCg0KPiBUaGlzIGlzIG5vdCBpbmZvcm1hdGlvbiB3aGljaCBzaG91bGQgYmUgcmVwb3J0ZWQg
dGhyb3VnaCBhIGdwaW8gZHJpdmVyLg0KPiBCZXNpZGVzLCB0aGUgZnVuY3Rpb25zIGRvbid0IGV4
aXN0IGF0IHRoaXMgcG9pbnQgaW4gdGhlIHNlcmllcywNCj4gYW5kIHRoZXJlIHNob3VsZCBiZSBu
byBleHRlcm4gZGVjbGFyYXRpb25zIGluIHNvdXJjZSBmaWxlcy4NCg0KPiBJZiB5b3Ugd2FudCB0
byBtb2RlbCBmYW4gb3IgcHN1IGluZm9ybWF0aW9uIHRocm91Z2ggZ3BpbywgZHJvcA0KPiB0aGUg
aHdtb24gZHJpdmVycyBhbmQgaW1wbGVtZW50IHJlYWRpbmcgdGhlIHN0YXR1cyBoZXJlLCB0aGVu
IHVzZQ0KPiB0aGUgZXhpc3RpbmcgZ3Bpby1mYW4gaHdtb24gZHJpdmVyIHRvIHJlcG9ydCBpdCBp
biB0aGUgaHdtb24gc3Vic3lzdGVtLg0KDQpUaGFuayB5b3UgZm9yIHRoZSBmZWVkYmFjayBHdWVu
dGVyLA0KDQpJIHNlZSBob3cgaXQgaXMgcG9zc2libGUgdG8gdXNlIGdwaW8tZmFuIGZvciB0aGUg
ZmFuLiBBcyBmb3IgdGhlIGd4cC1wc3UNCkh3bW9uIGRyaXZlciBjYW4gSSBtb2RlbCB0aGUgZ3Bp
by1mYW4gZHJpdmVyIHRvIGdldCB0aGUgbmVjZXNzYXJ5DQpncGlvIGluZm9ybWF0aW9uIGZvciBw
b3dlciBzdXBwbGllcz8NCg0KLU5pY2sgSGF3a2lucw0K
