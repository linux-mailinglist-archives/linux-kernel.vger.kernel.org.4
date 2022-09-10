Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63B5B446F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiIJG3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiIJG3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:29:07 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7101CFD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:29:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id v16so8829612ejr.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ZTuu2gUdZr5DySwjOMJBuPe4tNMA1YFFv9H1miY+0Uw=;
        b=jpEpO4i3fEtgVCvZ3Qs8weVO2BtRkvK9pU1/1eIO8Nclx8vvwswUG2ojYCYj7oxQJ8
         vmvvpxmgVQNu/J6h+F/LrTL8odjeBmR3LhHoz2XYjBzD8w4Stoq1eP79Yu5IrU7XxxD4
         eRzhf2MpKbQE4TSQYFNHX7gHx5PKRMA8X9Uif4B0RI7mlDVH5NwXGriVTujmQfFjCkwN
         yhk7Gh0zpB+pDfjtXMaXSQ7rjoMw2dTdTK01jBNBuvPrHj0x39A4nk1lUmR7zyNN3wwi
         hJOp5pCJXcbov+Tlk1OJprK7PuxQMslDwdhftsQcxb1Ss1apiskSP7I7NzaGOnNEI8Lj
         JCvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ZTuu2gUdZr5DySwjOMJBuPe4tNMA1YFFv9H1miY+0Uw=;
        b=yeu5ll+HjNKijSsb0TqftG145Mf7h3DgM2Y0DFylLNSJ++7ppWc7+ofh+1ORD+gvdM
         omYfWtakZ2zxtKQKDPL6HJ+stDyjrGfbldtdaOJtJzDCLzizOsG1qFq8dZKah8KE4873
         kZGx9uOoUaHsVMdu87BYoaAPknMSK9TQ7yguVosi1TsNfwxJd7K31I/LMDElGqOSVrvi
         FgCytAXNwOMkvNNxfMoefd8KnKzk6rJx1OuaML8KtHF+M0GmZK3zagOej9gzAL6fO+VQ
         ViBdLCeAdfvboZMcjsWOVqVWDZY5PFyYfI5ysJ7UaOypn5hUqQXwrXoZZ7HWV7KAq2wm
         NlGQ==
X-Gm-Message-State: ACgBeo07/DJGZXjHvC3TzV7Ko+zg707H/kkrZLowPtIELA4b/yvt7AlZ
        hOgjW6ZXoCsD3NM7o7mz2M5ItvZPmeg=
X-Google-Smtp-Source: AA6agR74ZdiJrO/fuR7ZfexUeUquOlWT8U8TOl3FcYfkoF0HTarb0jTxaZHGSvi5IKQjudYGXe4OUA==
X-Received: by 2002:a17:906:8477:b0:77a:6e22:72f9 with SMTP id hx23-20020a170906847700b0077a6e2272f9mr3057779ejc.170.1662791345365;
        Fri, 09 Sep 2022 23:29:05 -0700 (PDT)
Received: from [192.168.1.101] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id gx6-20020a1709068a4600b0073d68d2fc29sm1254282ejc.218.2022.09.09.23.29.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 23:29:05 -0700 (PDT)
Message-ID: <75e8636b-71f4-1334-47c6-0e60f26a2d0a@gmail.com>
Date:   Sat, 10 Sep 2022 08:29:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: add kfree() on an error path of
 rtw_xmit_resource_alloc()
Content-Language: en-US
To:     xkernel.wang@foxmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <tencent_DD1047278567B897D2CF7F13483573596E06@qq.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <tencent_DD1047278567B897D2CF7F13483573596E06@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/22 02:29, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In rtw_xmit_resource_alloc(), if usb_alloc_urb() fails, then the memory
> `pxmitbuf->pallocated_buf` which is allocated by kzalloc() is not properly
> released before returning.
> 
> So this patch adds kfree() on the above error path to release it. As there
> is no proper device to test with, no runtime testing was performed.
> 
> Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> ---
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

Hi Xiaoke,

I applied your patch and tested it. That is OK.

But you excluded the change history. Usually this is not accepted by 
Greg. Reason is that what identifies the patch is the change itself. The 
change itself is the same as: "[PATCH v4] staging: r8188eu: fix 
potential memory leak in rtw_os_xmit_resource_alloc()" Even if you 
change the Subject, Description and the branch it remains the same patch 
for Greg.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

