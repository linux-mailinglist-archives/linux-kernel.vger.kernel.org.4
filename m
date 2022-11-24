Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8BB63714F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiKXD42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKXD40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:56:26 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4328430A;
        Wed, 23 Nov 2022 19:56:24 -0800 (PST)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2AO3u4Hp002867;
        Thu, 24 Nov 2022 12:56:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2AO3u4Hp002867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1669262165;
        bh=DmgnDVDiiUf2g4oKI+oYEIgmMNACi/xWZ5iyXzLQYtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WXws+UhnRbFVDXMt35oAIl6UqcS23RbTh++qCbQZzXSwuE1VQdOhLCkynAper7wlf
         CkSsfZQVi/1OrwXWodILo3bvUoFh/of3j3HhFqwQBMi43dEhV4cH2oKujUYuLr1EjY
         N7OnAi/Fe//k2U1LOGRMaf0KIxemYUOQJgSIzSAyomd7Gl9OYjWk6odoq2zXCtZZFY
         GNwSAK4YmaFY/M1TCKtleF8GsXYYyE4I0SVFr6UvgL6+Qawug3XsUPKspwEtLoOik3
         4fXo+3oe4Y2WAK4lKPRGQafwj76haoKnkv6I6U7dXq1ht3ipkQiGyfMh4amMGqVRcq
         8yNU+eVkFuOng==
X-Nifty-SrcIP: [209.85.160.42]
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1432a5f6468so699883fac.12;
        Wed, 23 Nov 2022 19:56:05 -0800 (PST)
X-Gm-Message-State: ANoB5pl8efU3HCEZ3BbgyiTyUH63swkLyuuyCXIIqD9U7qvvhf7yjJzf
        flmMeYREPOXPYi52zLtX1lw0EBxR+aGKy17Z0oQ=
X-Google-Smtp-Source: AA0mqf49deRpTa5nOSQLTS7MVUEmw8tp6B0lu7Ey9T5i1tMD4jr9hzqSCutxN3kZP4LT4Mz7o+es09OsX7TIDYkZWuk=
X-Received: by 2002:a05:6870:3b06:b0:13b:5d72:d2c6 with SMTP id
 gh6-20020a0568703b0600b0013b5d72d2c6mr6489409oab.287.1669262164299; Wed, 23
 Nov 2022 19:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20221124032053.10627-1-rdunlap@infradead.org>
In-Reply-To: <20221124032053.10627-1-rdunlap@infradead.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Nov 2022 12:55:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARfULFwt9RGq34dXSwchCWMrwauh_PfMKPCSBAqhCOHzg@mail.gmail.com>
Message-ID: <CAK7LNARfULFwt9RGq34dXSwchCWMrwauh_PfMKPCSBAqhCOHzg@mail.gmail.com>
Subject: Re: [PATCH] nios2: add FORCE for vmlinuz.gz
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>,
        linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 12:21 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Add FORCE to placate a warning from make:
>
> arch/nios2/boot/Makefile:24: FORCE prerequisite is missing
>
> Fixes: 2fc8483fdcde ("nios2: Build infrastructure")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Dinh Nguyen <dinguyen@kernel.org>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: linux-kbuild@vger.kernel.org


Assuming this will go to the NIOS2 tree,

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>



Please let me know if I should apply this to kbuild tree.



> ---
>  arch/nios2/boot/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff -- a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile
> --- a/arch/nios2/boot/Makefile
> +++ b/arch/nios2/boot/Makefile
> @@ -20,7 +20,7 @@ $(obj)/vmlinux.bin: vmlinux FORCE
>  $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
>         $(call if_changed,gzip)
>
> -$(obj)/vmImage: $(obj)/vmlinux.gz
> +$(obj)/vmImage: $(obj)/vmlinux.gz FORCE
>         $(call if_changed,uimage)
>         @$(kecho) 'Kernel: $@ is ready'
>


-- 
Best Regards
Masahiro Yamada
