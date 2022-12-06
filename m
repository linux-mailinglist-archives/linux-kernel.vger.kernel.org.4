Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64246644F66
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLFXLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLFXL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:11:27 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D342992;
        Tue,  6 Dec 2022 15:11:26 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 140so15948984pfz.6;
        Tue, 06 Dec 2022 15:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfTm30VB1mndYkvvbw2Oxak8CjnQYLln6zOZ6Likm1A=;
        b=czes146P4fBUdjrU9CUKLgagdpW36UHAeBI4SRCOSd9HY37dFV+PwVIWuT9uEoPnxh
         7O33CfJciPqdY4LPg1KziDDAbaGTfvECjI+RcNKZ4O1bKFdp2o7kh03/mewtw0HYX3OQ
         9u9WYLRc7ivrm3gVe5pty6OuQQg8TZddEMmVQu9NakLz8DeYmg+pk199OV6lQaQ9x8wT
         5UckprbweEaRXF1GbnPr8fbsBp2NDIVqpqSl3rec0pksEGcKks1+7c5ckfwbR6MHg7H+
         CEJo913Jg28HDqX4k7/Tr69bZUEkzRNLphQfbRl8GFC3RXCFQESKFXrOLj7oKX685tzt
         WVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfTm30VB1mndYkvvbw2Oxak8CjnQYLln6zOZ6Likm1A=;
        b=wFwVg25nZfJi0Tz5BpC4A2k5PYoq0HF2zekIrFM/Dw/7LC5q6rQq6RxGnP9jc/b8NT
         zFgWhpMN1fHIuFNxJwyNpYHgPUkssKnddJ7MLPP18rltUtBNo7M72uEBmFmYKqn+LODj
         9sCfTEKLhYhEf5uwAz32eJxmUMZMjVG7DRELTWzVMQe/KT1HNbRqw1oKtS91WIIlcehC
         JOuXBySWZKAWgrc/F3o3MoHpcB1mpbLZ87gNi+A1ACXOI9gs5vuiHlJjVsu82Vx+2qDA
         NJd0o+egLb2JUDoXeHCu3mlHIODconvIxbRAyRYisWt6LsgFBmYJLm8S/6tU32LJ4A1S
         Wx5A==
X-Gm-Message-State: ANoB5pkH2u5xx7/kmy4Iyjg8OJcs8dweVi8k4iavLjGRV4kdXhj7qC+t
        ceuRp0oRMbnztL/zPcZDxMI=
X-Google-Smtp-Source: AA0mqf4UfUxYve2T+s32vQJd6OKR0C20+saAxeAtZ9WHcI2zn3cyNJwnDTTf5MuQYYH/dB446D4BxA==
X-Received: by 2002:a62:be17:0:b0:56e:664f:a5f5 with SMTP id l23-20020a62be17000000b0056e664fa5f5mr464952pff.8.1670368285963;
        Tue, 06 Dec 2022 15:11:25 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id x28-20020aa78f1c000000b0056c349f5c70sm12220709pfr.79.2022.12.06.15.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 15:11:25 -0800 (PST)
Message-ID: <6079a282-c802-9836-1ae7-d67526a205c9@gmail.com>
Date:   Wed, 7 Dec 2022 08:11:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 2/2] docs: Integrate rustdoc generation into htmldocs
Content-Language: en-US
To:     Carlos Bilbao <carlos.bilbao@amd.com>, corbet@lwn.net,
        ojeda@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bilbao@vt.edu, konstantin@linuxfoundation.org
References: <20221201204814.2141401-1-carlos.bilbao@amd.com>
 <20221206153151.771038-1-carlos.bilbao@amd.com>
 <20221206153151.771038-3-carlos.bilbao@amd.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221206153151.771038-3-carlos.bilbao@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2022 09:31:51 -0600, Carlos Bilbao wrote:
> Change target `make htmldocs` to combine RST Sphinx and the
> generation of Rust documentation, when support is available.
> 
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  Documentation/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 64d44c1ecad3..f537cf558af6 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -92,6 +92,10 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
>  	fi
>  
>  htmldocs:
> +# If Rust support is available, add rustdoc generated contents
> +ifdef CONFIG_RUST
> +	$(Q)$(MAKE) rustdoc
> +endif
>  	@$(srctree)/scripts/sphinx-pre-install --version-check
>  	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
>  

What about patch below on top of this?
This way, it is possible to skip rustdoc generation by saying:

    make CONFIG_RUST=n SPHINXDIRS=doc-guide htmldocs

The reordering is to complete Sphinx runs even if rustdoc generation
ends up in error.

With this applied on top,

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira

------
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2cf3e0fd7839..4d334468aaaf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -92,12 +92,12 @@ quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
 	fi
 
 htmldocs:
+	@$(srctree)/scripts/sphinx-pre-install --version-check
+	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 # If Rust support is available, add rustdoc generated contents
-ifdef CONFIG_RUST
+ifeq ($(CONFIG_RUST),y)
 	$(Q)$(MAKE) rustdoc
 endif
-	@$(srctree)/scripts/sphinx-pre-install --version-check
-	@+$(foreach var,$(SPHINXDIRS),$(call loop_cmd,sphinx,html,$(var),,$(var)))
 
 texinfodocs:
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-- 

