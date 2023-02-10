Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374C56922C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjBJP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbjBJP61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:58:27 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0EA18B23
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:58:22 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id m12so6230811qth.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8aTFVnOsWYVkAC4sToVkHybmRjgNOkZh2qFCAaG8DlI=;
        b=Mi1RyD77ugTxCb1ulPTtMBZeqpqGF5Q0mYp6MhS712A084x2kpLFCTpdLya3m1NBUB
         mvqzm2bWVkLTwhJjn1bLcYzYN72L+p0o9VwQzSEKpmQZ29vbd1X2RN+wKsRq8g8QrUmC
         /U4nv2mCzDf2SP4GQsoclIJ3AoMg3hpRBUPTDATzHhem9yI+A+SEf7iPp5A6Y7KmgTYt
         6S28lx6psVQCjX+FNSbb3BlyN3FwZeg4lZuIzPwRdsjRu2WqnmeomMMEqtGF37c6PQk5
         BCSN9vOA7ovMSr14qKKU6xB/I3KwmWB4D6y4N21aro/kEktfQZXbu2ZERpT2DAO6ql7V
         B7rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aTFVnOsWYVkAC4sToVkHybmRjgNOkZh2qFCAaG8DlI=;
        b=Ffw8owSZOa6xjckH/3R0K80ZXHsM196/2JwaBRydTv11WabU7jAFzPWOISBmWdxNgI
         QzvXkeOXn1FzLQn0yrE45K32QtlvGVB+n8xnFmmwx8Ur0LcxCXYEfcCGQHJuBqUmqcXx
         3Sq5Wmdvo+KUCxzMtF9V6mhutlivdHuOFHPNODKBrt/edcWNoRbd6LAFtOIctL3uDHnB
         s6o0dgtHVGv0J1iyntEUvVTkTG1rBuklaoQkuIKfQWNXiNS8eLYGGZAUrrATStBW2uEw
         6EkUXfP/KI+twh40lDBr2o3tGJT+7ta7m1RksB5DXJCo6XhoYmJdtaMKEf0KbQ2t8AdC
         TPJA==
X-Gm-Message-State: AO0yUKXWzf8TOTuJL2og4ijeAFKuPwTgVpH+5rWdNtnEjYvbiOJo0x1M
        pQnn5hhPpqJykA71cRq/ZEl4H7kaad0pgLGcbl4=
X-Google-Smtp-Source: AK7set8CcS3ZeuXDp8HKmLAtd+GYM9oJG6VhEc2IjxJIdB3epTN0zATVW2t3jUy1ugW8dZS1ccszPhq+V6c+iTLYmWg=
X-Received: by 2002:a05:622a:1001:b0:3b9:a589:e7e7 with SMTP id
 d1-20020a05622a100100b003b9a589e7e7mr3116880qte.228.1676044701339; Fri, 10
 Feb 2023 07:58:21 -0800 (PST)
MIME-Version: 1.0
References: <20230209115403.521868-1-jiucheng.xu@amlogic.com> <20230209115403.521868-3-jiucheng.xu@amlogic.com>
In-Reply-To: <20230209115403.521868-3-jiucheng.xu@amlogic.com>
From:   Chris Healy <cphealy@gmail.com>
Date:   Fri, 10 Feb 2023 07:58:10 -0800
Message-ID: <CAFXsbZos7GCF2fp73MrWxjMthFFKj8XAc2OJkNvOMEGUw51Jjg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: defconfig: Add Meson DDR PMU as build-in
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amazon.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Reviewed-by: Chris Healy <healych@amazon.com>

On Thu, Feb 9, 2023 at 3:54 AM Jiucheng Xu <jiucheng.xu@amlogic.com> wrote:
>
> Add Meson DDR PMU to defconfig so that build errors are caught.
>
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 851e8f9be06d..9fefe659ade7 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1296,6 +1296,7 @@ CONFIG_ARM_DMC620_PMU=m
>  CONFIG_QCOM_L2_PMU=y
>  CONFIG_QCOM_L3_PMU=y
>  CONFIG_HISI_PMU=y
> +CONFIG_MESON_DDR_PMU=y
>  CONFIG_NVMEM_IMX_OCOTP=y
>  CONFIG_NVMEM_IMX_OCOTP_SCU=y
>  CONFIG_NVMEM_MTK_EFUSE=y
> --
> 2.25.1
>
