Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B714B6A0264
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 06:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjBWFjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 00:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjBWFjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 00:39:05 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3822DFE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:39:02 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id f23so13019303vsa.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 21:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EwdWdKQBGyREoqdrHRFF8oqp7s6Uz5ClfcqZzsKL7No=;
        b=Q6tozNeCjntUtDQYGvefiA222AnJLm965VDgazVsMkdLHlxWsdPC8Zx17M6vEGc2pm
         jwFNavb1eQw6ZXcGwlg2N7A+F8CqZv+KWwOzY66fsETyrjwvkOJ2lIE3pKKO9FISymG+
         gPLYqpS8Wjr81tlelDflIOqWDo5chXw0R6ophpTh7c+VLAWgiBKDckeLW0jXrmXtu7Lq
         GcqdKD2VyMHM4BRVSOjJcWnGowB9ffF0QqIdGSmpGR4W1wrkRE3ZsLVaTZrmx3d6RH8S
         vOvvlAtWbdUOr241xQdoLppIpmD/Irq5JgO+RTm8/jqgmJ2HzJZA69KEpmsW/1Demto7
         yu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwdWdKQBGyREoqdrHRFF8oqp7s6Uz5ClfcqZzsKL7No=;
        b=nPuxAAD9x8GmB7KsDJFgPgPIg7Y60wxYYpqAs2En0L7dLDSg5PMWimTfikLVEgOPhc
         XPfijgksqvD3ngcZA3lzMM0417o0LjHxZHbxW6lHlTkXS+KYVtRDQpzWAUxZSaFkSntG
         mkIcshIjgkS0DN2tvRHlTGYn8LpT+y1H6fyxKnIxWhvJ8Wfeyqr7cfO5eQsASIjjegQh
         A3xe442jVxxJs+/+PL706TOnFDBQkRJDPGbkmt8/nGTDVWlN8JzHx1k9yAea/PmFkX61
         l7AZcfnmk0Z6V1c/9Bgj5KG4/2Ieryu1F8axXY2Cr4qwItbNCjsgJwNWBg0uPwz8t2Iv
         3BWA==
X-Gm-Message-State: AO0yUKXvMgxtSjnVIspxY/x9SwbDNHH1s0D/IzlRfWwjW47RJPk+Vn75
        WRDHzo7IPcYRO95qVtdbNvhQLB3xRJKKPnYVB+iK+HkgZ/aC01J9
X-Google-Smtp-Source: AK7set+Ram5ewAZuH5S7R/yDexCEcjuud2K1qMLqNSVvpWLc0aAP+cp0wrIsKR+cCWrRtaXbGblekV4O1IvGemhctxE=
X-Received: by 2002:a1f:bdcd:0:b0:40f:2033:6994 with SMTP id
 n196-20020a1fbdcd000000b0040f20336994mr202255vkf.2.1677130741499; Wed, 22 Feb
 2023 21:39:01 -0800 (PST)
MIME-Version: 1.0
References: <20230222173009.19874-1-jmaselbas@kalray.eu>
In-Reply-To: <20230222173009.19874-1-jmaselbas@kalray.eu>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 23 Feb 2023 11:08:49 +0530
Message-ID: <CAFA6WYPGF3Q=_U-rZGyyH=ouunwT=9nx7j+pueCVS5jLng4fxA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Fix typo Unuspported -> Unsupported
To:     Jules Maselbas <jmaselbas@kalray.eu>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2023 at 23:00, Jules Maselbas <jmaselbas@kalray.eu> wrote:
>
> Fix typo Unuspported -> Unsupported
>
> Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
> ---
>  drivers/tee/optee/call.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index 290b1bb0e9cd..df5fb5410b72 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -488,7 +488,7 @@ static bool is_normal_memory(pgprot_t p)
>  #elif defined(CONFIG_ARM64)
>         return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
>  #else
> -#error "Unuspported architecture"
> +#error "Unsupported architecture"
>  #endif
>  }
>
> --
> 2.17.1
>
