Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355E760BED6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiJXXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJXXnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:43:08 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6CC8287A;
        Mon, 24 Oct 2022 15:01:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r142so8866459iod.11;
        Mon, 24 Oct 2022 15:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyIbdz/gaZrm+seGxWNfxkvgBVd5EwDcZBrPGxEZk0c=;
        b=fZryfZMEuHbvYz4STXBnSHbm//E5vQKBReeGURV369WyiHDicOMaYtaHcZWZU5uc+a
         9O1A3sTGiAn+hCn5MxlDcYpG0HbYDR0au5+j/IIF7DH8kF0aJqcE76V/i0x5cAvht9tU
         33u8D77Ty5TVaWQjC01L1zFqcfqDJryGOYFwlg0Dur9XwJXF8cxzFB6XcqLgDDGBsSD7
         hxMPyzH2tE0Hzm5X9hYFnM2TmOM5jRLzO748ug48MNk0TOfFyBfEUxlTb9VLMP8GhnJ+
         VJDK3KUHxzjCypDLHHFzMz1fLnNOneKnsQUAzJTEuGIIXHQWwVAuxb5w2LWhYcpH5Df+
         ppAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyIbdz/gaZrm+seGxWNfxkvgBVd5EwDcZBrPGxEZk0c=;
        b=ojQ4fJJ7T+kjIUAcdlHYzakU3BAQVZe/XH8Bx7G6RQgyVqet8R5poSAfB34RPhtKKq
         46CyxUR2clreF1sKybpVM/bjpM98BM0ebK83hTcL9oWzC7lcRxgRzXCZxSpXyQ41Lh3o
         hdW+3TDXdhbt5Ku42C2NS/jprghZTx2tHJ2RNy4E0dI0f2qjKXm1nYWb4QC2AkQcicxi
         8jemCkJRWYGMBB0FNSZfqmBoWTX+gVpOVZM7CtDPVZW4Vmx0pWaw7XB/BMOi6BRkdEWM
         0+Mlpv5gwJZBCbE5U6rDKswSrotmPxLvbT4ogm1oqIIE4lxieqqKwV2TlXdnKg9oFezq
         vvqQ==
X-Gm-Message-State: ACrzQf1JcBqb3xq6+JzWgPIrxSI6+VIeKmUi1TPJgy1peEA9+MfLpfBw
        PqYLpVr3hgN6SSw7OpkP5yg=
X-Google-Smtp-Source: AMsMyM7RtBZPsjWxjk3w/MHlBxr9zvDfMgvG6pApiBy1jZhaP4bdcUktdaO2BMuAzUmhLjvV4sHFjg==
X-Received: by 2002:a02:85ae:0:b0:363:84f7:566d with SMTP id d43-20020a0285ae000000b0036384f7566dmr23267382jai.125.1666648903952;
        Mon, 24 Oct 2022 15:01:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b8cc:2162:7a0f:fd4b? ([2600:1700:2442:6db0:b8cc:2162:7a0f:fd4b])
        by smtp.gmail.com with ESMTPSA id y8-20020a056638038800b00363c1d1ac05sm250787jap.27.2022.10.24.15.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 15:01:43 -0700 (PDT)
Message-ID: <a2f5f7f5-8e0f-00a1-8534-d509d89efed6@gmail.com>
Date:   Mon, 24 Oct 2022 17:01:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/7] kbuild: Allow DTB overlays to built into .dtso.S
 files
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221024173434.32518-1-afd@ti.com>
 <20221024173434.32518-3-afd@ti.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221024173434.32518-3-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 12:34, Andrew Davis wrote:
> DTB files can be built into the kernel by converting them to assembly
> files then assembling them into object files. We extend this here
> for DTB overlays with the .dtso extensions.
> 
> We change the start and end delimiting tag prefix to make it clear that
> this data came from overlay files.
> 
> [Based on patch by Frank Rowand <frank.rowand@sony.com>]
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>

-Frank


>  scripts/Makefile.lib | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 0376a6f18bfb1..250b9fd73f6d2 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -358,7 +358,7 @@ DTC_FLAGS += $(DTC_FLAGS_$(basetarget))
>  DTC_FLAGS += $(if $(filter $(patsubst $(obj)/%,%,$@), $(base-dtb-y)), -@)
>  
>  # Generate an assembly file to wrap the output of the device tree compiler
> -quiet_cmd_dt_S_dtb= DTB     $@
> +quiet_cmd_dt_S_dtb= DTBS    $@
>  cmd_dt_S_dtb=						\
>  {							\
>  	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
> @@ -375,6 +375,24 @@ cmd_dt_S_dtb=						\
>  $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>  	$(call if_changed,dt_S_dtb)
>  
> +# Generate an assembly file to wrap the output of the device tree compiler
> +quiet_cmd_dt_S_dtbo= DTBOS   $@
> +cmd_dt_S_dtbo=						\
> +{							\
> +	echo '\#include <asm-generic/vmlinux.lds.h>';	\
> +	echo '.section .dtb.init.rodata,"a"';		\
> +	echo '.balign STRUCT_ALIGNMENT';		\
> +	echo '.global __dtbo_$(subst -,_,$(*F))_begin';	\
> +	echo '__dtbo_$(subst -,_,$(*F))_begin:';	\
> +	echo '.incbin "$<" ';				\
> +	echo '__dtbo_$(subst -,_,$(*F))_end:';		\
> +	echo '.global __dtbo_$(subst -,_,$(*F))_end';	\
> +	echo '.balign STRUCT_ALIGNMENT';		\
> +} > $@
> +
> +$(obj)/%.dtbo.S: $(obj)/%.dtbo FORCE
> +	$(call if_changed,dt_S_dtbo)
> +
>  quiet_cmd_dtc = DTC     $@
>  cmd_dtc = $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $< ; \
>  	$(DTC) -o $@ -b 0 \

