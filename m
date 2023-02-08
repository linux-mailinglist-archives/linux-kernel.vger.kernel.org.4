Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305A868F12A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 15:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjBHOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 09:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjBHOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:49:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F03255B0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 06:49:24 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n2so10221459pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 06:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f51tcd2NdxaPHLUZNDwBySdZVDgdomB/5aEb1/nyTPA=;
        b=4RScORAhUv9+TfjOHyZGQTW7TsmGTGHRd8bGZciqQlcgUysKj3iFQC7OYDkASdPXaw
         BImEoQdlhKSNh9xClUzgqUUscF2xkOFYFlMaa69tcgKK9PmmR7PKY6uZ0dFv/AM6cVHK
         xpIEjsYNKkHcq5G31Inx+u3uxsTcfFI4DzNAbOIGnlifNf167TXs2BeQ8dDAPMa1f9Gu
         gcLMovOgdt2FoVRDhwEa7KqeYr/2Wf2n+8IIMuPIYhG76CqZ7LWlx97M+V2NmkOdnY1E
         04GS6vY9rpid+svAe3Huf3cFju0rzMT7mrgY21sz1sFkBCyI0IgC7L+WdWeL3bhJNCoe
         t+gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f51tcd2NdxaPHLUZNDwBySdZVDgdomB/5aEb1/nyTPA=;
        b=jmzoCsDzMsTvaPRIdpwc0P0hp1oOHtl1EqkkCAsvlyO4mi98vtTeRfniNoMmsCdmTA
         qMrtBSM4CPq/c9Op+zdVJUujASs5mEj+q4e0gaWDFCCPuDkx5ibDCglH8a8GR6gOIpQr
         dZUktvbDQSN3WfN7PQvBcMwNXSV8pixbk4IyrxEewXAqdTV+qZqXvXqO2hnYoLkc6frO
         BRxR13zrrf+qnMyBuXqKNO/zN0meTDkemBgFvirzPGA9RtPpN6ztlPml+6eJkqiYOyDO
         aUN1TJeNxk1jV+yoXEBTKgUiWl5IQN1cpxXtFmwr7y0N96ZkOaHB1VI3qFrtsq0K6H0f
         M8ng==
X-Gm-Message-State: AO0yUKU5JNJYx46XPti/wzXgpg6GeF8szTSyyYPjA9PND5HBMUgaztuP
        +kkcZCtVNh6W7+V7TG//gKxht12+AjtfR9ZnBoQ=
X-Google-Smtp-Source: AK7set+X0/zwt9ty5gvVm+4g+ZYuZ4WBObj3FCvOzeDRHSQ2YQ+LrApZiupBQ58AnUZRxeD6IaHGxQ==
X-Received: by 2002:aa7:9533:0:b0:5a8:2b95:baea with SMTP id c19-20020aa79533000000b005a82b95baeamr2339524pfp.34.1675867763334;
        Wed, 08 Feb 2023 06:49:23 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id x19-20020aa79193000000b005a84de20c24sm112368pfa.209.2023.02.08.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 06:49:22 -0800 (PST)
Date:   Wed, 08 Feb 2023 06:49:22 -0800 (PST)
X-Google-Original-Date: Wed, 08 Feb 2023 06:49:18 PST (-0800)
Subject:     Re: [PATCH] MAINTAINERS: update Allwinner sunXi SoC support entry
In-Reply-To: <20230208142841.19597-1-twoerner@gmail.com>
CC:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     twoerner@gmail.com
Message-ID: <mhng-62becd72-44ff-41be-a90f-5de97e44b857@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023 06:28:41 PST (-0800), twoerner@gmail.com wrote:
> Update the information in the "Allwinner sunXi SoC support" block:
> - include more RISC-V information
> - move the block to keep it in alphabetical order
> - "L" before "T" (as reported by checkpatch.pl)
>
> Signed-off-by: Trevor Woerner <twoerner@gmail.com>
> ---
>  MAINTAINERS | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b8ad844bca77..ff39d34cb4ca 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1856,23 +1856,6 @@ M:	Emilio López <emilio@elopez.com.ar>
>  S:	Maintained
>  F:	drivers/clk/sunxi/
>
> -ARM/Allwinner sunXi SoC support
> -M:	Chen-Yu Tsai <wens@csie.org>
> -M:	Jernej Skrabec <jernej.skrabec@gmail.com>
> -M:	Samuel Holland <samuel@sholland.org>
> -L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -S:	Maintained
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> -L:	linux-sunxi@lists.linux.dev
> -F:	arch/arm/mach-sunxi/
> -F:	arch/arm64/boot/dts/allwinner/
> -F:	drivers/clk/sunxi-ng/
> -F:	drivers/pinctrl/sunxi/
> -F:	drivers/soc/sunxi/
> -N:	allwinner
> -N:	sun[x456789]i
> -N:	sun[25]0i
> -
>  ARM/Amlogic Meson SoC CLOCK FRAMEWORK
>  M:	Neil Armstrong <neil.armstrong@linaro.org>
>  M:	Jerome Brunet <jbrunet@baylibre.com>
> @@ -2620,6 +2603,25 @@ F:	arch/arm/boot/dts/rtd*
>  F:	arch/arm/mach-realtek/
>  F:	arch/arm64/boot/dts/realtek/
>
> +ARM/RISC-V/Allwinner sunXi SoC support
> +M:	Chen-Yu Tsai <wens@csie.org>
> +M:	Jernej Skrabec <jernej.skrabec@gmail.com>
> +M:	Samuel Holland <samuel@sholland.org>
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +L:	linux-riscv@lists.infradead.org
> +L:	linux-sunxi@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> +F:	arch/arm/mach-sunxi/
> +F:	arch/arm64/boot/dts/allwinner/
> +F:	arch/riscv/boot/dts/allwinner/

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

Thanks!

> +F:	drivers/clk/sunxi-ng/
> +F:	drivers/pinctrl/sunxi/
> +F:	drivers/soc/sunxi/
> +N:	allwinner
> +N:	sun[x456789]i
> +N:	sun[25]0i
> +
>  ARM/RISC-V/RENESAS ARCHITECTURE
>  M:	Geert Uytterhoeven <geert+renesas@glider.be>
>  M:	Magnus Damm <magnus.damm@gmail.com>
