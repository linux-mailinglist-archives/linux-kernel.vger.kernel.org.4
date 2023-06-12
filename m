Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8AE72B512
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbjFLBPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 21:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLBPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 21:15:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F1919C;
        Sun, 11 Jun 2023 18:15:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25bec2512f3so233973a91.0;
        Sun, 11 Jun 2023 18:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686532501; x=1689124501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M4r95/HNn3Z0zrSpboHuCJ1hLyk1T3UrNK3O9mwvSAU=;
        b=qBHQS/3mVdkqwWUwjNHfJG7MgUz02uTuSRMWHzmuF0huYJGmaCwPFFbu34+TV6ntNb
         NvNp1hh0DBIrPP0NJkdtG3glSpYlAJTB+ALyFDAZZ5J2Y7z0dgPha1XId+uGzoz57Zz4
         3Kw1D87TdXfMC82D3xhl/O6WDVKhMP7jfiaVrP06IrDNcnNXv9Tf7huVcwqeeGIFe1Sg
         5J0rsvttL6RJ9Y2OTUWTkXBj7QgjlNY2AfBSg+jRL/ZUf9pPdf17PMXCKC7hJa2MNzua
         t4G5lD+bejpiFC24EuLhWuPIJr7dAT/A/WmU0Ks8FRlOzJMJ5aJz2FyXcLRnKeV2zPCj
         Tofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686532501; x=1689124501;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M4r95/HNn3Z0zrSpboHuCJ1hLyk1T3UrNK3O9mwvSAU=;
        b=ObgbZLEmV15I/PNqxmN5jpmFVLLVsQ3fmU0lhEr5jxWKHR9X11FwCUqQkkYj7BJEAI
         VKpQzBUJ4+P7x4GSvnc+tmFOpyXLNVHW7T8A2v61tdGroCZA8DGZuaAmpDbywYWUqoqb
         MB4WnogxTSzLQqek9MLNuQ+QU+VXxedj1vSVNjrOA6vuTs4wjUN5Zr3+NXDymU8AEZWX
         nR7d4ngf7sfXOH/gIdF0yO9ECy7YglY+Fym+TGHSM7UtQ51VX4bQ+4DhdzevlQ9MNbUB
         0kxOh5RhNjBh/zEXHZLHVGDPrTA8XVuUIn61D/C6qSy0B/Qnpa1Dd+RMMTxI+ZmQnU4I
         2c1Q==
X-Gm-Message-State: AC+VfDwvMHKyFE9qXsToVDPxpKUDEEmpMDEUWBVWQmZVsE8LFodpsUcP
        Racx4UGWQfLyyAyJXgwwYOp5+iEkn0A=
X-Google-Smtp-Source: ACHHUZ4jjTczZTWwetrRr3xBtZ88HLcYRMXd8tv1P+Tyu8mNyogOWakBKA9EFPYVGhBB8nFuSSRb8w==
X-Received: by 2002:a17:90a:404b:b0:25b:e25e:9bd7 with SMTP id k11-20020a17090a404b00b0025be25e9bd7mr1867718pjg.1.1686532501391;
        Sun, 11 Jun 2023 18:15:01 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-80.three.co.id. [180.214.232.80])
        by smtp.gmail.com with ESMTPSA id x10-20020a63cc0a000000b0053fb37fb626sm6308170pgf.43.2023.06.11.18.14.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Jun 2023 18:15:00 -0700 (PDT)
Message-ID: <049d6b11-d5a9-ca28-2111-7fce2d946d7f@gmail.com>
Date:   Mon, 12 Jun 2023 08:14:56 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: add kdump.rst into index.rst
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        corbet@lwn.net, will@kernel.org, kernel test robot <lkp@intel.com>
References: <20230611230358.13635-1-bhe@redhat.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20230611230358.13635-1-bhe@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 06:03, Baoquan He wrote:
> Document kdump.rst was added into Documentation/arm64/, but not listed
> in Documentation/arm64/index.rst. That triggers below warning when
> executing "make htmldoc":
> 
>>> Documentation/arm64/kdump.rst: WARNING: document isn't included in any toctree
> 
> Fix it now.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202306110549.ynH2Juok-lkp@intel.com/
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>

Let me add Fixes tag:

Fixes: 03dc0e05407f39 ("Documentation: add kdump.rst to present crashkernel reservation on arm64")

> ---
>  Documentation/arm64/index.rst | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/arm64/index.rst b/Documentation/arm64/index.rst
> index ae21f8118830..e58391557f00 100644
> --- a/Documentation/arm64/index.rst
> +++ b/Documentation/arm64/index.rst
> @@ -15,6 +15,7 @@ ARM64 Architecture
>      cpu-feature-registers
>      elf_hwcaps
>      hugetlbpage
> +    kdump
>      legacy_instructions
>      memory
>      memory-tagging-extension

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara

