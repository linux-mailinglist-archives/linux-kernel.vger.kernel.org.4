Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD76605B65
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 11:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiJTJn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJTJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:43:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70A31C8438;
        Thu, 20 Oct 2022 02:43:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id i9so267583wrv.5;
        Thu, 20 Oct 2022 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFIXaRhb6LOT5Wmi8fHaBqhBfVYEurDojN9SfCe/f/Y=;
        b=MWExOnsgo6sj81A1gvqr8yDsFmVUT7ooWxiX4W6SNRvmavL2o/47qS46UGkEE51LqW
         Lyip5i64S98CQvyZeiiJUTsZb4Va3SqqLf3eYodXkpI99Kj608kV7pS65G13iwvnwOqi
         LN4EAtWj65D+HLsld/ompUmUB97Wf/ciqJ5HX+DVBi4Yh8mYNMV4mMsfdQaneTDkhMX2
         uMRe5RmhUmP3dumNnL+sJbivCVxGgXDJlbquZbj67qqpsh9CyvytrYr9D6aMrCZJCGnc
         wDf7hUS32I5nY/Np1mdPAggEjGlwQOj7cwW7zxnOj21FNKtPWNZGQW8RXIyADKEeq+Bs
         EOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFIXaRhb6LOT5Wmi8fHaBqhBfVYEurDojN9SfCe/f/Y=;
        b=NRuNbp7pDkdJTYjNcUfVq7r8k3szgnzDmymcFRl22WF4dUyOpMgq0x9ljZdE8MCDq7
         DqE/xk+3O1kOUU2dmrM3P6tPAEWFTqeAbErIfx5jcN5uHicX7LBiSC6MtZ3vs/jLfgic
         dBceELmn1KPz4My5QxwpIukhm5Wag6+a8T8aXIQDUOqfFIBvgaloAcjywQcPk7alp5a4
         oDgWk2WdCNsqWADzRvZr9qfltOVZfU9IYZzsxvm9A8Fk5urkMa4Cntkr7OItHUDg0hh+
         dpcF06TkWkKqBF4i+QL6QTgJrz5NBwdMhWWVrNXYODXJjhsJNjy/Bka5VaeY+PS8idsb
         hMIQ==
X-Gm-Message-State: ACrzQf0C5YXqlBLbUsQ2i7Wq4R350irogh1QyVzkbS0ypRw/924JkKNk
        i8mlZf1bUTUb/Fo0Klb7LLVmvYjcwQ==
X-Google-Smtp-Source: AMsMyM6F8nQvnCNmaTI47EGs3maXjm+TtLKs/lCB8tUVEpSgyVl1vwh7/wKTLKkYOAgsEHa3ziQYuA==
X-Received: by 2002:a5d:668e:0:b0:22f:d914:80ed with SMTP id l14-20020a5d668e000000b0022fd91480edmr7919798wru.45.1666259022559;
        Thu, 20 Oct 2022 02:43:42 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.126])
        by smtp.gmail.com with ESMTPSA id q1-20020adfdfc1000000b0022e049586c5sm15810098wrn.28.2022.10.20.02.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 02:43:41 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:43:39 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mm-commits@vger.kernel.org, torvalds@linux-foundation.org,
        masahiroy@kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        Jason@zx2c4.com, akpm@linux-foundation.org
Subject: Re: + kbuild-treat-char-as-always-unsigned.patch added to
 mm-nonmm-unstable branch
Message-ID: <Y1EYS/DRjvQd/8t+@localhost.localdomain>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221020000356.177CDC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:03:55PM -0700, Andrew Morton wrote:
> This will break things in some places and fix things in others, so this
> will likely cause a bit of churn while reconciling the type misuse.

> --- a/Makefile~kbuild-treat-char-as-always-unsigned
> +++ a/Makefile
> @@ -562,7 +562,7 @@ KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-P
>  KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
>  		   -fno-strict-aliasing -fno-common -fshort-wchar -fno-PIE \
>  		   -Werror=implicit-function-declaration -Werror=implicit-int \
> -		   -Werror=return-type -Wno-format-security \
> +		   -Werror=return-type -Wno-format-security -funsigned-char \
>  		   -std=gnu11
>  KBUILD_CPPFLAGS := -D__KERNEL__
>  KBUILD_RUSTFLAGS := $(rust_common_flags) \

ACK

Another reason is that characters were always some small non-negative
integers which mapped to pictures so making them signed was silly from
the beginning.

People should use "const char *" for C strings and "u8[]" for raw buffers.
Unfortunately, C can't give developer more.
