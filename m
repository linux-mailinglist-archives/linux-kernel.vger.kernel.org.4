Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995075FFF12
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 14:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJPMWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJPMWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 08:22:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758B32D8C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:22:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id l4so8543315plb.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=riG3rpz0PdYIywyB1Q3ZXsTuV9gq1bybMEHwwtvCYJ8=;
        b=Q67fJ94b/XDWxPCfXcwhRI9qVdhKC1jVRLPlFUb1kR9n6f+1C5t0EnoJXdelg+jDKO
         D9M/H9n7K7hKWNLqPbujIFgYCZJaLs9h70NKuJRlRJ4k5/vYyOqnUtq+LpukbQopLqk+
         TsT5JJ6XyEZxLR5K2yq98BpF+hHm+fYJWVYuCefHnPJY5WZzHc3ygCsUuEKoLXQtjDvf
         ffGj+wYd3dtgSHtk3rr9T0+aQibv7xSc5R/ifFdFoAxNGcdS9CxytftyZgpsRsrERNl2
         2hzN4KgTtpMiZ1cdEP2pWgQUaeLyflc2PKwbPyxMrmJ7OIngIR7lH4zxvBjEsipzZUz0
         5gyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=riG3rpz0PdYIywyB1Q3ZXsTuV9gq1bybMEHwwtvCYJ8=;
        b=M4wweo3zV9Xahdq7uS89ZhaBMY2O5jUjOjXNMQYDYMWumlUAv9mwE2PBG4UFvucEHM
         Xrhib4+qEb3yR/dx9nRcscv2zsXtiVAe+69qY+Hg7M3oHsBe7B2sG6dOe2qwm9ob69B0
         hG6J7QFONmScqy2OVAFo/24G5jqaQidJksSW5525XsLU8ZEO/yMY46+u36/CHwgKasAj
         mi7j8UVWuhYen7uck1lhA63opWdL5UI176BoZvniw+fZc6a0M7WQn9jGHpB8/G/RX/5r
         AdRVYZT/8u/lQjVOKwYoq+zm94uyKXv/78+mNRA+GCxxzMMpB3oHJGBl9YFmDvsRY0WY
         eFpA==
X-Gm-Message-State: ACrzQf0BWm8C83EuW2PlpWaxHEeu2DxgEitX7DIc9vzOF+fBn7zkMGpY
        cmm/j9BOqcwEydM4TBemb84=
X-Google-Smtp-Source: AMsMyM6mjWBZ2V++taqNvXtf8fwyILGKPIY6kA+A3IZiFigR6mdaElPWnWJUJJRKutnJEZMbOE6f2Q==
X-Received: by 2002:a17:903:2144:b0:182:42ce:5778 with SMTP id s4-20020a170903214400b0018242ce5778mr6767956ple.46.1665922924121;
        Sun, 16 Oct 2022 05:22:04 -0700 (PDT)
Received: from [192.168.43.80] (subs32-116-206-28-46.three.co.id. [116.206.28.46])
        by smtp.gmail.com with ESMTPSA id nd16-20020a17090b4cd000b0020a821e97fbsm4374996pjb.13.2022.10.16.05.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 05:22:03 -0700 (PDT)
Message-ID: <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
Date:   Sun, 16 Oct 2022 19:21:59 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr
Cc:     linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221015205936.5735-1-phillip@squashfs.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 03:59, Phillip Lougher wrote:
> 
> Which identified the "squashfs: support reading fragments in readahead call"
> patch.
> 
> There is a race-condition introduced in that patch, which involves cache
> releasing and reuse.
> 
> The following diff will fix that race-condition.  It would be great if
> someone could test and verify before sending it out as a patch.
> 
> Thanks
> 
> Phillip
> 
> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
> index e56510964b22..6cc23178e9ad 100644
> --- a/fs/squashfs/file.c
> +++ b/fs/squashfs/file.c
> @@ -506,8 +506,9 @@ static int squashfs_readahead_fragment(struct page **page,
>  		squashfs_i(inode)->fragment_size);
>  	struct squashfs_sb_info *msblk = inode->i_sb->s_fs_info;
>  	unsigned int n, mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
> +	int error = buffer->error;
>  
> -	if (buffer->error)
> +	if (error)
>  		goto out;
>  
>  	expected += squashfs_i(inode)->fragment_offset;
> @@ -529,7 +530,7 @@ static int squashfs_readahead_fragment(struct page **page,
>  
>  out:
>  	squashfs_cache_put(buffer);
> -	return buffer->error;
> +	return error;
>  }
>  
>  static void squashfs_readahead(struct readahead_control *ractl)
> 

No Verneed warnings so far. However, I need to test for a longer time
(a day) to check if any warnings are reported.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

