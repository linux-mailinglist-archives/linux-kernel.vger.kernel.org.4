Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98C566834C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbjALUHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbjALUEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:04:36 -0500
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BBA1CB0C;
        Thu, 12 Jan 2023 12:01:56 -0800 (PST)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CJl5jd013906;
        Thu, 12 Jan 2023 19:58:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=EwwL0y1ielmX6IcbHFzKnKElHs4HsXPuM60tvVujXx8=;
 b=pWxwAFyb0QEevvyBHoaKhamKKSAWRmZiQiRelIPFbiZ6tcL0Rlo+V0/M5K2V14HM1zam
 9NU6Q23TPYqJ56A9sGe9JEd8ebq0CVpB7O3CflkQ4z0SxyFgmkMZSZSYF+sf85eGjn4Q
 DyVrt7jVzlNRgfPFn7kOfXsSOu2hUB7ENPeS/Sywyhxl/bA3LisO0DhV9Pke9tVdnEkt
 wZRuh/8dwlkOgjyx8k3ou25jjXlE/5Eb1/gZwA+zg9ezIkTwIlzyyOODdxqjtMroiPbt
 quOam+YXgxfRAtmtMqbDSc7G2JrLVafwYLy9nSN7tJys2SRpxflf32d++KMM9Po/MKWR tg== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3n2rnp81x4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Jan 2023 19:58:27 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 5B322310C9;
        Thu, 12 Jan 2023 19:58:25 +0000 (UTC)
Received: from p1wg14923.americas.hpqcorp.net (10.119.18.111) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 07:58:25 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Thu, 12 Jan 2023 07:58:25 -1200
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 12 Jan 2023 19:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2wtmjCEypmzTMW+zkMYmAeKNGGqoDSazRmzTEAtGf8bMC5wjIiCAaqfo3BSG/gY+RNrDpIgqmaAGQ/yt2aGfgAkrTkRlWaezjChNETmUoDNii8bYLNUMZWc2AEBDBelxl5PAS2Qx6WzJIwfx2mdI5hT99Qm2XcGw9eg3hZzFFXFbG6kWddS36PYb5HPHtRJyccLSXC36pHb/g60XVTcIHz5q040liB4hL4TrSfBmywgLMMvBgnrHXjbYr9fmmLLEx86cFNSZ/bxncx6rt5cZ7D80RZtmEyfu8haFIXthmmhawHoIYdOq1EpbQl2GIt+K8Y0Z5ZS6sKxfGQJPxOlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwwL0y1ielmX6IcbHFzKnKElHs4HsXPuM60tvVujXx8=;
 b=Qhg5BvIcjUkGPK+KtWjSawUFzBaOPfF8PJqBxS9jxyetcRZeyrb/7sf061AAvV0R4JIR1rWV/e7UuOnlJHfHY7YUlne7qb42P2mNOj3pBGgZgb3h9Bvdwj8Oasb3IdEdm+IUibqg0RGCOJfftQpWeNQwxs8PX/1ygrTGh+vnxBHWinaouGYpPsVc7VQYWN6loSrn2RMewSh8tmw1/gjKNlTBCNnxT0Ko9YPXyl/Z6s7k4gGf0rXbk+kqLZS4xuASp0VLtgJsMUK3J5Ul+GR25TvgB54Lw4+Om4fVEo0+fkuhCP0J/p/7ISFz9/aEBoFQNHIn3NJkE8TwCJofh641jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 MW5PR84MB1819.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Thu, 12 Jan
 2023 19:58:23 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de12:a5c2:5c71:6b87]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::de12:a5c2:5c71:6b87%6]) with mapi id 15.20.5986.018; Thu, 12 Jan 2023
 19:58:23 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Thread-Topic: [PATCH v4 3/5] ARM: dts: add GXP Support for fans and SPI
Thread-Index: AQHZH7Ntz67eM5qHOEa31meIwV2aT66a49yA//+whoCAAGpOAP//3cYA
Date:   Thu, 12 Jan 2023 19:58:23 +0000
Message-ID: <1E4BFECB-D29A-43CE-A521-F2A81939202F@hpe.com>
References: <20230103203654.59322-1-nick.hawkins@hpe.com>
 <20230103203654.59322-4-nick.hawkins@hpe.com>
 <5ad677f3-2cbc-4ba0-bd48-2f832a72fb28@app.fastmail.com>
 <E2B35D8A-B8A6-40C1-8AC9-46E6C2CAE656@hpe.com>
 <6bae68eb-866f-4b78-b4db-e3154feec28e@app.fastmail.com>
In-Reply-To: <6bae68eb-866f-4b78-b4db-e3154feec28e@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.69.23010700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|MW5PR84MB1819:EE_
x-ms-office365-filtering-correlation-id: 97effea8-1663-4531-4533-08daf4d75cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MamtSopjgUaWYk2VrU/1ZxTIFOaxo1evFVSviNZdO7xVGwt3oRjXZEH4IOWa0yYdUUnKjX52hrABvS4Q+bywcdER6vTNoLf/D+cHo4x/fXXrd9u9j2LckGsaJ6KN3CHeK8TWvi9l/uW5xK8rYdDERTtamA2F+Sgey8LXuEl7L1tH31VtJgdpvZU2hOhSLTzPt8JgJ+BsAnXbcfZdR0krczkeFW4yn3PKtWs6L971lNM04wT2LORuCJXk4zJnpiv1IOao2pGFAJp1/ZhVjIL3Tb7dvbvzwS0lu6wJNbiTMahxaVtSVDJwB/m35ocZAsiCYiJZ+v8u3CgdhIjgol8mQqKABbS530GdkQp47sBhN9jKxl5UOhCyutcH2hVmE4lyBxGxuFnJXZHIGB/DGCTgvrAHtbLX/OZyVEf3gpDDmcnCEWNH8CZGzJwXP/HgmQclGPgkzgr6pmnKmgZJ8ErRk6hM1nNv1ZZEWwtJuD0EXGYt95FCSHk3XAxpKtGWTla5PMMHUhJM8hxBC0tJtPwoisx8dU8bbhizsoU7nfvAkdDlOa/Omg6y3UGw3f5Qn0xarFxNwhNKrPRA67BBCWXT/PTuCR5ZglxEB+MnXt+PFwU5r3jcxwjZYmOoNaymQFklmRzK/1M5UsmXEa7ESB/NsdDyyzYHESiIvH+3OhykK1JNn8FLl7jSe/9HqXOEdUWX4RQHhZBUGFnhclky2mY1Yn9tzQPN7dIlYsw8A6ej6Ak=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(6506007)(71200400001)(6512007)(186003)(478600001)(2906002)(6486002)(66476007)(2616005)(54906003)(66556008)(76116006)(36756003)(66946007)(64756008)(6916009)(8676002)(66446008)(316002)(41300700001)(4326008)(33656002)(82960400001)(38100700002)(5660300002)(122000001)(8936002)(83380400001)(7416002)(91956017)(86362001)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFF3ZUVIQmJmUHdTZzUxbmpXZkRWelg1OWFJTTB6ZWFqaTdHQUFmbXMxVnBG?=
 =?utf-8?B?dkluYldjdk8rRUlsMTJrdEJKNGNkaURLTmhSaHdDNG4wR2FwVjFVeWptb2VV?=
 =?utf-8?B?ZVNHcENxSUFNeDRRUFJnMDNtaTJ0OGdQZVJDSW8raVRMZDNVNk5ZdzhXK3VO?=
 =?utf-8?B?UTdHUk9ibDN3eVYyVi9GQU95NGlnNENRd1ZuamdpcEw4VUVUUEQ2THA5bnRw?=
 =?utf-8?B?QnJ4cVU1bS9mSnJxS21TN1RoZGd3NXkrc0VuQ1NjbnV3NWNYaHZEN2xpMlc1?=
 =?utf-8?B?aHM4Slc0TVFsSk0yWlY3RlJ2eHZlWUx2VkNiRDhOalg1UG5GNm0wVUtVZmRo?=
 =?utf-8?B?bmh4Z21yc0krMUdWbUcvOFhtZ2ZqWGdYSEcwbDg0aFZhdEZrRm9IREVpSG9a?=
 =?utf-8?B?dDJjQWx1bWFXaXZwN1oxTFJUeXZJVCtzOWU2N3FWU2ZQMDZvS213MUU0OW91?=
 =?utf-8?B?dURuMG5zY2RWOHRKNDNQUGJ5RTlTbTlNTnh6TjJNenE1aEVGdTc5NWZycHll?=
 =?utf-8?B?SWR0TEtNSlR5dk9JRGZDSGFYRVFFZlNpVTF3eTBqOXREVkNYZUp1eDJ2MVNL?=
 =?utf-8?B?ODVoQjF2QmJWTElLT3pNMlhSQ3JEUmNnVjlzZWJWZDU2QjBtWkw2S2NWZWpr?=
 =?utf-8?B?ajh1SlB5S0ZUUTE3RWxDTnNtM1BZbms3R1ZGcnR0T1BDeUhMRHlCVHZKYktC?=
 =?utf-8?B?MXVHcmlKekJGRDNoNDAyMDVPNEpnMWV1UzRwanhWNCsvRnNxdit3N1RJY1Ar?=
 =?utf-8?B?YTNoUmFQU0VXdDRrZWpiMzlHelQ2RTZzV0JSUWgvMHZtNmxIbWEwL1ova2c0?=
 =?utf-8?B?RndHRGJ0b2hUVjI5K0t2UC9XYUxFTkhSZkt0RHN5R2QzSCtUMmtTcmx4ZVM4?=
 =?utf-8?B?TFBEZGR5MFRNYldDa2I5OEZyakcrSTVsYjRQdEYxWXo0VXRLNzF6QU9STHhy?=
 =?utf-8?B?T3FkdmdBVFI4TU5yVmlqV3BKZGV6RUlRTllkZWxKZWJCZ29reTkwK29sM0tW?=
 =?utf-8?B?UW95OE9jaVNGWC9KTkl3eWV0Wjc3R2p5QTBJcm0xbVhqVTFNdExmUlcydTFa?=
 =?utf-8?B?Zjhkcy9uMER0dFNtWEExU1kwMnBOdVhBYS90b1pJZEt1czNLMUVJR242N0VQ?=
 =?utf-8?B?TlY1NXpxR05IM2d3THI2RkhJRFdrTDdwbkpnSHFOZjdMWmdnd2hvNlJsYlI1?=
 =?utf-8?B?VlpnZEluKzRZdEV0bzBBT1Ricy9BbC9EaEhZdFA3UXgyOWczRmlIM3Y4UDd1?=
 =?utf-8?B?RDlJQWc0TCtNdWN1cmI3OEpLUjQrSDJhWmF4TnU3SjMwSVV6U3NXMmJEK0ds?=
 =?utf-8?B?VG9uVmZzbmIwQnFLQWdjVDRCbi9TaDN2RStiWHNnWUFjNFRlRFhOWm9WNy9E?=
 =?utf-8?B?enRTQ3hDOFRIRzhxazhlZ291b1dqUEhkUDJyQ2dDR01IS3BkaTBseithT2x5?=
 =?utf-8?B?WWROUmFqVXQ0QnhTc2lVMUczTjI1N0VmN2tPUWt5WGtrR29XTWJvd0xldklN?=
 =?utf-8?B?aFBvNWQxVndIWlBnUjJQelNaRVNBdFFKeHM3U0NwUUxKN0xaY2RTMFRNQ1d2?=
 =?utf-8?B?YWloL1ZzeGlBbFVsakRhSE5MdlpVRHB0V0p6RWlEam5LdC9OZ2RjZTNkajNt?=
 =?utf-8?B?bGpPMkdHU0YyZmh3dFprK29CQW9haTVVMzFtbWY3RlFmVWRPUWVJenNKVktp?=
 =?utf-8?B?ZEwrN29SQzRPWkxBQUpMZXl5MTlLMkY4eCtpWU9oNmRDUmM3VUtpN053OWw1?=
 =?utf-8?B?RnJBOEdHZ2x2MVBZYVpiVWhudzJlNm5lVllEVUJWaU5KcU1Xa0M1WkNoUWp1?=
 =?utf-8?B?YitQRDRKSmtTSkZrQ2NuMnZIQmpUL044NXBBWTBRVUFuemptRTZYRFJWTmtL?=
 =?utf-8?B?L2tzcU04RWhsUDRydVhSclBqMmRsaW1SZ3pDSlp3NGFSa3ZkSTRCNm82d1Fy?=
 =?utf-8?B?WERrZnhsVStVN0ZVS0ZWc0VFaEl2MXVRTGhlb3UrczMyeGNmTlUwd1NjYk14?=
 =?utf-8?B?UWU4UTdHbWxxQ2ZRRVJjWGZOK2hEalA3MWhnOWdUMTc3QmN0MFFvdTcyWlFx?=
 =?utf-8?B?OHBoZVRoZGpVeEtudDVwcEJBUnQrVHRQRk41OGlxL0U3bmEzWmJDL01FbDBL?=
 =?utf-8?B?Z3NEVEV2MkwvY2hOYmsvMjBySTRTYnFqREc0a09mMjVYSmx6NHZoc2hLWmMz?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF4360759EB59343A90BF91DEB6FD908@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 97effea8-1663-4531-4533-08daf4d75cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2023 19:58:23.5988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IQaK9pHCjn+pvfQRtb7CON7cz1x0ifWObtLBsRC8+nT7ZQ1DqoDyxSiDTB3i61aRkX5Bb1xim7UYTzheHxd00Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1819
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 4rf1vbmyOsaABBOGYXqi9u4H3ARGbkow
X-Proofpoint-GUID: 4rf1vbmyOsaABBOGYXqi9u4H3ARGbkow
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_12,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=919 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011
 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120143
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJZiB0aGUgdHdvIHJhbmdlcyBhcmUgYWN0dWFsbHkgdHJhbnNsYXRlZCBzZXBhcmF0ZWx5IG9u
IHRoZQ0KPiBidXMsIHlvdSBjb3VsZCBhbHNvIGRlY2lkZSB0byBlbnVtZXJhdGUgdGhlIHRyYW5z
bGF0aW9ucyB3aXRoDQo+IGEgNjQtYml0IGxvY2FsIGFkZHJlc3MgYW5kIG1ha2UgdGhlIHVwcGVy
IHdvcmQgYW4gZW51bWVyYXRpb24sDQo+IHN1Y2ggYXMNCg0KPiByYW5nZXMgPSA8MHgxIDB4MCAw
eDgwMDAwMDAwIDB4ZjAwMDAwMD4sDQo+IDwweDIgMHgwIDB4YzAwMDAwMDAgMHgzMDAwMDAwMD47
DQoNCkkgYW0gbm90IGZpbmRpbmcgYSBnb29kIGV4YW1wbGUgb24gaG93IHRoaXMgd291bGQgYWZm
ZWN0IHRoZSBub2RlDQphZGRyZXNzZXMgYW5kIHJlZyBwcm9wZXJ0aWVzLiBJIGJlbGlldmUgSSB3
aWxsIHN0aWNrIHdpdGggdGhlIGN1cnJlbnQNCmZvcm1hdCBpZiB0aGF0IGlzIGFjY2VwdGFibGUu
DQoNCj4gTm93IGl0IGFsbW9zdCBtYXRjaGVzLCBleGNlcHQgZm9yIHRoZSBmaW5hbCBieXRlLCBh
cyB0aGUNCj4gcmFuZ2UgYWN0dWFsbHkgZW5kcyBhdCAweGZmZmZmZmZlIG5vdCAweGZmZmZmZmZm
IGlmIHlvdSBtYWtlDQo+IHRoZSBzaXplIG9uZSBieXRlIGxlc3MgdGhhbiAxR0IuDQoNCj4gSXMg
dGhlcmUgYSBzcGVjaWFsIHJlZ2lzdGVyIGluIHRoZSBsYXN0IGJ5dGU/DQoNCk5vIHRoZXJlIGlz
IG5vdCBJIHdpbGwgbm93IGhhdmUgcmFuZ2VzIGFzOg0KDQpyYW5nZXMgPSA8MHgwIDB4ODAwMDAw
MDAgMHhmMDAwMDAwPiwgLyogMHg4MDAwMDAwMCAtIDB4OGYwMDAwMDAgKi8NCiAgICAgICAgICAg
ICAgICA8MHg0MDAwMDAwMCAweGMwMDAwMDAwIDB4NDAwMDAwMDA+OyAvKiAweGMwMDAwMDAwIC0g
MHhmZmZmZmZmZiAqLw0KDQo+IEkgc3VwcG9zZSB0aGUgcGh5c2ljYWwgYWRkcmVzcyBpbiB0aGUg
b2xkIG1hcHBpbmcgd2FzIGFjdHVhbGx5DQo+IG91dHNpZGUgb2YgdGhlIDB4YzAwMDAwMDAtMHhl
ZmZmZmZmZiByYW5nZSwgc28gaXQgd2Fzbid0DQo+IGV2ZW4gYWNjZXNzaWJsZS4gSWYgdGhlIGFk
ZHJlc3NlcyBhcmUgaW50ZXJwcmV0ZWQgdG8gd3JhcCBhcm91bmQNCj4gYXQgdGhlIGVuZCBvZiB0
aGUgbWFwcGluZywgdGhhdCB3b3VsZCBoYXZlIG1hZGUgdGhlIENQVSB2aXNpYmxlDQo+IGFkZHJl
c3MgMHhlMGYwMDAwMCAoMHhjMDAwMDAwMCArICgweDgwZjAwMDAwICUgMHgzMDAwMDAwMCkpLg0K
PiBJZiBpdCBqdXN0IHdyYXBwZWQgYXJvdW5kIGFzIGEgMzItYml0IG51bWJlciwgaXQgd291bGQg
YmUNCj4gMHg0MGYwMDAwMCAoKDB4YzAwMDAwMDAgKyAweDgwZjAwMDAwKSUgMHgxMDAwMDAwMDAp
LCBidXQgSQ0KPiBkb24ndCBzZWUgeW91IHlvdSdkIGdldCB0byA4MGYwMDAwMC4NCg0KSXQgd2Fz
IG5vdCBpbnRlbmRlZCB0byB3cmFwIGFyb3VuZDsgaXQgd2FzIGFuIGVycm9yIGJlZm9yZSBhbmQg
d2FzDQpub3QgYWNjZXNzaWJsZS4NCg0KVGhlIHVwZGF0ZWQgc2VjdGlvbiBvZiB0aGUgZGV2aWNl
IHRyZWUgd2lsbCBiZToNCg0KYWhiQDgwMDAwMDAwIHsNCiAgICAgICAgICAgICAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7DQogICAgICAgICAgICAgICAgICAgICAgICAjYWRk
cmVzcy1jZWxscyA9IDwxPjsNCiAgICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxzID0g
PDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4MCAweDgwMDAwMDAwIDB4
ZjAwMDAwMD4sIC8qIDB4ODAwMDAwMDAgLSAweDhmMDAwMDAwICovDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA8MHg0MDAwMDAwMCAweGMwMDAwMDAwIDB4NDAwMDAwMDA+OyAvKiAw
eGMwMDAwMDAwIC0gMHhmZmZmZmZmZiAqLw0KICAgICAgICAgICAgICAgICAgICAgICAgZG1hLXJh
bmdlczsNCg0KICAgICAgICAgICAgICAgICAgICAgIC4uLg0KDQogICAgICAgICAgICAgICAgICAg
ICAgIHZpYzA6IGludGVycnVwdC1jb250cm9sbGVyQDRlZmYwMDAwIHsgLyogMHhjZWZmMDAwMCAq
Lw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxwbDE5
Mi12aWMiOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHg0ZWZmMDAw
MCAweDEwMDA+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtY29u
dHJvbGxlcjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxs
cyA9IDwxPjsNCiAgICAgICAgICAgICAgICAgICAgICAgIH07DQoNCiAgICAgICAgICAgICAgICAg
ICAgICAgIHZpYzE6IGludGVycnVwdC1jb250cm9sbGVyQGYwMDAwMCB7IC8qIDB4ODBmMDAwMDAg
Ki8NCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJhcm0scGwx
OTItdmljIjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ZjAwMDAw
IDB4MTAwMD47DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1jb250
cm9sbGVyOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNlbGxz
ID0gPDE+Ow0KICAgICAgICAgICAgICAgICAgICAgICAgfTsNCg0KICAgICAgICAgICAgICAgICAg
ICAgICAgLi4uDQp9Ow0KDQpUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg0K
