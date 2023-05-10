Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491B16FDB59
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 12:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbjEJKKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 06:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjEJKKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 06:10:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E2A13D
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:10:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc25f0c7dso12924953a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683713439; x=1686305439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A+6oHru7C70uRBlUD0hl5QSN+B+mjxZ6Dk4I39zF6EI=;
        b=sUmAeBWpzb3WDh9zH4niy04bUeH+g0ngakgbEfHiKmbsrs3voOBKmVGLtwaV1UDz/w
         5VxEi0oJeAMlc/NIRoGrEu413p9xtc6vGQsYphalKVAoLM1QOoTA64Rg/QiRbGOiI4Ue
         Sgu4lBsUrhuHXw+yKvVml3I+1X1M9mUyW3HXR5lmnCMDDEbzx2kFkIJQixHdsZUnkJUT
         xaan/KNxSPIIvyk/TSnXhE3qNGV2JHEOL20B/aKkgR7F95zX1VWnUSSV656DQdAfg2gd
         pdw1LSM9fWMYsqpgw/ZeUs/1hhb0NYoIIJ8/5YDZ/f1odxe0MB8FctM32Wii6UGGIuVk
         63Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683713439; x=1686305439;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A+6oHru7C70uRBlUD0hl5QSN+B+mjxZ6Dk4I39zF6EI=;
        b=d+2fasUAHh5Xn0yClLYzxF8D5D13PRr3Mzv2Dm6mpDAWLXHSAwln22pQ3PdapEDL51
         BYyzbbb14FBHvep9qpo1zhPrZrNL6FIe5nzeF1YpEvib3T6rjRyCTG2tTNszHrSk60Fr
         iyQ66kUbyuJbzXmUVs0Xz+14jQOnZxzD7wz/UTd0K/dklb2vApdvKelxhfoNCWzBOc+J
         zeTDCjlLIYx/IfspCv9Gc+wQa2iglLakkwcW18IVQNcHGBSOwCyYu9hxYUZVg32CdPuq
         hXAtEfR15E/y5FEDL6+wUcK+BSglEXs0ZV+SPnkrPCPYatlCmzPYtJVLjBdF6ezW5euJ
         Rpiw==
X-Gm-Message-State: AC+VfDyocpN8IPAmHi/JC3jsunh5oGPjnTMCYiK7Yo+T7T1NnrtDDse1
        bKeLA9nEf/DVh9wAb68vltUaXg==
X-Google-Smtp-Source: ACHHUZ59S3F8tS4Fb8+6T/WWQrM0r38Q4aXeTYbnbUuCE1kf9BaB9hkpLvkXrFNpewQE0GQOjz5xrg==
X-Received: by 2002:a17:907:1687:b0:958:cc8:bd55 with SMTP id hc7-20020a170907168700b009580cc8bd55mr16959522ejc.0.1683713439248;
        Wed, 10 May 2023 03:10:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906bc4300b0095fde299e83sm2438459ejv.214.2023.05.10.03.10.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 03:10:38 -0700 (PDT)
Message-ID: <a26c47fc-1915-bfde-2a3d-3902f153892e@linaro.org>
Date:   Wed, 10 May 2023 12:10:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next V3 3/3] net: axienet: Introduce dmaengine support
Content-Language: en-US
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux@armlinux.org.uk, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anirudha.sarangi@amd.com,
        harini.katakam@amd.com, git@amd.com
References: <20230510085031.1116327-1-sarath.babu.naidu.gaddam@amd.com>
 <20230510085031.1116327-4-sarath.babu.naidu.gaddam@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230510085031.1116327-4-sarath.babu.naidu.gaddam@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/05/2023 10:50, Sarath Babu Naidu Gaddam wrote:
> Add dmaengine framework to communicate with the xilinx DMAengine
> driver(AXIDMA).
> 
> Axi ethernet driver uses separate channels for transmit and receive.
> Add support for these channels to handle TX and RX with skb and
> appropriate callbacks. Also add axi ethernet core interrupt for



> +/**
> + * axienet_setup_dma_chan - request the dma channels.
> + * @ndev:       Pointer to net_device structure
> + *
> + * Return: 0, on success.
> + *          non-zero error value on failure
> + *
> + * This function requests the TX and RX channels. It also submits the
> + * allocated skb buffers and call back APIs to dmaengine.
> + *
> + */
> +static int axienet_setup_dma_chan(struct net_device *ndev)
> +{
> +	struct axienet_local *lp = netdev_priv(ndev);
> +	int i, ret;
> +
> +	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> +	if (IS_ERR(lp->tx_chan)) {
> +		ret = PTR_ERR(lp->tx_chan);
> +		if (ret != -EPROBE_DEFER)
> +			netdev_err(ndev, "No Ethernet DMA (TX) channel found\n");

dev_err_probe seems suitable here.


> +		return ret;
> +	}
> +
> +	lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
> +	if (IS_ERR(lp->rx_chan)) {
> +		ret = PTR_ERR(lp->rx_chan);
> +		if (ret != -EPROBE_DEFER)
> +			netdev_err(ndev, "No Ethernet DMA (RX) channel found\n");

dev_err_probe

> +		goto err_dma_request_rx;
> +	}
> +	lp->skb_cache = kmem_cache_create("ethernet", sizeof(struct axi_skbuff),
> +					  0, 0, NULL);
> +	if (!lp->skb_cache) {
> +		ret =  -ENOMEM;
> +		goto err_kmem;
> +	}
> +	/* TODO: Instead of BD_NUM_DEFAULT use runtime support*/
> +	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
> +		axienet_rx_submit_desc(ndev);
> +	dma_async_issue_pending(lp->rx_chan);
> +
> +	return 0;
> +err_kmem:
> +	dma_release_channel(lp->rx_chan);
> +err_dma_request_rx:
> +	dma_release_channel(lp->tx_chan);
> +	return ret;
> +}
> +
> +/**
> + * axienet_init_dmaengine - init the dmaengine code.
> + * @ndev:       Pointer to net_device structure
> + *
> + * Return: 0, on success.
> + *          non-zero error value on failure
> + *
> + * This is the dmaengine initialization code.
> + */
> +static inline int axienet_init_dmaengine(struct net_device *ndev)
> +{
> +	int ret;
> +
> +	ret = axienet_setup_dma_chan(ndev);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  /**
>   * axienet_init_legacy_dma - init the dma legacy code.
>   * @ndev:       Pointer to net_device structure
> @@ -1239,7 +1520,20 @@ static int axienet_open(struct net_device *ndev)
>  
>  	phylink_start(lp->phylink);
>  
> -	if (!AXIENET_USE_DMA(lp)) {
> +	if (AXIENET_USE_DMA(lp)) {
> +		ret = axienet_init_dmaengine(ndev);
> +		if (ret < 0)
> +			goto error_code;
> +
> +		/* Enable interrupts for Axi Ethernet core (if defined) */
> +		if (lp->eth_irq > 0) {
> +			ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,
> +					  ndev->name, ndev);
> +			if (ret)
> +				goto error_code;
> +		}
> +
> +	} else {
>  		ret = axienet_init_legacy_dma(ndev);
>  		if (ret)
>  			goto error_code;
> @@ -1287,6 +1581,12 @@ static int axienet_stop(struct net_device *ndev)
>  		free_irq(lp->tx_irq, ndev);
>  		free_irq(lp->rx_irq, ndev);
>  		axienet_dma_bd_release(ndev);
> +	} else {
> +		dmaengine_terminate_all(lp->tx_chan);
> +		dmaengine_terminate_all(lp->rx_chan);
> +
> +		dma_release_channel(lp->rx_chan);
> +		dma_release_channel(lp->tx_chan);
>  	}
>  
>  	axienet_iow(lp, XAE_IE_OFFSET, 0);
> @@ -2136,6 +2436,33 @@ static int axienet_probe(struct platform_device *pdev)
>  		}
>  		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
>  		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
> +	} else {
> +		struct xilinx_vdma_config cfg;
> +		struct dma_chan *tx_chan;
> +
> +		lp->eth_irq = platform_get_irq_optional(pdev, 0);
> +		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
> +
> +		if (IS_ERR(tx_chan)) {
> +			ret = PTR_ERR(tx_chan);
> +			if (ret != -EPROBE_DEFER)
> +				dev_err(&pdev->dev, "No Ethernet DMA (TX) channel found\n");

dev_err_probe

Best regards,
Krzysztof

