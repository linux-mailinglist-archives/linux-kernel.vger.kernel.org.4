Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4156656C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237988AbjAKJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236837AbjAKJBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:01:20 -0500
Received: from mx07-00575502.pphosted.com (mx07-00575502.pphosted.com [143.55.146.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E422736
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:01:18 -0800 (PST)
Received: from pps.filterd (m0320706.ppops.net [127.0.0.1])
        by m0320706.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30B16cx8031366
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:01:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wistron.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=POD111722;
 bh=veCkz+i87Moo0Y8k936kUofZ9qgaHPNBrSuj3g25wic=;
 b=EZfjSa7jGy6Ce8hhlo3pyPA5TtOJ1+w0lxRBEcH3H4BTlq+m5LJ9Ns/UydsbxPLLgOf6
 rriNQ98l+5ZJVXozyiWPFW2wDbU7+ngME7SqNYSdvNLoPk4BAgZChspadTgVB4Lhxd58
 xTL0OnlQQAjlrH6GMQCmI6Fpa9bIw5PdlisefT6d/X1COENkJdtNW5Jykp2Ejn0RJ1F5
 oRNsCAJ6+inX3T6b0VS6J5y0kNh4UprFvCVb2G0MdfAfej84lkG+JwHEZ+UtFHOoQnUz
 qM3uafH0H3Coiv3/CD/d0++Mu5v5f/FjYUxbGXw7OzOwLH63W6Pkixmc/UhS7x0O/4vN 9g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx07-00575502.pphosted.com (PPS) with ESMTPS id 3n1k5ph6r0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:01:16 +0800
Received: from m0320706.ppops.net (m0320706.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30B7LEHP027059
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:01:16 +0800
Received: from exchapp02.whq.wistron ([103.200.3.46])
        by mx07-00575502.pphosted.com (PPS) with ESMTPS id 3n1k5ph6qj-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 11 Jan 2023 17:01:16 +0800
Received: from EXCHAPP03.whq.wistron (10.37.38.26) by EXCHAPP02.whq.wistron
 (10.37.38.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 11 Jan
 2023 17:01:01 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (10.37.38.70) by
 mail.wistron.com (10.37.38.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34 via Frontend
 Transport; Wed, 11 Jan 2023 17:01:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BN2v4viJaH1478CgWJvv3TmOLMD9NC5R1Jmj2GwY0RwOQWxFh6iXjVROQFTYoRGlg5oK2LFg7q5W0Urkg2vu7ugRGy05x+YIGfmwO+W697UHskTSevCsI4+6iGW076+4lgoIdFnggcvCwV8ZWhvtEwzGfp+ibSWOU/QwM56rIPt6vDJqxzXsXQ38qgjdkciU1dr8RO01ZE3B9RItIlUX/OXCbgsO3rE8Qob3v4T8+q4oRLGs7V86JKw3SkOvFYIx/CYgyryh6uklwR0+YaBi6UDb0idtlzAWkGdnBKuVjRlMl6/KIo4ZiV0AkptQvjmcOeNz2J5iyGs0o6zshdmJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veCkz+i87Moo0Y8k936kUofZ9qgaHPNBrSuj3g25wic=;
 b=Gpayge9+AY7xF5RoohlP9Fbk23NHsPBLeW2CgtEXKhzxFnCZdvJN9CfW9cR9ty3I6zhcoFMYD0tIW5cJYGJAk9U6gjZ5XVSSEitQqVcLMeeH2bjgtIzbfuw2L/QHMRg+MhZCO/PFw1Slge7/s6zlo0I24khHVbiQG3fFdq7OX3PYRqsxIzSGYZFJQKkNxyXuBQWfPOiV+cvMNdcS/sVWYx4eZFX0DRIM25dYlKN+u/JwADOKjB+n4323Bf9uYapkpjfD13m65j8B2xkp3+IzPcJV+rLPXlnGCEqY/ox6QmKcVc872ubc2vglpWr+IhLuHbUu7Szs6Wcs92o1m4mpNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wistron.com; dmarc=pass action=none header.from=wistron.com;
 dkim=pass header.d=wistron.com; arc=none
Received: from SEYPR02MB6230.apcprd02.prod.outlook.com (2603:1096:101:bd::8)
 by SI2PR02MB5705.apcprd02.prod.outlook.com (2603:1096:4:1ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 09:00:59 +0000
Received: from SEYPR02MB6230.apcprd02.prod.outlook.com
 ([fe80::3d39:3684:4875:3a5]) by SEYPR02MB6230.apcprd02.prod.outlook.com
 ([fe80::3d39:3684:4875:3a5%4]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 09:00:59 +0000
From:   Andrew Lien/WHQ/Wistron <Andrew_Lien@wistron.com>
To:     Chanwoo Choi <cwchoi00@gmail.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
CC:     "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] extcon: Add EXTCON_BATTERY type for battery presence
Thread-Topic: [PATCH] extcon: Add EXTCON_BATTERY type for battery presence
Thread-Index: AQHZJJxu6ZBXrys0tk+4UuuUXnmZha6XqL4AgAFArZA=
Date:   Wed, 11 Jan 2023 09:00:59 +0000
Message-ID: <SEYPR02MB62308AE65824DC7F372EFCA585FC9@SEYPR02MB6230.apcprd02.prod.outlook.com>
References: <20230110023656.1334114-1-andrew_lien@wistron.com>
 <dc62d036-dcab-532b-1c3c-fbebcd1705fa@gmail.com>
In-Reply-To: <dc62d036-dcab-532b-1c3c-fbebcd1705fa@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR02MB6230:EE_|SI2PR02MB5705:EE_
x-ms-office365-filtering-correlation-id: e0b822a2-da98-4718-aca9-08daf3b25bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RBz3uIxQnPVy5Lfhtx0gLFTLY3mN5rNn8QlMtY5b2KZ44OcN0yCqzSJDy1MvPTTzzIFVeku6RmkApLKPpLwSnSDx68kJ/PQi61G3XPeK/kVYa+486qalt+d7x06BPWv8lDgnLJ2K9hEKQ1gElx3B9RKs88mMl7x25YaLkbERQ3m7TTjGwhS7TvuHJzz1e1F63kFbQaNwGSp9rELMdUQogxVbNxL/TSFL5cs02fjA6pH79x233AqOeXcch+lzkyj+/mDz+dWr3JqtWCl3IYySXCvI5jpVtjvM2lzZ+vii6sl6rE+BhicFmF34oCeZotelm+4mPwbbu6eaL/x2gx7AOLDwCxTww4d1R7AxCj932MicDSe7zzqoqN+fmIWjzG1NCVNHNLHQNZJDsSXvljH4xtdR5s2s1wrmsk62A6sZvLPdFYBK8NwuyYU3dF4h4KTPzksexxvFxvOFpImqELxTXe6sKgWM4s7DJVOiZTwtrMT7dPLcF42BWSAWfQd48WxyrUkigHQOp38LhMWi3fBxGgDGbKe44OsKjyVQceUaQu8z0lPQegbro3Z3NbUKrfSXYFfs529ZHEgfkSYq3+40mZ8gzvcHxqW3gt8knbVAvo/B43VZRHmx/4uSqJi2Q5Lmy9fkKQd3X4iYwMqJGHGdBv69Cm+az4XHjNkD8bomjgZjw7abnkSpC2ZIL0DxKK1idIiiHSDj2ZXDfknUD6O1wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR02MB6230.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199015)(6506007)(122000001)(38100700002)(53546011)(2906002)(478600001)(33656002)(9686003)(26005)(71200400001)(186003)(5660300002)(7696005)(316002)(8936002)(55016003)(86362001)(38070700005)(83380400001)(52536014)(66476007)(8676002)(41300700001)(66556008)(76116006)(64756008)(66446008)(4326008)(66946007)(110136005)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azNzRzdzQjM2cklwdjJPZUNkanZqZWgwNG5PbitEeE1mQlRBNnpuRVFRUFhh?=
 =?utf-8?B?bjFRUFl5dVk2VmJ0SFlBTjBwenJaemRoTHB4WHJHNGdqOFQzbUdxczV6RDBk?=
 =?utf-8?B?WFpyeWlOWDAzYzhMd3Z6dmNURXdIZ1BoeXEvYWk3SEpmamR3eHFUMVJBWnFH?=
 =?utf-8?B?a0R4VUYzMEQ2Yi93aUptcGYycnNybGw0aVI3eGpJNEhRRjdyM3VIRVE4bXBD?=
 =?utf-8?B?LzZxV2dtL3hmazVuZ3RWei9nTjk0ek1LWnU1MEVHZDlhMUl3b01WZFc1cDRw?=
 =?utf-8?B?d0QxaUFMekRZRldFZE1qQURESm41NFh3Uk93WVRKT21VbG80TXhCZVdOQmZL?=
 =?utf-8?B?T203czVjY0cwN1AwYWIrUVdFV0tJN2dMTnBjeU5uU0Z4bU1CNmt5Y0dxRGly?=
 =?utf-8?B?aW9ZNzI2NTlSUzVmZFdaKy9DbnhXQ3Z1a0RSTFdkRFNqTEtkNDNCdStpdVpX?=
 =?utf-8?B?cW16dE9PcmZQb0ZRMXI1ZUtBWXlmclNzZzZQbGtvZm9McGEyTnZGbDNjbnM2?=
 =?utf-8?B?VlVSNGFEREg0QURhazBiVi9TaXE5bGV2T2c2WVlrZ0JDczNFVDB5RTJ0N2FM?=
 =?utf-8?B?TVMwYlFRbnRPWmRFWE9DR2VNV29vRmhOdlp0RXBWTDY1K0FicFdobU1QaWNE?=
 =?utf-8?B?ZFUyRHZWc1ZhcENSTTVSQkx4K2JJTm1DUWNBdUdOZG9FMTlMS3FaYkhxWlhM?=
 =?utf-8?B?ellJc2Rodll3SzhpQTVSTzlObzd6aTBpM2RmNjVGT29RM2JJeE0ydzVLaTU3?=
 =?utf-8?B?OGJFNEJtYWxqOUNoeDBJeGVtSnpnaUhvWmExNjBqelM1S3UwbGI3cWVyV3pI?=
 =?utf-8?B?b01WM1ZRZi9MM1dGdHM3TWZ1OUh5anFDMGVBSDVOS0x4TVFKK3dmYTdhT3Jl?=
 =?utf-8?B?TndTZXlBV1dBRndnR1dlZkNZZWdWaHkwR3RoK1o3U01WOElCczU4Q2pRWlVJ?=
 =?utf-8?B?NE1USDlibmMwNUtCaHdsc1VUeittSmQyd1BZTVp5YlR3SVZ3ZzZ5WnNSQ2RW?=
 =?utf-8?B?WndPN2dMbTFRMm1BSkR4a3l0Zk5CZ0NEbDRMWU5QRlJXMHhEN0xqTnpOQWcy?=
 =?utf-8?B?d1Qwdi9IejNvOVhheWNxSUY0Z3gxTkUwRTlKYm90UlJLR0ZCZVVwWE5Udm1D?=
 =?utf-8?B?bVorMER2cGxJSFRzdit6WWJYMTdRbk1ZUmhhMlZScFkreDJwNmRTN01oVDlV?=
 =?utf-8?B?RGQ5OGZMRDhYVXRORzVEb0FuSnE4WUdxTkF3ZHlxUlM3TUxjSUVqY2EzbGpR?=
 =?utf-8?B?R3dDcjJiR0kweTdyUmppeFhiMDZhdlVkRE5XaXRmamV6MFZNSjZsWG9EM3lT?=
 =?utf-8?B?MXU3Y2xwV3RRZ2VNaFlPQkFuUjEzYjJzZkpodW9IUms1V3VQOWk0V2RndmxL?=
 =?utf-8?B?QmdkLzE5cDUzQVo5NzFxY29QeDJDMTNrczFlQ1pibThhUG4wM3RaQ0pHcXBJ?=
 =?utf-8?B?d1JTNC9nWTNPR2VzbDhJYnNJdDMycVJUWi8zSmJPZ0JBbVN2elJ3WDBIaE85?=
 =?utf-8?B?VHRaTXgxZGJmS3RnaTVEVENvTEhYSjlOak5LZkNTU3NMSzUwMnJtcmZiNm9q?=
 =?utf-8?B?RXZVeVRzWUxTdmtWUGYvWHN4WTZ0RTNpTWYyZncxdnFyWVQzZGZIdVNoNndo?=
 =?utf-8?B?OU9ZZjh0RnN3K0hXOEszcEZ5aEVoSXdwVDN3ak93SFU2cytYeDh2ak92dkVT?=
 =?utf-8?B?SlVCSnUyTnN0OWFYbVdlNE53U3N4amF5eWJzQ3Z4ZFpQb2syYlpXdnNBb0Jl?=
 =?utf-8?B?VUVCUWhheGo4bUR2SDdmbGxXbGNyVUc0MWZyUWUvT3p0YUZvTWFtQ3NIUi9T?=
 =?utf-8?B?MDk4aVlsWVN5YS9EUW9XY1V0RkRQT091UlVoSEVwTFptUTFWRkpLeVp1RDlE?=
 =?utf-8?B?TlRvczZHOFFmdFo4bm05aG1YbkFwOTg4aE5LT0xMeVNmTHZaalcvUzRGUVhC?=
 =?utf-8?B?WmN6cyswbE9IL2pFM3owaU82UUV1SlNHYjdLM2Mxck04VGVEVXJud2d0SzRm?=
 =?utf-8?B?clJzSXJKakF0NnlacHo2SEJsMWljWDcwQW5WYkdid0xla2Izc0tHSEFlMGFV?=
 =?utf-8?B?dm85aFJNcmlYYlU0cU1QRzZHMTdpWnd1SU0yN2RXYnU0ZitSK1libDFMdVUr?=
 =?utf-8?Q?SwDa+KrYHH1CtQOB4oAuf9Zmh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR02MB6230.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b822a2-da98-4718-aca9-08daf3b25bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 09:00:59.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: de0795e0-d7c0-4eeb-b9bb-bc94d8980d3b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IBiIn9TAn3SYsqg51ljG6url6mJlf8f3MSy7QWMT84EGXgAbQo4EAqKPjKXMYCUV4Cy7NTWMxp60qnughT1ECQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5705
X-OriginatorOrg: wistron.com
X-TM-SNTS-SMTP: 7DC07C57685D220C8695D938063E2D6886E65C3458E3696CCD47D5710E419B122000:8
X-Proofpoint-GUID: q_OzFelNV3hxHc3gfuOGEBDwrJG1ZlBl
X-Proofpoint-ORIG-GUID: iW3icxDnpCm2J5zWUp5ehmETKiiS6bH0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_03,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110068
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnkgSSBkaWRuJ3QgZGVzY3JpYmUgaXQgaW4gZGV0YWlsIGVub3VnaA0KDQp3ZSBoYXZlIGEg
c3RhbmRhbG9uZSBkcml2ZXIgdG8gZG8gYmF0dGVyeSBkZXRlY3Rpb24sIHRoaXMgZHJpdmVyIGlz
IHNlcGFyYXRlIGZyb20gcG93ZXJfc3VwcGx5IGRldmljZSBkcml2ZXINCmFuZCBub3QganVzdCBy
ZXBvcnQgdWV2ZXQgdG8gdXNlcnNwYWNlLCB3ZSBhbHNvIG5lZWQgYSBtZXRob2QgdG8gbm90aWZ5
IG90aGVyIGtlcm5lbCBkcml2ZXIgImJhdHRlcnkgcmVtb3ZhbCBldmVudCINCml0IHdpbGwgYmUg
YmV0dGVyIGlmIHVzaW5nIHNhbWUgYmF0dGVyeSBkZXRlY3Rpb24gZHJpdmVyIHRvIHN1cHBvcnQg
ZGlmZmVyZW50IHBsYXRmb3JtIGNoYXJnZXIgZHJpdmVyLg0KDQpieSB0aGUgd2F5LCBzd2FwcGFi
bGUgYmF0dGVyeSB1c3VhbGx5IGhhdmUgNCBwaW4gY29ubmVjdG9yIChwb3dlciAvIGdyb3VuZCAv
IElEIC8gVEhFUk1BTCkNCnlvdSBjYW4gZmluZCBzb21lIHBob25lIHRoYXQgc3VwcG9ydCBiYXR0
ZXJ5IHN3YXAgZmVhdHVyZSAobGlrZSBTYW1zdW5nIHhjb3ZlciA2IHBybykNCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IENoYW53b28gQ2hvaSA8Y3djaG9pMDBAZ21haWwuY29t
PiANClNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgMTAsIDIwMjMgOTo0MCBQTQ0KVG86IEFuZHJldyBM
aWVuL1dIUS9XaXN0cm9uIDxBbmRyZXdfTGllbkB3aXN0cm9uLmNvbT47IG15dW5nam9vLmhhbUBz
YW1zdW5nLmNvbQ0KQ2M6IGN3MDAuY2hvaUBzYW1zdW5nLmNvbTsgbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gZXh0Y29uOiBBZGQgRVhUQ09OX0JBVFRF
UlkgdHlwZSBmb3IgYmF0dGVyeSBwcmVzZW5jZQ0KDQpPbiAyMy4gMS4gMTAuIDExOjM2LCBhbmRy
ZXcgbGllbi9XSFEvV2lzdHJvbiB3cm90ZToNCj4gVGhpcyBpbmZvcm1hdGlvbiBjYW4gYmUgdXNl
ZnVsIHRvIGRldmljZSB0aGF0IHN1cHBvcnQgYmF0dGVyeSBzd2FwLCANCj4gZm9yIGV4YW1wbGUg
YWxsb3dpbmcgdGhlbSB0byBpbmRpY2F0ZSB0aGF0IGEgYmF0dGVyeSBpcyBwcmVzZW50IG9yIA0K
PiBub3QsIHNvIHByb3ZpZGUgYSBzdGFuZGFyZCB3YXkgdG8gcmVwb3J0IGl0IHRvIHVzZXJzcGFj
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IGFuZHJldyBsaWVuL1dIUS9XaXN0cm9uIDxhbmRyZXdf
bGllbkB3aXN0cm9uLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2V4dGNvbi9leHRjb24uYyB8IDUg
KysrKysNCj4gIGluY2x1ZGUvbGludXgvZXh0Y29uLmggIHwgMyArKy0NCj4gIDIgZmlsZXMgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9leHRjb24vZXh0Y29uLmMgYi9kcml2ZXJzL2V4dGNvbi9leHRjb24uYyBpbmRleCAN
Cj4gYjRkZjQzNzJmMDk3Li42YzQ3ZDIzMjQ0YzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZXh0
Y29uL2V4dGNvbi5jDQo+ICsrKyBiL2RyaXZlcnMvZXh0Y29uL2V4dGNvbi5jDQo+IEBAIC0xODQs
NiArMTg0LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgX19leHRjb25faW5mbyB7DQo+ICAJCS5p
ZCA9IEVYVENPTl9NRUNIQU5JQ0FMLA0KPiAgCQkubmFtZSA9ICJNRUNIQU5JQ0FMIiwNCj4gIAl9
LA0KPiArCVtFWFRDT05fQkFUVEVSWV0gPSB7DQo+ICsJCS50eXBlID0gRVhUQ09OX1RZUEVfTUlT
QywNCj4gKwkJLmlkID0gRVhUQ09OX0JBVFRFUlksDQo+ICsJCS5uYW1lID0gIkJBVFRFUlkiLA0K
PiArCX0sDQo+ICANCj4gIAl7IC8qIHNlbnRpbmVsICovIH0NCj4gIH07DQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L2V4dGNvbi5oIGIvaW5jbHVkZS9saW51eC9leHRjb24uaCBpbmRleCAN
Cj4gYjBiNGFiYjAxOGVlLi44ODIxMGI0ODFiNmMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvZXh0Y29uLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9leHRjb24uaA0KPiBAQCAtODEsOCAr
ODEsOSBAQA0KPiAgI2RlZmluZSBFWFRDT05fRE9DSwkJNjANCj4gICNkZWZpbmUgRVhUQ09OX0pJ
RwkJNjENCj4gICNkZWZpbmUgRVhUQ09OX01FQ0hBTklDQUwJNjINCj4gKyNkZWZpbmUgRVhUQ09O
X0JBVFRFUlkJCTYzDQo+ICANCj4gLSNkZWZpbmUgRVhUQ09OX05VTQkJNjMNCj4gKyNkZWZpbmUg
RVhUQ09OX05VTQkJNjQNCj4gIA0KPiAgLyoNCj4gICAqIERlZmluZSB0aGUgcHJvcGVydGllcyBv
ZiBzdXBwb3J0ZWQgZXh0ZXJuYWwgY29ubmVjdG9ycy4NCg0KQWN0dWFsbHksIGJhdHRlcnkgaXMg
bm90IGV4dGVybmFsIGNvbm5lY3Rvci4gVGhlIHBvd2VyX3N1cHBseSBzdWJzeXN0ZW0gYWxyZWFk
eSBwcm92aWRlZCB0aGUgUE9XRVJfU1VQUExZX1BST1BfUFJFU0VOVCBmb3IgdGhlIGJhdHRlcnkg
cHJlc2VudC4gWW91IGhhdmUgdG8gZGV2ZWxvcCB0aGUgcG93ZXJfc3VwcGx5IGRldmljZSBkcml2
ZXIgYW5kIHRoZW4gdXNlIHBvd2VyX3N1cHBseV9jaGFuZ2VkKCkgdG8gc2VuZCB0aGUgdWV2ZW50
IHRvIHVzZXItc3BhY2UuDQoNCi0tDQpCZXN0IFJlZ2FyZHMsDQpTYW1zdW5nIEVsZWN0cm9uaWNz
DQpDaGFud29vIENob2kNCg0K
