Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB65F8159
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJGXp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGXp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603873FA15;
        Fri,  7 Oct 2022 16:45:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F276460EB7;
        Fri,  7 Oct 2022 23:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD35C433D6;
        Fri,  7 Oct 2022 23:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665186325;
        bh=YLLSpBQQFLa/F8wsdbV6TipE4jcTYgrcfVI+IjLgpqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=trTga5ZkBrHYOxY102H46cFDBgQcLulpu0yCoAszW7FcdFt85DqCzoy1/ga8M1y81
         uHPi54RxpmQgew9dx9ViaFMQIxo2DdHAmBIjMiFSMb0bkXNhXfLlcdglZY3OrMq8sg
         Tfvn1/KZtZQJP5xzae3affj33tJRoECM64dVoikKFSU7gRAbajC7rszOTyvI9z03OP
         gnYkpklvcxqg4NqnynSxzHGufCu5IJTDRoNBJwuiQh4HEa3e7qfsJ+WrSXQH6qfqcW
         ICGZRp4yfXUSzOPQoXAObTLDOxATOxuxY6NV+e6i7Z3SCLtIoENvn4h5XCAT9raNNv
         m9szBfXbi6imw==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-134072c15c1so3956959fac.2;
        Fri, 07 Oct 2022 16:45:25 -0700 (PDT)
X-Gm-Message-State: ACrzQf08i24esBH/FXeWWBCINb7KHgxZooUXmthzWPacSF7pd6+OJuWo
        AQH5xSUCzBdOEwa6EY/mNWUQcsfP4qs3uVVcOjI=
X-Google-Smtp-Source: AMsMyM5TZIwp0kTrGANDAJMA/t1spMCowMJvqK6Y2gPyqH6d29tQwjl8V7Ign8OxfngYXCct4f+U+xSvyb8l1NZ2rJs=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr9674015oao.112.1665186324398; Fri, 07
 Oct 2022 16:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20221007201648.2755133-1-colin.i.king@gmail.com>
In-Reply-To: <20221007201648.2755133-1-colin.i.king@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 8 Oct 2022 07:45:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRMNYpfwhZkjurgs2vGJRgokDNDMD-bj-x9RNjv_ZDLPA@mail.gmail.com>
Message-ID: <CAJF2gTRMNYpfwhZkjurgs2vGJRgokDNDMD-bj-x9RNjv_ZDLPA@mail.gmail.com>
Subject: Re: [PATCH] csky: Kconfig: Fix spelling mistake "Meory" -> "Memory"
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-csky@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, it would be in for-next.

On Sat, Oct 8, 2022 at 4:16 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> There is a spelling mistake in a Kconfig option description. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  arch/csky/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index adee6ab36862..100f5eb2313e 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -269,7 +269,7 @@ menuconfig HAVE_TCM
>         bool "Tightly-Coupled/Sram Memory"
>         depends on !COMPILE_TEST
>         help
> -         The implementation are not only used by TCM (Tightly-Coupled Meory)
> +         The implementation are not only used by TCM (Tightly-Coupled Memory)
>           but also used by sram on SOC bus. It follow existed linux tcm
>           software interface, so that old tcm application codes could be
>           re-used directly.
> --
> 2.37.3
>


-- 
Best Regards
 Guo Ren
