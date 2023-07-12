Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D5750CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjGLPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjGLPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:41:20 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C171BE8;
        Wed, 12 Jul 2023 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1689176471; x=1689781271; i=deller@gmx.de;
 bh=zq79MRO+i5G9UPifz9mJl9vnVEcX8oaeEPaIBJmbcYU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GqgASp9f/TiJrqE+U0Mr5/GR1CVPM2LydwrYAMsft69JsVV4ZBdqpqOrd9h0GUJkZBr76BX
 vVsRO9MMdcYw5od8BDsnw/rxyy/KJq/AjN/q1tkbap9tIT9F3yBm3Y3I5IQvg8/EOPTAvzmf/
 +1+JIh4+dtJgFfWqm3Zooc6nj5cU6KT0Df6dUNo3zLu2Qq7vjWjfdeT6b/+t/b4vK6RJBYtE/
 KnHiq4HNtutaujrroAUrLj5PPGTPEkX2Pl+tCFy0e9yRlCeAjDPnAM1PozdLYGmQbNVLoruuA
 xtzPU7r2adY2FL5zEdV+3MlTgwBKcJTsehkKTUssBNfi4dZedjGA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.144.114]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEV3C-1qCVUj3H8U-00Fxxz; Wed, 12
 Jul 2023 17:41:11 +0200
Message-ID: <fb040564-eccd-0ef7-ff73-df3f3d20533f@gmx.de>
Date:   Wed, 12 Jul 2023 17:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH][next] video: fbdev: kyro: make some const read-only
 arrays static
Content-Language: en-US
To:     Colin Ian King <colin.i.king@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230712145702.460690-1-colin.i.king@gmail.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230712145702.460690-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mQ/cfZnJ29UYE4XxJE0HeQ0bntrNcIgEtlcy7t/pFl2MOSTxQZm
 dy4UsPXflxXm3Jn8cvoGst8Pwt0xpM3KwQ2+oCGPrSQlAPj+OsSWO/4nrxQQj9UbOaZItI1
 UyShhqdgtpLxb/V4MC+xtDe5PGRfmuunjK3+a8VYQTZpT3YogMX7A13nLUOCg3s/Hz+DC/0
 ATP+sPlLEflBFNAsZj16w==
UI-OutboundReport: notjunk:1;M01:P0:0/poKF7wRdI=;+nmGHnHVTQbY8QRsP5e83JpfUBQ
 kWc3ht9X1T0oq0tvPI3IDgh3ZoRstzyi0dYBLxnXEh0iZBYx5/J594Dm7elZYQbEwtRdRv3vP
 Q2hbORsR2ZXpk63cepj1wGtYAvCvSAR9GDHqkM4gBtVQ2NxDmWXqjLM6Yg4s/1n5xDShfQrpF
 fYdCllVnX6ddftk7aQlKMaE5RDygmTLtWfbRjlIgp9PjMjXTJpxW+bg8WjvQzZhp8isVxl+X/
 q5v/+OcrljUUBqqRJixctoWIJ3AQYDn1uPQUqDEHVEHNahVygoMaVyuT2oBW2tOXd13ck/WnK
 lblgjMcdm1jKiiLCg1Bh2wQNuVClC/5dnVVjHPACtLvKoRr0wr4ySCtllmciid5j1sm5ojMWO
 UQk7LH/j1JDsd+smo5ifu5j0ts2ZiXs1nrb8IVxBR6ywmNd0OwbvgGvD82vc2x5njJ5T0oRAI
 9bicvWzUIqiE5add4PubYPr+SG5LCfgnniqnhpiiJCb7baW0hM00nRVku67P2iD4oFUNLqhtV
 Wazf2DZG9sVcQhhVvjhuJkAeIKPbZXI8csvz/H5Vltiy7YxNiQqhQc5fVaoEScyEjdHeW6UXQ
 vVdQO2qZWjlicFTOIy6OKutSOqFOf4rnLnLpKN7e/KrDEjjNVyJiGqUriObD0ZMIEiRAFCT1l
 7bRhIrmhAhI4SMskaRaPMbnbUsAwr00+SzMxfHjJrRQaSizTgThz7LHM9XkwjHlfj10WA08po
 JV2KTpI1hZ3Cw5GmX8IajNQy4C3KWIQB4xxI51WXd0eKnz4fOyYRzhfY9lIdIKNsMxkrPqGJI
 FyFArIOJAf2kQhCHn9nrQuV7z2RjWIdBPI72brCqzNViPIzjEc5KValqzYgL6ngVNWdNlWgys
 GzsBvTbppGX/4vVDm2jympGMNqXr8HZW/fsNm3jM8LaQVBja90PKmCHqq/OaC6lGJyWYxlIDm
 49GilA==
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/23 16:57, Colin Ian King wrote:
> Don't populate the const read-only arrays on the stack but instead
> make them static const. Also makes the object code a little smaller.

Looks good, but you can optimze even further...

> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   drivers/video/fbdev/kyro/STG4000InitDevice.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/vide=
o/fbdev/kyro/STG4000InitDevice.c
> index edfa0a04854d..bf1ee3addbd0 100644
> --- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
> +++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
> @@ -83,11 +83,11 @@ volatile u32 i,count=3D0; \
>   static u32 InitSDRAMRegisters(volatile STG4000REG __iomem *pSTGReg,
>   			      u32 dwSubSysID, u32 dwRevID)
>   {
> -	u32 adwSDRAMArgCfg0[] =3D { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
> -	u32 adwSDRAMCfg1[] =3D { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };
> -	u32 adwSDRAMCfg2[] =3D { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, 0xa7d2 };
> -	u32 adwSDRAMRsh[] =3D { 36, 39, 40 };
> -	u32 adwChipSpeed[] =3D { 110, 120, 125 };> +	static const u32 adwSDRAM=
ArgCfg0[] =3D { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };

Make this u8 instead of u32 (saves 5*3 =3D 15 bytes):
+	static const u8 adwSDRAMArgCfg0[] =3D { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };

> +	static const u32 adwSDRAMCfg1[] =3D { 0x8732, 0x8732, 0xa732, 0xa732, =
0x8732 };

u16

> +	static const u32 adwSDRAMCfg2[] =3D { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, =
0xa7d2 };

u16

> +	static const u32 adwSDRAMRsh[] =3D { 36, 39, 40 };

u8

> +	static const u32 adwChipSpeed[] =3D { 110, 120, 125 };

u8...

Can you change that (test compile) and resend?

Helge
