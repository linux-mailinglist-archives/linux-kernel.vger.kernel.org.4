Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6A5E636E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiIVNRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiIVNRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A1AECCF9;
        Thu, 22 Sep 2022 06:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8790B63383;
        Thu, 22 Sep 2022 13:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB225C433D7;
        Thu, 22 Sep 2022 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663852641;
        bh=x9EZseEA0PIBQdEf8joKTvvbD5nJbC3PTH3Wh3WrbXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uPNbRC2HKIPvUhAP9prxhTxQaJzsQNl1L7xgfCFWTwJ7pAWN86OMYoNdM31Xuz1AQ
         Aiej/HWDhE7mKe3XzEIqO/c3grUzbBn9j/HWkSt0HmDDhGXHYUZHyjOtaPzJXVP1Ho
         Zvp6F8EGu96G6oPJij9C8YaprqjoH8p5IKgTR4YBVmXoSJwZ0sAafVN4g1Rrfglwbo
         kKU5Obvso02WvQr+3BQ9DMPBE5x1UWJoZGZsMpCwldplYI7UrIolDa9xVEkdhcObzl
         tHNf9TV/yTRwDE4Y48b9YUfJmTVR7Yr6RMYSd434MITAvxj4cTNBJ7nPAeo/0YtN5u
         B5lF/gCfOJzCg==
Received: by mail-lj1-f179.google.com with SMTP id a14so10950433ljj.8;
        Thu, 22 Sep 2022 06:17:20 -0700 (PDT)
X-Gm-Message-State: ACrzQf2YeMBYgUmKsSNLpCAf9P/9wO1B/p31YSMxERyaTrlXv5quDEtX
        HonbvKHO0NakWT9LF1sG0/bF2G2bxoXRn7vRNVc=
X-Google-Smtp-Source: AMsMyM6q3bBLBY2OjqmXgTbgtxJ7IhRQqk58EtZ9+ZiyWfMOCOSN3Wd6huyQ/rfigeiPhnyFyUZfn79+676BO0lVmNI=
X-Received: by 2002:a2e:9115:0:b0:26a:c086:5138 with SMTP id
 m21-20020a2e9115000000b0026ac0865138mr1001036ljg.189.1663852639014; Thu, 22
 Sep 2022 06:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220922130452.233323-1-chenzhongjin@huawei.com> <20220922130452.233323-3-chenzhongjin@huawei.com>
In-Reply-To: <20220922130452.233323-3-chenzhongjin@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Sep 2022 15:17:07 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFtx0OZozwedDsUJotfPi8Ugrcy2J+ee_YH4nb=36W2dQ@mail.gmail.com>
Message-ID: <CAMj1kXFtx0OZozwedDsUJotfPi8Ugrcy2J+ee_YH4nb=36W2dQ@mail.gmail.com>
Subject: Re: [PATCH -next 2/3] arm64: head: Mark constants as data
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
> Add data annotations to constants part of the image header.
>
> Signed-off-by: Julien Thierry <jthierry@redhat.com>
> Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> ---
>  arch/arm64/kernel/head.S | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index 814b6587ccb7..f298e88e2d23 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -57,9 +57,10 @@
>         /*
>          * DO NOT MODIFY. Image header expected by Linux boot-loaders.
>          */
> -       efi_signature_nop                       // special NOP to identity as PE/COFF executable
> +SYM_DATA_LOCAL(efi_nop, efi_signature_nop)     // special NOP to identity as PE/COFF executable

This is an instruction not data

>         b       primary_entry                   // branch to kernel start, magic
> -       .quad   0                               // Image load offset from start of RAM, little-endian
> +SYM_DATA_LOCAL(_zero_reserved, .quad   0)      // Image load offset from start of RAM, little-endian

Why convert this quad? And why does it need a symbol?

> +SYM_DATA_START_LOCAL(_arm64_common_header)
>         le64sym _kernel_size_le                 // Effective size of kernel image, little-endian
>         le64sym _kernel_flags_le                // Informative flags, little-endian
>         .quad   0                               // reserved

But not this one?

> @@ -67,6 +68,7 @@
>         .quad   0                               // reserved
>         .ascii  ARM64_IMAGE_MAGIC               // Magic number
>         .long   .Lpe_header_offset              // Offset to the PE header.
> +SYM_DATA_END(_arm64_common_header)
>
>         __EFI_PE_HEADER
>
> --
> 2.17.1
>
