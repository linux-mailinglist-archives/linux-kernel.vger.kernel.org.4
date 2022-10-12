Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48305FCE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJLWHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJLWHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:07:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DDB12C894;
        Wed, 12 Oct 2022 15:05:32 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id fy4so129495ejc.5;
        Wed, 12 Oct 2022 15:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05/YOF9lKengUXPyv4GjbMJL03h9GoaGK9qputQVcKQ=;
        b=pSZ1sMPUODSiAfjgbX18qE71vIigyta7liB/jyM3MF3Ewq6S/sCW92zPFD9qlmLzx5
         RK/dU+TwB7ooNVLGLVNwoVmYcgBfmRvMtpN1gv4KVeaIRSE4fs4QR4C0Ukve+vkbfR4d
         DRJ/4RkQvdtl6jqTe3on/a9T8c8MIgo3r/tDHmvu9GONEnWzeyHfN0xPBEu8voM8SPgy
         +EqCG0kB0YMj37kW6tlQimAm1DaasJ89y/wE46w6sfFAl7R1HxSeyltZ4SAXYshTR5db
         DpRd05DA6mZGdJUU++o0BF4d9HxIgii260GjcVXYRW9RrO2s+Yk+HNPmpiJGefWuiQ43
         Jfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05/YOF9lKengUXPyv4GjbMJL03h9GoaGK9qputQVcKQ=;
        b=uuuapBa5zaKyR73SUkY2xmYuHxIgddcUbkPtbWSjif1/RpakKbHtSOAH/S6sM7eEc+
         6vNkqTgkk+8cO9y7BNpDfuu3h7jpJb/LYCnU/F2Q4pXZMuIs0Ets+pA5L7IFiqAvR5ca
         ef6TkFzIFbjlNtILr8INC1ptg3GBOMLcxRtl3ODrKZ+TG5a84O+pdNhmUwWze/X7gy6c
         62RYYoU5fMSA1w7P4PG0AC5RSyPL4TB2DRMp2m2ET3RptYXDZmCBXJ4g59sNKXiuPRza
         SxPbtBK/GA2lN1s3HsLS5A/xPE+w00JnsmKHhvi8P6UKPi9GymOaNo3dzX2RshBXiV9S
         21jw==
X-Gm-Message-State: ACrzQf3OiNUYiyBsFXaro2BJlxQxUzxpekwfHj7HeFdNb7w4sfQfRw88
        Hpj+RslO2oY7S+cFP3g1BK8=
X-Google-Smtp-Source: AMsMyM7H5BDzL7/Y47HYKrpQ9t0CHdfgPAcDBA0E2sccNKcx67HoTE4AqTsjnHFp8sFb7pAx0Z+6lQ==
X-Received: by 2002:a17:907:3181:b0:787:d81c:a6ad with SMTP id xe1-20020a170907318100b00787d81ca6admr23629517ejb.769.1665612245437;
        Wed, 12 Oct 2022 15:04:05 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id g1-20020a17090604c100b00731803d4d04sm1870324eja.82.2022.10.12.15.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 15:04:04 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     yong.deng@magewell.com, Yang Li <yang.lee@linux.alibaba.com>
Cc:     mchehab@kernel.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] media: sun6i-csi: Remove unnecessary print function dev_err()
Date:   Thu, 13 Oct 2022 00:04:03 +0200
Message-ID: <2603792.X9hSmTKtgW@kista>
In-Reply-To: <20220929054003.37487-1-yang.lee@linux.alibaba.com>
References: <20220929054003.37487-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

Dne =C4=8Detrtek, 29. september 2022 ob 07:40:03 CEST je Yang Li napisal(a):
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
>=20
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D2314
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c index
> 8b99c17e8403..9119f5e0e05e 100644
> --- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> @@ -913,7 +913,6 @@ static int sun6i_csi_resources_setup(struct
> sun6i_csi_device *csi_dev,
>=20
>  	irq =3D platform_get_irq(platform_dev, 0);
>  	if (irq < 0) {
> -		dev_err(dev, "failed to get interrupt\n");
>  		ret =3D -ENXIO;
>  		goto error_clock_rate_exclusive;
>  	}
> --
> 2.20.1.7.g153144c


