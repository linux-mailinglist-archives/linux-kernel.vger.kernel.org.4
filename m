Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7B660BED7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiJXXns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiJXXnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:43:09 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1F3303A89;
        Mon, 24 Oct 2022 15:01:44 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 137so8875332iou.9;
        Mon, 24 Oct 2022 15:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCVvqcbtryqkba55ajfW30/hhAqAey3voyUhIcczG7M=;
        b=k/yMzxKN4O9CuIG2TeoPuCZX8tR28S/zIO/DMm9skNax/0ZGiRi3KnqAxfvVdhxQgd
         mfM77go/T9zPJ2m+Ah0m29PXxfzHUsj0pKFSqmEQpkfbix6x3255hbO0kH3qE36fDa9a
         9bGE5miMjx7uL3w+6JKd9R3w6MYBXIyvW+naaJ1GI5vov+gafXo9iZIyhRZuTB6J0azk
         e8yQx3qqmKQDMg1ybvER2wdbCoNMr/TYcjuB77FBzWnl8TWzhynSNfv2hF8FgzxZF/EL
         1dLEXNs76kqJ8lOhPB/Zykm3NmnxRJQpW684o5ppGAKuQS3QrfV6p35vHapqq26aTp1I
         EB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iCVvqcbtryqkba55ajfW30/hhAqAey3voyUhIcczG7M=;
        b=lPKJz+qXBVBOdZoK+JAptx+9xxtd59ELi0AalMYQczqaNS/vwFjMGK2mCYFEYPAWAI
         vGSTDdf/U2TYEyusldrJOlRgH2y0RN3e+/3f09jEXcZcNF04xTXD0PoVr2r3XT3OUFW3
         qvt8yhp9b22ZWpWDx6qOuEcuxkfGDvoewLchyDf7ls7tV3ONMfaOh0RIiiVc+a8m/YG9
         SCXibJrw+y3IObVjPYnVhuhXbwkczmQVG3xaDtG7dcm3ZLkgUko7RUWgPThKTwf8pYlt
         pLVuEKfega5Xntmm8UsC3k77wpb8vOAteKELMYwh7IxLe0BseynYgbY9XUIvHiXHGLar
         gYDQ==
X-Gm-Message-State: ACrzQf0Bltfmj9SH1b0WS6YEHi5Zb8c2+xNnH33RnvCNwp4zfsBqnmEc
        okVJ/WhvRibtt+kXFpGFJ3U=
X-Google-Smtp-Source: AMsMyM4c7c0r3zBwwZ7I7IPHzKNxH3p9ZAkVLOPu5ptxF2+B6ZMa4GlxQWLzQae7hJt8jjF5atZehw==
X-Received: by 2002:a02:a487:0:b0:363:fc40:edf5 with SMTP id d7-20020a02a487000000b00363fc40edf5mr22740252jam.233.1666648900481;
        Mon, 24 Oct 2022 15:01:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b8cc:2162:7a0f:fd4b? ([2600:1700:2442:6db0:b8cc:2162:7a0f:fd4b])
        by smtp.gmail.com with ESMTPSA id v2-20020a056602058200b006bcbe33eca6sm362168iox.14.2022.10.24.15.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 15:01:39 -0700 (PDT)
Message-ID: <8cc34d10-a087-5ccf-ec0e-df87ff0d95f9@gmail.com>
Date:   Mon, 24 Oct 2022 17:01:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/7] kbuild: Allow DTB overlays to built from .dtso
 named source files
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
 <20221024173434.32518-2-afd@ti.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221024173434.32518-2-afd@ti.com>
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
> Currently DTB Overlays (.dtbo) are build from source files with the same
> extension (.dts) as the base DTs (.dtb). This may become confusing and
> even lead to wrong results. For example, a composite DTB (created from a
> base DTB and a set of overlays) might have the same name as one of the
> overlays that create it.
> 
> Different files should be generated from differently named sources.
>  .dtb  <-> .dts
>  .dtbo <-> .dtso
> 
> We do not remove the ability to compile DTBO files from .dts files here,
> only add a new rule allowing the .dtso file name. The current .dts named
> overlays can be renamed with time. After all have been renamed we can
> remove the other rule.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>

-Frank


>  scripts/Makefile.lib | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 3aa384cec76b8..0376a6f18bfb1 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -408,6 +408,9 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
>  $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
>  	$(call if_changed_dep,dtc)
>  
> +$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
> +	$(call if_changed_dep,dtc)
> +
>  dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
>  
>  # Bzip2

