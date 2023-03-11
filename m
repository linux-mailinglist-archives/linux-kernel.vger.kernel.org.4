Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF736B5B61
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 12:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCKL5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 06:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKL5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 06:57:47 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E614E1165C3;
        Sat, 11 Mar 2023 03:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1678535851; i=deller@gmx.de;
        bh=yudQPl1VTUGzYuErIjGlx84Q61WYZUnkIuekSmPuDQU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mdFrjG3b44WUES3zvnhAzu6HcoYsur6qo0lD9Y/sSc1A4m9Im6JbCBKS9iglDeTgs
         K3jP41Jdn6Ziec+/7nudibHJVYeENvv6r2aT/3olcadEYxkj2994LgoPSzQQG5X8ka
         4ED/j7QD7/SQ1D5ZSNSoxa0WggrMm4jVaA9T9l6pUVK2qsiqk9Zl9HZSynPH5j3U2R
         d9DLaNLYYNbDkHnyFl+k1//ee1yKHYVIrBMXbWk9KfkOUmhKj2EK9YiHdP0PySjCiU
         IZ9uF2f0VTOCmjanWOSkIx/6dcj9QjEm39xPeHMNmjJc0dYMqnIuZd301EYQFVPJtA
         50RnLLrtyukRA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([94.134.154.207]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS54-1qHPKj31a6-00kupN; Sat, 11
 Mar 2023 12:57:31 +0100
Message-ID: <6b7239e3-81f6-067e-1fd2-9dc62166d4da@gmx.de>
Date:   Sat, 11 Mar 2023 12:57:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH -next] fbdev/clps711x-fb: Use
 devm_platform_get_and_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230308054950.15164-1-yang.lee@linux.alibaba.com>
From:   Helge Deller <deller@gmx.de>
In-Reply-To: <20230308054950.15164-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+wet9JncmlnLThMtE15PZgB5TXAyuM5XdCu0BkHncFzjMoIYasa
 wMAF7k4U8EiV6gmyM7HGE0W/SW8grUTRgYD4dhifvQJ1dlPhaiEgEcGWVoOZmLsqhcrIOUG
 LrgLIVTIUEhFUHjwxlljrqpiJ4VFDCQdEGnqAU+hAA4hhfkJTyWrcpOIxVSYcvB/K35GVA6
 yMSRei7Vl+85gdjrMVx+Q==
UI-OutboundReport: notjunk:1;M01:P0:+ljmdtxQlKg=;BGKjGEsuVgcQ9eJ9p5eEuzOXbw/
 HRBk+u/7qxQNMysDpxo3U+nJyvrlBgNdjH9AzoMesr+sZEJg8gQx0Bi+OyAskvIoRSqdmaQ/b
 oroA8OkSpLFzvQ+erwOhMyGU1fvRm+6zT/pT//7x8pcqjPjzXvaJnuyITSCQR0i1ns4ACapSi
 01ZwFBAGccDFs1+PzK7gcsdBmGr8pCgfnmreOKLYGNBIwd+nw7C49K1oTEJ+maFAcTpmSn/Rd
 uqZr+i30ASUVF5RejcoJKqZbtK513pG9BEJBOlCkWPwyN4rnKGQfa4QjoQC+8thM0/DYMgXxc
 JAg8sX9qHEjmwUpNaMNxnJTYXqi6mZXwqTqy53yQWRNC89b2dMLXkiXoYyvkNn3CBoGZ+zhi5
 YoT9UeUXvPE29j2+GmGPV7mr0z1BCqZvoYvuWvG5HzAkw94vlO+fhT8IAUGcxSvMo1cMC7Qow
 ddmEFxHIt6nWsrxKBqnmGjDbEN4z3Uk0nsAqzE5dNExlofU5powy9SizFYD/pC+WYFxMG4cx9
 tJJl/xS24JOPPPw1ku9ghjl9jBhMN59CZ/hFupNtHQsHnmWUyk0j5AI+TI8IOKEhDcFH2c8Gh
 IrAUKligIdvSYfDEWKk4XPnotMlmcAiS2Ra0lPI+jNDCnErtsS/DNyEmECeN+zLIb+G1A1N1N
 XtZM6GTvoe35IBF0IdfnTGrupoilHhQorTRiB6dAqdG5NaO8Q8zvwwMwxMBL/wd/DHPwPeHSE
 4+viCXqMv4Kh44R91jH+QkrnbFnV0Zl10J+4p3sn5wz1Qm0IL7taBB0ZADjYTKD05qgOqSbJE
 bsMjd2S9xq+LtDY2LGiDnpEKmjLXoOsPco7HEkBMMbzohNCh06HOf6GXVCIqQYNEoO6005Hn3
 Ng76rGWMvymT/o4gSE5Nq9HigG6yA0UtHm/xInOP3coDCKfnmVpXGODYP0avPZ8czG6BCmaKk
 We0NTw==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 06:49, Yang Li wrote:
> According to commit 890cc39a8799 ("drivers: provide
> devm_platform_get_and_ioremap_resource()"), convert
> platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

applied.

Thanks!
Helge

> ---
>   drivers/video/fbdev/clps711x-fb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clp=
s711x-fb.c
> index 45c75ff01eca..c8bfc608bd9c 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -238,8 +238,7 @@ static int clps711x_fb_probe(struct platform_device =
*pdev)
>   	info->fix.mmio_start =3D res->start;
>   	info->fix.mmio_len =3D resource_size(res);
>
> -	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	info->screen_base =3D devm_ioremap_resource(dev, res);
> +	info->screen_base =3D devm_platform_get_and_ioremap_resource(pdev, 1, =
&res);
>   	if (IS_ERR(info->screen_base)) {
>   		ret =3D PTR_ERR(info->screen_base);
>   		goto out_fb_release;

