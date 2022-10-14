Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1935B5FF3C9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJNSm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJNSmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:42:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F01CEC1D;
        Fri, 14 Oct 2022 11:42:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id y10so3783838qvo.11;
        Fri, 14 Oct 2022 11:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9T8jQNwButrrQoYqMshRtxbE6/ysi6nkPvoph0oCh4=;
        b=NZ+mnzMKjGzR20/DcjUW/jqBO2up2/pWNkWfpdBbp8dzS0x1xoVipOTEav2dPPlnam
         1iam/ch44zJEDumTd2/KgTRPNkNMPl+jZY/tNG4MRytK0oOqZelynAWHJf/zZ8o8TZZB
         +PJJlkqcVf1pS+tWQiJhPkSpSj45t0OtLAFTxO3EnEkSamYkv1RSVVdw+AivjLQkWpPl
         GKA6ZXOaJCkt8JLzbGOA+EQhZtmsHw/GJfs5ExIberWdaIPK/k4jrJqKreRFy8ZgtQjq
         J37+/wy2zIaI6EPqv1s/P6ovTemtvaMECbzJqEiSTfFtNb2aYgmF+Nj5aWJSQ4Nge5gf
         ZGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9T8jQNwButrrQoYqMshRtxbE6/ysi6nkPvoph0oCh4=;
        b=BKgzbXvn8YJDTmNCyqVjZ0vPSZpuizIc/EoU+lfEjRLFOvcos7maiyRxkw4zHPKlBB
         A7RJnKM+fK8vUrO45pCJCmCPKhD/DKvVn3Oc5qdjVpjsA1CBFeSeby7pMGhE9EqnbQD1
         3mftmDhEYwwTmQ5F77ENQcfUAhwn/Vnb65VyL248Zxnj++KSmZayqsxpU+i6uvv2s/BZ
         eNwS8s6fJfl86nya/qJG7X/9bgJxRMtz5GPhG8y1qK661SXusUo1RotvPs7SE3acbEEI
         5kJIROmsAAEqVrzEoth2SUwa1TmyGAw45ULcLqzMprfNH4rFwhZNv56DwPG39PIrQatL
         vSVA==
X-Gm-Message-State: ACrzQf1K5l01eUi2//9Y78+zg3eppJCpXMPNsjImTjdr9cNJZ6CBd/gb
        G6NaEpEQqzQjul3I1GLApPM=
X-Google-Smtp-Source: AMsMyM59QX20NproZZLr6f8lAomXJGjze6pXpwJ3i6f8PkAyt8h2Y3hNSGyyzPU8j5uKZtHLzqOnwA==
X-Received: by 2002:ad4:5aee:0:b0:4b4:595:fb54 with SMTP id c14-20020ad45aee000000b004b40595fb54mr5414058qvh.5.1665772970400;
        Fri, 14 Oct 2022 11:42:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b45a:72e4:d631:1b4c? ([2600:1700:2442:6db0:b45a:72e4:d631:1b4c])
        by smtp.gmail.com with ESMTPSA id bm9-20020a05620a198900b006e42a8e9f9bsm3222120qkb.121.2022.10.14.11.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 11:42:49 -0700 (PDT)
Message-ID: <90998e63-056e-52e6-03d2-775fc65d901d@gmail.com>
Date:   Fri, 14 Oct 2022 13:42:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] of: declare string literals const
Content-Language: en-US
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20221012174622.45006-1-cgzones@googlemail.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20221012174622.45006-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 12:46, Christian Göttsche wrote:
> of_overlay_action_name() returns a string literal from a function local
> array.  Modifying string literals is undefined behavior which usage of
> const pointer can avoid.  of_overlay_action_name() is currently only
> used once in overlay_notify() to print the returned value.
> 
> While on it declare the data array const as well.
> 
> Reported by Clang:
> 
>     In file included from arch/x86/kernel/asm-offsets.c:22:
>     In file included from arch/x86/kernel/../kvm/vmx/vmx.h:5:
>     In file included from ./include/linux/kvm_host.h:19:
>     In file included from ./include/linux/msi.h:23:
>     In file included from ./arch/x86/include/asm/msi.h:5:
>     In file included from ./arch/x86/include/asm/irqdomain.h:5:
>     In file included from ./include/linux/irqdomain.h:35:
>     ./include/linux/of.h:1555:3: error: initializing 'char *' with an expression of type 'const char[5]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "init",
>                     ^~~~~~
>     ./include/linux/of.h:1556:3: error: initializing 'char *' with an expression of type 'const char[10]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "pre-apply",
>                     ^~~~~~~~~~~
>     ./include/linux/of.h:1557:3: error: initializing 'char *' with an expression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "post-apply",
>                     ^~~~~~~~~~~~
>     ./include/linux/of.h:1558:3: error: initializing 'char *' with an expression of type 'const char[11]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "pre-remove",
>                     ^~~~~~~~~~~~
>     ./include/linux/of.h:1559:3: error: initializing 'char *' with an expression of type 'const char[12]' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>                     "post-remove",
>                     ^~~~~~~~~~~~~
> 
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
> ---
>  include/linux/of.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 6b79ef9a6541..8b9f94386dc3 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1549,9 +1549,9 @@ enum of_overlay_notify_action {
>  	OF_OVERLAY_POST_REMOVE,
>  };
>  
> -static inline char *of_overlay_action_name(enum of_overlay_notify_action action)
> +static inline const char *of_overlay_action_name(enum of_overlay_notify_action action)
>  {
> -	static char *of_overlay_action_name[] = {
> +	static const char *const of_overlay_action_name[] = {
>  		"init",
>  		"pre-apply",
>  		"post-apply",

Reviewed-by: Frank Rowand <frowand.list@gmail.com>

