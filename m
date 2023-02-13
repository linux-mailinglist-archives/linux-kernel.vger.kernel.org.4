Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DB769508C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 20:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjBMTXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 14:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjBMTXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 14:23:19 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676BEA5D1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:23:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so12025592wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 11:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y+56iSYR4yr3TVMO6fYxyxMGF4cwUsOWWeZJxgHnAgQ=;
        b=PWF/PNnrW5/pcyZ0n/V1M29o35ZZQy818zhMbXbNYFiTnOAOpMWlXvnQiZiVbbuB2k
         vDzj/R/XS5vnNImPCY/kYZMo7s2BDQ586r1Wf5oF2XjFdtBtTF79xA/ObYtOUJoWpJ0+
         G82HefH1PM1E8EskRsMVX43Wx//AeRLf/Xe7R0gEBWJwMAMw0QaY0pRH+BviHtxMC4UC
         R6PajOZ07rjHdbmV1aLqkPgkkvMjS9rOiy9ABHlbGHqwscV6Q283s5k01V7IksStqjAp
         6NOmtDHxJlujDXdU5Kew1LWC5gNaOeBahPA0HCUiaKhT75wAEX6LCb76D6PRyYT2aZCq
         HgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+56iSYR4yr3TVMO6fYxyxMGF4cwUsOWWeZJxgHnAgQ=;
        b=yhugpu4TLMcy2bZKVTpRMncztU/v2hiLBRLuJUUdHcf9M6rIiyXkead9GKNRnrsSO0
         /IJr6jDWHo/nEwWhG7sXe98brpWjZBlIuAGbaXUoXtKwSoOIJETvQIC4vOBzTlHnC0F8
         nd2ryAnLJ3gWfENGd2gc86/dz0hAf0ykD/taJll0MXjhW9x7VWUjKdw4vvZIjsCYV/d7
         J2ei8ZJNFntBAhQgim4rmZ8e6TmxDQsZpL39O46AGkPcbakWv4jOom23Ykm33I+2FvDw
         C+eov9ZCSV28xcO73yYQDDhwyOVBcHtoVxiW3346c+co9hVKSFUiTeanV1lS+QuhO3Lc
         1a2g==
X-Gm-Message-State: AO0yUKWstVN1UyM/iU834Pd28oyoK7SjcXw+Zvem6G6buuUrKQBSIF0R
        WUAf8liXo66kiWwkm3nO5Vyy6Si5JC4=
X-Google-Smtp-Source: AK7set9mW7XbdLOhDfKx2EylmpC6Mvn8DuZjVcZwd+ZwVe+IUWFvYx+ut3SmwTdw3jVmtKoamkyLrQ==
X-Received: by 2002:a05:600c:3ca3:b0:3dc:5ae4:c13d with SMTP id bg35-20020a05600c3ca300b003dc5ae4c13dmr26176962wmb.4.1676316196857;
        Mon, 13 Feb 2023 11:23:16 -0800 (PST)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f26-20020a5d58fa000000b002c5526680cbsm5553695wrd.92.2023.02.13.11.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 11:23:16 -0800 (PST)
Message-ID: <befeaafe-357f-ad0f-a2a3-b45a836b2734@gmail.com>
Date:   Mon, 13 Feb 2023 20:23:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] staging: r8188eu: merge _rtw_enqueue_cmd into its caller
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230211165045.414424-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230211165045.414424-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/23 17:50, Martin Kaiser wrote:
> The _rtw_enqueue_cmd function is called only by rtw_enqueue_cmd.
> 
> When _rtw_enqueue_cmd is called, the caller has already checked that the
> obj parameter is not NULL. _rtw_enqueue_cmd returns _SUCCESS in any case.
> 
> We can merge the two functions and simplify the error handling.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 47 +++++---------------------
>   1 file changed, 9 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index d57360a68fb3..ca9e3d4ee7f4 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -28,32 +28,6 @@ void rtw_free_evt_priv(struct	evt_priv *pevtpriv)
>   	}
>   }
>   
> -/* Calling Context:
> - *
> - * rtw_enqueue_cmd can only be called between kernel thread,
> - * since only spin_lock is used.
> - *
> - * ISR/Call-Back functions can't call this sub-function.
> - */
> -
> -static int _rtw_enqueue_cmd(struct __queue *queue, struct cmd_obj *obj)
> -{
> -	unsigned long flags;
> -
> -	if (!obj)
> -		goto exit;
> -
> -	spin_lock_irqsave(&queue->lock, flags);
> -
> -	list_add_tail(&obj->list, &queue->queue);
> -
> -	spin_unlock_irqrestore(&queue->lock, flags);
> -
> -exit:
> -
> -	return _SUCCESS;
> -}
> -
>   int rtw_init_cmd_priv(struct cmd_priv *pcmdpriv)
>   {
>   	init_completion(&pcmdpriv->enqueue_cmd);
> @@ -125,28 +99,25 @@ static int rtw_cmd_filter(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
>   
>   u32 rtw_enqueue_cmd(struct cmd_priv *pcmdpriv, struct cmd_obj *cmd_obj)
>   {
> -	int res = _FAIL;
> +	unsigned long flags;
>   	struct adapter *padapter = pcmdpriv->padapter;
>   
>   	if (!cmd_obj)
> -		goto exit;
> +		return _FAIL;
>   
>   	cmd_obj->padapter = padapter;
>   
> -	res = rtw_cmd_filter(pcmdpriv, cmd_obj);
> -	if (res == _FAIL) {
> +	if (rtw_cmd_filter(pcmdpriv, cmd_obj) == _FAIL) {
>   		rtw_free_cmd_obj(cmd_obj);
> -		goto exit;
> +		return _FAIL;
>   	}
>   
> -	res = _rtw_enqueue_cmd(&pcmdpriv->cmd_queue, cmd_obj);
> -
> -	if (res == _SUCCESS)
> -		complete(&pcmdpriv->enqueue_cmd);
> +	spin_lock_irqsave(&pcmdpriv->cmd_queue.lock, flags);
> +	list_add_tail(&cmd_obj->list, &pcmdpriv->cmd_queue.queue);
> +	spin_unlock_irqrestore(&pcmdpriv->cmd_queue.lock, flags);
>   
> -exit:
> -
> -	return res;
> +	complete(&pcmdpriv->enqueue_cmd);
> +	return _SUCCESS;
>   }
>   
>   struct	cmd_obj	*rtw_dequeue_cmd(struct cmd_priv *pcmdpriv)

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

