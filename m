Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB075E635F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiIVNOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiIVNOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A44EA59C;
        Thu, 22 Sep 2022 06:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 772D96338E;
        Thu, 22 Sep 2022 13:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA7BC43140;
        Thu, 22 Sep 2022 13:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663852452;
        bh=fNgGRurTHx6e54748ie56cxwpBqgA20LmVhFU/CTT/4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RHOmGrGoYKgd9F069CvVZ9MLgM22iF8DaoSk+9N/YbhiYj0dlq8pRiGxbMm0GUlrT
         1s+CbsMS3q7qH/kph59yi6xAWcu/LHWXGWUfbRRurOTU0L7oghrQYOr6n+EtjVYT5C
         QeGzfV8poAFtENO3Uf0oL+rfXHRUM1swIRLAv3d/k5Ls7ONHDpbE4ddMJt+eqpTdD1
         IA3oz7oUwOl5r8EzaL4FfRUraH0WsRrfOMerW2sgZlvx90XfMwIEEdtevD6dLj+5LI
         GRHzdRTLLXNwGXMqy5kDMYN88qqGoRaX/UJ/MXT+u8mhmow/5krLscw8AsVcziQGPQ
         8jhRwZG8W+AiQ==
Received: by mail-lf1-f54.google.com with SMTP id a2so14621442lfb.6;
        Thu, 22 Sep 2022 06:14:12 -0700 (PDT)
X-Gm-Message-State: ACrzQf3m5t3cShj2sR42zn9sR3Ec+yuViJfHOj1q2Fu1IEm0tRuCl5hD
        rYzN3UdsdD6U0bK/YyTkRQD/9jQJ87TpCJAOiHw=
X-Google-Smtp-Source: AMsMyM62FN66QhEr2E9WQ4yTIqwM3yXIz+ExidSVsP5kh+/j6z5bqfvmxKldJJ0afDSWIJAzCyFH9TdTjL1zoGky9Fs=
X-Received: by 2002:a05:6512:4024:b0:497:4db:6ad0 with SMTP id
 br36-20020a056512402400b0049704db6ad0mr1296066lfb.637.1663852450898; Thu, 22
 Sep 2022 06:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220922130452.233323-1-chenzhongjin@huawei.com> <20220922130452.233323-2-chenzhongjin@huawei.com>
In-Reply-To: <20220922130452.233323-2-chenzhongjin@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Sep 2022 15:13:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGSjGr_yBC_9DiFu4k3JpDRPB+BPuKdNu2XeSWT2BSZvQ@mail.gmail.com>
Message-ID: <CAMj1kXGSjGr_yBC_9DiFu4k3JpDRPB+BPuKdNu2XeSWT2BSZvQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/3] arm64: efi-header: Mark efi header as data
To:     Chen Zhongjin <chenzhongjin@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, catalin.marinas@arm.com, will@kernel.org,
        broonie@kernel.org, maz@kernel.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sept 2022 at 15:08, Chen Zhongjin <chenzhongjin@huawei.com> wrote:
>
> This file only contains a set of constants forming the efi header.
>
> Make the constants part of data symbols by wrapping them with
> SYM_DATA.
>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>

Why is this necessary? These are not emitted into a .text section, and
are not even covered by the kernel's mapping of memory. So the .L
prefixed labels are deliberate: it prevents the symbols from polluting
the symbol namespace with symbols pointing nowhere.


> ---
>  arch/arm64/kernel/efi-header.S | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/kernel/efi-header.S b/arch/arm64/kernel/efi-header.S
> index 28d8a5dca5f1..3eacd27ab761 100644
> --- a/arch/arm64/kernel/efi-header.S
> +++ b/arch/arm64/kernel/efi-header.S
> @@ -28,6 +28,7 @@
>         .macro  __EFI_PE_HEADER
>  #ifdef CONFIG_EFI
>         .set    .Lpe_header_offset, . - .L_head
> +SYM_DATA_START_LOCAL(arm64_efi_header)
>         .long   PE_MAGIC
>         .short  IMAGE_FILE_MACHINE_ARM64                // Machine
>         .short  .Lsection_count                         // NumberOfSections
> @@ -160,6 +161,7 @@
>
>         .balign SEGMENT_ALIGN
>  .Lefi_header_end:
> +SYM_DATA_END_LABEL(arm64_efi_header, SYM_L_LOCAL, efi_header_end)
>  #else
>         .set    .Lpe_header_offset, 0x0
>  #endif
> --
> 2.17.1
>
