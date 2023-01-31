Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF9368264A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 09:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAaIYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 03:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjAaIY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 03:24:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C383A87D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:24:27 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2412041ACB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675153466;
        bh=/5BL9ngeEyyp1khW8jOxq2+Z8rqfL+UzO1NbnAv2DuU=;
        h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=jeze7IkZDU3AqTvvLFUF8kRhNI13Vq5kd8CIoehZ1qE94X0n9khPuKcQ2JAx9NcjW
         sE5ka4sm45zV0jVj9KyIyDurMAX1gJDRRAJEfUCKOED2YNpEjPJxdMY+adBtIVOplB
         L/dSkAjc/FYnnIlqz79fXVIgWLzJCARLbcIb7pNM3RVM++GeEVWLM0JN7BInapwNSU
         +XHYMVOmSQA7BvR85nnD+XTSJm4FXoVKhosgEmix9dwx/+4Gh4Cp/QM1A+AA0UzqA9
         ZI1Jci9wcENi+WxlCscqDi8viGVwmEm30QmH6cB1bKzX/yaPjgwRZ7YDDzjXsQML2A
         VrLpJ9mcuz2dg==
Received: by mail-ej1-f70.google.com with SMTP id p16-20020a170906499000b0088c5a527c89so782831eju.23
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:24:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:organization:references:in-reply-to:message-id:subject
         :cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5BL9ngeEyyp1khW8jOxq2+Z8rqfL+UzO1NbnAv2DuU=;
        b=jd8mCIjoNhQ6AKaZFdBWST6V8bYWdhd+e0BsO1w8KF4+fssI8t1Spnnaam0Ca6vM7W
         ieRWbV6aNlvS20tSRNRGNpjDf3oI5nMHQ86jtFJNqkpisCP2uA8l11O98+ByVtEWb9qv
         AtZZxXTQyA26BUrK/uaI6sfJ45Go91Iqss9ajd7cS3yCPRE5z2yIVYEdlvB5FXSt4Oj7
         GGftUr9P1i25i11R+/zHc8g9TTYjLb4Rs+ToVAH0rn6gSpUDCQqCy/DjGIZGFfVHraJg
         undlPVIHJUDE8Jc6ubPGoZKB8owJFmJBHKu2Xxcw5dgpIjJcmlA23C5xJx19kg9DAK+Q
         M+0Q==
X-Gm-Message-State: AO0yUKXVAiFqAkgU1PSMK4jm7fZgCdz5r5ptgBiXNng63jW/2s85MXni
        tJGO/WYUjUfFEuWFyDQ+VUxC35yktaLjwRtHllShhpILsiakfMjXvx2PJqhU1/Vshfk6YMMTSeo
        3Msba1dquEaoj6iQNKZ7oAEaHVPeD70VUioIdn+zjaw==
X-Received: by 2002:a17:906:a101:b0:878:4497:380e with SMTP id t1-20020a170906a10100b008784497380emr19072737ejy.4.1675153465768;
        Tue, 31 Jan 2023 00:24:25 -0800 (PST)
X-Google-Smtp-Source: AK7set+cTvy4sSj6lLmdAFK7ZgJR7jW3+4MU8HPiM94SUT+UU8gCLfuH+llbAdC53GGigYG7KREj4w==
X-Received: by 2002:a17:906:a101:b0:878:4497:380e with SMTP id t1-20020a170906a10100b008784497380emr19072720ejy.4.1675153465521;
        Tue, 31 Jan 2023 00:24:25 -0800 (PST)
Received: from gollum ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm7107144edb.79.2023.01.31.00.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 00:24:24 -0800 (PST)
Date:   Tue, 31 Jan 2023 09:24:23 +0100
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] soc: qcom: llcc: Fix slice configuration values for
 SC8280XP
Message-ID: <20230131092423.04d1deb2@gollum>
In-Reply-To: <20230127144724.1292580-1-abel.vesa@linaro.org>
References: <20230127144724.1292580-1-abel.vesa@linaro.org>
Organization: Canonical Ltd
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ix.lq/XAZUDbvnn1aahrLTq";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ix.lq/XAZUDbvnn1aahrLTq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 27 Jan 2023 16:47:24 +0200
Abel Vesa <abel.vesa@linaro.org> wrote:

> These new values are now based on the latest LLCC SC table.
>=20
> Fixes: ec69dfbdc426 ("soc: qcom: llcc: Add sc8180x and sc8280xp configura=
tions")
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>=20
> The v1 is here:
> https://lore.kernel.org/all/20230126171636.2319496-1-abel.vesa@linaro.org/
>=20
> Changes since v1:
>  * dropped the LLCC_GPU and LLCC_WRCACHE max_cap changes
>  * took the new values from documentatio this time rather than
>    downstream kernel
>=20
>  drivers/soc/qcom/llcc-qcom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 23ce2f78c4ed..26efe12012a0 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -191,9 +191,9 @@ static const struct llcc_slice_config sc8280xp_data[]=
 =3D {
>  	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
>  	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
>  	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> -	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> -	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> +	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUSS1,   3, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> +	{ LLCC_CPUHWT,   5, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
>  };

Without this patch UBSAN reports multiple of the following on a Lenovo x13s:

[    0.083079] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    0.083085] UBSAN: shift-out-of-bounds in /build/linux-laptop-0y97Sr/lin=
ux-laptop-6.2.0/drivers/soc/qcom/llcc-qcom.c:772:45
[    0.083091] shift exponent 32 is too large for 32-bit type 'int'
[    0.083096] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 6.2.0-1001-laptop =
#1-Ubuntu
[    0.083100] Hardware name: LENOVO 4810QL0100/4810QL0100, BIOS N3HET75C (=
1.47 ) 11/01/2022
[    0.083104] Call trace:
[    0.083107]  dump_backtrace+0x110/0x16c
[    0.083115]  show_stack+0x24/0x50
[    0.083119]  dump_stack_lvl+0x68/0x9c
[    0.083124]  dump_stack+0x1c/0x48
[    0.083126]  ubsan_epilogue+0x14/0x60
[    0.083132]  __ubsan_handle_shift_out_of_bounds+0xf0/0x1e0
[    0.083139]  _qcom_llcc_cfg_program+0x9c8/0xad4
[    0.083145]  qcom_llcc_probe+0x284/0x33c
[    0.083149]  platform_probe+0x74/0x110
[    0.083155]  really_probe+0xd8/0x430
[    0.083158]  __driver_probe_device+0x94/0x1e4
[    0.083161]  driver_probe_device+0x48/0x17c
[    0.083164]  __driver_attach+0x150/0x2cc
[    0.083168]  bus_for_each_dev+0x80/0x100
[    0.083173]  driver_attach+0x30/0x54
[    0.083176]  bus_add_driver+0x1d0/0x2a0
[    0.083179]  driver_register+0x84/0x184
[    0.083183]  __platform_driver_register+0x34/0x60
[    0.083187]  qcom_llcc_driver_init+0x2c/0x48
[    0.083193]  do_one_initcall+0x64/0x320
[    0.083196]  do_initcalls+0x188/0x1f8
[    0.083201]  kernel_init_freeable+0x170/0x1c0
[    0.083205]  kernel_init+0x3c/0x180
[    0.083209]  ret_from_fork+0x10/0x20
[    0.083213] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

They're all gone with this patch. From that perspective:

Tested-by: Juerg Haefliger <juerg.haefliger@canonical.com>

...Juerg

 =20
>  static const struct llcc_slice_config sdm845_data[] =3D  {


--Sig_/ix.lq/XAZUDbvnn1aahrLTq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEhZfU96IuprviLdeLD9OLCQumQrcFAmPY0DcACgkQD9OLCQum
QrfLEhAAnOJ//8SXzjgTRNVPOGc6RlldTuB6tmKv4M2p/X0h+DVM8CfkleM8eIFF
a5RgxoHd2lAUrmK43V8LiIGEbIxaQ+zLCan91QwnQSlzd4Vp60FKMqrbgNyqd9mC
5n6nO5gmbVV0OwpZykejhwxsbVpbzGm8B8q/TH4NGDG16qUZ8K9tDu718ANzO92O
y8Y8sdi+S9MhiYIwBasF2BKX6m0rzOj9l1Vum6og8nGNqF720qn598wPUMtH0ubk
vGXOR957zafuh6dpOP1rXFXGVytAKwEfkECqk12MH6lLER5hAcwGRT+Hr5piCpRr
ZRMCZJ4q1AG2T2ZFtgWTVIQh7gy0gL5X2erK4YCVP1K1fCMpRsxsFcZs9CXba1zU
FCf+QSM6FK5KeoRBc+B2fb3QBjR84xD6OYFMypvJUQz9AEloRxh2KxpVGh0loWM/
QrJVyWxgBil/LmMsjMI7ho3YqRFxiIqJb7NBTD/ByNiervOtao5sOi+ZQ63bAXEQ
5t7/7roAnmiMwIcscxbnQ90dIJrfLzAoqCnnwtPEKuBFeOiGmrfURg5Oc9CnB6Xr
20H8W9cxd0AqbbA505BbgzR/A7V56bk5M93tAT066MCfBbnhx+yvxfx9Jh50YE3B
O3JtctWzQatM6pQyxWdWN869Zyr0YeRjQGbHEr4ErRFJikCr78E=
=QsVV
-----END PGP SIGNATURE-----

--Sig_/ix.lq/XAZUDbvnn1aahrLTq--
