Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8510472C534
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 14:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjFLM4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 08:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbjFLM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 08:56:29 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF6D2965
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:55:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30aea656e36so2913481f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 05:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686574528; x=1689166528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9vEB33NcvmcxWNYGTGzEUyTDl860rGXs/xWvGUHnmI=;
        b=zVBGvG/9Ein+58JMNFahT7B3FJ4MddoexPwNHps71bsJrPEfiJM9T2+/E8P9vTAa2Q
         uUYql338dDaK/HmZ1clqttMmYDK5PovLOJEG+XvwufH7uRZ2qWFQgDXRaeIVCRY7HdUH
         vBOIORsBlixJimaRG6YuyOkvRsliqjCUbL4xBgwTHyMj/lfL75REVYApD2audteXjmQL
         ElEN6XCYUZVQ+TTrGIyzfwOw8im3CUj7vU43o+9kX3E9k2nZ9kBhbgxYPrOmASZ5AfOf
         4T7LZAdnjtZ3AQtiCu4qOzABd2IxJJRJsnXFdPLuoYELVwCELF3oxJoi8AD/gX1slwNH
         4yGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574528; x=1689166528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X9vEB33NcvmcxWNYGTGzEUyTDl860rGXs/xWvGUHnmI=;
        b=jeMB5zdoHaAtuSvAD34vS7YP8hkVEA6sWiwvaDt+F69vvb7StlxKZdCtm0QbTtdKty
         OpHCdD9spSv8dQy32/pwGh4/g00yqUxUAouVD9JjmP4UQ9QiJP1hsVxMMXp0iV0Li6aD
         8slb1NZ/E8AriJmIyD7PfjgvibE2+XMVRBFFRLA7gC4diu1iAWMQI0XEjxQO/tHj3gJK
         1ndeQrnWdsHW3WMEgZ5j6hPikvYieAW8vbYdvGYpN0oYKyBPgXx3ul3arPYBQhENZwxv
         ga6/rEWWqrXgzuavplMkBeNPuUTTjt1+hBWpY8Y3sUA7e6fWDSX5tjO2NCkkB19JroxP
         4R4A==
X-Gm-Message-State: AC+VfDznJWqWF5PPtgVeUgO+gTz/qpZxa963fm0sECPpjOKSKBTMD/kp
        KiQ04uljx5WN/mmJdOmtojlipA==
X-Google-Smtp-Source: ACHHUZ4gf1YErScBsO5wqbHIjCSwb4LNGjqGJ59sJpOAtJ4l0LoEJdLBWPvt9IMFmxT90eEBlJ9CWQ==
X-Received: by 2002:a05:6000:1046:b0:30f:c1ab:a039 with SMTP id c6-20020a056000104600b0030fc1aba039mr2069812wrx.40.1686574527749;
        Mon, 12 Jun 2023 05:55:27 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id v17-20020adfedd1000000b0030630de6fbdsm12344273wro.13.2023.06.12.05.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 05:55:26 -0700 (PDT)
Message-ID: <ef12e2ff-5410-1f4e-e549-d99e37214257@linaro.org>
Date:   Mon, 12 Jun 2023 13:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] misc: fastrpc: Add cached buffer support
Content-Language: en-US
To:     Ekansh Gupta <quic_ekangupt@quicinc.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ekangupt@qti.qualcomm.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, fastrpc.upstream@qti.qualcomm.com,
        quic_anane@quicinc.com
References: <1686307187-15199-1-git-send-email-quic_ekangupt@quicinc.com>
 <1686307187-15199-2-git-send-email-quic_ekangupt@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1686307187-15199-2-git-send-email-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 11:39, Ekansh Gupta wrote:
> FastRPC driver uses DMA API for region allocation for any buf_alloc
> request and the DMA region is unmap and freed once the usage is
> complete.
> 
> Cached buffer support enables caching of certain types of buffers
> instead of freeing which help in reducing the overhead of DMA API
> call for every buffer allocation request.

Can you quanitfy this argument with some measurments?

what kind of savings/overhead are we seeing with this patch vs without?

--srini
> 
> A list of cached buffer is maintained which will get reused when
> needed and this buffer list will get freed during device release.
> 
> Co-developed-by: Anandu Krishnan E <quic_anane@quicinc.com>
> Signed-off-by: Anandu Krishnan E <quic_anane@quicinc.com>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>   drivers/misc/fastrpc.c      | 133 +++++++++++++++++++++++++++++++++++++-------
>   include/uapi/misc/fastrpc.h |   8 +++
>   2 files changed, 122 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 30d4d04..a961a66 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -41,6 +41,10 @@
>   #define INIT_FILE_NAMELEN_MAX (128)
>   #define FASTRPC_DEVICE_NAME	"fastrpc"
>   
> +/* Maximum buffers cached in cached buffer list */
> +#define FASTRPC_MAX_CACHED_BUFS (32)
> +#define FASTRPC_MAX_CACHE_BUF_SIZE (8*1024*1024)
> +
>   /* Add memory to static PD pool, protection thru XPU */
>   #define ADSP_MMAP_HEAP_ADDR  4
>   /* MAP static DMA buffer on DSP User PD */
> @@ -195,6 +199,7 @@ struct fastrpc_buf {
>   	struct dma_buf *dmabuf;
>   	struct device *dev;
>   	void *virt;
> +	u32 type;
>   	u64 phys;
>   	u64 size;
>   	/* Lock for dma buf attachments */
> @@ -293,6 +298,7 @@ struct fastrpc_user {
>   	struct list_head maps;
>   	struct list_head pending;
>   	struct list_head mmaps;
> +	struct list_head cached_bufs;
>   
>   	struct fastrpc_channel_ctx *cctx;
>   	struct fastrpc_session_ctx *sctx;
> @@ -300,6 +306,8 @@ struct fastrpc_user {
>   
>   	int tgid;
>   	int pd;
> +	/* total cached buffers */
> +	u32 num_cached_buf;
>   	bool is_secure_dev;
>   	/* Lock for lists */
>   	spinlock_t lock;
> @@ -391,17 +399,95 @@ static int fastrpc_map_lookup(struct fastrpc_user *fl, int fd,
>   	return ret;
>   }
>   
> -static void fastrpc_buf_free(struct fastrpc_buf *buf)
> +static void __fastrpc_buf_free(struct fastrpc_buf *buf)
>   {
>   	dma_free_coherent(buf->dev, buf->size, buf->virt,
>   			  FASTRPC_PHYS(buf->phys));
>   	kfree(buf);
>   }
>   
> +static void fastrpc_cached_buf_list_add(struct fastrpc_buf *buf)
> +{
> +	struct fastrpc_user *fl = buf->fl;
> +
> +	if (buf->size < FASTRPC_MAX_CACHE_BUF_SIZE) {
> +		spin_lock(&fl->lock);
> +		if (fl->num_cached_buf > FASTRPC_MAX_CACHED_BUFS) {
> +			spin_unlock(&fl->lock);
> +			goto skip_buf_cache;
> +		}
> +
> +		list_add_tail(&buf->node, &fl->cached_bufs);
> +		fl->num_cached_buf++;
> +		buf->type = -1;
> +		spin_unlock(&fl->lock);
> +	}
> +	return;
> +
> +skip_buf_cache:
> +	__fastrpc_buf_free(buf);
> +}
> +
> +static void fastrpc_buf_free(struct fastrpc_buf *buf, bool cache)
> +{
> +	if (cache)
> +		fastrpc_cached_buf_list_add(buf);
> +	else
> +		__fastrpc_buf_free(buf);
> +}
> +
> +static inline bool fastrpc_get_cached_buf(struct fastrpc_user *fl,
> +		size_t size, int buf_type, struct fastrpc_buf **obuf)
> +{
> +	bool found = false;
> +	struct fastrpc_buf *buf, *n, *cbuf = NULL;
> +
> +	if (buf_type == USER_BUF)
> +		return found;
> +
> +	/* find the smallest buffer that fits in the cache */
> +	spin_lock(&fl->lock);
> +	list_for_each_entry_safe(buf, n, &fl->cached_bufs, node) {
> +		if (buf->size >= size && (!cbuf || cbuf->size > buf->size))
> +			cbuf = buf;
> +	}
> +	if (cbuf) {
> +		list_del_init(&cbuf->node);
> +		fl->num_cached_buf--;
> +	}
> +	spin_unlock(&fl->lock);
> +	if (cbuf) {
> +		cbuf->type = buf_type;
> +		*obuf = cbuf;
> +		found = true;
> +	}
> +
> +	return found;
> +}
> +
> +static void fastrpc_cached_buf_list_free(struct fastrpc_user *fl)
> +{
> +	struct fastrpc_buf *buf, *n, *free;
> +
> +	do {
> +		free = NULL;
> +		spin_lock(&fl->lock);
> +		list_for_each_entry_safe(buf, n, &fl->cached_bufs, node) {
> +			list_del(&buf->node);
> +			fl->num_cached_buf--;
> +			free = buf;
> +			break;
> +		}
> +		spin_unlock(&fl->lock);
> +		if (free)
> +			fastrpc_buf_free(free, false);
> +	} while (free);
> +}
> +
>   static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>   			     u64 size, struct fastrpc_buf **obuf)
>   {
> -	struct fastrpc_buf *buf;
> +	struct fastrpc_buf *buf = NULL;
>   
>   	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
>   	if (!buf)
> @@ -432,16 +518,23 @@ static int __fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
>   }
>   
>   static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
> -			     u64 size, struct fastrpc_buf **obuf)
> +			     u64 size, u32 buf_type, struct fastrpc_buf **obuf)
>   {
>   	int ret;
>   	struct fastrpc_buf *buf;
>   
> +	if (fastrpc_get_cached_buf(fl, size, buf_type, obuf))
> +		return 0;
>   	ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
> -	if (ret)
> -		return ret;
> +	if (ret == -ENOMEM) {
> +		fastrpc_cached_buf_list_free(fl);
> +		ret = __fastrpc_buf_alloc(fl, dev, size, obuf);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	buf = *obuf;
> +	buf->type = buf_type;
>   
>   	if (fl->sctx && fl->sctx->sid)
>   		buf->phys += ((u64)fl->sctx->sid << 32);
> @@ -490,7 +583,7 @@ static void fastrpc_context_free(struct kref *ref)
>   		fastrpc_map_put(ctx->maps[i]);
>   
>   	if (ctx->buf)
> -		fastrpc_buf_free(ctx->buf);
> +		fastrpc_buf_free(ctx->buf, true);
>   
>   	spin_lock_irqsave(&cctx->lock, flags);
>   	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
> @@ -674,7 +767,7 @@ static void fastrpc_release(struct dma_buf *dmabuf)
>   {
>   	struct fastrpc_buf *buffer = dmabuf->priv;
>   
> -	fastrpc_buf_free(buffer);
> +	fastrpc_buf_free(buffer, false);
>   }
>   
>   static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
> @@ -951,7 +1044,7 @@ static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
>   
>   	ctx->msg_sz = pkt_size;
>   
> -	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, &ctx->buf);
> +	err = fastrpc_buf_alloc(ctx->fl, dev, pkt_size, METADATA_BUF, &ctx->buf);
>   	if (err)
>   		return err;
>   
> @@ -1334,7 +1427,7 @@ static int fastrpc_init_create_static_process(struct fastrpc_user *fl,
>   				fl->cctx->remote_heap->phys, fl->cctx->remote_heap->size, err);
>   	}
>   err_map:
> -	fastrpc_buf_free(fl->cctx->remote_heap);
> +	fastrpc_buf_free(fl->cctx->remote_heap, false);
>   err_name:
>   	kfree(name);
>   err:
> @@ -1403,7 +1496,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>   	memlen = ALIGN(max(INIT_FILELEN_MAX, (int)init.filelen * 4),
>   		       1024 * 1024);
>   	err = fastrpc_buf_alloc(fl, fl->sctx->dev, memlen,
> -				&imem);
> +				INITMEM_BUF, &imem);
>   	if (err)
>   		goto err_alloc;
>   
> @@ -1450,7 +1543,7 @@ static int fastrpc_init_create_process(struct fastrpc_user *fl,
>   
>   err_invoke:
>   	fl->init_mem = NULL;
> -	fastrpc_buf_free(imem);
> +	fastrpc_buf_free(imem, false);
>   err_alloc:
>   	fastrpc_map_put(map);
>   err:
> @@ -1521,7 +1614,7 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>   	spin_unlock_irqrestore(&cctx->lock, flags);
>   
>   	if (fl->init_mem)
> -		fastrpc_buf_free(fl->init_mem);
> +		fastrpc_buf_free(fl->init_mem, false);
>   
>   	list_for_each_entry_safe(ctx, n, &fl->pending, node) {
>   		list_del(&ctx->node);
> @@ -1533,9 +1626,10 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>   
>   	list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
>   		list_del(&buf->node);
> -		fastrpc_buf_free(buf);
> +		fastrpc_buf_free(buf, false);
>   	}
>   
> +	fastrpc_cached_buf_list_free(fl);
>   	fastrpc_session_free(cctx, fl->sctx);
>   	fastrpc_channel_ctx_put(cctx);
>   
> @@ -1570,6 +1664,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
>   	INIT_LIST_HEAD(&fl->maps);
>   	INIT_LIST_HEAD(&fl->mmaps);
>   	INIT_LIST_HEAD(&fl->user);
> +	INIT_LIST_HEAD(&fl->cached_bufs);
>   	fl->tgid = current->tgid;
>   	fl->cctx = cctx;
>   	fl->is_secure_dev = fdevice->secure;
> @@ -1600,7 +1695,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
>   	if (copy_from_user(&bp, argp, sizeof(bp)))
>   		return -EFAULT;
>   
> -	err = fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, &buf);
> +	err = fastrpc_buf_alloc(fl, fl->sctx->dev, bp.size, USER_BUF, &buf);
>   	if (err)
>   		return err;
>   	exp_info.ops = &fastrpc_dma_buf_ops;
> @@ -1610,7 +1705,7 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
>   	buf->dmabuf = dma_buf_export(&exp_info);
>   	if (IS_ERR(buf->dmabuf)) {
>   		err = PTR_ERR(buf->dmabuf);
> -		fastrpc_buf_free(buf);
> +		fastrpc_buf_free(buf, false);
>   		return err;
>   	}
>   
> @@ -1805,7 +1900,7 @@ static int fastrpc_req_munmap_impl(struct fastrpc_user *fl, struct fastrpc_buf *
>   		spin_lock(&fl->lock);
>   		list_del(&buf->node);
>   		spin_unlock(&fl->lock);
> -		fastrpc_buf_free(buf);
> +		fastrpc_buf_free(buf, false);
>   	} else {
>   		dev_err(dev, "unmmap\tpt 0x%09lx ERROR\n", buf->raddr);
>   	}
> @@ -1866,7 +1961,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   		return -EINVAL;
>   	}
>   
> -	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, &buf);
> +	err = fastrpc_buf_alloc(fl, fl->sctx->dev, req.size, USER_BUF, &buf);
>   	if (err) {
>   		dev_err(dev, "failed to allocate buffer\n");
>   		return err;
> @@ -1935,7 +2030,7 @@ static int fastrpc_req_mmap(struct fastrpc_user *fl, char __user *argp)
>   err_assign:
>   	fastrpc_req_munmap_impl(fl, buf);
>   err_invoke:
> -	fastrpc_buf_free(buf);
> +	fastrpc_buf_free(buf, false);
>   
>   	return err;
>   }
> @@ -2380,7 +2475,7 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>   		list_del(&buf->node);
>   
>   	if (cctx->remote_heap)
> -		fastrpc_buf_free(cctx->remote_heap);
> +		fastrpc_buf_free(cctx->remote_heap, false);
>   
>   	of_platform_depopulate(&rpdev->dev);
>   
> diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
> index f33d914..91c7c4f 100644
> --- a/include/uapi/misc/fastrpc.h
> +++ b/include/uapi/misc/fastrpc.h
> @@ -64,6 +64,14 @@ enum fastrpc_proc_attr {
>   	FASTRPC_MODE_PRIVILEGED		= (1 << 6),
>   };
>   
> + /* Types of fastrpc DMA bufs sent to DSP */
> + enum fastrpc_buf_type {
> +	METADATA_BUF,
> +	COPYDATA_BUF,
> +	INITMEM_BUF,
> +	USER_BUF,
> +};
> +
>   /* Fastrpc attribute for memory protection of buffers */
>   #define FASTRPC_ATTR_SECUREMAP	(1)
>   
