Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC373BCC2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 18:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbjFWQiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 12:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjFWQiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 12:38:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1E9B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:38:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b6824141b4so14450565ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 09:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687538328; x=1690130328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/PqgxOGlm7JeknPbdLeTMxaNpvnqwn+/rBHeoNzP99Q=;
        b=Fvu6J9RAuxOlIvBCs/wWJmY7LyKVzVmMsTQYDLGffI9IaezGB5zMp89ScbMMvQDguD
         3zKkTDePTzXxvOLcRcveEubSrOFR+ik+0xXYPOAFRmlISt3lMVEhFYIMUkDZL3pCWD5W
         xI5AVw4CmpyN7tJ73xlDgSPm+mo8SEIwZW/+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687538328; x=1690130328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/PqgxOGlm7JeknPbdLeTMxaNpvnqwn+/rBHeoNzP99Q=;
        b=PxHu9KtF6U63TqmCdtlZFFDeK2B4uPQOqYMvAigDZFVJjhppYK1XhT5I7yJzzrUK/z
         fn5zh4ToHdKFgnLHZ71e1SaDpqLRJszYghZEiWJ2QoTSds6O7gbdp6+Qn49uWndZ7ugU
         q63WawV42WQSZMjX6cy9yXX4Mh2fOQc+1xe5f1881toX4ApYknnx7QT7iZUKlLnyakAu
         tUSivrmuUVl8/CRVFCCA9gFzU8PENo57OZ3Ds4BWUDzxVXNRkf9Jv0oBmxfqkFxDuOIJ
         G/epL97bvfT4nGRL79TKPxCSZ14cEeteinYFFcnfm297s9yNlOooEsiRE2/cS169z0Mk
         ly4A==
X-Gm-Message-State: AC+VfDzTU6yhlnW0b2M2NstSjM2cUU3HIF75lNx24FRL4XFCBZJxASn7
        Cd7XzJrEGlzoswzmfVy47PSSvO5TlBm9Tzk8iQo=
X-Google-Smtp-Source: ACHHUZ6Ea4cEX2yb7KtxAHZHvVCQ2kOV3aUY2rpTco4cDXWJWEhhPp7d0DQIgq2+csyN9udkqjSpKA==
X-Received: by 2002:a17:902:bc43:b0:1b6:8233:6f5c with SMTP id t3-20020a170902bc4300b001b682336f5cmr12102473plz.19.1687538328318;
        Fri, 23 Jun 2023 09:38:48 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id o1-20020a170902bcc100b001b0f727bc44sm7467396pls.16.2023.06.23.09.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 09:38:47 -0700 (PDT)
Date:   Fri, 23 Jun 2023 09:38:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Baruch Siach <baruch@tkos.co.il>
Cc:     Eric Biederman <ebiederm@xmission.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] binfmt_elf: fix comment typo s/reset/regset/
Message-ID: <202306230938.64FD809@keescook>
References: <0b2967c4a4141875c493e835d5a6f8f2d19ae2d6.1687499804.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b2967c4a4141875c493e835d5a6f8f2d19ae2d6.1687499804.git.baruch@tkos.co.il>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 08:56:44AM +0300, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> 
> Resending with LKML in Cc. kvack.org MX does not like our mail server.
> ---
>  fs/binfmt_elf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git fs/binfmt_elf.c fs/binfmt_elf.c
> index 8a884e795f6a..f304a3434c5a 100644
> --- fs/binfmt_elf.c
> +++ fs/binfmt_elf.c

Same formatting issue with this one.

> @@ -1773,7 +1773,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
>  	/*
>  	 * NT_PRSTATUS is the one special case, because the regset data
>  	 * goes into the pr_reg field inside the note contents, rather
> -	 * than being the whole note contents.  We fill the reset in here.
> +	 * than being the whole note contents.  We fill the regset in here.
>  	 * We assume that regset 0 is NT_PRSTATUS.
>  	 */
>  	fill_prstatus(&t->prstatus.common, t->task, signr);

But thank you; I've applied both to the execve tree:

https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=for-next/execve

-Kees

-- 
Kees Cook
