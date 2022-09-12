Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF25B6138
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiILSlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiILSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:41:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1FE0EE3C
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:41:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id wc11so7742223ejb.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 11:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MQD/YZKKsSAPByH7OP1dF0G+HDMpJwM4coeTZ3+yRho=;
        b=M1wTVRT5z2jhy1GkmMcs4SZSrW2CrhbUdl6/1dNTrQBLiIm/YdQaWXHcDGt9ofX6He
         I49SJfNf4Op9o+7kKDPgM3tf8+tPhsffZYE7qPthXT4oEn/RFQFrbInl7azTzQLP+WBg
         ilgiJpAXmGfZ5rM71YIflcJZgAPKUPbnfG13EU+raO74AqfC8tFzRcludXAjXEY4MMJ0
         zdpqOhEGS98cmcCDeAAtU5EghQiDhTlnJCCBQBK+6dDq+X9cANDHpn3lksZO1J/ZHLPU
         pn2/li0TbG8zidU32YxgE0+c+rFwnBC2UmQaONs2xKdyLLKJurLzb4hygrJDsmESuyHp
         yerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MQD/YZKKsSAPByH7OP1dF0G+HDMpJwM4coeTZ3+yRho=;
        b=GuNTBQHmanrTtibXI85MXnVM0ikd7fyn7+xwh9zF1Nnvh6mLddxTWaKApeCKW5z4xm
         2gz+b+wKJCx/tZtBPBWvBTbUOAKt3bLELU9x3qKSFFWYAuLHlB+6HMfQLt89TgZZ3fel
         nOD2rdHOGOFsjflkXzv0gfe66lR3AFvUvZdYYui5AeiCDUVBuKP8WP0U4QwcYCH/MMZe
         GOaOpzYvN5nU/1zeCoZLCkRv4/lRZBG3xNXtx8FJ7Ax2OvaLjzXkwrfn9u5rWPGwvg0H
         xJeJGunP4JlwP8dsKXrDhSBoISsef30XG7eyDgPSuHUuaR/EaxtoEsYjk1/W+a9y2kM2
         83DA==
X-Gm-Message-State: ACgBeo3KW0cYp7bYwm43GkJ+Ulea+8MyFsu0fFdzHYQGXGGaCvXrhoEF
        1pBaStwDNtVs+7EuESupSeA=
X-Google-Smtp-Source: AA6agR6/EfLbd8HHkWtIOfJkgvXO/wNUcXLd8RXEpZvx5Wd6cNhgLW3awLT4MAkZ290gQnCWUw79/w==
X-Received: by 2002:a17:907:2d2a:b0:77e:def7:65e9 with SMTP id gs42-20020a1709072d2a00b0077edef765e9mr2618918ejc.85.1663008104955;
        Mon, 12 Sep 2022 11:41:44 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id fw18-20020a170907501200b0073dbaeb50f6sm4797433ejc.169.2022.09.12.11.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 11:41:44 -0700 (PDT)
Message-ID: <872cb7eb-b0b8-2d0e-7fd1-5ac47af6bd55@gmail.com>
Date:   Mon, 12 Sep 2022 20:41:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] staging: r8188eu: add kfree() on an error path of
 rtw_xmit_resource_alloc()
Content-Language: en-US
To:     xkernel.wang@foxmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <tencent_3B46EE3287288555389AD2EC3F388827B306@qq.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <tencent_3B46EE3287288555389AD2EC3F388827B306@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/22 04:50, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In rtw_xmit_resource_alloc(), if usb_alloc_urb() fails, then the memory
> `pxmitbuf->pallocated_buf` which is allocated by kzalloc() is not properly
> released before returning.
> So this patch adds kfree() on the above error path to release it in time.
> 
> Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
> ChangeLog:
> v1->v2 update the description.
> v2->v3 rebase.
> v3->v4 update the description.
> v4->v5 rebase and update the corresponding subject and description.
> Note that the original function name was changed, so the subject of this
> patch is updated from "[PATCH v4] staging: r8188eu: fix potential memory
> leak in rtw_os_xmit_resource_alloc()" to "[PATCH v5] staging: r8188eu: add
> kfree() on an error path of rtw_xmit_resource_alloc()".
> In addition, thanks to Philipp Hortmann for his testing and advice.
>   drivers/staging/r8188eu/core/rtw_xmit.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index 67f9c05..9c39d08 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -44,8 +44,10 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
>   	pxmitbuf->dma_transfer_addr = 0;
>   
>   	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
> -	if (!pxmitbuf->pxmit_urb)
> +	if (!pxmitbuf->pxmit_urb) {
> +		kfree(pxmitbuf->pallocated_buf);
>   		return _FAIL;
> +	}
>   
>   	return _SUCCESS;
>   }

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
