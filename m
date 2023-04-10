Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94056DCA56
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjDJSFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjDJSFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:05:15 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2076.outbound.protection.outlook.com [40.92.99.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF6519B1;
        Mon, 10 Apr 2023 11:05:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mrKfRIXbyre3j5DFNM2GgjcJsGLcso9BFkq5yzz0dgrB4ZcMMmRGQAOrESr35JWOJp3CeLHCG7j4lL7R1rxkZOR5m7QfdPSm1v2z/SXZ8qG0w/842AfE27krmbyI4z6y4IARSYWS5vRDVxXp+SMOfArxNGr/UPJnY3CnIG+D6kmQEaKepjyCbf0nrSktQAvV3afZ1n1q97Iu7UuJBLxo4UljIyDXifK9Hm/7RZlVcJz+I0ZaBEoUB4fCt2UAO+fx5TTVAHFTqVQNzyAKn1sq1DqDRE8JeqifLLCsja/cb3XiNmY9+zD3yI9JqfUdemF4PfGgi4N2S4+sz2cStUjVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+63mtC7uipLrWCOHLqW5BrHaHI6S/XpQzsTWGDeFLU=;
 b=iIuJDTpUqJbAmBnc2g7qwU7RDofmZXc29uXeoztgqyReRXpVCWBKd+wVAFhKbIXnNvnun4RQr7E08QyPGr4WQv/DNezjsR4x95Dym1PcxrT7R+X1Q7lEkkeL0sxefIGR+DIDYvUH9RYT4AqXScXQeP07QChg/0Gys3slk8Cvarm/E5aFDh61xsYJ6EuWx4m0MeuFI4W+rCtrfDvYHiErlZPkee8bE2M3Bc7P2VXnaKNQdUU7F2d5TrCg6+VqznSS6AHXG/TlPTXvpWP6cja/W2GyXRXyQRirRORNh1d6retC9f7D7D7YScISEvWsu6Z19zi1Ki+Z2l9K7Dxzpn87KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+63mtC7uipLrWCOHLqW5BrHaHI6S/XpQzsTWGDeFLU=;
 b=hCWyIDxRkPfAwMNiZcyt4xhYRw0bJw+Izg3VovOGQDazf0kVJN5WnCFS0MqbP2XjlKS7DrZE7NOl6ABOkMj6+vHDsr0L8531qCIjQ0pr9q5Gu1mujb82izaZjVYiWm8VbzrjuuHBX3Zert1VbMeRImSoP3fPf3NREdv471YnBzAdHpA/u8V8QZ+olw2+hmvZ7q9ALvPFeGHgRXc9eyLqsjcjfPzQWrcZz1WGzc/3Xg5zD24PV5UgklcytHaDEhxYRSI+lUcVn5e37qtaJef3x6n97JbKX+1aNdhM4DAKieAmccxwQ+QAKzTidaXUN1yRbrHDASPiRzwPmJ6vkZvi8Q==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:252::12)
 by OS3P286MB2647.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1fe::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 18:05:09 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d190:6e4d:5a1e:59a%3]) with mapi id 15.20.6277.033; Mon, 10 Apr 2023
 18:05:06 +0000
Message-ID: <TY3P286MB26113FF6ABD3CBA616DEC6DC98959@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 11 Apr 2023 02:04:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Shengyu Qu <wiagn233@outlook.com>
Subject: Re: [PATCH v4 2/4] mmc: starfive: Add sdio/emmc driver support
To:     William Qiu <william.qiu@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-3-william.qiu@starfivetech.com>
 <TY3P286MB26115A8F90DAD2D7DA4DCBEB988B9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <TY3P286MB26115E6311132C791616D32B98889@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <cfde7320-323f-725e-8ed5-c8473bce1755@starfivetech.com>
In-Reply-To: <cfde7320-323f-725e-8ed5-c8473bce1755@starfivetech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sNk2wlgdvRqH5G96fOVxZhZY"
X-TMN:  [nTPWSuv2uSkDYn+gKy2eLfjRV9VwyhMmW/MJl/S0ET+LG2EEqDzKkw==]
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:252::12)
X-Microsoft-Original-Message-ID: <88f1d138-df66-bcc0-b29c-d92c15c4889b@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|OS3P286MB2647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e299031-9cfa-461a-d3e1-08db39ee1da9
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uAqS/xTimYNbWnEice/7Q/JLzR9MIwtUJMHfPgssDj2ia8ZnVncplqsi10hBnUjfbmFvsnesB+IOn1cN6u6oBRYKiJkksKGYaKxwQ8f6//viBgGnENI2ZTWlFrEO0Tvf6bpP87Z7HJqUpO1Cg+ZvpJvcS5U0iGxYbJchSx8ZQfcsxEwVLPnclZXKOsFft3UAkyAKEk962SbutOvmtvvSBjDXy6ZMNntgtWdksNXYERJs1a0kq6jyRExXz1+GOBUMXawNLk9aEw3EeuUpPumzLHF8+sHsMGtAgSknW7WGVTBgZEEK9wsGhoO5WBzxDMTVwU83aHD+io6taHBnuD5ENeL5PPL01rKMC88NecvSEEGnrJT7P7dCtUJYnepZn743OKv1X3UyXbBLoKfdRYbjHMO7DFfaPuHkpZD85BrQrMS6mlbM5lDSKLS39JL0kNqHZCBXCZ8gQqEoZYzVVAFvUZHv/5R4crIO/vPAlA68dfiPuXn5OOPXOGqgxccXzbK+xPCufznGYbZzMBFwc6DO95gMe/kxvslWpxcvLZ4QX3btfmCBCMNxfKUiLLBW5aE3V26U7I0T0zV4imQD7dzxCjBXxakEsQTUQVE3HJ29Nuk=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlg0RnNlcFBmb1F4NlNLamxjODlPUkR2WHdENUJBYXlIVllPcitIYUphREYx?=
 =?utf-8?B?dStMMDBrbHlheC9BN1V6ZDRpSHZyVStKTVNBUGNZTUZ0dk9nTjhOWm5RREtX?=
 =?utf-8?B?b0t4bURKK0FCc3gwNEQrMGNxY3J3S28rYlYycUJiWkxzc0RjZTRnc3pJY0xD?=
 =?utf-8?B?V0Y0YXdGSVpjc0pLL1FPa0pMV3lpYk5ITHdPTXBuaGFzTVQrYWNQTk9ITnhO?=
 =?utf-8?B?dU9uTTFIM0J2T0VuVUVFRlRhODdOVXBpUmFjQ1lRbGdUdkRobmJMUzFGZEM2?=
 =?utf-8?B?RjhURzEwRFB3NWk0YVp5dSs5Y3hxcDFMazV1N1R5UHpxN0oxZWZpNjRwU3M2?=
 =?utf-8?B?Y0EzVHdKNXhUekl3ME1SNTlkbkpkeVMvMkZ3NEU4V3NRY1huQUlNNG1ReGFC?=
 =?utf-8?B?ckg0SDRYa09uMUhjSC8ySkJ6bUVqSFNUcVRXK2NReDU4MlEyZjFhbHZ6UGtG?=
 =?utf-8?B?ekdhRzcxVHhab1I1eHlwRWVSR2xUWjF1bXVBLzJWSStxSGdWYWhTWlZIaHFs?=
 =?utf-8?B?YnBOcXZqOFBCK1pWbll2TnllQ0krM0JDRVFBNlR4RWlZN2ZMdnkyaWJhdnlI?=
 =?utf-8?B?UDVncjhIK0JNQVlIeVVFMWVGWVhrcTk1VG1GSUhBYWl4dFdiTkczWUtlcnNL?=
 =?utf-8?B?VlNKMS9FbEJJT0phOTM4ZlA4dXpLOU5FSElJbG9KMS9WV0Y1RkFkRVg2aXhH?=
 =?utf-8?B?MjhOT1FJQkN2cEd4aWl2YU1xRlBwNWw3UnQrUUtsU3F4SVZudHM4RFAvd2hQ?=
 =?utf-8?B?enY0NERZcnlQSzNLTGN6amFxeGpING83Zm56Mi9vZmlPYks5UjlWSzFJNDVu?=
 =?utf-8?B?eVBQTXNLaGdvSGdhV1dQRndHdVJwZkppYmZ4RXM5RUZsR05CT2lrUmZ2NklU?=
 =?utf-8?B?ZjRMQUJZNXFJaG5ueVFhdGZJS3NBdkhUc0k3Tk9PNzBWWnpxdjBsa2ZlU1k3?=
 =?utf-8?B?MWczY210bUVGbkFoZGcrYUx2cGdZRDVMbE1YM1pNVWVyL1JaYXBXM2ErY1hX?=
 =?utf-8?B?VXNCaHFCck5KWTRFbXROZUlISjNIVkFYWXlCTndzU3ozY0c2ZDFEMnA1SkIy?=
 =?utf-8?B?WlY5R1p5Tjg2ZHpyOEZEVSt3cW02OHZxbEUwWk42WmVTeDJ3TXZkN2gwNUVD?=
 =?utf-8?B?YWFDYnU0ZUk3TGRsN3pKR3VPQ3hDUS9oQlNXL0J4WWpYTzBqYUo3RDRKeU93?=
 =?utf-8?B?bTZiQ3lSamZYcnViYmxybklrMnhvSmRCZzNtNzI5S3ZMU2NpUVc4ajYrS1V1?=
 =?utf-8?B?c283WlpXd3JwU3J0dzlnWFdTZDZMSFFVNmtBY2pZUkxNWEdzT0huQUo5MWln?=
 =?utf-8?B?UnFTWC91ODArdFIwWllsbHVZZjRqZ3VHMmNrUC93OTIrOGZ6eS9zMXNMSHNO?=
 =?utf-8?B?RXVac1c0VDFURkpOMURYSXArbG9hMzBveEhSdzl5VVJBYThPalVjM2NXaHZL?=
 =?utf-8?B?UDlpUVhtWEJUNm4wYkJJTzU0YzlYY1lPTzRYQS9pN3k2dFRhQWRhazdQSXRT?=
 =?utf-8?B?bDVEU1liMkgyTk9FWitta2xJUkl0TkRnYnUxTXBSUFpsWHFyTFFJRDFPdlhn?=
 =?utf-8?B?cWVGMGhXbDdIc0dqYWVFYm13dWorRkNnZWpNMzZKcUFoQnJIU0hsemZOU3Na?=
 =?utf-8?B?MlVKWHZncHZGVGRuMWk5VG9WU0NIY1I0aVZCUk93M2JNOW91OXN5MzI0NWRq?=
 =?utf-8?Q?FvwdxcRto4fWwUiHkB/y?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e299031-9cfa-461a-d3e1-08db39ee1da9
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 18:05:06.8763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2647
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------sNk2wlgdvRqH5G96fOVxZhZY
Content-Type: multipart/mixed; boundary="------------e800v56UKbWHUMcTYwJn0sK2";
 protected-headers="v1"
From: Shengyu Qu <wiagn233@outlook.com>
To: William Qiu <william.qiu@starfivetech.com>,
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org
Message-ID: <88f1d138-df66-bcc0-b29c-d92c15c4889b@outlook.com>
Subject: Re: [PATCH v4 2/4] mmc: starfive: Add sdio/emmc driver support
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
 <20230215113249.47727-3-william.qiu@starfivetech.com>
 <TY3P286MB26115A8F90DAD2D7DA4DCBEB988B9@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <TY3P286MB26115E6311132C791616D32B98889@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <cfde7320-323f-725e-8ed5-c8473bce1755@starfivetech.com>
In-Reply-To: <cfde7320-323f-725e-8ed5-c8473bce1755@starfivetech.com>

--------------e800v56UKbWHUMcTYwJn0sK2
Content-Type: multipart/mixed; boundary="------------XaDka4KwzZuHdDsdyXYNjbcx"

--------------XaDka4KwzZuHdDsdyXYNjbcx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello William,

> On 2023/3/29 0:08, Shengyu Qu wrote:
>> Hello William,
>>
>> Sorry for making noise about this, but seems deleted voltage swtich fu=
nction
>>
>> doesn't help about this. But there's still a problem about eMMC speed.=
 Currently
>>
>> only about 20MB/s maximum reading speed could be reached when using eM=
MC
>>
>> on VF2, any idea about this?
>>
>> Best regards,
>>
>> Shengyu
>>
>> =E5=9C=A8 2023/3/28 0:01, Shengyu Qu =E5=86=99=E9=81=93:
>>> Hello William,
>>>
>>> I'm digging into downstream mmc driver these days and found a problem=

>>>
>>> that current version mainline driver doesn't has a voltage switch fun=
ction for
>>>
>>> it. Downstream older version has one but was deleted in this commit [=
1].
>>>
>>> It was deleted since vf2's SD slot doesn't have 1.8V input but commit=
er forgot
>>>
>>> that vf2's eMMC slot has a proper 1.8V input.
>>>
>>> So could you add voltage switch function for mainline? I've met a eMM=
C speed
>>>
>>> problem possibly due to it.
>>>
>>> Best regards,
>>>
>>> Shengyu
>>>
>=20
> Hi Shengyu,
>=20
> Sorry for the late reply.
>=20
> First of all, I will consider adding voltage switch function, but the i=
mplementation
> method is to configure the pmic register configuration in dts, and the =
implementation
> interface will use the voltage switch function in dw_mmc.c.
>=20
> As for speed, the main reason for the low rate is the clock of JH7110 a=
nd the
> associated IO driving strength, in this limit, the maximum reading spee=
d I tested was
> about 50Mb/s.
>=20
> I will try to reproduce your problem and try to solve it. Thanks for su=
ggestions.
>=20
> Best regards,
> William
I found out the reason and fixed that. dmwci driver needs vqmmc supply
configured in device tree and a successful voltage change to actually
enable 1.8v mode, even 1.8 supply actually already physically exists.
So to solve this problem, I wrote AXP15060 driver and device tree
bindings basing on -upstream branch and gets over 75MB/s read speed. The
driver series is already under review here:

https://lore.kernel.org/all/TY3P286MB26117891DFB2DD615A7C54EF98969@TY3P28=
6MB2611.JPNP286.PROD.OUTLOOK.COM/

Best regards,
Shengyu
--------------XaDka4KwzZuHdDsdyXYNjbcx
Content-Type: application/pgp-keys; name="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Disposition: attachment; filename="OpenPGP_0xE3520CC91929C8E7.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
lMSoVV3z1s8dA1DK95ykSdIFtVZT
=3Dr4B8
-----END PGP PUBLIC KEY BLOCK-----

--------------XaDka4KwzZuHdDsdyXYNjbcx--

--------------e800v56UKbWHUMcTYwJn0sK2--

--------------sNk2wlgdvRqH5G96fOVxZhZY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEET/yoGP3p5Zl+RKVuX75KBAfJsRkFAmQ0T58ACgkQX75KBAfJ
sRmpkw/8DwA5dRRPrqqYN1x34M4ZQrX358W+UxTbr0VosyZYFJxnERcL7EdgTl0M
QQ6dQQkQDcNUl2a/w4lxC6y3g9upDyPTOnUg3DSGEUVdLO53Gkk7j7n1vBCYJAkC
JtV3wD7n/v7ho/HCmucCyLvX8HWNYqNhTlugmOKuVWtvB/VYxgIBGgh3GrlxDGMB
pGJMU1Sss98AIrkls8MKfxx11ooSEeuhRfp84ly3r8T4Z4HJPoJr044bqICrI+TH
Bm928vXmzyEehsQervXBnO3gyfm7uxfAiD9FN1duSHSSOaexuRseOLciV/QvnDmY
2o9m8KRV7A26Y+dxLSpmtaFmHnQEDG3sEBQRo/LCydTSX3e7ewW8m9PygoTR9FOa
w5TxNkjqVQrFfZ/KHx4+8CINfefjg9sO1aUCJICSf7+MrVLFv/fZ2I7KJFu97xnB
TOGAh7v7zFHFD7R4htbrllAmBdVaaF6TiPWRrWDQPKG+fcsVfySET2ZX09NXKQoY
+nU7H9DdDq3R6oaxx13KLjAeq1f1Jv/rgDIeh4pw+JM6tEWEC7GxUQHSTWK2i0RL
nTpMC8VLIALZTc0FYycBMs4EOIbSNMQa+BoF3bDMRJZdOq5IJXgD+TWG7O/WHCeU
G+heT3Wb/1aOczmdmSiF7bi1ZBFtRI1KwinRgRJ1pcPoFVzuBRQ=
=3pZ1
-----END PGP SIGNATURE-----

--------------sNk2wlgdvRqH5G96fOVxZhZY--
