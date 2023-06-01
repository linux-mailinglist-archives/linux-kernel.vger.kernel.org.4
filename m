Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D02B71A326
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjFAPuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbjFAPtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:49:21 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FFA10C2;
        Thu,  1 Jun 2023 08:48:43 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 351DbDVM010537;
        Thu, 1 Jun 2023 15:48:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=KniJvSduPurqAX8RGTvH8Z0EWsc+AoEAhUYpnCTgq1o=;
 b=pll+ziCzuv6HFkfJfg3uPU/1J/fsDB3ZOWiiILotbJ/PnY3YbfffjugROZiD2X8mvV3x
 tgo5buGQ3zEA/lqwTZkK3oB0teEVAzq+jCv1fP8vz24dHRmCaiYjVbMJCtbwjwSOWvKL
 njNpoVRA2mgfMK+wDqpUHo+TQLeiUY5sMTM4pQVBvUQTGT4K2RbqLqODviOfJfnzImRh
 F2GVhW2ESX220VIokPxvoz3rpPitPNWAPnFLerTOOd8nSfNIoOCF3ccztnvlme8ldq0h
 QrUGAe9+3jyGmyZtPyvgpVYHa8iv9MunZJQ5IJmrSAF0iHEboBsDiAbzZ7CYizjwrfz0 3A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qxvce186u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 15:48:16 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 1033712B47;
        Thu,  1 Jun 2023 15:48:14 +0000 (UTC)
Received: from p1wg14925.americas.hpqcorp.net (10.119.18.114) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 03:47:54 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Thu, 1 Jun 2023 03:47:54 -1200
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Thu, 1 Jun 2023 03:47:54 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOp2RYdciOkyvt9Ma274Cf+QP63weqsUj+eN9uLfjqUHPrvAtXWBVb/AfE3g29olS6wCM5raFDglF4FGf+0vahQvU9Wzc/r2kEpPzJSmtDOJsb7Q+Qw+nSwWI2bIyUHvJ8z/ypH2+o2tfUgwWx2ozylku0n+SUz2mGxPYqIEag303TazrYEkYZ8YwDHMUOxtAiGP8WHFPmBv6M4ccQMPP/Z7Jlmxf8vTbqr/MtzNGpgd3/YWEc4EPfdjCM9uX+qp12lEhGoIJgGFBZ1EHHNf9Fiv0VJWY3pSpX3PmleFCA7ZyxneBatwrtoVupmp8lzecAAwGnegbjVi9TQlntp9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KniJvSduPurqAX8RGTvH8Z0EWsc+AoEAhUYpnCTgq1o=;
 b=bozvGu6lC0TXjxLq9wd+x866tp+G7e3zaCyAsUBkWxw/vidEMPTOa996cC6FcQ4zKnqxmFVtdBShhkc7eWD4zxsa7Il+i3U+33Wdcgd3wpZTp/XB4MPcA36KWTCLtAzrCTejaoHBelsByHBFfBgIA1z3x+8IciepBoxK6qNkWTYYZYwazBBUFuskJK45n39QJjntc0n69rdhwRC32Fv27KzE0hJvw+Z4hzJJ+LjDeIx0p7bn0IMU+7MxzkkXuHkonejzpk5HY3JPAtPrQo9DAVa8N1278jBdwoErxS+8VUC2/UmSoPjnik+F4PDxzhtUdPSKvZYr4MpaiT3e71Bkxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH0PR84MB1478.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:171::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 15:47:52 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%5]) with mapi id 15.20.6455.020; Thu, 1 Jun 2023
 15:47:52 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
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
Subject: RE: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Topic: [PATCH v2 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Index: AQHZk9PWKQUBcQjeO0mLSJz9z8PkXK90ljUAgAAVFxCAABXlgIABVANQ
Date:   Thu, 1 Jun 2023 15:47:52 +0000
Message-ID: <DM4PR84MB19273A008BB11589CEEF697188499@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20230531151918.105223-1-nick.hawkins@hpe.com>
 <20230531151918.105223-5-nick.hawkins@hpe.com>
 <07b2a2f7-5ddc-0f10-6b1f-184dc21fa580@roeck-us.net>
 <DM4PR84MB19274F575858CBCB2FA5C23E88489@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <b1d8f851-4e87-333c-229c-b9dc37ea3c40@roeck-us.net>
In-Reply-To: <b1d8f851-4e87-333c-229c-b9dc37ea3c40@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|PH0PR84MB1478:EE_
x-ms-office365-filtering-correlation-id: c737322b-1bf6-448f-6fd9-08db62b78f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fmk/ykCTmSx/iQorfqYKuWpne3aDXdqzUOfvd/uawThYK6I+5ArHkhyw9GcVSLbwuYEAxZUAGnt7Jh4JM8GhDMqiucZgcClP9VkVu+M1aCZ/qytgwMsSmp+yMPfmmB3sAZJmGrddP0dBIag+2DiTtfcfFjM0eDC6SBXYED0m/Pso+FRWiBhB3+V6tCiRaQSaAOKMnfZGw+EB9xgD9/UftAEg0ku824vsz737DX4H0daKk2QSu2FDsNCqU44u9oG5+M18a77EQKkUE3NfmJHO5SXORXZ5HQeIvrEB2acHRTGI4k8uYORFzUgb8qGEV5wDuXMUJyUFCjUd3UF1Z3CuOGBLxwQhRKhXdTYDDYX62IUyQzTzeDv+0IbQgmc1m8UPhpLYpMB9H7rhMP/O9fzPk1aTwijJljC8Pl6xf30yR4zgFHiz4hGh+Jgs8T9K6I/+b52W3x85acM2Y8K25lEkEq32JvK6mJuLGAhJBeCl7uP9EONSFKsXWl1C1v9uQn+kldaEbcrdnDpgbK+n83QmJYsdv+18Y8FHQ2U5+Pyo8IdySO8nYO1Qda4Po1SrJti5MtAcGcTTB/PMa1t/pExeDDa7FfMWv01pLlRoOTuSXGR+W0F33l9ImanGYl6vOqQ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(86362001)(33656002)(82960400001)(122000001)(38100700002)(38070700005)(71200400001)(478600001)(54906003)(64756008)(7696005)(8936002)(5660300002)(66446008)(2906002)(7416002)(6916009)(52536014)(66476007)(66946007)(66556008)(316002)(76116006)(41300700001)(8676002)(4326008)(55016003)(6506007)(186003)(83380400001)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MCtGcU9acTg5WlM2UWd6RW4yc0k1cUsySjVzdkZVMVI5OXI2dWo3NU5jRnV5?=
 =?utf-8?B?bzlpL2RSVkhxbVBlK0NwTm11b09GL0tQSVBESkJkZkFVTFAwRXFlRlJQdUQz?=
 =?utf-8?B?WWVwaWIvTVZ4ZU5wSnhpYmh1S2FRN0t3S2JRbUZLVW5tTVgvTzJTNm5lUEVV?=
 =?utf-8?B?aVdsTHdmazlpYml0V0ZGRy80K0NZZFYyMmcxTFA2U2lzRWhLdjJzZkNRdzZj?=
 =?utf-8?B?VjJOUUc1ajFVZkJTYXZNYUVHRWNEd0tIY0JCT1hRbXJzZWE4TE5sMi9keDVz?=
 =?utf-8?B?cU40dU9JZnd6R0p0Qnlwc0xsMHJ0alpzUEJCS0RvWUFaWkxtRDlVQkhBOTZ4?=
 =?utf-8?B?d1J4R0NmQWpNTVh2b080b3dzaE13eVVzVWFjd0djM3Zxd3o5VWY2RVY0WmtU?=
 =?utf-8?B?bWprMVB4bWoyaFB1a0ZkMmJvYzU0Y0syVnRlOGkySGNuVTlKQzBSV1dnMWdI?=
 =?utf-8?B?UzdEaDEvME1udVFtUWZGWVlhSXZpbENWRWdRWVBUeVpnMUd6RTQ4a0M0RVJj?=
 =?utf-8?B?SVFkNkVuU0NCREE2Yy83WkIzdmhvSFNTNC9NR1dSUW9Sd1RyYzI0ZElZL0ov?=
 =?utf-8?B?c2pwTUV1N01KbEVBZ2tuT1VSVjhtVldqS2N5cGZWVDNTYXRTNVJwR1dMSDhK?=
 =?utf-8?B?cS94TnpCS0Y3NzhkU3RTdUYyWWpQYTdSRFFlSzFMaGprdnBKRlF5NEhqWWRZ?=
 =?utf-8?B?R3NkRkFNcXRKWWdpOTU5c1ExZ3JzeVZBVHp2UDI1U2krTm1uV1BKakJLUjY2?=
 =?utf-8?B?TFVoOXUxZHRYTlMyTjI5MFJCSGppQW45M3E0SHdwS3lGRi8xYWFqcFFWeHl4?=
 =?utf-8?B?azc3c1RUZElaNENJZmhLbnR6RzBQclM5QjFHM213aklsTVdKQlhhRGFOdCtl?=
 =?utf-8?B?R2RwN3FLUjBXY2VYQUQ1ckpRc2ZQY0dQZnVCL05wcXdXSEVJVVcvQWsvbi9i?=
 =?utf-8?B?b2JyRHVsWUFwNEdoakNBV0ptYUNUZnRwYjVtRnRLK3hIcTVqbEFnTHNKaUVZ?=
 =?utf-8?B?ZkJ5blNwSUMwMkpkTVpVTmxDdVVqS2taczEvMGp4bnNqT1VKcXc4V0RIRDJN?=
 =?utf-8?B?Kytxd3RBUmJacDhVRWQ4ZDZNQVE3V0tpa0hzRmY3UVVFanhoa09wUnNjWHQz?=
 =?utf-8?B?MnBEUG40REc2d25SdDc5Sk9SaDJpaCtWNTd4SFFZbEtLQjFFZ1hydytOejNU?=
 =?utf-8?B?WXArVU96VmFBaTFUMDlycHNEV3NCUEJ4ZFV0VnFEdks3V1lIM2NSS2hiSmFy?=
 =?utf-8?B?ck8rbU1LeEw3c0J2WkNWS0JVM0JjYjIwYVd0ZkNKN2Z1VnAzVGREVGlWSUhO?=
 =?utf-8?B?bzdwL29ZeGh5RmdTS0FzaERPQXhvNml6WjFoQllna1pzQit4RVlZcmNxblh2?=
 =?utf-8?B?VG9KTEg0M2swSFI1RnFibDRPNWVBOVlKdDY0Y3hLQzIyR0RSc0M4Tk5NM3JP?=
 =?utf-8?B?MllBajZzczdCWGwyaUIyRm5NQm5lVXFTbWZWM0NZTGNPYjd5WDJuR0Qwc2xo?=
 =?utf-8?B?QUk3VU5kdy9mOXdXZkJGcGdNUSttb3luemFqdFhvK1lXYTcwMHFwZHZaQ3Bn?=
 =?utf-8?B?WnBhY052Zk1idjhJcHhDWG1UemlxdVRleTNudjI4c3lYMnkvUTVWQ2cvTnFB?=
 =?utf-8?B?cmgveUNaUW5wbGxhV2ZWVWNnbFM3L1JFTGdwOWNjVkZBVzhjUkkvSm5qTW93?=
 =?utf-8?B?WUxORjRVU3RDSkhjWTdEOG5MZ2o5TzhhQm16N2V5aWtFc2prR09BQ1hVVUwv?=
 =?utf-8?B?VGE5c2JZYkd2Smpsd1U2WWR4WW80VnhqWHZZNXd4cHJ5OSsyQzNCQitTMlFT?=
 =?utf-8?B?am1VTEgyMlBoSmZMdU5MNzZUcUtwUjdxNXFiTWdzWDAyTHFHYmNMUDF6OGpT?=
 =?utf-8?B?M1lJMmZNZGhvaFN4d0d0UExmRlEvbUhmZ3FocFozdGtRendkbDNiZFFRMXlW?=
 =?utf-8?B?MklhQ1F6cVRUNVE2QmVzM0RGc1JWdk1YTXdmQlRJUFplaVdGci9ZcEMrNDJU?=
 =?utf-8?B?dndOQ1d2YjY3Y0xadjF0SlJKKzFmRG8rTDJjTXpqNzdjN1d0enlkeEJxQzdT?=
 =?utf-8?B?WUhJUFhuZmovY2dMcXUzMzRTQnppQUJKZXBxeGlMaGpIY2RGZVRXYkk0UTBF?=
 =?utf-8?Q?XkDxT500QXL97MPnG4yXapsa2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c737322b-1bf6-448f-6fd9-08db62b78f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 15:47:52.5432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeYwgEY55Kh20dpCjcHzYMuBxLbP3QzurCbZINErE6v4201w4J9HKtXBbYagLgiv8dazMEf4SW57ximdVoG/pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1478
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: 78pYT7IqWj0VD6JZw69Y_mF3kkYOqW16
X-Proofpoint-GUID: 78pYT7IqWj0VD6JZw69Y_mF3kkYOqW16
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=610 clxscore=1015
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010137
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBJZiB0aGUgaG9zdCB3YW50cyB0byBvd24gdGhlIGZhbiBzdGF0dXMgZnJvbSBncGlvIHBpbnMs
IGl0IGhhcyB0byBsaXZlIHVwIHRvDQo+IGl0IGFuZCBvd24gaXQgZW50aXJlbHkuIFRoZSBrZXJu
ZWwgaHdtb24gZHJpdmVyIGRvZXMgbm90IGhhdmUgYWNjZXNzIGluIHRoYXQNCj4gY2FzZS4NCg0K
PiBJbiBhIG1vcmUgIm5vcm1hbCIgd29ybGQsIHRoZSBod21vbiBkcml2ZXIgd291bGQgIm93biIg
dGhlIGdwaW8gcGluKHMpDQo+IGFuZCB1c2VyIHNwYWNlIHdvdWxkIGxpc3RlbiB0byBhc3NvY2lh
dGVkIGh3bW9uIGF0dHJpYnV0ZSBldmVudHMgKHByZXN1bWFibHkNCj4gZmFuX2VuYWJsZSBhbmQg
ZmFuX2ZhdWx0KSwgZWl0aGVyIGJ5IGxpc3RlbmluZyBmb3Igc3lzZnMgYXR0cmlidXRlIGV2ZW50
cw0KPiBvciB2aWEgdWRldiBvciBib3RoLiBBZ2FpbiwgaWYgeW91IGRvbid0IHdhbnQgdG8gZG8g
dGhhdCwgYW5kIHdhbnQgdXNlciBzcGFjZQ0KPiB0byBoYXZlIGFjY2VzcyB0byB0aGUgcmF3IGdw
aW8gcGlucywgeW91J2xsIGhhdmUgdG8gbGl2ZSB3aXRoIHRoZSBjb25zZXF1ZW5jZXMuDQo+IEkg
ZG9uJ3Qgc2VlIHRoZSBuZWVkIHRvIGJ5cGFzcyBleGlzdGluZyBtZWNoYW5pc21zIGp1c3QgYmVj
YXVzZSB1c2VyIHNwYWNlDQo+IHByb2dyYW1tZXJzIHdhbnQgZGlyZWN0IGFjY2VzcyB0byBncGlv
IHBpbnMuDQoNCkdyZWV0aW5ncyBHdWVudGVyLA0KDQpUaGFuayB5b3UgZm9yIHlvdXIgdmFsdWFi
bGUgZmVlZGJhY2sgd2l0aCB0aGUgc29sdXRpb25zIHlvdSBoYXZlIHByb3ZpZGVkLg0KQmVmb3Jl
IEkgcHJvY2VlZCB0aG91Z2ggSSBoYXZlIGEgcXVpY2sgcXVlcnkgYWJvdXQgdGhlIGZhbiBkcml2
ZXIuDQpJZiBJIHdlcmUgdG8gbGV0IHRoZSB1c2VyIHNwYWNlICJvd24iIGdwaW8gcGlucywgd291
bGQgaXQgYmUgcGVybWlzc2libGUgZm9yDQp0aGUgdXNlcnNwYWNlIHRvIGZlZWQgYSBrZXJuZWwg
ZHJpdmVyIGRhdGEgdmlhIHN5c2ZzPw0KDQpFeDoNCkdQSU8gRHJpdmVyIC0+IChPcGVuQk1DKSAt
PiBGYW5kcml2ZXIgKHN5c2ZzKS4NCg0KSGVyZSB0aGUgR1BJTyBkcml2ZXIgd291bGQgcHJvdmlk
ZSBmYW4gcHJlc2VuY2UgaW5mb3JtYXRpb24gdG8gT3BlbkJNQw0KYW5kIHRoZW4gT3BlbkJNQyB3
b3VsZCBwcm92aWRlIGZhbiBwcmVzZW5jZSBpbmZvIHRvIHRoZSBmYW4gZHJpdmVyLg0KDQpJZiBp
dCB3ZXJlIHBlcm1pc3NpYmxlIHRvIHByb3ZpZGUgZGF0YSB0byB0aGUgZHJpdmVyIHZpYSB0aGlz
IG1ldGhvZCBJIGNvdWxkDQphcHBseSBpdCB0byB0aGUgUFNVIGRyaXZlciBhcyB3ZWxsLiB0aGUg
UFNVIGRyaXZlciB3aGljaCByZXF1aXJlcyBwcmVzZW5jZQ0KaW5mbyB0byB2ZXJpZnkgYSBQU1Ug
aXMgaW5zZXJ0ZWQgLyByZW1vdmVkLg0KDQpUaGFua3MsDQoNCi1OaWNrIEhhd2tpbnMNCg==
