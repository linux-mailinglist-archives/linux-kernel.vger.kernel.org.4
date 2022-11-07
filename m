Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0B61F65B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbiKGOmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbiKGOmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 09:42:05 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C4F18
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 06:42:02 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 78so10606225pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 06:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lpaUCO78J+XfOOB4UTMko2tm5ZNs2acSxi/1vpzRt5Q=;
        b=NUw6dzVijAV7U+uWIcyNo1dhTOCkGgatzrmZfs8T16BjAqgcGOeqDJlpV6HrRwpVlj
         Yvz84EIB276eXUgOK8rY1f2s6JToVHzCz9ch79YaZ1Sl1sJTvVafQCjpgW+6KpxueNj2
         kIF49EuMfLvcG7BvlEiM1ncxEtfliNoXFGjXsCQ6JWrX25WerBI4OL3wOLpfRmwgAEM9
         PPv6euiDUoir+NERawnA8B7z1b4qh0z+WFKg0vQr6CdWjpjgyfgEqPc2/fiCqwX5Q7Ls
         n/WO56fEGwDALDm2RLhvWLIggzXRKv6jp5pkrzYzoswPdPjb5hOt7uCa89O+lpQcr7Aw
         Qrpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lpaUCO78J+XfOOB4UTMko2tm5ZNs2acSxi/1vpzRt5Q=;
        b=7qHLr2mmUvxXJ8taSBmxkYVkmDhmSIS3iUwFWqPmo9jPAJIPT62e8yK3vSZtYrqtPC
         tEvDJskhTJ41pscvFYULuQepAT3fiKWHx5hRosTJq5OPUAS5hFB5fBf2ZzQTVHV7M6fB
         NDObjt53af24dKUgaoeVntc39/GtWY4zzWJK4zuRQqEYEFMT0BaSKY2o97XyuUITdWgv
         j++5meVNnqyzCbiuvMiaPrzIcyxInGt+w09eMWzpuZ7LiqhEf9Kk/D2fHRoeCU5iM4Da
         uH66ATtk8TRlrSXSua2fspg9AoTBkOzDGvZ3lhR5CJCq5e5CIGXNEvGVpdLboX3WffXf
         KyNw==
X-Gm-Message-State: ACrzQf26xFvMalVl4VWdMjcqZzk6orEnkwBRyuLTCt+7+ccuNxRQs82P
        vRenW1a2qIzg9FK6Kib9tP0zcw==
X-Google-Smtp-Source: AMsMyM5IN215GF0/pokM5ghYLA//82M1Y8wJP7921bgAqP2H20MCo2o1KLkwVkaU/Ty3T+/dxkHaMQ==
X-Received: by 2002:a05:6a00:140f:b0:56e:1190:e731 with SMTP id l15-20020a056a00140f00b0056e1190e731mr28656854pfu.39.1667832121594;
        Mon, 07 Nov 2022 06:42:01 -0800 (PST)
Received: from [10.4.186.187] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id y13-20020a63fa0d000000b00460c67afbd5sm4294802pgh.7.2022.11.07.06.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 06:42:01 -0800 (PST)
Message-ID: <b66ad97f-9d7e-0453-85e1-3b45ff14da6a@bytedance.com>
Date:   Mon, 7 Nov 2022 22:41:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [External] [PATCH 1/2] erofs: put metabuf in error path in
 fscache mode
To:     Jingbo Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        chao@kernel.org, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Cc:     yinxin.x@bytedance.com, linux-kernel@vger.kernel.org
References: <20221104054028.52208-1-jefflexu@linux.alibaba.com>
 <20221104054028.52208-2-jefflexu@linux.alibaba.com>
From:   Jia Zhu <zhujia.zj@bytedance.com>
In-Reply-To: <20221104054028.52208-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/11/4 13:40, Jingbo Xu 写道:
> For tail packing layout, put metabuf when error is encountered.
> 
> Fixes: 1ae9470c3e14 ("erofs: clean up .read_folio() and .readahead() in fscache mode")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>   fs/erofs/fscache.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index fe05bc51f9f2..83559008bfa8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -287,8 +287,10 @@ static int erofs_fscache_data_read(struct address_space *mapping,
>   			return PTR_ERR(src);
>   
>   		iov_iter_xarray(&iter, READ, &mapping->i_pages, pos, PAGE_SIZE);
> -		if (copy_to_iter(src + offset, size, &iter) != size)
> +		if (copy_to_iter(src + offset, size, &iter) != size) {
> +			erofs_put_metabuf(&buf);
>   			return -EFAULT;
> +		}
>   		iov_iter_zero(PAGE_SIZE - size, &iter);
>   		erofs_put_metabuf(&buf);
>   		return PAGE_SIZE;
