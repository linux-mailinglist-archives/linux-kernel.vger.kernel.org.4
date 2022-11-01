Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEAC86144BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKAGjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiKAGjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:39:51 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37918FF7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:39:50 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id h9so18916217wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAwGDhopAFOE7srfgJIoNusdj+fr/wTaggRxhKzUGzU=;
        b=QeYIuhAXzN83FdC3qTqbzL06gKIGSLEtKjkEnzP8EArJnTwXTZH8xrOj2HITR+Ogyr
         cruhby0UJKXT2HJKseCZgATXeO/BZAgfxp8udosT5CgKCNvkpdOIw7vwpapY46BBQzkz
         CCU2wpEGyTle07CI1tSAkXB5QQM9QhR/5PCVkgJN/ZYnAjCtOw3f73P6nizvQYetyG1z
         63dl4Y3g/CdThooVSmCFflEFlGY/QSJt0IHwuGtwdosD88vws1lKbNPH3BtbzyN9k6ED
         yALpnhEoVn6aiogfLbL6csUJZLU1uSvF6VSYdNPkJVYGbfYFXeuY/tTv1Zu1R86hze3X
         RzzA==
X-Gm-Message-State: ACrzQf2dYXeNhRkkr1hEYPz9LnEVIMY7aWCbzoqIPhsBa14d3WN6lvoJ
        S1oo9MxH2rCYwiSOcYxLoEE=
X-Google-Smtp-Source: AMsMyM6EUwt/5cpiFAwY/hKGqnVWb+j85iFuJ0Q1kUZc2mxKUHH5dQDpEaXZ6XnMU1qu5nrurHM5hw==
X-Received: by 2002:adf:da4f:0:b0:236:cdd4:4ce2 with SMTP id r15-20020adfda4f000000b00236cdd44ce2mr5015752wrl.626.1667284788784;
        Mon, 31 Oct 2022 23:39:48 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id g13-20020a5d698d000000b0022cc3e67fc5sm8760697wru.65.2022.10.31.23.39.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 23:39:48 -0700 (PDT)
Message-ID: <a46f4e97-0f47-b3ba-88b8-17c95fa622f5@kernel.org>
Date:   Tue, 1 Nov 2022 07:39:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/2] scripts/head-object-list: remove x86 from the list
Content-Language: en-US
To:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20221031151047.167288-1-alexandr.lobakin@intel.com>
 <20221031151047.167288-3-alexandr.lobakin@intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20221031151047.167288-3-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31. 10. 22, 16:10, Alexander Lobakin wrote:
> Now that x86 boot code is not hardcoded to the particular linking
> order, remove x86 files from the list and let them be placed inside
> the vmlinux according only to the linker script and linker
> preferences.
> 
> Signed-off-by: Alexander Lobakin <alexandr.lobakin@intel.com>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   scripts/head-object-list.txt | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/scripts/head-object-list.txt b/scripts/head-object-list.txt
> index b16326a92c45..405d2942898a 100644
> --- a/scripts/head-object-list.txt
> +++ b/scripts/head-object-list.txt
> @@ -44,10 +44,4 @@ arch/s390/kernel/head64.o
>   arch/sh/kernel/head_32.o
>   arch/sparc/kernel/head_32.o
>   arch/sparc/kernel/head_64.o
> -arch/x86/kernel/head_32.o
> -arch/x86/kernel/head_64.o
> -arch/x86/kernel/head32.o
> -arch/x86/kernel/head64.o
> -arch/x86/kernel/ebda.o
> -arch/x86/kernel/platform-quirks.o
>   arch/xtensa/kernel/head.o

-- 
js
suse labs

