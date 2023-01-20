Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4C6675621
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 14:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjATNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATNvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 08:51:45 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4417A8C;
        Fri, 20 Jan 2023 05:51:44 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id v10so6823769edi.8;
        Fri, 20 Jan 2023 05:51:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7z4p3bE6yeWZf9K6gd38mjPF+wHICd+ZDjndpXq4sU=;
        b=c96DBGE6Quo+ZfjDWh8cXxNdpzAdwX0tGEbrwallV7zrrCb8PEGFnyMcu8kPCPgnPM
         mei2a2ktFzKU6Kph7uUYQRLtx2JHXmxwm8waPchbkNL8Y/MxeJXt4638eYQLIuYEKM4O
         7PaHRWwHcmo3YwtDhEoq9+9mpZSgyltQnvk8fPiKgSfEBBVppjhV6DdUNWdTXBExHtRJ
         wYA6uXvdncoEbrrojBGINBF+RjGzHe76KtkB3UsIR/Bf76wUgOflyI3ATm1imOAwk22M
         K9EYXaVuocEa/s42Yi7hgT+mPV5n3sSX3s0bKwGoqbg/gNL0YO/Vhtbe7FpU65nAtAr3
         4mDQ==
X-Gm-Message-State: AFqh2kpF9wcQEOZL4P5YC2gORnu0ZZtLvhC799o1c/bA6JZOuoCSEJdD
        xiem4qQE2nmYKSAp27Ysdbf8R0quz+jQoAMd908=
X-Google-Smtp-Source: AMrXdXtP5nWZeqdv/HtGkPdXqIpj/Oe+I/LVjm8KHGxKctawzLe1A7TwcW/LT4cmqKELB6jq+ny40EGxkgAkcMgX2XU=
X-Received: by 2002:a05:6402:28a4:b0:485:2bdf:ca28 with SMTP id
 eg36-20020a05640228a400b004852bdfca28mr2195464edb.251.1674222703011; Fri, 20
 Jan 2023 05:51:43 -0800 (PST)
MIME-Version: 1.0
References: <20230103032840.12265-1-rdunlap@infradead.org>
In-Reply-To: <20230103032840.12265-1-rdunlap@infradead.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 14:51:31 +0100
Message-ID: <CAJZ5v0hmwtYDYKP5BsDfynTyw+LvL5qpcXmbiWSZV7MpTTtrcA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: swap: don't use /** for non-kernel-doc comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 4:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> kernel-doc complains about multiple occurrences of "/**" being used
> for something that is not a kernel-doc comment, so change all of these
> to just use "/*" comment style.
>
> The warning message for all of these is:
>
> FILE:LINE: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>
> kernel/power/swap.c:585: warning: ...
> Structure used for CRC32.
> kernel/power/swap.c:600: warning: ...
>  * CRC32 update function that runs in its own thread.
> kernel/power/swap.c:627: warning: ...
>  * Structure used for LZO data compression.
> kernel/power/swap.c:644: warning: ...
>  * Compression function that runs in its own thread.
> kernel/power/swap.c:952: warning: ...
>  *      The following functions allow us to read data using a swap map
> kernel/power/swap.c:1111: warning: ...
>  * Structure used for LZO data decompression.
> kernel/power/swap.c:1127: warning: ...
>  * Decompression function that runs in its own thread.
>
> Also correct one spello/typo.
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---
>  kernel/power/swap.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff -- a/kernel/power/swap.c b/kernel/power/swap.c
> --- a/kernel/power/swap.c
> +++ b/kernel/power/swap.c
> @@ -581,7 +581,7 @@ static int save_image(struct swap_map_ha
>         return ret;
>  }
>
> -/**
> +/*
>   * Structure used for CRC32.
>   */
>  struct crc_data {
> @@ -596,7 +596,7 @@ struct crc_data {
>         unsigned char *unc[LZO_THREADS];          /* uncompressed data */
>  };
>
> -/**
> +/*
>   * CRC32 update function that runs in its own thread.
>   */
>  static int crc32_threadfn(void *data)
> @@ -623,7 +623,7 @@ static int crc32_threadfn(void *data)
>         }
>         return 0;
>  }
> -/**
> +/*
>   * Structure used for LZO data compression.
>   */
>  struct cmp_data {
> @@ -640,7 +640,7 @@ struct cmp_data {
>         unsigned char wrk[LZO1X_1_MEM_COMPRESS];  /* compression workspace */
>  };
>
> -/**
> +/*
>   * Compression function that runs in its own thread.
>   */
>  static int lzo_compress_threadfn(void *data)
> @@ -948,9 +948,9 @@ out_finish:
>         return error;
>  }
>
> -/**
> +/*
>   *     The following functions allow us to read data using a swap map
> - *     in a file-alike way
> + *     in a file-like way.
>   */
>
>  static void release_swap_reader(struct swap_map_handle *handle)
> @@ -1107,7 +1107,7 @@ static int load_image(struct swap_map_ha
>         return ret;
>  }
>
> -/**
> +/*
>   * Structure used for LZO data decompression.
>   */
>  struct dec_data {
> @@ -1123,7 +1123,7 @@ struct dec_data {
>         unsigned char cmp[LZO_CMP_SIZE];          /* compressed buffer */
>  };
>
> -/**
> +/*
>   * Decompression function that runs in its own thread.
>   */
>  static int lzo_decompress_threadfn(void *data)

Applied as 6.3 material, thanks!
