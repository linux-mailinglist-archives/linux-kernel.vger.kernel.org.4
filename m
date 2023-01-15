Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3466B37D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 19:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjAOSjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 13:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjAOSiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 13:38:51 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6F71285A
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 10:38:50 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id cx21-20020a17090afd9500b00228f2ecc6dbso5185584pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 10:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wgDu1UZCFEKonHoSuKGNi3twt6bIZItIIeZhKOBbBGs=;
        b=gkJDbq/ocZLiukS/yFhQc7DFgrsi/wU7+B60LLQ0yVk2fGvngqJ0I8n0saVhRbpLAO
         nyMcnviK+58KEzFnzPrAi+4FHmTgZiPNflvg9AiSW8O48md9PYAWQBjasWA99CTzOSE6
         j0IrMNu+3GgK0giZqW7lR+R6+rcITGuSNFVFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgDu1UZCFEKonHoSuKGNi3twt6bIZItIIeZhKOBbBGs=;
        b=u4YXnWgUlAhnLlLnU+++qsgltK7Z7RHjJvnXE7heMQclrEBS09cX0E4g7mbAiUvHj0
         aDUjCimoYy46ZrB+NxARsSeE9yJPeBycUFerGQc3ko2+tjLDEtZhWM47iq73ypt/qdU+
         gElPxFfWNOxuIOWCenzyv3kESgqyRykFSmahDaXT/Ii1uCdbG3pC/xHR59GBeQEF72wS
         U8rmZrAj1dmJkukwtsZbWNwMRsYirLyBNpnalQd3wfFZjxsuJiWnMC3mMdDGqsBeznoA
         kbmiyIy+b/JTK1PBG96G96LMMA/VVsexxFcoQUOVk6ei7hVaJ0zjXxz11bzS0Hq9qCJy
         KL2w==
X-Gm-Message-State: AFqh2kofG/UksmRnGVZqNqOrRFkRXE4wZ+WEKfAr0kBeLtb0uvyKSsOX
        5KV1F1njz7OApZ9iB65ZUkLBbQ==
X-Google-Smtp-Source: AMrXdXtwKryXCthfydUDvdFpoMDIWaa6UrOSYCiX1dvWpYv/ubTXTOmRJMZx563hFxmifVBujT/O1A==
X-Received: by 2002:a17:902:aa8e:b0:191:4575:48aa with SMTP id d14-20020a170902aa8e00b00191457548aamr82447502plr.11.1673807930314;
        Sun, 15 Jan 2023 10:38:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001947ba0ac8fsm3160052plk.236.2023.01.15.10.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 10:38:49 -0800 (PST)
Date:   Sun, 15 Jan 2023 10:38:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ACPICA: Replace fake flexible arrays with flexible array
 members
Message-ID: <202301151037.20CC3F0@keescook>
References: <20221118181538.never.225-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118181538.never.225-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 10:15:51AM -0800, Kees Cook wrote:
> Functionally identical to ACPICA upstream pull request 813:
> https://github.com/acpica/acpica/pull/813

Any update on this? Upstream is currently unbuildable since October.

> One-element arrays (and multi-element arrays being treated as
> dynamically sized) are deprecated[1] and are being replaced with
> flexible array members in support of the ongoing efforts to tighten the
> FORTIFY_SOURCE routines on memcpy(), correctly instrument array indexing
> with UBSAN_BOUNDS, and to globally enable -fstrict-flex-arrays=3.
> 
> Replace one-element array with flexible-array member in struct
> acpi_resource_extended_irq. Replace 4-byte fixed-size array with 4-byte
> padding in a union with a flexible-array member in struct
> acpi_pci_routing_table.
> 
> This results in no differences in binary output.

In the meantime, can you take this patch for Linux, and we can wait for
ACPICA to catch up?

Thanks!

-Kees

> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Robert Moore <robert.moore@intel.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> Cc: devel@acpica.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  include/acpi/acrestyp.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/acpi/acrestyp.h b/include/acpi/acrestyp.h
> index a7fb8ddb3dc6..ee945084d46e 100644
> --- a/include/acpi/acrestyp.h
> +++ b/include/acpi/acrestyp.h
> @@ -332,7 +332,7 @@ struct acpi_resource_extended_irq {
>  	u8 wake_capable;
>  	u8 interrupt_count;
>  	struct acpi_resource_source resource_source;
> -	u32 interrupts[1];
> +	u32 interrupts[];
>  };
>  
>  struct acpi_resource_generic_register {
> @@ -679,7 +679,10 @@ struct acpi_pci_routing_table {
>  	u32 pin;
>  	u64 address;		/* here for 64-bit alignment */
>  	u32 source_index;
> -	char source[4];		/* pad to 64 bits so sizeof() works in all cases */
> +	union {
> +		char pad[4];	/* pad to 64 bits so sizeof() works in all cases */
> +		DECLARE_FLEX_ARRAY(char, source);
> +	};
>  };
>  
>  #endif				/* __ACRESTYP_H__ */
> -- 
> 2.34.1
> 

-- 
Kees Cook
