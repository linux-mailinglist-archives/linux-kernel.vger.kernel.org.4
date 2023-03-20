Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95526C0931
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 04:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjCTDHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 23:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTDHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 23:07:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A11166D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:07:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x15so423770pjk.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679281629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AO/Kc/wZ789QMgjmi6lkKnv1SPC+EjWPNYHlpNWang4=;
        b=MLneBM69E0eNWqSSRbMLxGLynumc3n3n4/0ZrG/y2WUBU+O8sVOyAfvHzipgvNgLde
         BytLR5TCX9eW24vhaEsoyioLVeHhgMt3Gr1LxlGirp/6KcOLeO5RHzD+Cy/zJWGrB5Du
         mohbSBj+3V9+uDxw8ovqMMvm3+rCzipSj8Y0XSmNCDgj0Qa+pWthedNHbb/T5EIF1SA9
         IXOiqdF4945OvJ2SJJUmHUFqLt/5UlTB99OuVNWcYjjtWssAiYeh3XNgvAE0ix+h/XSv
         Abe9isGes7zsbrfTkgV10wfJI3Vq96bTfaV0dhb7lzxQDYKpyGRo/TdBtJYQgfVSh0I2
         DzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679281629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AO/Kc/wZ789QMgjmi6lkKnv1SPC+EjWPNYHlpNWang4=;
        b=NpdB/hcuuX1k57kNoJ1Wn+uaDvc/va7uj6YDpWkRhwqYmKpf6YDvnK8MPaaJdCyp/B
         SkB9LG8OXJMoBNB4Dr4yOimnme+DyyQpx/ullxzGY+pQA/jywWH55MfLBa/W78nPhmSN
         IqvLWwdXJMD6hpnnJfFAAczXXe5s0MOcRkDzMeWZr0dc+hnAA9GlevXUP/fe9/AxTg2l
         kr6jq5BfxbVLMZm8NYcouMGMs/Ru1QclcBzl4QfSSIrJ+YDdsLfyDpXnHlSlt7r7fc24
         qNWpdph0s8Al2TSdcHKCYplaXXtunFm+dLm3ozsiyRA151qBewHIlucVtxJl7yMyRZM5
         24lQ==
X-Gm-Message-State: AO0yUKUKmwhqp25dToEJaawPRowe+Uo1WZF42WuhvvkzE0Pno0FYhG/b
        kvy9nkk2KmxvPXuT+P5W42cbiKCnu3pOPrMpys8=
X-Google-Smtp-Source: AK7set/SfVfa7KBc5T050Amk4yKIuMnwq6TYwkfvV+uKticquXmpOlcPi0snqOfT0IQIpyeuCSloeaqzNZus9jtQzvs=
X-Received: by 2002:a17:903:1314:b0:1a0:48ff:5388 with SMTP id
 iy20-20020a170903131400b001a048ff5388mr5910843plb.6.1679281629449; Sun, 19
 Mar 2023 20:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230319234710.1749455-1-cphealy@gmail.com>
In-Reply-To: <20230319234710.1749455-1-cphealy@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 20 Mar 2023 00:07:00 -0300
Message-ID: <CAOMZO5Cfc2cYEYvZxm4v1teCgZJjbY08_gWWDxmp4YDCmbewhw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: imx_v6_v7_defconfig: Enable SMSC Ethernet PHY
To:     Chris Healy <cphealy@gmail.com>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        andrew@lunn.ch, Chris Healy <healych@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Sun, Mar 19, 2023 at 8:47=E2=80=AFPM Chris Healy <cphealy@gmail.com> wro=
te:
>
> From: Chris Healy <healych@amazon.com>
>
> The imx53 base imx53qsb uses an SMSC Ethernet PHY.  Enable it's driver.
>
> Signed-off-by: Chris Healy <healych@amazon.com>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_=
v6_v7_defconfig
> index 6dc6fed12af8..a12d45e99782 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -135,6 +135,7 @@ CONFIG_SMSC911X=3Dy
>  # CONFIG_NET_VENDOR_STMICRO is not set
>  CONFIG_MICREL_PHY=3Dy
>  CONFIG_AT803X_PHY=3Dy
> +CONFIG_SMSC_PHY=3Dy

Running 'make imx_v6_v7_defconfig' causes CONFIG_SMSC_PHY=3Dy to be
selected by default
because USB_NET_SMSC95XX is already enabled.

It seems that we don't need to explicitly select CONFIG_SMSC_PHY=3Dy as
done in this patch.
