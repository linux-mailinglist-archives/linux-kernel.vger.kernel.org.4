Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2CB666606
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjAKWJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjAKWJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:09:52 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806F7E93
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:09:51 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u19so40327137ejm.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxBTVvtQmWuJNtulasWvUWRckn18pgjUJsMduZ9gth8=;
        b=MLykj0kjmN8I5Uclna25NMEdgbMI6q4xpEHdnPmv2/2W2UWpz8uw8OG2vTgVlV5BMC
         0JNhxY6Bhfp9zJ+4dGPkuIsJ4THanAxM50A7tI/O64pC+2b8q33+MKdHOsTcJs9bHrOM
         jOnb8ghW55naNZ6sw9SiQqyWoNImv+5f/6/qS1Fz8IyI8AvVpEk24TueUa/1ECh/Vork
         DMD9ucLAB2gYlYauhUWAmJVoTiboqZ3y8XSM5ZgnbgWF0quKmLEj3Vgba3S3dpB+uom+
         Ui2oeRUSovHxpKXi0lIicmzQpy0Qb1sIgJb7Ce3vVb7aRCE/8Rc6qF27DmU30LIcB/T4
         Y4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxBTVvtQmWuJNtulasWvUWRckn18pgjUJsMduZ9gth8=;
        b=VL3v32yIe/MT4O0UF7+Yv6KoRVJ7EmFXrFeZLQDzX83seh10U8jbtn8wh5hqOHJfhp
         ShEctgLLYiWE36Lx62cvRylojjrVTNtV2ghxOXjBPEhiiRP7SI4uTBTi2sCpH5Pk/oAZ
         ORSNBmJakMlzYtqiqN030gaD/slrREinW9dHj0XQvNEYeLfukqbwdrjX4r9BXQY6Kj1k
         z1FXZQ375KdD2/4GTNvZ+ZlOz798r+TjVmG/rqP2a0gmLEoY8N5d/bbUUQ0TMIp1Yfxo
         vYXIOHumJZBg2gLYrNjnxWHxcGoy/Mwlmvu5qUUJN+a0KqHBZbFJ7UTh3mTcbL9dC1rR
         YN0Q==
X-Gm-Message-State: AFqh2kozn4Yl9t/Iacgjx0yeX8rkgS7+pPmMHL1wPLB6hnx8zkSLCPVA
        wn8a9uFvY4UHowp1KJegmS0=
X-Google-Smtp-Source: AMrXdXuvzCZRuvDoZTAN3AY/HQW4rf4kXn+Qd1IFUIfCId19rPx8DduId1fS2pVqJqZpLQI2oNgtmw==
X-Received: by 2002:a17:907:8a20:b0:7c1:27c:2530 with SMTP id sc32-20020a1709078a2000b007c1027c2530mr18371437ejc.3.1673474989968;
        Wed, 11 Jan 2023 14:09:49 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id ja25-20020a170907989900b0084d1160a19dsm6776634ejc.98.2023.01.11.14.09.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 14:09:49 -0800 (PST)
Message-ID: <b910456d-6306-d532-224e-81f862636930@gmail.com>
Date:   Wed, 11 Jan 2023 23:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] staging: r8188eu: remove NULL check for usb_kill_urb
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230111100201.251905-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230111100201.251905-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 11:02, Martin Kaiser wrote:
> usb_kill_urb handles a NULL parameter. There's no need for NULL checks
> before we call usb_kill_urb.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> index 62106d2f82ad..583533631133 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
> @@ -29,8 +29,7 @@ void rtw_read_port_cancel(struct adapter *padapter)
>   
>   	for (i = 0; i < NR_RECVBUFF; i++) {
>   		precvbuf->reuse = true;
> -		if (precvbuf->purb)
> -			usb_kill_urb(precvbuf->purb);
> +		usb_kill_urb(precvbuf->purb);
>   		precvbuf++;
>   	}
>   }
> @@ -153,15 +152,13 @@ void rtw_write_port_cancel(struct adapter *padapter)
>   	padapter->bWritePortCancel = true;
>   
>   	for (i = 0; i < NR_XMITBUFF; i++) {
> -		if (pxmitbuf->pxmit_urb)
> -			usb_kill_urb(pxmitbuf->pxmit_urb);
> +		usb_kill_urb(pxmitbuf->pxmit_urb);
>   		pxmitbuf++;
>   	}
>   
>   	pxmitbuf = (struct xmit_buf *)padapter->xmitpriv.pxmit_extbuf;
>   	for (i = 0; i < NR_XMIT_EXTBUFF; i++) {
> -		if (pxmitbuf->pxmit_urb)
> -			usb_kill_urb(pxmitbuf->pxmit_urb);
> +		usb_kill_urb(pxmitbuf->pxmit_urb);
>   		pxmitbuf++;
>   	}
>   }


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
