Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1250726DE6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjFGUqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234768AbjFGUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:46:12 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE52D48;
        Wed,  7 Jun 2023 13:45:54 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357IRNU1032526;
        Wed, 7 Jun 2023 20:45:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=rPZrTv7HOXPYSoGKEgKH62iBBJpI4KRFtXDfvAqtkds=;
 b=Vb2xrV12uML4YZk/WyKEXKoP6OhDtcdkfzNA+JS48uRSvxqa+5S2UB0Pnn9VvMcJ+Tew
 nvXx9HVcpA98ocJT2mKt3QHER+jfNy7Vg9pE1Ufx37+SX9hBnTGIOZ3xqi1+h/4D8UEf
 5vhbTWMED0CIFJ8RmTZUy/fm123O5ginQbcLUtYCU+pjPCssnTLaLs202F8NxeeWObtb
 nNWROVrbWjf17NRTiqsufcZd/vHK8iNlgqy09TMprP+okoZuaIJYW9ZdFh8ZPudf3ic6
 O5nBsRBjuU21kdwXtsqZKaJ6m/1Vv/dJTFVfs1QL+WCx7IQh96SEIviAHL6/xmFJHkpa Zw== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3r2a9p2fqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Jun 2023 20:45:34 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 7DD1E14788;
        Wed,  7 Jun 2023 20:45:33 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 08:45:33 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Wed, 7 Jun 2023 08:45:33 -1200
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 7 Jun 2023 20:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyvXFDNbBpQrl/83CgSEwtKxZbYe6LOqmZfTtjCPTowEOX4Jbyi8MJFlj5ul4il7kvLgUKTQFN+5CsRqbUGxAMburdKrYy0LZUtsaNdpvrCLq2Y/wujarVjW80JXGOIBk7X0XWrO4feYMdoobXqxBBVhH376vMrG8+NrQ9SyfRMNI8f9hrbc6A8rC2JvUyR7nXg2sChswCW520yrE2ivcJ68qIv3bL9Vtq63J/3/comnei1m41gPJW9kZrVj2982a/h64vmJfm6phc27sP/u3VlkArG8j39/1TVA9cVmrKZl5YaI7Mj6ModzvniKNkhVmwCiozu/tR+PtJdGKHppCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPZrTv7HOXPYSoGKEgKH62iBBJpI4KRFtXDfvAqtkds=;
 b=GSd24nshGhHKRDG1RxTRKcROLZadql6jR+EeDt9I/AeQJ0Bf/25X1DaxCBB8jJZ3CO63xwtA+mqrF3ndC1nMV4fGk4sPXORhmRCDQwwjxWj97BmEIGOzyCvx5FzzXJPrpDCfCSoTjifO3LUFzj5+Z1j9h998RB5ygaEKHcvfEDLBShzNV50fjNhIsT3k+W6+S6o/45hIiSO1/3MJBdrgEmlA68wRzOvUAA+oubSDtoqpX0dwntcWZmRVUaGh/CWY60+mUVZEuNiVN301BgTPueSVD8gbtfemsGRQqMwwsUlpIzJsT0pNSLcfqNXM09vYUuJuufX5lYASfO8iqx/NKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 DM4PR84MB1687.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.22; Wed, 7 Jun 2023 20:45:26 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::2a07:1ac6:6523:8682%6]) with mapi id 15.20.6455.037; Wed, 7 Jun 2023
 20:45:26 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Topic: [PATCH v3 2/5] gpio: gxp: Add HPE GXP GPIO
Thread-Index: AQHZmBjF4JEt/zYBEESMQ0szz/IlCK99gJKAgABZOsCAAG30gIAA6I8AgABaYAD///NGgA==
Date:   Wed, 7 Jun 2023 20:45:26 +0000
Message-ID: <7FEECBB4-482E-4719-94CA-6D10E4C08078@hpe.com>
References: <20230606014234.29491-1-nick.hawkins@hpe.com>
 <20230606014234.29491-3-nick.hawkins@hpe.com> <ZH76x6E9cbfrJHeu@surfacebook>
 <DM4PR84MB19278E9DD0BF34C570F714708852A@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
 <CAHp75Vcc9hh6MYPSCJa1vniU=rC4Y+j9pCS4Np-b-Pyh5eUwNg@mail.gmail.com>
 <81CFCEE8-5276-475A-A2AB-A814DEDA04B2@hpe.com>
 <CAHp75VeZkLSTw8OFmDMYb+im0qK0NQRHpndzBM7fMHm=HZCzeA@mail.gmail.com>
In-Reply-To: <CAHp75VeZkLSTw8OFmDMYb+im0qK0NQRHpndzBM7fMHm=HZCzeA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.73.23052700
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR84MB1927:EE_|DM4PR84MB1687:EE_
x-ms-office365-filtering-correlation-id: 66620f01-189b-45de-789d-08db67981f90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zUoQx0nSktVnDOO4JaSv1ltjOPDp+emFwIVyLI0QMkczedMdf9352NZsbZKrZLu6LeTUn+bfI7rlPF+Ho7+hJUnXrAdo9T24IGgANey6XG4DGaTfVkoYSGfEW60osT67NCGgNFtASvTa1RmNOZ5ESl/Zzw3xW3cWRSUZfrHCrWNs2xeP+1+Bu21bVsIVBHP6LtgugsG4PMGDysjN4k1aQYKApfBnt6m0anAQsMGtiTEKbnfYKW/tiJ4OdKA1HZzIdvb/EdZ/cbNM32Zh/wrmRsV+RkEyLmBM/g1PXtdUXui1alSJFMzpEa10kSvSmcC4BpW1RoXIwaA+Z6w/ThxsU73GVorVDym4G1ZbQmMu86r5qxX+y1TRdSwKfjOOa0oiqtm2dNxQpYu3kQkbyeVA5RxxlGpJ93VnBqWIdohTSIG7JFZMlgdFoRw112uIp+7Y820RkcXv537BwxKlG3FY3W2+ElE90Ms2s39S6irce74o49tre12Hgj4yvFj0W6V+AfrV0YOv5Sz7BNentS/2w9DsfH/isQWm/+CV7oSMT7GF7BysmIDLAQOhTCZnVgQadtq9bH91mWfYcFXiJ0A+X5ifXWDkjnD2reZVdMMRn0CXIiA/PCtC03SlEBi/scZo17pKr9ddtZ1pyNP1qmVlng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(66476007)(91956017)(66556008)(66946007)(76116006)(66446008)(8676002)(5660300002)(2906002)(7416002)(6916009)(4326008)(64756008)(316002)(41300700001)(54906003)(8936002)(82960400001)(6486002)(478600001)(122000001)(83380400001)(36756003)(2616005)(33656002)(186003)(71200400001)(6506007)(6512007)(86362001)(38100700002)(38070700005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2JTdzVWY0FZMWFrdU8yVWIvMTVvSy84anUrSFpZOWtPRVQwcmlnYlZlNGFw?=
 =?utf-8?B?TGxyWVFBTVNnNjJFb20wSlNZOWJHWTJabEp1QmtMWXlhcDhPclhQZktlNjk1?=
 =?utf-8?B?aVprVDEya09rQXN4TUdwaE9qUWZYNEdpRkx2UUtaaWJOdTRQOTNyNTNPQTlq?=
 =?utf-8?B?QXZwUFArbUh1cXZBZzBBcEY1K0UwWTNVQ2xSc1VPRVlCY09PSU5LVlJscVIw?=
 =?utf-8?B?eUdvc215WjdnTUNXeVhSMFY0dzc1ZEc1RmU1enRsL3UwQ0syVGtiYzN6eFRn?=
 =?utf-8?B?UzFSYkJnVVpnMG9WSEVyS05tVnliWldDUkdkYUVQd1NwNjFqZ2ZqK1IzOWF2?=
 =?utf-8?B?NENtRy9GcFJBdEVlK0xvYXFBT1JoMG96cG5oVEJPSENibFN6Mzdsc2c5QzZJ?=
 =?utf-8?B?NkZPOXVWaXBKNWxmQnppbWtJZjN4NG1yT1pIY1JxT0hJS3lINGRLT2NzMnA5?=
 =?utf-8?B?ZGNMZHFWdzVna2hhZTRkR1JGRFR4MGZHWnBIbFFVdEFCeXgzanJERWxQQm1N?=
 =?utf-8?B?bU5aK1g1K294bGJGSVhCV21ycXRzNUFDbzE0Z01CU2xpV1dXWmRGclkzOWUr?=
 =?utf-8?B?NExpaXZlKzlla25oSFRrY1VRWHIwMGt5TlczV0hXV1pLd1I1c1l2VTRhWkha?=
 =?utf-8?B?SGFPVTl0V0hycDhSZ3RINkJoVWJ1L08ya000TGJMT05zL0FJa0YzS1VmTjBz?=
 =?utf-8?B?NXJTRTM4SVJBN0Z6dUg5ZEpmbVBodlNUU2E0dzY3VVUrY00zZm8rVTBLR3hv?=
 =?utf-8?B?VWhqekRoVml3b1ZhOHh0U2VrQS9XSTdPcXcxbkNUSnB2WVlabHcyWmpyUW42?=
 =?utf-8?B?eU5WNkhHSWRORGFocitkeVFBVm1vaDZnOXJNVXlwK3Q4bElNc1RXWGdWcy92?=
 =?utf-8?B?ZmtiZy9yZEhhUzBidzg3UDRxNERtR0cyNEVTS2RuZTNHL05lZVdiRFJiaEhr?=
 =?utf-8?B?NTRvZFRYWmNiSEJ5QVZGTlRzWGxPSHFkalQ2b0Z4QlBvYmN4akFSWHJMVlE0?=
 =?utf-8?B?dlJDWXZMWW5DZWs3b09nZDlrQzBWZXJqcVhxeVJkZUFNWEZoVEhKcEl1V2Fv?=
 =?utf-8?B?UU42OGh2bk00SWUvYklZR0x3Tkd0YVExeWVLRU50dXJSbXNIR1lVdjlNU1dx?=
 =?utf-8?B?UkhLNXpBOExqN1JaRTBxVU9vYnR4MEVQc2VhejRVVk1PUXk4ei8zcTJpbEZG?=
 =?utf-8?B?dk1XUFp6NHgweDROcDQ0Q0tZSytoNWhTSFJyYVNBaWlabFladkF3b2VlYVZ6?=
 =?utf-8?B?ZG00R0VMMkdSL2g1ODlCUVg0d1B5Rm1GcnJhbGNqUEJuMkIzeXZ4aHhwd2N0?=
 =?utf-8?B?UzMyRGtLcUtodGxETG9NaXJZZUorTUt2WmhRSllzaEtuUWpTbDZpUVdzME5F?=
 =?utf-8?B?SUxrVndvRnBCMWl5ckt6VXFLSWExalB2c3g2YlRWUUk3NXE0c3lZWmlMVmRa?=
 =?utf-8?B?THhhUEtIcmRjZkVWRWJvRFVRQkhja1lDMy9HNHdROXlsdzA5Yk1IcUxtekhO?=
 =?utf-8?B?bC8wQkVoY0x0bW1CYWp4dVYwdHFmdzZEWlpoZU04VlhZU3FRblJrQVpybkkz?=
 =?utf-8?B?VlJhNERmVjFoNHg4cUlRUjFHSWZRS3ZQNVBKdjNGRXRZRU42dHNoL1F0Z05P?=
 =?utf-8?B?eWZPSWN1alF2SE9VUUJzd01EbDhleWtTSGlnd3YvTmNFYW82by90OW9BdXk5?=
 =?utf-8?B?QnNIeUtDSGplbTBZZ0V3akZ1MXJoZS9jUHFVREl5c1FlR2lQakwrWTVjMkVt?=
 =?utf-8?B?dEpnRXpBYkE4M1V4U3lTOElLR1RzU2RheWtnVi9hMElIcVJTTEVBdWM2RG9T?=
 =?utf-8?B?cGw0L3doK3RYVTJCSEVnWVpBbDg5MEpLUlliREYyMFhSQTNJLzhCeWFiU2hY?=
 =?utf-8?B?aW11RlQwaW8xVmVQdWs3d1VRQ1pmS2FTM2NJODNiZ3N1V1NmaEFObUZoQlg5?=
 =?utf-8?B?ODJMN1pDUU81R2Q1Q1VSY2tLL05rZWZDc0l6Y1FkYjZTUDRZWEpLTE1ON3Fl?=
 =?utf-8?B?aDdJaDhSQkRCS1NuWDU2Qm5wRjRVY0N3U0lyYzNheDlsMURseW1zRDh5ZDNJ?=
 =?utf-8?B?d1ZlcGJyZVZYWjQ5SG1CWUJtQkFmdGh3Qk5NdHFReSsvMjZhSzdUTExlcTd1?=
 =?utf-8?B?Yk1zS3BLS1F0SVgzS093VXkwc2hSQ1F6SURlNzRqK2owbGJhbzZpbkZEYllL?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16A39FF0550ECD4181C3D96A848616C2@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 66620f01-189b-45de-789d-08db67981f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 20:45:26.4831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOfgIqbpuBpC24ap8OjMF1A0hyPAMiGz+ojX6kclajPxD6aSSEFg8MtGwi0EyVgdWbf8gJl0xqoM9wfg89VY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1687
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: cIax32X575s_hK01O9TnkIl8iefZjqay
X-Proofpoint-ORIG-GUID: cIax32X575s_hK01O9TnkIl8iefZjqay
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_11,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxlogscore=607
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070180
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

PiBJdCBkb2VzIGNhcmUgYWJvdXQgdGhpbmdzIHRoZSBhdmVyYWdlIEdQSU8gY29udHJvbGxlciBk
cml2ZXIgbmVlZHMgdG8NCj4gcmVwZWF0LiBTbyBhdCBsZWFzdCB5b3UgbWF5IHRyeSBhbmQgc2Vl
IGhvdyBpdCB3aWxsIGxvb2suDQoNCg0KPiA+IElmIGdwaW9fcmVnbWFwIGlzIHJlcXVpcmVkLCBo
b3cgZG8gSSBjcmVhdGUgYSBkaXJlY3QgY29ycmVsYXRpb24NCj4gPiBiZXR3ZWVuIGEgc3BlY2lm
aWMgZ3Bpby1saW5lIGFuZCBhIHJlZ2lzdGVyIG9mZnNldD8gRm9yIGV4YW1wbGUsIGluDQo+ID4g
Z3Bpby1neHAtcGwuYy4gR3Bpby1saW5lIGF0IG9mZnNldCAwIChJT1BMRUQpIGlzIGF0IHJlZ2lz
dGVyIDB4MDQuIFRoZQ0KPiA+IGdwaW8tbGluZSBhdCBvZmZzZXQgOCAoRkFOX0lOU1QpIGlzIGF0
IHJlZ2lzdGVyIDB4MjcuDQoNCg0KPiBZb3UgbWF5IHJlbWFwIHJlZ2lzdGVycy4gU2VlLCBmb3Ig
ZXhhbXBsZSwgZ3Bpby1wY2E5NTN4LCB3aGVyZSBzb21lIG9mDQo+IHRoZSByZWdpc3RlcnMgKHdp
dGggaGlnaCBiaXQgc2V0KSBhcmUgYWN0dWFsbHkgdmlydHVhbCByYXRoZXIgdGhhbg0KPiByZWFs
IG9mZnNldHMuIFNpbWlsYXIgaWRlYSBjYW4gYmUgdXNlZCBpbiB5b3VyIGNhc2UuDQoNCkdyZWV0
aW5ncyBBbmR5LA0KDQpJcyB0aGVyZSBhbnkgZG9jdW1lbnRzIGF2YWlsYWJsZSBkZXNjcmliaW5n
IGhvdyByZWdtYXBfZ3Bpbw0KcG9wdWxhdGVzIHRoZSBHUElPIGxpbmVzPyBEb2VzIGl0IGF1dG9t
YXRpY2FsbHkgZ28gdGhyb3VnaCBhbmQgYWRkIGxpbmVzDQpmb3IgZWFjaCBzdWNjZXNzZnVsIHJl
Z21hcF9yZWFkIGFuZCBiaXRzIHBlciBieXRlPw0KDQpJIGhhdmUgdGFrZW4geW91ciBhZHZpY2Ug
YW5kIHVzZWQgdGhlIGFkZGl0aW9uYWwgcmVhZGFibGUgYW5kIHdyaXRlYWJsZQ0Kb24gcmVnbWFw
X2NvbmZpZyB0byBsaW1pdCB0aGUgbnVtYmVyIG9mIGFjY2Vzc2libGUgcmVnaXN0ZXJzLg0KDQpz
dGF0aWMgY29uc3Qgc3RydWN0IHJlZ21hcF9jb25maWcgZ3hwX3JlZ21hcF9jb25maWcgPSB7DQog
ICAgICAgIC5yZWdfYml0cyA9IDgsDQogICAgICAgIC5yZWdfc3RyaWRlID0gMSwNCiAgICAgICAg
LnZhbF9iaXRzID0gOCwNCiAgICAgICAgLnJlYWRhYmxlX3JlZyA9IGd4cF9yZWFkYWJsZV9yZWdp
c3RlciwNCiAgICAgICAgLndyaXRlYWJsZV9yZWcgPSBneHBfd3JpdGVhYmxlX3JlZ2lzdGVyLA0K
ICAgICAgICAubWF4X3JlZ2lzdGVyID0gMHg4MCwNCiAgICAgICAgLm5hbWUgPSAiZ3hwLWdwaW8t
cGwiLA0KfTsNCg0Kc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfY29uZmlnIGd4cF9pbnRfcmVn
bWFwX2NvbmZpZyA9IHsNCiAgICAgICAgLnJlZ19iaXRzID0gOCwNCiAgICAgICAgLnJlZ19zdHJp
ZGUgPSAxLA0KICAgICAgICAudmFsX2JpdHMgPSA4LA0KICAgICAgICAucmVhZGFibGVfcmVnID0g
Z3hwX3JlYWRfd3JpdGVfaW50X3JlZ2lzdGVyLA0KICAgICAgICAud3JpdGVhYmxlX3JlZyA9IGd4
cF9yZWFkX3dyaXRlX2ludF9yZWdpc3RlciwNCiAgICAgICAgLm1heF9yZWdpc3RlciA9IDB4N2YN
CiAgICAgICAgLm5hbWUgPSAiZ3hwLWdwaW8tcGwtaW50Ig0KfTsNCg0KVGhhbmtzLA0KDQotTmlj
ayBIYXdraW5zDQoNCg==
