Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D93167677F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 17:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjAUQvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 11:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjAUQvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 11:51:10 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2058.outbound.protection.outlook.com [40.92.99.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B2B28D27;
        Sat, 21 Jan 2023 08:51:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo1pd6ncN6iSZ2l3l8WHj9Oduay/JeqvnGxzzL06kxJLZj5FL27N8H1fErxNnwSBNINRaA/aekS1HoBFRCnVs6cpu84F3dAV5/JWtnY0Ie4w689/idH/K5ze060uZXCcQc/zTFlqLbSE9JFNqOEiJ1k+Mr2ro7RzYsW4QNyiES1chUaHRN2dnQ/Ch0cyHzZAnWHw+12WD/W/BO8kT1nqHoCY8jKuC5yFKLmPUuwFLNlqoTYMM2gK6gXWdRLpiuNRV1wkHQrjaJ7GhlB73ioCDgZChRvm/PZTDPeCzpA4uFNl6/PuQTuzvF7NhKzsg1d1UUwCDIbeWI9CXWBBrXTVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SthR/2SMS7WQMSziJ0+v3+tzIbzriFNVZDPJktwx0S0=;
 b=FjYHc/M/Q+sRNU++POvkhdFge0pPN7Z2USSI5PgH7OFbVwLemmUIeHADc7UJFJe4FlOZMoqjW4gU5R/VO2z473gnnywutMcsQCM5DgOBCGgAk+RHOcmcSkQMBY+ybameHsgE2BOJAzc051ixHEKBlOddTA7ryVKGxcGVZYFPeDZnIbyjUdUyWDJvph8jFMHtPp6e2xDBl4aNE06txayLKMI7ARhl8F21XUFbcgEL4Fg2NSnqoZ19IwIGSXrLhdGK0FPzkPAz7IsY5W+xNx/TSx2ZVcX3pGNTR9WJqDfVvaLhS5xP59Y0jZXAN8lFKG5qtHTu8E0hdeUqe3e3sdVQfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SthR/2SMS7WQMSziJ0+v3+tzIbzriFNVZDPJktwx0S0=;
 b=pgEbiGH0JhjhDHnrdBYp0ZitUYG2yupvyqK6saboiwP2L5f6iPVGVNwF5M5PgkW7wwzLkPHDRfvhH0oqh3wuZzwC9cNYZW51L9iH59V7AB1so8aNgqHx7DmN+1lKueuRbXnn/2jyL7AKZXI/J81dBUKmuBu32kSYKN6BzuMUQy43C54X7sbr2reQ2QwdAPJxJj4adpsSRb2CH0Nugpn77sifAVej82tW70wwo6E8Dto4FveeCRI8//75aR5sOxS9v+AFiMG0FkCG8QkfrTaQlSl1BIVILuWnKupZaIeCezq/BtMlQNJJnn1boIHokK5eSaIuL+w0WIS76X2lauv4jw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by TYCP286MB2767.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:247::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Sat, 21 Jan
 2023 16:51:05 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::20f8:c5a7:6b12:55e7]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::20f8:c5a7:6b12:55e7%7]) with mapi id 15.20.6002.028; Sat, 21 Jan 2023
 16:51:04 +0000
Message-ID: <TY3P286MB26115F60D273E840D36A610598CA9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Sun, 22 Jan 2023 00:50:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To:     m.tretter@pengutronix.de
Cc:     devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
        frattaroli.nicolas@gmail.com, heiko@sntech.de,
        jacob-chen@iotwrt.com, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        mchehab@kernel.org, robh+dt@kernel.org
References: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
From:   Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------F1mVd8LcTKQ3sNpdyNTu36f1"
X-TMN:  [FvDflEHZbihBDeVVCc6YkxQzM4lP9WuskcYubqp3/ki2c1PZTdK/uJlQtEx7lyef]
X-ClientProxiedBy: TYAPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:404:2c::35) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <763a61be-9200-bde2-d82b-bf91c5f0dd8a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB2767:EE_
X-MS-Office365-Filtering-Correlation-Id: 331c6462-3d4b-4820-3284-08dafbcfae80
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzPHj8NpVCvkBWUWyV2hkZWQEiByosgNPDztrFPOdx+zAmCDt/KEvXQKXVHUVuUTE7TR8chLGO03HS2iFGY8OYGdDmn70c+LSCX4/ix6/gZDYlmpldZq2ZOiLVVSVKfocH8hctdpsu/hF8ZyYjcSihckHOMgCpZgKZfIbBOaxkVVRX5LHO6G6yNn3A+/2ZU2KS0sCSFwqwQyselo90dUbo55SvWESkcwU9RrLo77agZWqQgPdpslYg5Zd0JeEi4zHfnGcgSKPqKelV+Jpqj8xlpUU5BU+ksy8SB/zTxB1FaF5tvwJLs3cwKknYeNYcQvHyOou5GEjbwEPjyMeVJeXmz5+L8J0CoxSsFmx7N6J9dgf+7LgMYPpw5PZHuXyzyKXEHWSA3BqG84SfruZfOXTGKI2Z1NF/vyOsGcWKEUIlCRY9p63zU2zEFH8cZ6aFjHTVgoO3mEbbFysdPyhQhhvTYEBq6X600S1Wqr2FOw1o4RnQOae9TDKuxSoPMnmKIdFgYWEGqRv3681HOZQ4cmwva+c6s7Mp/johzOqVUm3eNpgEHozFheUw5BZG1oYVHzYigaeefpl8ksIi6+I5ej26JREVXvqOP1djpR+wDiZNhAc9Wg5jK1SYXzeQyEhR7Y49jrPPIXBWsTeKjp62OwmQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z29VeW9heCtjOHRWa0dqMWIxL3RBeUE0UWordHVXcy9SUk13c1VrWWpGcVZn?=
 =?utf-8?B?UHlSQ1lteFJ3Z2k5dVpyZDQyZnBxNXZHQ3FBbElFcnlOZDcwQXMxSzl2ZnpP?=
 =?utf-8?B?TXBGbExiSWdHbDBIYXRmTzVuMUV3aUYvOXExVnQyeEFzNk9PMGMzWHJIb05n?=
 =?utf-8?B?a1lINE5JR0l2OGljTjV4YkhnS2s4TUFFVm1wSEtjZUNxZVg1VmRPTSthekNT?=
 =?utf-8?B?aVBMRHZvNlJVQXNyY1hQbTdWZklHcTZFTHUvSFd0QUdBcUc3L0psS1ZDaEJn?=
 =?utf-8?B?bEFLV1E0UzJHSUdTRnZKSVFiUDN1WnE0c2ZWcjlSc1ZxS21JWWRZclJ5VUdq?=
 =?utf-8?B?YnJGcHdZdXkrdENDL3RXMnhRR3F3cDNwb2hCTkN4Qy9nbVJFZGpUMHoxUjYx?=
 =?utf-8?B?Sjg2ekF4SzVzVlRMRTl4ZHBESktBdEtCa0JrK0c3V3pyazhuSGM4YkpTMVVO?=
 =?utf-8?B?M3VVTnA0MndjdW9QZFV4ZkNPRVRYb0JScmd2a2JxZjduYWtHVE5vK0Z0cHhm?=
 =?utf-8?B?WncyZ2JPMHArUVBJZXdyZ0NNR0FMbFFhc09DVHVVVjQ3ZGZXT1FpalAya0h2?=
 =?utf-8?B?SndoWXdibWgwY0hNR0J5QnhTWFFlZzR0cENxTmJkaGhSUUswL3JFRFBQeWJY?=
 =?utf-8?B?TGtWUHk5di9BS2pnT1E2aC94UDJ6RW5sYjd6eTZMOEpaeFFUOU1wU1BJQVNU?=
 =?utf-8?B?bXVVS0F0dWpvSlNLek1tZWNrN25vL2RnSmdtcUY0Sm51bWZCdjhhTGx2SDgz?=
 =?utf-8?B?UUxBSnRBcHZWRkpSUWtqZ3JTNEZwSDlYcUFvQ1RhNW9wTW1sL3RXN3REZTFY?=
 =?utf-8?B?VjlLdkdKZkNYeVlGOTFlMGpZcFBIN0pmY0tRdzhtRzlmdDlpMDNrS1ZkclEw?=
 =?utf-8?B?eXlzUGFVNisrV2lIVlFNcGd1WnJ0SllSWkNYM1NubS9nb1d1eXNXeCs5UlFm?=
 =?utf-8?B?VkhqZkZIbGxxUVZFSUJqMUg3NTBRK2lkWUZtd0JDeTl6Y3VJWnMyODNxV08y?=
 =?utf-8?B?MXNOdC9JanNlWDNXYUQrY3I3VVdIRjU2Wi9tWlFhQ1JBb0s3eHB1OTJ6OE9q?=
 =?utf-8?B?OUVGMHhwR0xPS2VGSk10WUtyYXJQeFVBd3FDTWhBcEQydS9QU0RSVFBFdUxK?=
 =?utf-8?B?VTNLcUp4T1VGUzZiUXR0Y3JSbnAwblJQYS9jV3hCYmVKa0tCbDdJYTd3Z2RC?=
 =?utf-8?B?cXJFMnN2bm51N2ROVCtSYnNhaTFjZDRTcW1vS1hDTDZzR25rUHp6UytGb0s4?=
 =?utf-8?B?d09YVndQU0M2YVdxZEMwTEtFVzAvUFA4ME1NSS9YRHJuVzlJc3dPTDM0TjRq?=
 =?utf-8?B?RGNQbkZRT25aNlNVVTVLT0ZIVnp4Wi9CL0MybXdPbmc1VUl3NkRlSU56L2lI?=
 =?utf-8?B?UDJFdjBZZXI0em8raXoxaEE3ZFRlSG9OTUI5dWJiMjgzWHNXL0FTQWhpSWRv?=
 =?utf-8?B?NldUSXVWQSsvbTdTNnBUVGlhY3lhRzlUTVc4Y3c3UzVvbjRJaURVSjR4SWJq?=
 =?utf-8?B?K2dDdE5raHp0VTdRN0FlOHVSd0xSSTJoSVNrNnR0eXp1Vzc2WGdqbGpIRHdW?=
 =?utf-8?B?eXc4V1J4NC9UMjlRcjhwMEl6QU9YeCtyc21rUXcwakMvU3hLT1VPVytZckQ5?=
 =?utf-8?B?UjBMUS9RRHR2K2ZrNGRrZEpzWXBjS1ZHeTZQZnpQcTRFT3pUblpNd20zQ0kw?=
 =?utf-8?B?SExyemZwenUwRnZMTFRNeUJEM3ZjNWNCOXE5dXpFSWFEajlUSUhjRkt5Vmdi?=
 =?utf-8?B?MWdCZGhjajlXVm5weG1jUGpIZmJlWDRtNk1JeWJMZWtKUExQT3pYSWs5dkJC?=
 =?utf-8?B?TXFOQTdBcjRWZXVQa0s0dz09?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 331c6462-3d4b-4820-3284-08dafbcfae80
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2023 16:51:04.6073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2767
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------F1mVd8LcTKQ3sNpdyNTu36f1
Content-Type: multipart/mixed; boundary="------------XseuzttbWFDS00pi1uxbfhzX";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: m.tretter@pengutronix.de
Cc: devicetree@vger.kernel.org, ezequiel@vanguardiasur.com.ar,
 frattaroli.nicolas@gmail.com, heiko@sntech.de, jacob-chen@iotwrt.com,
 krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
 mchehab@kernel.org, robh+dt@kernel.org
Message-ID: <763a61be-9200-bde2-d82b-bf91c5f0dd8a@outlook.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
References: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
In-Reply-To: <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>

--------------XseuzttbWFDS00pi1uxbfhzX
Content-Type: multipart/mixed; boundary="------------hDZiE1z47DwUuu9S29JnKwut"

--------------hDZiE1z47DwUuu9S29JnKwut
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Hello Michael,

Since we have the over-4GB problem now, should we mark this problem as a
TODO or something?

Shengyu
--------------hDZiE1z47DwUuu9S29JnKwut
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------hDZiE1z47DwUuu9S29JnKwut--

--------------XseuzttbWFDS00pi1uxbfhzX--

--------------F1mVd8LcTKQ3sNpdyNTu36f1
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmPMF94ACgkQX75KBAfJ
sRkdzQ//cdpSQtOe1egutNtW5fWebeL82pePE34gknlmuIJIOHKcGcXBml8ow558
M0KlVO0aisS5ENsNa42TDf4/AVWf2lpzx0exT0bYcmUxutu+EzTI5s0sndYiZBU4
2bFRtMRASeO2YAGMUSm0+P3vrEOaNlgvbRi9dTh9j+BpHVuqRSwshdnjYgb7mpUb
AsS/NqVXccwpJtJWZU7wcTrbfBdDtC+sHDEf5Uj6naebXdD01Wmhd2F6/3XmXWX8
OKUh6FH9xD9l61QSffyVR5fFzN9sOq4HGG543Fj9o+f+J0Ba0KbHedFLY/9c36I1
V7WK/UfVzWpVRYrYqC0somqHpvVnb+IVfgWXo+QZthUW4UTTcODqYx/+IPs9LAtM
1QH2XMCGim+KuNqZ/LLjDHOVZIJaCJkurLgTdqXRKyj/1IUXN5egCH7y5X9Xidri
weIgIKGm2Dicvb2GHo9D8pa85qpVevCU5mMILOcG+Qn7bXm4FMZ1ucMvfqARrtIo
JxF6nrJDJL2OmctWI+S7KlmsAm+ec7AIQ/Q83ceYrvtYO0njjH2bA/WTYzB9TDHG
gPXESDUucdgMz6eqmMkh0AlK34olBYVkJeSY4IREJMWZIfBRQtBu+CkGOT24Sz2Z
4dzCA7KyKwqOxHy9oq1rXY8tTeEdk3alX2C28+goZr2zgv3EKnY=
=is+w
-----END PGP SIGNATURE-----

--------------F1mVd8LcTKQ3sNpdyNTu36f1--
