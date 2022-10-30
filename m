Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9590612A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 11:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJ3KkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 06:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJ3KkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 06:40:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4619F2BB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:40:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id k2so22980921ejr.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 03:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGFd6yEFbbRiXKkguK7e/PC3bOLVDfqzNL+us0Fp3Nw=;
        b=k1bbyvERjl2SJ7iZjkPa/XVKDX+KQH1w5Kw2KxyUGtiUo3FHtc1iIAYcP7La6leXmK
         Jl9wKx2w+iwRYgoNcJjQLCJKc3Y+M+Jpg0+TW7rVodmiP82Tf7r/zP1Hb+f4wft3ePuS
         A+xMezo1Fk3JewfYq5Z3CGfXbivBpfHkoRDCKNslpj3NSnYUZegN4riDCmRnMm5ojvTx
         JB4qTKcGsazFomvzEevT0SDQB745r16osIj/Ghbagz8c31k/Ca8vjSn+w0GY/LnOpLyL
         olxAFD5PTcAtaI34st8Zge3DwCPIRfMQIxrEuaWCs9MBmtqqrZm+unXwYyqqIOW8uFAx
         kNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGFd6yEFbbRiXKkguK7e/PC3bOLVDfqzNL+us0Fp3Nw=;
        b=s6AG/VOvXM4esxhe2L7LV3QelfvRSjEstboNdLt++qy+fkzdq2+wL2usUUS6Ioy8JI
         laVJOga2nN/n+bZCMxoNfBmwNs0Xtah2zZrK36fMDffca6D1+t9+cGgilj/MBsbVqHEn
         IXpbArPzuG/YkS3yYSL9P5PT57U7h5/S//6DRBP7Eeruj4J0sNmSRjvKPVgIauE+y/iP
         xFBqSKYr2d+HNLwvyuuVeGfnl5WFJssJ0/e+yIsUP5EKdzUOQ8pvsh7sorLFMP333CSk
         CUv9oaCd9TLyMR+RhV9SkmqTiU8Ku6S39zTO5odishQ0jjdm3JLMFBpBJ+id8+cCd9pz
         LAgw==
X-Gm-Message-State: ACrzQf0EX1Pt4A9IKz+onJhZkehsSS+iEQdl+SzWYL1g2UcMDJGn0Mw/
        X8c+d35OGZznOYA491RJRb0=
X-Google-Smtp-Source: AMsMyM7Kb7ZzSXTbaaJeHzqj8oZ/v5QY3duAyytKC6PUEv42ZpHcu2spyBVa0eYv34wjauJ2x/w/8g==
X-Received: by 2002:a17:907:78a:b0:78d:9ac7:b697 with SMTP id xd10-20020a170907078a00b0078d9ac7b697mr7499697ejb.457.1667126418899;
        Sun, 30 Oct 2022 03:40:18 -0700 (PDT)
Received: from [192.168.1.102] (p57935738.dip0.t-ipconnect.de. [87.147.87.56])
        by smtp.gmail.com with ESMTPSA id tx8-20020a1709078e8800b0078175601630sm1711531ejc.79.2022.10.30.03.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 03:40:18 -0700 (PDT)
Message-ID: <cc1c4548-984b-a40e-c93a-7e179d64912f@gmail.com>
Date:   Sun, 30 Oct 2022 11:40:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] staging: r8188eu: use min() instead of ternary operator
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221030081020.8533-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221030081020.8533-1-straube.linux@gmail.com>
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

On 10/30/22 09:10, Michael Straube wrote:
> Replace a ternary operator usage with the min() macro to improve
> readability.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index 8516e253bb03..22aab3f986b4 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -3568,7 +3568,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
>   
>   		if ((_VENDOR_SPECIFIC_IE_ == probereq_wpsie[0]) &&
>   		    (!memcmp(&probereq_wpsie[2], wps_oui, 4))) {
> -			cp_sz = probereq_wpsie_len > MAX_WPS_IE_LEN ? MAX_WPS_IE_LEN : probereq_wpsie_len;
> +			cp_sz = min(probereq_wpsie_len, MAX_WPS_IE_LEN);
>   
>   			pmlmepriv->wps_probe_req_ie_len = 0;
>   			kfree(pmlmepriv->wps_probe_req_ie);

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
