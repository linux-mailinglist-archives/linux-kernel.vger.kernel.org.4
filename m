Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE766A8FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 04:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCCDIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 22:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjCCDIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 22:08:13 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD97615553
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 19:08:12 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id r5so1585244qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 19:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1677812892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtFwTdVwKlt2HPFqS6JWdnkwoS9VbQjLUEhGF6OSSZE=;
        b=QE/EDs4Ix3xkylm5Fcz5nQL80rHtuziqGz2kedrkucExE5w8dXBV35aYo7K5fMbAiH
         S8MTdKueuqDmWABSVE0/moawK2y5Unlj/SQYKCHbHPaobw864hSn3jhGLWuO0PABMeey
         5LcbQaH3D3W01hp8XAUtcUD9sNhRL4mKqAtNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677812892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtFwTdVwKlt2HPFqS6JWdnkwoS9VbQjLUEhGF6OSSZE=;
        b=IqOyZ/BruE7k/kIkbEjz5uTEcc00uKiAp/S7guYEzfhAhRXjgn3S2PESmX/LOYUNoi
         PuM1UAMgAzX8E6Q9Tm3maP71uy6l/j5eZIXtO8We+FKjwoTYqqt0HXmV0ivOocTVUlYr
         SJdUiIpkIJdNpbz6gk7eJJ9wheCz9suZk64AHBuqw4uYaUVBQG0RM3L6nFMgcznPrvrp
         DaOpMaWXaYF5PqSnmwPwoh358apK9f0rjnDarPpnLVbMzKRmUdBcDTR5M/NChnQUhhJ2
         wxJ3++kmjV1LdBa1kmzxhNfy/gUvMVgjYIuK3Es/8Ut8k3rs4U8WybiJn3P/EZqY59b8
         qpIQ==
X-Gm-Message-State: AO0yUKU4yYtXje5WjkPaRCNf5QM5hBmgobS17HCpgeixU1Jj8gAJpY/C
        SA98QWEEbkfC4wkk8qx/LzjXOg==
X-Google-Smtp-Source: AK7set8p1efjvsmZsXnYTfWfn4EuoPfVyXTwuYw5lQLPIyH8QD7/cBl02oG9UI97rsa78ytUbKBzsw==
X-Received: by 2002:a05:622a:553:b0:3bf:bac6:9961 with SMTP id m19-20020a05622a055300b003bfbac69961mr646660qtx.55.1677812891786;
        Thu, 02 Mar 2023 19:08:11 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id 17-20020ac85651000000b003b62bc6cd1csm902902qtt.82.2023.03.02.19.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 19:08:10 -0800 (PST)
Date:   Fri, 3 Mar 2023 03:08:10 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, stable@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kheaders: Use array declaration instead of char
Message-ID: <20230303030810.GA1598250@google.com>
References: <20230302224946.never.243-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302224946.never.243-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2023 at 02:49:50PM -0800, Kees Cook wrote:
> Under CONFIG_FORTIFY_SOURCE, memcpy() will check the size of destination
> and source buffers. Defining kernel_headers_data as "char" would trip
> this check. Since these addresses are treated as byte arrays, define
> them as arrays (as done everywhere else).
> 
> This was seen with:
> 
>   $ cat /sys/kernel/kheaders.tar.xz >> /dev/null
> 
>   detected buffer overflow in memcpy
>   kernel BUG at lib/string_helpers.c:1027!
>   ...
>   RIP: 0010:fortify_panic+0xf/0x20
>   [...]
>   Call Trace:
>    <TASK>
>    ikheaders_read+0x45/0x50 [kheaders]
>    kernfs_fop_read_iter+0x1a4/0x2f0
>   ...
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/bpf/20230302112130.6e402a98@kernel.org/
> Tested-by: Jakub Kicinski <kuba@kernel.org>

Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> Fixes: 43d8ce9d65a5 ("Provide in-kernel headers to make extending kernel easier")
> Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/kheaders.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/kheaders.c b/kernel/kheaders.c
> index 8f69772af77b..42163c9e94e5 100644
> --- a/kernel/kheaders.c
> +++ b/kernel/kheaders.c
> @@ -26,15 +26,15 @@ asm (
>  "	.popsection				\n"
>  );
>  
> -extern char kernel_headers_data;
> -extern char kernel_headers_data_end;
> +extern char kernel_headers_data[];
> +extern char kernel_headers_data_end[];
>  
>  static ssize_t
>  ikheaders_read(struct file *file,  struct kobject *kobj,
>  	       struct bin_attribute *bin_attr,
>  	       char *buf, loff_t off, size_t len)
>  {
> -	memcpy(buf, &kernel_headers_data + off, len);
> +	memcpy(buf, &kernel_headers_data[off], len);
>  	return len;
>  }
>  
> @@ -48,8 +48,8 @@ static struct bin_attribute kheaders_attr __ro_after_init = {
>  
>  static int __init ikheaders_init(void)
>  {
> -	kheaders_attr.size = (&kernel_headers_data_end -
> -			      &kernel_headers_data);
> +	kheaders_attr.size = (kernel_headers_data_end -
> +			      kernel_headers_data);
>  	return sysfs_create_bin_file(kernel_kobj, &kheaders_attr);
>  }
>  
> -- 
> 2.34.1
> 
