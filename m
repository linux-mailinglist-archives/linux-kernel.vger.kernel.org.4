Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8515B3DCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIIRQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiIIRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:16:32 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A081269F7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:16:31 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id q8-20020a170902dac800b001753aa66955so1636361plx.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=QFnamYGdcG3RTWVvJqLpNP3EOD8aM2gxJ3g8gRyZ/qk=;
        b=SZDHTIlVA5bFdnkuLwRHMUF8b0DsCuxNe0fYCWz/xwk8nwWdFc9k+A/WOChKR6ieC3
         +BW4tKJNm3e1VqUqRMNxLvU8sPPNogaEYK8hCYU4cK0DkN03j7mdOZMMAvviilmuOwQ4
         kKI8hcgpOsaAk/GzQy2WIxA4gLrfrL3nDQtuIq5fWkzo32K0mtGJvl6lduSquvjr2Ui9
         4hrw8ugyiAtQK9eJ5o++h7DMHX6voU/NU+SIqLvyeaqmk6hTU6RbeLWsCFkkKlvUgAGD
         do4tJ0+3JJr9aF6opCBRafTiqUPU1Mpvxf47fQ1eZQTJ+PqcRPb1SYay2obwdigNTsOn
         V2SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=QFnamYGdcG3RTWVvJqLpNP3EOD8aM2gxJ3g8gRyZ/qk=;
        b=t8NH2cAW8/M03P6++zvIvRUl3sLXwJAe+LggD0hHhoUzE5eU2WJk3e+dPBl5xVmZ1x
         Ck9Msaeu1D8L8fKDeXosJwEAy392OtUcGnTdREaha9dbMFlDiTuylABCafWPnKYMPwLV
         yDKKldZg3RFt7sJZe7XQA+uzXBF6WSkmBlbeHOyL0eRoP1JGsOCxvFKx84v6bJVirpyz
         UMQfTMDFs3FV/5Wc7L/+Z5ZhUy5gx69kEyKjQ5mGI2vGgN0JtHcMxSznVXg0hD7zqjF2
         778aMdCEQ6zeOrrXshBbXqAt0/muPJA0IU6dWQ1wooHy2PdUZHR6+6YN1ZdJc/4xVGBg
         GTwg==
X-Gm-Message-State: ACgBeo27PtNoCrUHXfa0vOxsTWUphngJV2VEDm2a7ypXM3LNsdueJrm3
        pVJLFDif+HRg35eJzOm7gMn2/ws=
X-Google-Smtp-Source: AA6agR4VgrH7q/84mlNCM//BP7eyC3elYRo8C1BlKXdyJDnVsy4G6helZVU18gXJ3LRp2ozS5hXIPhc=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1252:b0:53a:8943:4b1e with SMTP id
 u18-20020a056a00125200b0053a89434b1emr15344063pfi.2.1662743790577; Fri, 09
 Sep 2022 10:16:30 -0700 (PDT)
Date:   Fri, 9 Sep 2022 10:16:28 -0700
In-Reply-To: <1662702346-29665-2-git-send-email-wangyufen@huawei.com>
Mime-Version: 1.0
References: <1662702346-29665-1-git-send-email-wangyufen@huawei.com> <1662702346-29665-2-git-send-email-wangyufen@huawei.com>
Message-ID: <Yxt07BE7TOX6dGh2@google.com>
Subject: Re: [bpf-next 2/2] libbpf: Add pathname_concat() helper
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
> Move snprintf and len check to common helper pathname_concat() to make the
> code simpler.

> Signed-off-by: Wang Yufen <wangyufen@huawei.com>
> ---
>   tools/lib/bpf/libbpf.c | 74  
> ++++++++++++++++++--------------------------------
>   1 file changed, 27 insertions(+), 47 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 5854b92..238a03e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -2096,20 +2096,31 @@ static bool get_map_field_int(const char  
> *map_name, const struct btf *btf,
>   	return true;
>   }

> -static int build_map_pin_path(struct bpf_map *map, const char *path)
> +static int pathname_concat(const char *path, const char *name, char *buf)
>   {
> -	char buf[PATH_MAX];
>   	int len;

> -	if (!path)
> -		path = "/sys/fs/bpf";
> -
> -	len = snprintf(buf, PATH_MAX, "%s/%s", path, bpf_map__name(map));
> +	len = snprintf(buf, PATH_MAX, "%s/%s", path, name);
>   	if (len < 0)
>   		return -EINVAL;
>   	else if (len >= PATH_MAX)
>   		return -ENAMETOOLONG;

> +	return 0;
> +}
> +
> +static int build_map_pin_path(struct bpf_map *map, const char *path)
> +{
> +	char buf[PATH_MAX];
> +	int err;
> +
> +	if (!path)
> +		path = "/sys/fs/bpf";
> +
> +	err = pathname_concat(path, bpf_map__name(map), buf);
> +	if (err)
> +		return err;
> +
>   	return bpf_map__set_pin_path(map, buf);
>   }

> @@ -7959,17 +7970,8 @@ int bpf_object__pin_maps(struct bpf_object *obj,  
> const char *path)
>   			continue;

>   		if (path) {
> -			int len;
> -
> -			len = snprintf(buf, PATH_MAX, "%s/%s", path,
> -				       bpf_map__name(map));
> -			if (len < 0) {
> -				err = -EINVAL;
> -				goto err_unpin_maps;
> -			} else if (len >= PATH_MAX) {
> -				err = -ENAMETOOLONG;

[..]

> +			if (pathname_concat(path, bpf_map__name(map), buf))
>   				goto err_unpin_maps;
> -			}

You're breaking error reporting here and in a bunch of other places.
Should be:

err = pathname_concat();
if (err)
	goto err_unpin_maps;

I have the same attitude towards this patch as the first one in the
series: not worth it. Nothing is currently broken, the code as is relatively
readable, this version is not much simpler, it just looks slightly different
taste-wise..

How about this: if you really want to push this kind of cleanup, send
selftests that exercise all these error cases? :-)


>   			sanitize_pin_path(buf);
>   			pin_path = buf;
>   		} else if (!map->pin_path) {
> @@ -8007,14 +8009,9 @@ int bpf_object__unpin_maps(struct bpf_object *obj,  
> const char *path)
>   		char buf[PATH_MAX];

>   		if (path) {
> -			int len;
> -
> -			len = snprintf(buf, PATH_MAX, "%s/%s", path,
> -				       bpf_map__name(map));
> -			if (len < 0)
> -				return libbpf_err(-EINVAL);
> -			else if (len >= PATH_MAX)
> -				return libbpf_err(-ENAMETOOLONG);
> +			err = pathname_concat(path, bpf_map__name(map), buf);
> +			if (err)
> +				return err;
>   			sanitize_pin_path(buf);
>   			pin_path = buf;
>   		} else if (!map->pin_path) {
> @@ -8032,6 +8029,7 @@ int bpf_object__unpin_maps(struct bpf_object *obj,  
> const char *path)
>   int bpf_object__pin_programs(struct bpf_object *obj, const char *path)
>   {
>   	struct bpf_program *prog;
> +	char buf[PATH_MAX];
>   	int err;

>   	if (!obj)
> @@ -8043,17 +8041,8 @@ int bpf_object__pin_programs(struct bpf_object  
> *obj, const char *path)
>   	}

>   	bpf_object__for_each_program(prog, obj) {
> -		char buf[PATH_MAX];
> -		int len;
> -
> -		len = snprintf(buf, PATH_MAX, "%s/%s", path, prog->name);
> -		if (len < 0) {
> -			err = -EINVAL;
> +		if (pathname_concat(path, prog->name, buf))
>   			goto err_unpin_programs;
> -		} else if (len >= PATH_MAX) {
> -			err = -ENAMETOOLONG;
> -			goto err_unpin_programs;
> -		}

>   		err = bpf_program__pin(prog, buf);
>   		if (err)
> @@ -8064,13 +8053,7 @@ int bpf_object__pin_programs(struct bpf_object  
> *obj, const char *path)

>   err_unpin_programs:
>   	while ((prog = bpf_object__prev_program(obj, prog))) {
> -		char buf[PATH_MAX];
> -		int len;
> -
> -		len = snprintf(buf, PATH_MAX, "%s/%s", path, prog->name);
> -		if (len < 0)
> -			continue;
> -		else if (len >= PATH_MAX)
> +		if (pathname_concat(path, prog->name, buf))
>   			continue;

>   		bpf_program__unpin(prog, buf);
> @@ -8089,13 +8072,10 @@ int bpf_object__unpin_programs(struct bpf_object  
> *obj, const char *path)

>   	bpf_object__for_each_program(prog, obj) {
>   		char buf[PATH_MAX];
> -		int len;

> -		len = snprintf(buf, PATH_MAX, "%s/%s", path, prog->name);
> -		if (len < 0)
> -			return libbpf_err(-EINVAL);
> -		else if (len >= PATH_MAX)
> -			return libbpf_err(-ENAMETOOLONG);
> +		err = pathname_concat(path, prog->name, buf);
> +		if (err)
> +			return libbpf_err(err);

>   		err = bpf_program__unpin(prog, buf);
>   		if (err)
> --
> 1.8.3.1

