Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9337265B5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 18:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjFGQTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbjFGQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 12:19:13 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1891BF3;
        Wed,  7 Jun 2023 09:19:00 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357Cgd21016824;
        Wed, 7 Jun 2023 16:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=xR5gOkDDe4RzsBYChIg1xI4NpgQuyv+hA6o0Zx55hp8=;
 b=HvoYbX1wmkyQ8C4VFyBmaP88EpnhQdvhX6uABlG2jiZeDV//uUY48/hXyO2vrAGmdJuw
 FWMtPaiZOlat1r4W2fVfaZz98oFusINHBbOpZJKX0eiBAxo2Wbn9Sj/1iJDQobWw9VAJ
 ZJYL25eudPeR/RzoFw9P/U+5EzcPeYrpdc2JthKTJpBSirmK5g2hwYKCqzfB69h7Cn7k
 Rd16nDVgmj6MrHLAZS1bO9Fq1FaAUqg+M8K5yrkkaEGdodVb7gubpZL1+B0asNJUS30Z
 7jVRFhU3jXbi82zfjYWZzv59eHs4VbLEzS19uzI7POsHij6ZV/7umzvUa29RmyZETJwH 5w== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3r2rjpaqcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 16:18:38 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id CB65514785;
        Wed,  7 Jun 2023 16:18:37 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:18:32 -1200
Received: from p1wg14919.americas.hpqcorp.net (16.230.19.122) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 7 Jun 2023 04:18:32 -1200
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 04:18:32 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqlwOb1qtS7E54bwBTISOkeGrG4lqurNZkE2r9aE3l4ui/4D1+gcudJRtZvqKzzTuhMbiAa+Mm6iiGkJErzdXRU3xYVwIaFrpYvvs4pRX1a36DG0Z4aB/+9j/ZVmaouwqPQ2DBmE69rZ78ticQYU4vRmgPQHasmtiYRYPraGFnUfiiQLLfdyCjV2lTCgDOijE6bzpSGfCGlYJUvOMk8ULTCmw0mJ9Yz1p3pO/ddvpWCShA4ctK4WfazXjzXIoyawvXvcMTTxvw5WZKHDke44R4ww1JLF9Yw0tDYMuXNklApKnBKWnwCvwUyEQSZZFRfkxnm4CvdM1qj+oKwbbAMcAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR5gOkDDe4RzsBYChIg1xI4NpgQuyv+hA6o0Zx55hp8=;
 b=YwojOXDXUoN+2Ao1IWsRJdkayl3dt/kH9+GtU0vaJEkEr7scX6MAceVWtK7hNsQIh27Um+ZvFs+I5s6IsX7LU008o6gt0XqMHXf2v4Bg1bP+Q1/mFfPKQ4Nu6oi1dxIdk4RVh4q4ZI68lwtJ7AlGUEvcFt07+PBTRwYDgt3GmsCEGueuJTUicAG2zqlgApzEmCb/HEpf9EFfBLIxeNlb1empOQyNydC2PSL3vLI5bQHCWrxNRGEgwLkm7iO6I1JCzpnP0ovKdMNNwgnJNzfksyEr9SUKarWk71g2DXmw4LNfwwPN7hoKwxmuzqzgL0CndcIwDSIW34gkHf2C3V2faA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1709.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:48::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.38; Wed, 7 Jun 2023 16:18:30 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%6]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 16:18:30 +0000
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
Subject: Re: [PATCH v3 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Topic: [PATCH v3 4/5] hwmon: (gxp_fan_ctrl) Provide fan info via gpio
Thread-Index: AQHZmBjCtB73WBqWlE2DLJ+qVorVLK9901iAgAFgCIA=
Date:   Wed, 7 Jun 2023 16:18:29 +0000
Message-ID: <6CCF9E6B-DAF7-4C58-B184-BD122D905081@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-5-nick.hawkins@hpe.com>
 <22d5f12e-578b-4484-a90e-6e81289ed458@roeck-us.net>
In-Reply-To: <22d5f12e-578b-4484-a90e-6e81289ed458@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.73.23052700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1709:EE_
x-ms-office365-filtering-correlation-id: f328713c-3415-46f2-dc8a-08db6772d4f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RakrJ0Ek8jidjS8KgdaqdpktXXkcGXNEb/bBhk73bIGrHKW0dBYkEPmBVMtC/BmHMmv3EvA+V8Zwq1IITFnCHJT3UN/J+XPdauLzQzRLRPt+Chp2Dbdx2UHmuKn2Tnd5vUlPoHzJLbu4dDXUXb9lMAJsyEn5qf/65ZFU9PAMvH9zKZkWDUc2TcEpAu6DINbR0QzmS0Lo5QtkorCOFn102z6Mw+oti7pEyVrLEHa1HQY3wXm1ITPdsCym4r+xryFBeCs+YiSecptiZOnFzpzETAtKjVlucWL1LJIHiXXFSYiQPwzVeyj9O8wYTvTJ5bTbRx7WBNuxiM15sZhIwHOHpNxOZGGEpJCc5o+Kkh7AexqfVbCuU+V2SJabr9ubLb6vSKqFN2PpcVS9xb6F9/uTPTROx86lAWzPoPJMjgtk570az4MjuP/t+vdd+nfusQK5MUEWn1vycnEpZcNV0gRNzbwMebEpOi3fFy7NmBJHbtSVH1Cif/3l6GvsRCiFr9qoRxWRokGLDzzmE557omVyMEYM8xMZ/lQEK6/FZcaCtxNZ10ItPbR7BmtFF3radS4sP5bMGwZoNoS261qFV6KxePO5A7Y2PzpZz+hf2ku7l8Ufgir5xX/Rp8QLKEZyI2B/2OQK7tzlojAeMPOrK4YH7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(478600001)(4744005)(2906002)(2616005)(38070700005)(186003)(6512007)(33656002)(6506007)(86362001)(82960400001)(122000001)(38100700002)(6486002)(36756003)(71200400001)(5660300002)(8936002)(8676002)(41300700001)(76116006)(91956017)(66446008)(64756008)(6916009)(4326008)(66476007)(66946007)(66556008)(316002)(54906003)(7416002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGYveW91VytiKzJ6aWFRNXRCbGtUR095VXNPZDN6STRoSHYyMTNjaUEvWTBC?=
 =?utf-8?B?MU1ma09CcDlJeEJsK09hMFAvWHJHUmx6SEx0MHpCSlVQSk1XVTdPcTdKcjNH?=
 =?utf-8?B?WHVqbXFUTDl1TUY5WVRTSEI5aWNvMk1hb292aVVrMmRWZ25CNVlQMEEzRTBz?=
 =?utf-8?B?UkNzMVNVRnVzdEFlVkVQVUNnRHNFQUlnWFFYZGl3WXFobG5kSUNTZS9CMWN0?=
 =?utf-8?B?SE1PSGdXSWdZcEN2MU9SN2hRUnB6RzBxZ0hNYkZHYnJWS05hU3VIV084blY3?=
 =?utf-8?B?clRETHA5bjU4TVo4WmpZeFJJRWNBY3Z6SXdOaW8xdU1zTVg0NTB2RkhtOS9i?=
 =?utf-8?B?Qko5ZEpRWklSYkRodXVuOSt3bURRZjFaMkhxQW1IYmVjYUppZlZGZytJYWha?=
 =?utf-8?B?dkhhV2RsZGVpK3RVaGFDeTRWVUtMZnkwd0c4WnBMUDJxSkkvNGJKZWo2R0hQ?=
 =?utf-8?B?V0w0WE9MLzBhcVpTNUxsM291NXZyenB2aFJOR3hwRXRSRzgyM3pBZExvK1ZQ?=
 =?utf-8?B?bXlaaGRYRGhPdHpIMExKcm1LblBXZWhKNzB0R2thSjQ5d0lwYVIrSXJIa2RR?=
 =?utf-8?B?TTJzN0JPVHhOdGpNbUZLalNabkNkaDM1Y2YreE41VUl5S1doVXlPVy81TlNI?=
 =?utf-8?B?NGVLbkIrZXZTenBpcGFObW9sdnFETTh0WHBmUWNCWGhJWXpZbElHUE9nclor?=
 =?utf-8?B?UDlXVDNTWEd2TFF6NVZjcFJNYUVTKysxVjgyaTVrNUs2akxOQWVoaTV1U3lo?=
 =?utf-8?B?WTJvS3FESWVnUmNLZDRkcFhUWkFVUzZvdk92aTJnTnRVYmc5cFpWdXJKUldQ?=
 =?utf-8?B?SjBCMnQ5UWcydGxxaW1ZNlBpcjU0VXVqWGZRRkNxSnVjZjhYN3lRdnpZcGJq?=
 =?utf-8?B?bUY0MWZad3Z5YnhoMnlOZVlyeUZDeUVCc2I2SUFXZjg2dE13dUIyL1Q3eXpK?=
 =?utf-8?B?S0tsOU9EL0xRVEZJM0pQZ0FUVmdXSWwxdTZNUHYraklBQmUvUTA3NTBOM2Nn?=
 =?utf-8?B?cWFLdmhKclNOSTdTVnVjK3VLbVpaTzY3N3R4Mk1xUkl0dFBWam9rc0dxb3JF?=
 =?utf-8?B?Y2EwMjhxK3hURE9vTG5PSzN2cTBKaU5jSVRnNlVENDVpS1l2ZXRMNXRtNStm?=
 =?utf-8?B?QkdqaVJiTlRGN2RPeWtwUGNyY1JMeWZKNEQ0bGNvdFZEQzFXVWVwclZ3T245?=
 =?utf-8?B?azNkazM2OFB6RWZMamJxeHZMOWY2NG1pMkhZcE1PeTFEbXFRU1p0aFZMMmFL?=
 =?utf-8?B?UnExQ0FtcFFmL3JoWng4aTJucy9wd0xhMk11SnZjUHhsQzFhNDFFQW5ZRFBU?=
 =?utf-8?B?SnVEQ05ISUxCTnBiYThEelh0WkQ1Qlluamc0TlI1Nk05NWJ3MmRaVVRFZmd0?=
 =?utf-8?B?VzBEb2lYTWc4ZmhaTjFOQmZvaXNYNUR0OEt3enViRTJNRmVKTDJUOWlxUGZB?=
 =?utf-8?B?TVZUVENzc0JUQ05MMlJ5NW9LOHFXWmZZdTZ4dCtMN2NrbXg0bzNmSDlVZTB5?=
 =?utf-8?B?Vzl2SjY1NHhQN29yUDFici8xZ2UydzJJTXVhYzJ0eW5xcDJWZktNNzJHNEZQ?=
 =?utf-8?B?OC9xS3pVb2cwNHNxN2xsVUZzR1duNHYvRC83Qk10TXVpUzVRajNKY3YyNDFX?=
 =?utf-8?B?eTVDT0RLR3NFbnZHNzUvNFZidWtiVzJocmtxTVpjVFVyR01CNG9Fd2JOK1U2?=
 =?utf-8?B?MFlianp4aS9nVk5xYXJ5Z2ZHZDFtaTB5K2ZBMXkrM1dTanVNQ2dpeWY3MTd4?=
 =?utf-8?B?U0RkMy9IYWpHWktSSnVSMzZrbjk4V2wrY1h0UzJqVUlLQjY2WktxcytQUzRo?=
 =?utf-8?B?UFh3SnpKUjhyNlRJYUxXdzRCZDZKNnN2QzhvbGdNOXBhZTA0Mm1COFZ3Q3R1?=
 =?utf-8?B?SVdxb2R5c3ZNdlkwSXM5dkNiMnR4Uld2M1lVNTlsLzBiT3JGWmN3Nitzayt5?=
 =?utf-8?B?d3FlWjVxeWNOajR3b1h1Q0dKeGYzOGFXNnpqQnBYWktHeDczeTZzampoM2VM?=
 =?utf-8?B?K2VycEpjNFZtTSt3V3M1TkgvUVROQ0JEKzlDSWRwRmRwdXpoTmYxaXNoOXZZ?=
 =?utf-8?B?dkNScVhMN0VhdkE2T2NUL3o1VGhPWDJGNy9zc3dIOVk4eDZVempwNXZ5OXpl?=
 =?utf-8?B?SFdMQ1plMXZRMVRzN0JPL0thZWRBczNYdmtBU0t6WHcyazYxQWZSQUtzbDN1?=
 =?utf-8?B?WXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B53A61671AF95419349044E9032F8CE@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f328713c-3415-46f2-dc8a-08db6772d4f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 16:18:29.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QaCtu2pTqeg7hpeNT76EQWn8b5L9T2zO15WYYa7LQD774VHW/BtFvDsL4N6kCcp0t7AZ1ExxO8v1gz0zu65NOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1709
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: EeL01ZNsPnv3082L59_lbAdIewwd8Mcd
X-Proofpoint-GUID: EeL01ZNsPnv3082L59_lbAdIewwd8Mcd
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_07,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 mlxlogscore=421 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070139
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gPiBUaGUgZmFuIGRyaXZlciBub3cgaXMgaW5kZXBlbmRlbnQgb2YgdGhlIGZhbiBwbHJl
ZyBHUElPIGluZm9ybWF0aW9uLg0KPiA+IFRoZXJlZm9yZSB0aGVyZSB3aWxsIG5vIGxvbmdlciBi
ZSBwcmVzZW5jZSBvciBmYWlsIGluZm9ybWF0aW9uIGF2YWlsYWJsZQ0KPiA+IGZyb20gdGhlIGRy
aXZlci4gUGFydCBvZiB0aGUgY2hhbmdlcyBpbmNsdWRlcyByZW1vdmluZyBhIHN5c3RlbSBwb3dl
ciBjaGVjaw0KPiA+IGFzIHRoZSBHUElPIGRyaXZlciBuZWVkcyBpdCB0byByZXBvcnQgcG93ZXIg
c3RhdGUgdG8gaG9zdC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNrIEhhd2tpbnMgPG5p
Y2suaGF3a2luc0BocGUuY29tIDxtYWlsdG86bmljay5oYXdraW5zQGhwZS5jb20+Pg0KDQoNCj4g
Rm9yIG15IHJlZmVyZW5jZToNCg0KDQo+IFJldmlld2VkLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51
eEByb2Vjay11cy5uZXQgPG1haWx0bzpsaW51eEByb2Vjay11cy5uZXQ+Pg0KDQoNCj4gTGV0IG1l
IGtub3cgaWYgeW91IHdhbnQgbWUgdG8gYXBwbHkgdGhpcyBwYXRjaCBub3cgb3IgaWYgSSBzaG91
bGQgd2FpdA0KPiBmb3IgdGhlIGdwaW8gcGF0Y2hlcyB0byBiZSBhY2NlcHRlZC4NCg0KR3JlZXRp
bmdzIEd1ZW50ZXIsDQoNClBsZWFzZSB3YWl0IHVudGlsIEdQSU8gcGF0Y2hlcyBhcmUgYWNjZXB0
ZWQuDQoNClRoYW5rcyENCg0KLU5pY2sgSGF3a2lucw0KDQoNCg0K
