Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81461613E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 11:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiKBKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 06:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKBKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:52:00 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FA321E2A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 03:51:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f16-20020a05600c491000b003cf66a2e7c0so982748wmp.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X3t89BApMC9GV5pVw6Uj+C2lxdZ+0mjrFrpyj0nVCJ0=;
        b=RoStPn3f7qNAjvTlBT5i0I+o3K99wdi9ACnHtuu3av0GiNmY4mcgzTnVJqyfMYeYfK
         ZX8Yx0MNU24vwcb2srYLsOIynFFGxbuHs8/u3lXUWSV9ZZF+q5BzjziXt7svqTA74XPj
         fPV5U3P284lsqBrZh6SaPmA6Z2P5UsydrE9FBMuxe2CrXpT5EnECWBM+EsgNWkl8GHlJ
         SJQT+TL9nrT7t60ImXuyEnulYHAqJh6YTP8cqlGZZGDYt+s2fSFZZ23wsJkArQccM3bK
         hA+lffNiVZ+w8/woU60YXfgDMn1i7pjGQNlVn/wMoImgZhdOZ59e56c/5YIhJOoPRtP4
         qI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X3t89BApMC9GV5pVw6Uj+C2lxdZ+0mjrFrpyj0nVCJ0=;
        b=yfhFQIUa5CaAchCGEj7s1ocyiqA0Vl85Lv5eF5jsi3eyg/rc/fZOwZANO7EBqXmGFB
         8AO49vw1m9LP0MahQcYiYmwvdkVwe32JuKbFmZVwM+7+bXv5mhy8xCjMOI9fTHJaHJHZ
         gUxdSVHl3CmnJobrwR7qyVe6UtJuRekMF6iejuqAJ+1ImkHP+89zvWW3PAae4Ir7LXOy
         O6EA+GV90JimX1YJedsRdysRHjpmvopKKbSi2eDKqMRBH6R//nHQWYXe3KZebEy5oUj6
         BPLhDhuCqeDqbjPeI5ND9m57Qb1+Nhk+88dz5OWjQ55htM6hapCzgbimkHEcszvwyto+
         q9Ww==
X-Gm-Message-State: ACrzQf0EXP7YvRpm9CQ9/nx2CA41lQynXL2yV83PGdY22ay8KT2doYJb
        Sw663ZqJCnZQGiOL0stnQyyZyQ==
X-Google-Smtp-Source: AMsMyM5BM7WyTIpyAwNqmgJuMpcJ9L39yP3gmgFPQqONbA9X+8z7GKjHpV7nkv21MwfpIaJWjP0Otg==
X-Received: by 2002:a05:600c:198e:b0:3c6:e7e6:490 with SMTP id t14-20020a05600c198e00b003c6e7e60490mr15296534wmq.79.1667386318373;
        Wed, 02 Nov 2022 03:51:58 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b003b4ff30e566sm1898157wmq.3.2022.11.02.03.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 03:51:57 -0700 (PDT)
Message-ID: <c4948e58-0666-5d4b-3436-7672f98fe1e3@isovalent.com>
Date:   Wed, 2 Nov 2022 10:51:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH bpf] bpftool: Fix NULL pointer dereference when pin {PROG,
 MAP, LINK} without FILE
Content-Language: en-GB
To:     Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
References: <20221102084034.3342995-1-pulehui@huaweicloud.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20221102084034.3342995-1-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-02 16:40 UTC+0800 ~ Pu Lehui <pulehui@huaweicloud.com>
> From: Pu Lehui <pulehui@huawei.com>
> 
> When using bpftool to pin {PROG, MAP, LINK} without FILE,
> segmentation fault will occur. The reson is that the lack
> of FILE will cause strlen to trigger NULL pointer dereference.
> The corresponding stacktrace is shown below:
> 
> do_pin
>   do_pin_any
>     do_pin_fd
>       mount_bpffs_for_pin
>         strlen(name) <- NULL pointer dereference
> 
> Fix it by adding validation to the common process.
> 
> Fixes: 75a1e792c335 ("tools: bpftool: Allow all prog/map handles for pinning objects")
> Signed-off-by: Pu Lehui <pulehui@huawei.com>
> ---
>  tools/bpf/bpftool/common.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index e4d33bc8bbbf..653c130a0aaa 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -302,6 +302,9 @@ int do_pin_any(int argc, char **argv, int (*get_fd)(int *, char ***))
>  	int err;
>  	int fd;
>  
> +	if (!REQ_ARGS(3))
> +		return -EINVAL;
> +
>  	fd = get_fd(&argc, &argv);
>  	if (fd < 0)
>  		return fd;

Good catch, and thanks for the fix!

Reviewed-by: Quentin Monnet <quentin@isovalent.com>
