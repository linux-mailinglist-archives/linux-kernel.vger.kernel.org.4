Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13E6B590E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 07:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCKGqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 01:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCKGqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 01:46:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC831E1CB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:46:21 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x3so29201607edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 22:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678517179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ecFiLM2NOIcmzrMEnFX3qID1W2x+qNart8iHS9x3+NY=;
        b=jlyIVZeyrcS2IlBV31rw0plRZrWDMwbR5ancg1fckRmpLSHoHFa39MKkQPBvBelJ3o
         VI5/dJCcqkSHlaihGlwe4N9ejnBce02gri3z5OHVPlm2QNLh6RZIAravfMDFAnXHOQ7E
         7h0vs1AAzmM04Zg0d4PUzMLfsV9W7Ky8a7SgC2J72Ysp0N5JNriF2MYQ/E7sPw5OkNFB
         zZ1ENjQHv+h72Q3f5+U07cp1Z1nZ6xI4Si6Wp/jeZ67fpFmr7nCK1o8ByR4vpHZk4Pmb
         V6fRdLb1UR6N+uZjN/1rKoWUrBu27d+n7UlfsVPI757OFNgYeumL3fR9ElaYfFjGNPZX
         7K7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678517179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ecFiLM2NOIcmzrMEnFX3qID1W2x+qNart8iHS9x3+NY=;
        b=AxmnKe2XfO00FoQF4aK+ehvLi+wbAaztjp9SyZL6J+dnTEeo5b7KjCJGrHr6AvT74w
         sT1u8lvs6D6NJFigqMrnnjQg+yzOjlommDG8tlNWmy55S8sQBY3IpcOJoXiUu2lirTFs
         H9euBRBrjgLPBw+ZXqOwQtamcSyiLOQGGrL1WLJeywdR2HQOzFK4PlL5tG0W1Ufb+tsa
         vL/kDG6HT0NLAJDXZgb01AzqkPVFZkeOD/rZjjDPOPXQU86fuA4kDU2rTEAF6GhSWYlt
         ZPrPuZNwbizy0ZzYXQ8ww+cREIkOokFKC2iQkrhT+lfPyvIrw9/rugbdaOwwjKvCh/Zn
         BZYA==
X-Gm-Message-State: AO0yUKU9Ss5YSmGDXrN8K1FzWS4QEdwIDgRK4W3c8hjKoutP6Ke5fOrk
        ItXzni1MCx8iioxWwdDHzrA=
X-Google-Smtp-Source: AK7set91MWvVpLbTHsjGIj4gqdvNh5aeBIpo4n4HWR3bKEPO1ZoBMVZW1PTUMUJo7TUgTJGt2xsCZg==
X-Received: by 2002:a17:906:518e:b0:882:bffc:f2d2 with SMTP id y14-20020a170906518e00b00882bffcf2d2mr8489802ejk.2.1678517179517;
        Fri, 10 Mar 2023 22:46:19 -0800 (PST)
Received: from [192.168.10.15] ([37.252.81.68])
        by smtp.gmail.com with ESMTPSA id ot7-20020a170906ccc700b008ef13127b5fsm771602ejb.29.2023.03.10.22.46.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 22:46:19 -0800 (PST)
Message-ID: <0059d07f-97ce-724a-39ec-2a640ba82ef5@gmail.com>
Date:   Sat, 11 Mar 2023 10:46:16 +0400
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

#syz test 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
