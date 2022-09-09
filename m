Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 016B05B3DA3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiIIRGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIRGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:06:30 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3949011749F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:06:29 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r194-20020a632bcb000000b0043541f027d9so1254068pgr.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=+dBYz90mu90lIiOo6JMMkRfvVSiBxRyF6ljXVUnQrCw=;
        b=Py30OtJBq9XoSZQz8kw+7Sj58/fGxNwbWhBckzHo0L80w9/6JyTd8jbzYkJyzqqGoB
         aslp4sJfC2tdUW1z/zabgBigIThpPsfmSYCeFxjZtBmND2hgKHri7WcpXERnswiT9u4F
         UE3sRmTRJDRRZN4kHskX635YLnDbpepPp7SXMZdV9+qLOEXNV/nIEYRXcb1VW3ODygaN
         b1UGAR5QfYXLArqfWgd/EkqwnSZPx8mJdOsLEAUuGntOpvmUUvQPfAi9M8f9aFA+bfLO
         kR1X4XtB2IJeiULDEoe/LoCMFb72NWLbJR0stI0HSJnnJy3SkMLZYCbc+pPXuFjLLi5H
         e1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=+dBYz90mu90lIiOo6JMMkRfvVSiBxRyF6ljXVUnQrCw=;
        b=AuPCYLsNINu0zsyWwQ/vmuidK+uRaVfjOZ7MtVRrKeNYy/xtjEUn7R8MEjx10jYwK3
         XGcbAK943j88wfvCqy4/9x0ebSmbPy20pXipmeZfH1pxQCGDliFFQBVBhs9L2IF2/pnC
         vx+ovRI82z8aCvjNAPg34qkNQZmSu6Bn4xob8RgbhOkIJj8x+VayTOvZq5CqYX+1G2jr
         ZqegON7+lIt6Os7flyBNkkYZeoCoB7e2MXCI4n+aP46NnABU1Ps1WAIGdeTN0KmZp8TA
         SW/Uh2QZXWtMaNEwXinCnDY0Vf9Gq8zz5xZMKci79wPD0aVvOvCF6EY4zubAcOwBEhy0
         9i9g==
X-Gm-Message-State: ACgBeo0d0GBMpeyU8chxI/HqJEcbZ0N6dv/WXVlvLY7lOlBvBBXYCwsw
        5xZSqFxc9CKlg3pAXjS1ajEFfNM=
X-Google-Smtp-Source: AA6agR5PFY27vZflpYbySQhbsJcOn2PebC/wEqF5OfnfuYU2ZjUHxthLaXwx4TpzGMOFy5wgD/Wkn3s=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1909:b0:536:65dd:44ca with SMTP id
 y9-20020a056a00190900b0053665dd44camr15602323pfi.1.1662743188662; Fri, 09 Sep
 2022 10:06:28 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:06:27 -0700
In-Reply-To: <1662702346-29665-1-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1662702346-29665-1-git-send-email-wangyufen@huawei.com>
Message-ID: <Yxtyk/Sxr0L7S22D@google.com>
Subject: Re: [bpf-next 1/2] libbpf: Add make_path_and_pin() helper for bpf_xxx__pin()
From:   sdf@google.com
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Wang Yufen wrote:
> Move make path, check path and pin to the common helper  
> make_path_and_pin() to make
> the code simpler.

Idk, I guess I'll defer to Andrii here; I won't really call it simpler.
The code just looks different and looses some observability (see below).

> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>   tools/lib/bpf/libbpf.c | 56  
> ++++++++++++++++++++++----------------------------
>   1 file changed, 24 insertions(+), 32 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 3ad1392..5854b92 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7755,16 +7755,11 @@ static int check_path(const char *path)
>   	return err;
>   }

> -int bpf_program__pin(struct bpf_program *prog, const char *path)
> +static int make_path_and_pin(int fd, const char *path)
>   {
>   	char *cp, errmsg[STRERR_BUFSIZE];
>   	int err;

> -	if (prog->fd < 0) {
> -		pr_warn("prog '%s': can't pin program that wasn't loaded\n",  
> prog->name);
> -		return libbpf_err(-EINVAL);
> -	}
> -
>   	err = make_parent_dir(path);
>   	if (err)
>   		return libbpf_err(err);
> @@ -7773,12 +7768,27 @@ int bpf_program__pin(struct bpf_program *prog,  
> const char *path)
>   	if (err)
>   		return libbpf_err(err);

> -	if (bpf_obj_pin(prog->fd, path)) {
> +	if (bpf_obj_pin(fd, path)) {
>   		err = -errno;
>   		cp = libbpf_strerror_r(err, errmsg, sizeof(errmsg));
> -		pr_warn("prog '%s': failed to pin at '%s': %s\n", prog->name, path,  
> cp);
> +		pr_warn("failed to pin at '%s': %s\n", path, cp);

This seems to be making logging worse?
We went from "can't pin 'program name' to 'path': ENOENT" to "can't pin
to 'path': ENOENT". You can deduce the program name from the path, but
why not keep the proper log message?

>   		return libbpf_err(err);
>   	}
> +	return 0;
> +}
> +
> +int bpf_program__pin(struct bpf_program *prog, const char *path)
> +{
> +	int err;
> +
> +	if (prog->fd < 0) {
> +		pr_warn("prog '%s': can't pin program that wasn't loaded\n",  
> prog->name);
> +		return libbpf_err(-EINVAL);
> +	}
> +
> +	err = make_path_and_pin(prog->fd, path);
> +	if (err)
> +		return libbpf_err(err);

>   	pr_debug("prog '%s': pinned at '%s'\n", prog->name, path);
>   	return 0;
> @@ -7838,32 +7848,20 @@ int bpf_map__pin(struct bpf_map *map, const char  
> *path)
>   		map->pin_path = strdup(path);
>   		if (!map->pin_path) {
>   			err = -errno;
> -			goto out_err;
> +			cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
> +			pr_warn("failed to pin map: %s\n", cp);
> +			return libbpf_err(err);
>   		}
>   	}

> -	err = make_parent_dir(map->pin_path);
> -	if (err)
> -		return libbpf_err(err);
> -
> -	err = check_path(map->pin_path);
> +	err = make_path_and_pin(map->fd, map->pin_path);
>   	if (err)
>   		return libbpf_err(err);

> -	if (bpf_obj_pin(map->fd, map->pin_path)) {
> -		err = -errno;
> -		goto out_err;
> -	}
> -
>   	map->pinned = true;
>   	pr_debug("pinned map '%s'\n", map->pin_path);

>   	return 0;
> -
> -out_err:
> -	cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
> -	pr_warn("failed to pin map: %s\n", cp);
> -	return libbpf_err(err);
>   }

>   int bpf_map__unpin(struct bpf_map *map, const char *path)
> @@ -9611,19 +9609,13 @@ int bpf_link__pin(struct bpf_link *link, const  
> char *path)

>   	if (link->pin_path)
>   		return libbpf_err(-EBUSY);
> -	err = make_parent_dir(path);
> -	if (err)
> -		return libbpf_err(err);
> -	err = check_path(path);
> -	if (err)
> -		return libbpf_err(err);

>   	link->pin_path = strdup(path);
>   	if (!link->pin_path)
>   		return libbpf_err(-ENOMEM);

> -	if (bpf_obj_pin(link->fd, link->pin_path)) {
> -		err = -errno;
> +	err = make_path_and_pin(link->fd, path);
> +	if (err) {
>   		zfree(&link->pin_path);
>   		return libbpf_err(err);
>   	}
> --
> 1.8.3.1

