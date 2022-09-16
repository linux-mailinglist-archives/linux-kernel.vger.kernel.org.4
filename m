Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592AF5BADB1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiIPM6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiIPM6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:58:40 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9BB832E3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:58:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id cc5so26068546wrb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 05:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bkVgNaB5w39A++bxNFLwcR/OnSuiCg+ysFlzXQmJY08=;
        b=ADIeSS9W2NJxpUxaduHdkUbgikHOfnDLWr3KykSIbaai5/l7eI+UFw9XCgL1j0qnD/
         oDTsrtiV1vlhLV6ORsArIDz1ZcOyVxrXxm4UirJJMG1CbZ9DkBjkX5PCwwoc3fI00As3
         5jmub4XeBIjMfBpk4uAQGLrFOVDs+qaFOQuC6BevsnqYTl8RaqFtjNomSNtvJbm4K8CA
         rRARkBiC78kdkqrFAjI0P+QKM6HCEsIW0xnOe3HawYgz/wFNQ4d3Dha9o0fNbdCe6vlh
         2yghU9GHaI1aOyP2T2QwEFVVpzJ0NQdN3C/0ZR/xfqdHNcKYZ5Sr+FMxCZEqUry1DB5a
         PlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bkVgNaB5w39A++bxNFLwcR/OnSuiCg+ysFlzXQmJY08=;
        b=l1Nycrw1KsJQvtkEorrbnT1D0WZwhamyfj4W6RabfIfduV4XZefi+DHTvAiTcJZsg1
         bPXUoM1pVYSmRQVxC2z/WFAmWYldF07vT8eXRLJvnm1SBgyRgXPyvfWQJaX4Mb9De5e6
         ITmlNV++ddEDUGz5c6ftycmDdU+43Zkw13SeYOY1ccmtXzrN0otlQ9OO9rPVRH16ADJD
         ErRWSw24iB3V5NfjPAmPp5OvYYEWHJc0YYJeOaQIc1FT/Nhh9g4YkD8oSRuXrgG8A8IJ
         KirqyAQ4Xv1NpFf0uG9oFZFf/hcC18YxN8ocWYSWBEV76XrADRqGbtiZRiKjbFNBeAR2
         7b3Q==
X-Gm-Message-State: ACrzQf2un4pffaLRpNtHEBfvGuyUMLm5BoeRy6Yl3ui2w1WDzMFpY30f
        u1gLo55eP0/sCm1PNL5lO5gsuQ==
X-Google-Smtp-Source: AMsMyM5Kyt+fmGvMQc7WIFSjluHH+tpxEBrz/ltpfmniS/6+efJwkQ2A2Tv/g8b5jQha05xHlYHKqw==
X-Received: by 2002:a05:6000:86:b0:228:db07:24bc with SMTP id m6-20020a056000008600b00228db0724bcmr2770788wrx.204.1663333117236;
        Fri, 16 Sep 2022 05:58:37 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id j16-20020a05600c191000b003a8434530bbsm2217835wmq.13.2022.09.16.05.58.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 05:58:36 -0700 (PDT)
Message-ID: <a71b5f36-8a81-3aa6-6aee-655878b5d4af@linaro.org>
Date:   Fri, 16 Sep 2022 13:58:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 08/10] misc: fastrpc: Safekeep mmaps on interrupted
 invoke
Content-Language: en-US
To:     Abel Vesa <abel.vesa@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
 <20220909133938.3518520-9-abel.vesa@linaro.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220909133938.3518520-9-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/09/2022 14:39, Abel Vesa wrote:
> If the userspace daemon is killed in the middle of an invoke (e.g.
> audiopd listerner invoke), we need to skip the unmapping on device
> release, otherwise the DSP will crash. So lets safekeep all the maps
> only if there is in invoke interrupted, by attaching them to the channel
> context (which is resident until RPMSG driver is removed), and free them
> on RPMSG driver remove.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/misc/fastrpc.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 6b2a552dbdba..bc1e8f003d7a 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -275,6 +275,7 @@ struct fastrpc_channel_ctx {
>   	struct fastrpc_device *secure_fdevice;
>   	struct fastrpc_device *fdevice;
>   	struct fastrpc_buf *remote_heap;
> +	struct list_head invoke_interrupted_mmaps;
>   	bool secure;
>   	bool unsigned_support;
>   };
> @@ -1119,6 +1120,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   				   struct fastrpc_invoke_args *args)
>   {
>   	struct fastrpc_invoke_ctx *ctx = NULL;
> +	struct fastrpc_buf *buf, *b;
> +
>   	int err = 0;
>   
>   	if (!fl->sctx)
> @@ -1182,6 +1185,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>   		fastrpc_context_put(ctx);
>   	}
>   
> +	if (err == -ERESTARTSYS) {
> +		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> +			list_del(&buf->node);
> +			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> +		}
> +	}
> +
>   	if (err)
>   		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
>   
> @@ -2277,6 +2287,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>   	dev_set_drvdata(&rpdev->dev, data);
>   	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
>   	INIT_LIST_HEAD(&data->users);
> +	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
>   	spin_lock_init(&data->lock);
>   	idr_init(&data->ctx_idr);
>   	data->domain_id = domain_id;
> @@ -2301,6 +2312,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>   static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   {
>   	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
> +	struct fastrpc_buf *buf, *b;
>   	struct fastrpc_user *user;
>   	unsigned long flags;
>   
> @@ -2315,6 +2327,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   	if (cctx->secure_fdevice)
>   		misc_deregister(&cctx->secure_fdevice->miscdev);
>   
> +	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
> +		list_del(&buf->node);
> +
When would you free these?
looks like we are leaking even after dsp is down..
Should we not do fastrpc_buf_free() here?



--srini

>   	if (cctx->remote_heap)
>   		fastrpc_buf_free(cctx->remote_heap);
>   
