Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9095773A94F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjFVUHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVUHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:07:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E9119B
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:07:07 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b53b8465daso38208595ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687464427; x=1690056427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rRceC2Em04Mn9wWhJvKcNrbkdrle685Lc8A6OEbK70c=;
        b=bsirya4zb/3ljIjxpSptQZleePVH2CV1o92QhMq5NxKbXezIIWsrETVcJPExRmrWI0
         VHMWYzwCE0iMHi45bkHW3s864nrpv+huGC+J3hhyUhbEK63ZXZrIy9cGbq0A3JZ6CMdm
         JKUEQOL5VVmno+2HdwPSKy9rHYMCuMBSTbeCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687464427; x=1690056427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rRceC2Em04Mn9wWhJvKcNrbkdrle685Lc8A6OEbK70c=;
        b=OYVWBqMmlBBhHP1lArGWqDUixI8QsQC3DUPKZrXzYjYTVWPUUxN0PIffEik5+IP03T
         deS00j8UIqTrB2uYd7FotddRP8TLZNP0TPndAcfSo4+Xm2EMGOHfKoMJdXdXXzAWeaQG
         RlrO8rvlQUDYkKttd/pfVOsqGGrvbMlPOGY6ckro5nc0Q5bYIuPcT0o+mAvCwOoIKRlN
         JFiRGXqUCGh/fPczNrFAUjyjIigpHdJqwwAuXavyDBYJQkJRjmEEXF7rvK3gRSI37SFT
         RuHLSea9HYlhGWtVObZsprbz3bsHQgT7lhoEXwgWiRY8X6IEsiapZehD9rt0BRQeRcdT
         D6bg==
X-Gm-Message-State: AC+VfDwT6js+0umxhCuh/YrRVTCdMHwxlgFfeAEtlXAuhGpL7qUDpLH7
        0HUuHmA1qUg9hYe6SI9GsCHivw==
X-Google-Smtp-Source: ACHHUZ6SuJ4+KH06vVHTEyfMKFigI3xO/NPcNvbNy7RgwL5n4tcxFj7GSoXHgSW2Xxso/W7fTzjZ7w==
X-Received: by 2002:a17:903:190:b0:1b1:9968:53be with SMTP id z16-20020a170903019000b001b1996853bemr14191367plg.64.1687464426840;
        Thu, 22 Jun 2023 13:07:06 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id iy9-20020a170903130900b001aaed524541sm5735306plb.227.2023.06.22.13.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:07:05 -0700 (PDT)
Date:   Thu, 22 Jun 2023 13:07:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] elf: correct note name comment
Message-ID: <202306221305.5F23BC4@keescook>
References: <a7e56e9c0f821348a4c833ac07e7518f457cbdb8.1687413763.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7e56e9c0f821348a4c833ac07e7518f457cbdb8.1687413763.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 09:02:43AM +0300, Baruch Siach wrote:
> Only the NT_PRFPREG note is named "LINUX". Correct the comment
> accordingly.
> 
> Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> 
> Resending in hope kvack.org mail server would be willing to accept my
> submission this time.
> 
> Adding LKML as a safety net.
> ---
>  include/uapi/linux/elf.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git include/uapi/linux/elf.h include/uapi/linux/elf.h
> index ac3da855fb19..a8a0cced62c6 100644
> --- include/uapi/linux/elf.h
> +++ include/uapi/linux/elf.h
> @@ -372,7 +372,7 @@ typedef struct elf64_shdr {
>   * Notes used in ET_CORE. Architectures export some of the arch register sets
>   * using the corresponding note types via the PTRACE_GETREGSET and
>   * PTRACE_SETREGSET requests.
> - * The note name for all these is "LINUX".
> + * The note name for most types is "CORE". NT_PRFPREG note is named "LINUX".
>   */
>  #define NT_PRSTATUS	1
>  #define NT_PRFPREG	2

Is this accurate? I see this logic in fs/binfmt_elf.c:

                bool is_fpreg = note_type == NT_PRFPREG;
		...
                fill_note(&t->notes[note_iter], is_fpreg ? "CORE" : "LINUX",
                          note_type, ret, data);

i.e. only FPREG is named "CORE", otherwise "LINUX".

Shouldn't this patch have CORE and LINUX swapped?

-- 
Kees Cook
