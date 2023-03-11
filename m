Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 730456B5A00
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 10:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjCKJV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 04:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCKJUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 04:20:46 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DFF2739
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:19:48 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x3so29991630edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 01:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678526387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pp15R7AN1g9JfNTcPdKWcY79zOLhi73tWbb1tIB1i+0=;
        b=FDCnm4WSk24SppuAS2DjJpqkLKAYCHeBVG/dBtdTyddqYcrKXp/HqV8qMlm0NUimDE
         IsQQIGzs1Vx1p+P3euE4+GSKWH26lovKkxHZQBJxT8xm3KuEZxjcfKOzpUUnqRCm3v27
         igkFAO8f6WKemxy+zNn9sGwcFRzeMjB9SWRiq3wZ3ZDLA69gLkMgC5w0uHnbw42cAxyy
         sJVB5vnSwIsuE7rC/frjFSOlIIyYkfySHXXdPMvA9rGzowgUipfKWycz7Eme/fyePEGX
         8D1E7JSKjCXnIaCD8BXbRbU5oYzY3drkblT8ZVvP4R5261OASMTSMn+o3gnnIXJvwGWo
         sH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678526387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pp15R7AN1g9JfNTcPdKWcY79zOLhi73tWbb1tIB1i+0=;
        b=51NjqPNZLxdXXDppOv6vzCHuJxMxbu2fReN/5zUrgyTOoD+OBSNd/TtYyBeggi5uys
         EDuzn7UyUm0BZtiyLpwKfPExM9Fy7Vl7hwrVSDUf2PJyDzEAaK8zSLZEPhpJgt4bLE4M
         rKRs51JnVQw+cqzf96OgPxzEMDLsAuDBgyEauOxmTmNu/BH9iYh6vUqRSTGTGDA/o1Jj
         n6PegJDg+IU2ZIDQ0kK3gr7j1gnNT//vsWEttF9I6G0V4BUBuJraIT6MexkPpCAAZ6MF
         msHVtIF7r5TKRKCVhfV1+wnL76KZE8L3kKlMz/+MmCZt7WpvGv0SPWCuJW+d0aehh5i+
         nkdg==
X-Gm-Message-State: AO0yUKVXpYnm1jlSzrZO3XqJlaNQhCNJg7NbHr0OoMPkvc9KBq+IrxNm
        iLKCd2sKhrSdxpcgJ9CyaHY=
X-Google-Smtp-Source: AK7set8/lXEbMZ7dy3RnFiL9KBD46H5wRKw3OpbFtqMiOZiqL6p61stQL4FSFsmU6+NPOdBH0PNgMw==
X-Received: by 2002:a17:906:208a:b0:889:d24e:6017 with SMTP id 10-20020a170906208a00b00889d24e6017mr4875012ejq.3.1678526386798;
        Sat, 11 Mar 2023 01:19:46 -0800 (PST)
Received: from [192.168.10.15] ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id a20-20020a1709065f9400b008be0b7242d5sm895678eju.90.2023.03.11.01.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 01:19:46 -0800 (PST)
Message-ID: <9e341f7d-b7b6-0237-2a2d-8395eef8ca04@gmail.com>
Date:   Sat, 11 Mar 2023 13:19:44 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] 9P FS: Fix wild-memory-access write in v9fs_get_acl
Content-Language: en-US
To:     ericvh@gmail.com, lucho@ionkov.net, asmadeus@codewreck.org,
        linux_oss@crudebyte.com
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, himadrispandya@gmail.com,
        syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
References: <20230311063411.7884-1-ivan.orlov0322@gmail.com>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20230311063411.7884-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/23 10:34, Ivan Orlov wrote:
> KASAN reported the following issue:
> [   36.825817][ T5923] BUG: KASAN: wild-memory-access in v9fs_get_acl+0x1a4/0x390
> [   36.827479][ T5923] Write of size 4 at addr 9fffeb37f97f1c00 by task syz-executor798/5923
> [   36.829303][ T5923]
> [   36.829846][ T5923] CPU: 0 PID: 5923 Comm: syz-executor798 Not tainted 6.2.0-syzkaller-18302-g596b6b709632 #0
> [   36.832110][ T5923] Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/21/2023
> [   36.834464][ T5923] Call trace:
> [   36.835196][ T5923]  dump_backtrace+0x1c8/0x1f4
> [   36.836229][ T5923]  show_stack+0x2c/0x3c
> [   36.837100][ T5923]  dump_stack_lvl+0xd0/0x124
> [   36.838103][ T5923]  print_report+0xe4/0x4c0
> [   36.839068][ T5923]  kasan_report+0xd4/0x130
> [   36.840052][ T5923]  kasan_check_range+0x264/0x2a4
> [   36.841199][ T5923]  __kasan_check_write+0x2c/0x3c
> [   36.842216][ T5923]  v9fs_get_acl+0x1a4/0x390
> [   36.843232][ T5923]  v9fs_mount+0x77c/0xa5c
> [   36.844163][ T5923]  legacy_get_tree+0xd4/0x16c
> [   36.845173][ T5923]  vfs_get_tree+0x90/0x274
> [   36.846137][ T5923]  do_new_mount+0x25c/0x8c8
> [   36.847066][ T5923]  path_mount+0x590/0xe58
> [   36.848147][ T5923]  __arm64_sys_mount+0x45c/0x594
> [   36.849273][ T5923]  invoke_syscall+0x98/0x2c0
> [   36.850421][ T5923]  el0_svc_common+0x138/0x258
> [   36.851397][ T5923]  do_el0_svc+0x64/0x198
> [   36.852398][ T5923]  el0_svc+0x58/0x168
> [   36.853224][ T5923]  el0t_64_sync_handler+0x84/0xf0
> [   36.854293][ T5923]  el0t_64_sync+0x190/0x194
> 
> Calling '__v9fs_get_acl' method in 'v9fs_get_acl' creates the
> following chain of function calls:
> 
> __v9fs_get_acl
> 	v9fs_fid_get_acl
> 		v9fs_fid_xattr_get
> 			p9_client_xattrwalk
> 
> Function p9_client_xattrwalk accepts a pointer to u64-typed
> variable attr_size and puts some u64 value into it. However,
> after the executing the p9_client_xattrwalk, in some circumstances
> we assign the value of u64-typed variable 'attr_size' to the
> variable 'retval', which we will return. However, the type of
> 'retval' is ssize_t, and if the value of attr_size is larger
> than SSIZE_MAX, we will face the signed type overflow. If the
> overflow occurs, the result of v9fs_fid_xattr_get may be
> negative, but not classified as an error. When we try to allocate
> an acl with 'broken' size we receive an error, but don't process
> it. When we try to free this acl, we face the 'wild-memory-access'
> error (because it wasn't allocated).
> 
> This patch will add new condition to the 'v9fs_fid_xattr_get'
> function, so it will return an EOVERFLOW error if the 'attr_size'
> is larger than SSIZE_MAX.
> 
> In this version of the patch I removed explicit type conversion and
> added separate condition to check the possible overflow and return
> an error (in v1 version I've just modified the existing condition).
> 
> Reported-by: syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   fs/9p/xattr.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
> index 50f7f3f6b55e..6affd6b3f5e6 100644
> --- a/fs/9p/xattr.c
> +++ b/fs/9p/xattr.c
> @@ -35,10 +35,14 @@ ssize_t v9fs_fid_xattr_get(struct p9_fid *fid, const char *name,
>   		return retval;
>   	}
>   	if (attr_size > buffer_size) {
> -		if (!buffer_size) /* request to get the attr_size */
> -			retval = attr_size;
> -		else
> +		if (!buffer_size) {/* request to get the attr_size */
> +			if (attr_size > SSIZE_MAX)
> +				retval = -EOVERFLOW;
> +			else
> +				retval = attr_size;
> +		} else {
>   			retval = -ERANGE;
> +		}
>   	} else {
>   		iov_iter_truncate(&to, attr_size);
>   		retval = p9_client_read(attr_fid, 0, &to, &err);

Tested via syzkaller, this patch fixes the bug (see patch testing requests):
https://syzkaller.appspot.com/bug?id=fbbef66d9e4d096242f3617de5d14d12705b4659
