Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1BB5BAF7E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiIPOi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbiIPOiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:38:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53610B40D7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:38:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so49808388ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 07:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2hekt6nHmDXb09svRYspIovCwUxYyIVHgZSXoQyIl+k=;
        b=SFH1piZ1wl+dYjTFfiOzjwm5fI+/WSD0vBB9yBMmjrbolDnWC/6U9TVbGpDPit/0ES
         UUWUzIMXDJswTFPpUSs2bQz1HKHAlff4k2OO982m7E2ogYAaAlCcz+v6pL6YXHn7JZ09
         263HOyhB9k8djHzypKXBiHPWGswf9IMrrY0odun/7GVSrmRHrtorYPkfRwkXf79IOyhU
         rsTJO7Kie/UsasSir2ML+YdjREDVgRnjk1VSA1ZA7xpfUu60Xu2CKXq5NELJHbDCB2To
         IoR0qoMNN7IOJY031zmLjTFaKb1fNbBHf+e6M0wKl30ktbsDQdlx9EZwtUk9ydlQK7Qu
         myEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2hekt6nHmDXb09svRYspIovCwUxYyIVHgZSXoQyIl+k=;
        b=XaJ/8vaaGN7S3r7oRxicrPonssr0qvYUQLH4yewbgHGB/vaWdNWJLVbyOVJnG18+bx
         kK+ZHkQpwa4oi2QGKSsbu8PcODd3EJ53GRTZN+nGhnMi9bnl2/6hExikeWMPN4MKvxcx
         XcIbG7WucJEJ+WxEAB7niIOapECML1b07FPkf+KJX/LN+0GGFxM4KCRXyCHBTmfjyTH2
         yKAnB7chEGw7srqkaXLYeKBmdz+Aas0MUie9aL7FYU8yi6eo9ZgXHODqz8utrJsVMDnA
         0L4ESOnt3KmE6RlrciaDdHxvJ2++E8LIzASfeo/k/DsLtOd5LFEXkd6BAn8kldV7ang+
         6Byg==
X-Gm-Message-State: ACrzQf1rVPIvHr5XDMedXFeDgxQPnOq2Jcmcw9SPRTt+YwAnle+bv+/q
        bNvCTjJMYeQbdLj8HPn5DTRTWQ==
X-Google-Smtp-Source: AMsMyM520XIqN6p3HKYAlwE92zHeNJJ+Fe5xeWMnuVrGvp0QrtwA4dQnKiX2weHwOi8VZ2B4Q7JoXw==
X-Received: by 2002:a17:906:7944:b0:73c:838:ac3d with SMTP id l4-20020a170906794400b0073c0838ac3dmr3824004ejo.242.1663339123786;
        Fri, 16 Sep 2022 07:38:43 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p21-20020a170906499500b0078082f95e5csm1393062eju.204.2022.09.16.07.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:38:41 -0700 (PDT)
Date:   Fri, 16 Sep 2022 17:38:40 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 08/10] misc: fastrpc: Safekeep mmaps on interrupted
 invoke
Message-ID: <YySKcI3dwv9b4ri0@linaro.org>
References: <20220909133938.3518520-1-abel.vesa@linaro.org>
 <20220909133938.3518520-9-abel.vesa@linaro.org>
 <a71b5f36-8a81-3aa6-6aee-655878b5d4af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a71b5f36-8a81-3aa6-6aee-655878b5d4af@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-16 13:58:35, Srinivas Kandagatla wrote:
> 
> 
> On 09/09/2022 14:39, Abel Vesa wrote:
> > If the userspace daemon is killed in the middle of an invoke (e.g.
> > audiopd listerner invoke), we need to skip the unmapping on device
> > release, otherwise the DSP will crash. So lets safekeep all the maps
> > only if there is in invoke interrupted, by attaching them to the channel
> > context (which is resident until RPMSG driver is removed), and free them
> > on RPMSG driver remove.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/misc/fastrpc.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> > index 6b2a552dbdba..bc1e8f003d7a 100644
> > --- a/drivers/misc/fastrpc.c
> > +++ b/drivers/misc/fastrpc.c
> > @@ -275,6 +275,7 @@ struct fastrpc_channel_ctx {
> >   	struct fastrpc_device *secure_fdevice;
> >   	struct fastrpc_device *fdevice;
> >   	struct fastrpc_buf *remote_heap;
> > +	struct list_head invoke_interrupted_mmaps;
> >   	bool secure;
> >   	bool unsigned_support;
> >   };
> > @@ -1119,6 +1120,8 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
> >   				   struct fastrpc_invoke_args *args)
> >   {
> >   	struct fastrpc_invoke_ctx *ctx = NULL;
> > +	struct fastrpc_buf *buf, *b;
> > +
> >   	int err = 0;
> >   	if (!fl->sctx)
> > @@ -1182,6 +1185,13 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
> >   		fastrpc_context_put(ctx);
> >   	}
> > +	if (err == -ERESTARTSYS) {
> > +		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> > +			list_del(&buf->node);
> > +			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> > +		}
> > +	}
> > +
> >   	if (err)
> >   		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
> > @@ -2277,6 +2287,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
> >   	dev_set_drvdata(&rpdev->dev, data);
> >   	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
> >   	INIT_LIST_HEAD(&data->users);
> > +	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
> >   	spin_lock_init(&data->lock);
> >   	idr_init(&data->ctx_idr);
> >   	data->domain_id = domain_id;
> > @@ -2301,6 +2312,7 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
> >   static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
> >   {
> >   	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
> > +	struct fastrpc_buf *buf, *b;
> >   	struct fastrpc_user *user;
> >   	unsigned long flags;
> > @@ -2315,6 +2327,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
> >   	if (cctx->secure_fdevice)
> >   		misc_deregister(&cctx->secure_fdevice->miscdev);
> > +	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
> > +		list_del(&buf->node);
> > +
> When would you free these?
> looks like we are leaking even after dsp is down..
> Should we not do fastrpc_buf_free() here?

Yes, we should. I forgot to add it.

Will send a new version.

Thanks.

> 
> 
> 
> --srini
> 
> >   	if (cctx->remote_heap)
> >   		fastrpc_buf_free(cctx->remote_heap);
