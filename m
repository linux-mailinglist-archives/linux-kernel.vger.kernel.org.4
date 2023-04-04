Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344456D6C72
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjDDSjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 14:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjDDSjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 14:39:17 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2058.outbound.protection.outlook.com [40.92.98.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E6B3;
        Tue,  4 Apr 2023 11:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMoEAdQMvAnYdZCYG4Wf/4ArQC7/2uHkovxALm2NUugM3gOINjwXthTiSAfYsVvcy28GI2/ujCJcbyAysUkfz6gyKlplDaf++8jVQKuKyemY+H0Ndj2rXQ0KAxgx/o9M9fpalwCgVGpgl4M1SYUeeXPtla4wywLeRuFnPaWDMBy5OXML2mDJKV0cUx667ml1jN1mnxCW3o2tLbDumrbIaEGfLMLDwOX0uyt/it7CYX8DlygaU46v3KeJcTcYWwWHe9MLUJoH2bQAxR2iCFMOfvmAD2pHByT5dVmd9mRbUzG+ggzYM2JfB0HQ8zzPGMcaszNGtArLcuxD1EqQiixSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/7pP4xIBkZRY6TZBkzYTzSCPgM9vdoj9i2ceWBlF44=;
 b=HPNuMiYSvp0ytSiS45DSjNjX+PkWekmX0u1mtYLH4QX3ZXpwb7QzuZBbDB5EUKqPYyjcHQUauHkhcsGNaUH0ga6nk14PY5ExDyc4YceJBptHRM6VhQD9CtMEI0w8dtQKE4lDaBVTJjjSuzjTjsKFfAE4G1vj/iVsgAk+vnl+3UVLaz9GE+VSSiidxtmkM/SNenGM1wzWM0SjBJTtFP8crwhvXP4B/tZTzNdB3L9W6LPQM+Egcrzrh3nUUQ6/sD2vGfzwaj91CJMXezp/v39csQrAGfsxqTmG08vsq+pBhvve2cYW2Q1x100OsnvZFLgsV/Oq/bcM8Zins9zfZ2Ojzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/7pP4xIBkZRY6TZBkzYTzSCPgM9vdoj9i2ceWBlF44=;
 b=GdFro0p0Kr6dlK8HXf3ZiDHz4ytLtLbL7ooti17kdf5p40E0jlx9DBZ1F8O4CjP5yjm5jjBwiVSdKVq/hSnGhEijQf7xWg0GW39ObHVRS8g1vxgLkc1hzhveUwRPxjPQW6PPE7Ak5fbiJCMUsBHmC27N0kZfTt7Ym66mq/TqtV+wj2sE51DkBJYBsf+7dcGA+QUmTQuXh+3klAoj5+dnCk8afUoNt17RX5qTSmwidRD8AcJhxOL/E9WBK/OgFpOChDWq5j15Mg+Gwm3DpYF90p6pGoHLFAMWjj0yTCPcmwTDYyYhpgG25v/GyMdEpXVXL1kimrDZXko4ekJ6bxWNEw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TY3P286MB3707.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.29; Tue, 4 Apr
 2023 18:38:39 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:38:39 +0000
Message-ID: <TY3P286MB26110E2983EB074270B7610898939@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Wed, 5 Apr 2023 02:38:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v7 21/22] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
To:     Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230401111934.130844-22-hal.feng@starfivetech.com>
In-Reply-To: <20230401111934.130844-22-hal.feng@starfivetech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8HF3TC0sXHjaWIZDvCSGvh97"
X-TMN:  [U6g5yN3+E4SR5WCMq18FwqWt/5+z/CUe]
X-ClientProxiedBy: SG2PR01CA0113.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::17) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <a913d80a-6d42-2a52-4995-1a29cf28f3e8@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TY3P286MB3707:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b6c6eb-35e4-4dbf-102e-08db353bce85
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qfl6LqDtj2L8UK0vQMRTYSg2/E5KHENzUBWlxa9Z7VhgZAgq3HAs7FSY4sghewJewHMTh4W85eljbWxuNaTa5hebkhfrZ+QDqLFes7/8dxtNuuajjzyRkFuG8aYGUyhnFZLbh3IpBA614/myUmWELbvgyNgNvtvqPHrM4+kK2rwzf9VNbo/rCZpdo1W1sot/cKYuwt0YNkahQkGMxCCplM0BKnHnCfXTl477eMk3itT1USE1TEJmh944r+7xYcR/MaO+TQIcJfeKfeFi2LkbsijUQ41pU4xzl/8HUmQ/xnQBo33PlxhBioenBvpItdgJhj2K4DtmkWlA+2tpmiWu6uWACdXyeRo9boutS+fwxu5vcWMbD70JO7cYVBNDDN7u0bEZDwxEbjUcXfRmCNzIl26stR6C+2VytVlJKWjJDK/VN2f1e5MiHJH+/z5DJmdHKq+0enyxnsTOQIhwnWhkuYIpUxGux6jPiStxB1IUjObqHuLp6xe7V96tXGc+qCJORj6ARVv5zo8nYDqYfjE8FTHX+Kmccs2nZhe1GQcZq+hyUlcja+yHUj4gO7iUBpL7VPsnqqHKJ6oEVA6cN4t9kVq+/QZtef7YA2ZN1gdxiAjEdqIOWU04DPP36A+x4DPu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V09jTlJWVjlWMWtRTDhEbEV3bDE1VXc0V2VqR1BGS2NNc3o3UVZjbzZCNTUv?=
 =?utf-8?B?WUUzM0tjNDZRZmFaNUNkWWwwU0xDY2MrUkxkY0pLK2ZISklYRTRlcW92cHFC?=
 =?utf-8?B?U3hNS0VwcWNQYUZHaXUwS0RrSldKdTV2bmIwMnlVakFMVFM2eFlOZGdiMlUx?=
 =?utf-8?B?cG50aVdpMU9PcWprRHE2eTE1TFF5Yk80RVZBbVZQd29WYnUrcjVUb3liR29p?=
 =?utf-8?B?Z0UrN2U1blBMNFQwYnZvVmFPWGg5ZUtOYzhCaFFPT1R5SWdRWmVMNXcxVzh0?=
 =?utf-8?B?KzNjNDRYbDRCZzdzZW9xKzNlNk15azVPTVA0cmg4elYyWFRDOHYrbUFiR1Zm?=
 =?utf-8?B?Unp0VXk0dytVOC9tb3ZmY2lJbXZSTFFEakRaY2RuTDdsbnB6ZHNYemRVSmNN?=
 =?utf-8?B?amp4U1daeWVGMkEyMTFVNEgyTWdBOW1BK3c4bjc2ZldrWithd2g1aTJ3R3k4?=
 =?utf-8?B?cFFRNDlhUWlBdHJBeERTekh6SndDWWUxWDdjdW5BVjVUQVlwOERsMFlvSlg5?=
 =?utf-8?B?MUMvQWJZTmRDVTRLZmVPYm80STRHUFNkaFo4OXowejBjZEM2cjdxSUFpaHdF?=
 =?utf-8?B?Z2tjTXpHejcyQW1VN2NkTm5EVFdwMlVHQUJ6c0JISzVYZmtaNFJiTVVMMFVa?=
 =?utf-8?B?QjhsbnpTTDZJV2s1aE1qbFZpK3FicklnbVVrR2lkYVp6NDcwS0VGZ2w0WERC?=
 =?utf-8?B?YnNtcWpWdUt5RDRDRGRnTVlkRGVFdGFBcGp1bndLdjdRem1Rc1JrdDh1Ykhp?=
 =?utf-8?B?WFBFc0tML2FnYkpDTEhFVW5YUkxYbFJLcTNPUFlKRjA4L1A3QjVzNWVlWEZK?=
 =?utf-8?B?Zm5LZEpxdkhZZ1lwUHpzMmZkTVdBbDZ5eU9GZzBDWWFtVi9JNUc3WVE5TTcz?=
 =?utf-8?B?Q3lMbUpRaVY0eGJEZm1OZExUZE1ZVVoxMTIxTXVMYUFtUHdheG5OSnREcHVl?=
 =?utf-8?B?c0hIcEw2bWtiTFcyUDM0VjdPQjhySmhtUE5wcUtiUnFxYk8zODJwZ0twR3dL?=
 =?utf-8?B?Uzc1bDNieFBDRWw3NnErdEV5bjNMamxWMENNaUtiVVVBeDNmelUyNlZwajNk?=
 =?utf-8?B?ODBBQUdFTHhDZGR2dlRUVzRsU2hmS3QrWlh3Ry9IYlF6N21IWG1VZVYxd2d4?=
 =?utf-8?B?dVFFMEZuUlRVSVllSGVCbjlSSElRdEpNalZGcjloQ2lBK0xNemRHS0NuRFRO?=
 =?utf-8?B?Y3ZYTDlTVCtvbUFNLzJVMDMzSVB5ekFRbVBpRkVEc3FiQ05jRG5uMjNtU1Ny?=
 =?utf-8?B?aDlGVWN4VWpCT3FBVUs5bWJ5aUE3bW12ZC8vYjRJbk56NExCUkdvd2wrRk0v?=
 =?utf-8?B?cHJTZCs3MzRMczJGaE1qa3k0UGFRNk9JUHhFOUV5OTJDNjA4SllLRWt1eUJG?=
 =?utf-8?B?MG5Rem1yZ01hTEthMVptSFdJaUY1elZ6WVZzbWpBQU92VUJ3cmdEOW9iSnkz?=
 =?utf-8?B?dUFNOFZjWEpxVTlWZGFSYWpLclpPNHlqVUVQSFJlMjY0SkV6VC9GbHVLMWlC?=
 =?utf-8?B?T1dNSWdtYkFYend0Wk5qejV4OXpzWlR0YjhIb2tOVGJLUEtmT25GQ3o2SkZy?=
 =?utf-8?B?OERkOGYxenF5T2RGWFVFYzF4SEhUSDdIVkNzQ1FYZnVIN0NhMm5ZT1JVNmFF?=
 =?utf-8?B?UE16aVlPcW9uT0NFamNyMC9MQzZ1Rmc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b6c6eb-35e4-4dbf-102e-08db353bce85
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:38:39.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3707
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------8HF3TC0sXHjaWIZDvCSGvh97
Content-Type: multipart/mixed; boundary="------------gFfzpMAoJmn1iNDJH0B5QOZS";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: Hal Feng <hal.feng@starfivetech.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Ben Dooks <ben.dooks@sifive.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Marc Zyngier <maz@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 linux-kernel@vger.kernel.org
Message-ID: <a913d80a-6d42-2a52-4995-1a29cf28f3e8@outlook.com>
Subject: Re: [PATCH v7 21/22] riscv: dts: starfive: Add StarFive JH7110
 VisionFive 2 board device tree
References: <20230401111934.130844-1-hal.feng@starfivetech.com>
 <20230401111934.130844-22-hal.feng@starfivetech.com>
In-Reply-To: <20230401111934.130844-22-hal.feng@starfivetech.com>

--------------gFfzpMAoJmn1iNDJH0B5QOZS
Content-Type: multipart/mixed; boundary="------------nRg8J0r7XWEmxNsDB1AIaiZm"

--------------nRg8J0r7XWEmxNsDB1AIaiZm
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSGFsLA0KDQo+ICsJYWxpYXNlcyB7DQo+ICsJCWkyYzAgPSAmaTJjMDsNCj4gKwkJaTJj
MiA9ICZpMmMyOw0KPiArCQlpMmM1ID0gJmkyYzU7DQo+ICsJCWkyYzYgPSAmaTJjNjsNCj4g
KwkJc2VyaWFsMCA9ICZ1YXJ0MDsNCj4gKwl9Ow0KPiArDQo+ICsJY2hvc2VuIHsNCj4gKwkJ
c3Rkb3V0LXBhdGggPSAic2VyaWFsMDoxMTUyMDBuOCI7DQo+ICsJfTsNCj4gKw0KPiArCWNw
dXMgew0KPiArCQl0aW1lYmFzZS1mcmVxdWVuY3kgPSA8NDAwMDAwMD47DQoNCklzIG10aW1l
IGZyZXF1ZW5jeSBvbiBKSDcxMTAgY291bGQgYmUgbW9kaWZpZWQ/wqAgSWYgbm90LCBJIHRo
aW5rIGl0J3MgYmV0dGVyDQoNCnRvIHB1dCBpdCBpbnRvIGpoNzExMC5kdHNpLg0KDQo+ICsJ
fTsNCj4gKw0KPiArCW1lbW9yeUA0MDAwMDAwMCB7DQo+ICsJCWRldmljZV90eXBlID0gIm1l
bW9yeSI7DQo+ICsJCXJlZyA9IDwweDAgMHg0MDAwMDAwMCAweDEgMHgwPjsNCj4gKwl9Ow0K
PiArDQo+ICsJZ3Bpby1yZXN0YXJ0IHsNCj4gKwkJY29tcGF0aWJsZSA9ICJncGlvLXJlc3Rh
cnQiOw0KPiArCQlncGlvcyA9IDwmc3lzZ3BpbyAzNSBHUElPX0FDVElWRV9ISUdIPjsNCj4g
KwkJcHJpb3JpdHkgPSA8MjI0PjsNCj4gKwl9Ow0KPiArfTsNCj4gKw0KDQpCZXN0IHJlZ2Fy
ZHMsDQoNClNoZW5neXUNCg0K
--------------nRg8J0r7XWEmxNsDB1AIaiZm
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------nRg8J0r7XWEmxNsDB1AIaiZm--

--------------gFfzpMAoJmn1iNDJH0B5QOZS--

--------------8HF3TC0sXHjaWIZDvCSGvh97
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmQsbqEACgkQX75KBAfJ
sRm9xRAAgn3dziVd+nbDsluGWbDVurFVX6cJ5jSh93TIvbTV7xevGVU8RklvzXX3
sM4zUMmLuK5HnoL4Pd91hjix8RG8wJ/3LJ+FPz2SoTBGFwfN3d+mz2viudBCCBvW
8WtCmVv+vgIr+gWQMg5CscvlN52J+YcgHiK4GCHjkARJZ1GpFH6MuDeGj8vQFYAc
PUS/MXm3KkkBvgLuyKpK0Zn10nCFHqT5KigVPLhkw1KxHjKUUkTkrttCCz3cUHGo
W/JZuR/QyO2EmQR61VeyrE4Kd7Pioz3yytS8JGFuVq9DjQ0BqoQjUhnGq8K54uqj
ffcqb1cXBABSKbkMpG4IJigRt7e/m7Kq6FOiMmp7Pd18VxeHsF4SVCBKTLFKfjxg
zoqb8UMhBaY5yIY4NdayEE6023iwZyeLqLDFukW67mF8UvFRxoh/M/JdmrRXR+Sm
2GsJKoPD80SoypC8O8HjkwdGjVWDrPEdzESDS2FbMXLYeXYuwxTrUJfT3lvr4q8X
EVHmmBsld636cS6E1sKl4nT8fCxVaoUAhHCZLzHG+pSQOHDrLH9bSMdCnSp59KFP
4yMZoIt25yfHH9+nYgw6GXOhXCuVzBbOnh5tjIYlznOMk8JB4BMlBUAAfuKozZpB
SyLhhuZ+WlHwEyG65prSneS2Z0J9LPcyNGS8ZtjkrbyRUBIYo2c=
=+4mA
-----END PGP SIGNATURE-----

--------------8HF3TC0sXHjaWIZDvCSGvh97--
