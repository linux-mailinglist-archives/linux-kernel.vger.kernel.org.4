Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F273B6B2D58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCITHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjCITHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:07:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D964FC7DF;
        Thu,  9 Mar 2023 11:07:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id me6-20020a17090b17c600b0023816b0c7ceso7250562pjb.2;
        Thu, 09 Mar 2023 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678388826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QiW/GimxYzzA2iRUpbB1MwJUXLVF9QiXeP5cxfSDJK8=;
        b=K0xQ9cXLmFBrHgdRsA3zWI3dYp64rCflQID+kL2O12eiZd+Lt8jFRl3IPmeVCHRPxE
         9CfE5uizTrfFgHQ6GILBZi4WVYFG8hkQ8m60V7ENAzQcYmy/IWYRcMZchpsj2pvKXIzS
         NrGW4iPoZZX14HeOtftC4pQS5bi+QFDFF5FKbaHk+18/2RD1DbWFnM13erovORIa1j6y
         ljfW6mgLJMTR+WSe2Xh1DvRBDo8wsWWQkushitvPRQ45bt2Hr/oduPcJQCSXAGqvo7BN
         q5/YkSnvWioyNyy6SzKuaE9Ydf7uXLfS7Fk0nh0+o+7A5mZIJbBBn45Sh+gQPvgO01ZN
         CrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678388826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QiW/GimxYzzA2iRUpbB1MwJUXLVF9QiXeP5cxfSDJK8=;
        b=BEAqlkw2aE8fWWJcWvAb2fhvLruKnY/1HAwy3tRQFfag0yDhN6FaqdWsGzv7gW5Hpn
         cPdnHsWunSdZluu02BzVRAQu3byMvZpLvCz/oSNSosZAuFLeQ+DuMhbLIHojCbxT/fyW
         Qsa/x6pSEuxcYgL+Op2Jk06kZE5m9U3VnYb/QXyGNdKvtW2nXkjMF52WevKjZUcNCU4O
         l3KZTJb7bw+fw/cwYiYgUanuLaoXGfG3Ld6wK0jQ3blJKIwDY4PmoRiJY+U1ZhThew/A
         Lh3NFT849JhGJ5DEZcLMuqGsHNLLwXZdpGdUkAvKxy++OLyMZ1y+BJOvGIposcf5oX0b
         34Sg==
X-Gm-Message-State: AO0yUKWwMcTkFeUdH45oCMg19koNC3S5Qfo9NnVAD1A4k5bgh8+EnBsN
        jbzt6rp7XmNc7RY5r9Bt0ng=
X-Google-Smtp-Source: AK7set8W8EnDGqg1UGWtg6B3U9/8p7YDa6ID6pL62JuZEQSZTP6IP4CJ+RGtD/yGgpdg05hxMVVJFQ==
X-Received: by 2002:a17:903:2303:b0:198:b945:4108 with SMTP id d3-20020a170903230300b00198b9454108mr31521115plh.0.1678388825774;
        Thu, 09 Mar 2023 11:07:05 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id kp14-20020a170903280e00b00196251ca124sm20708plb.75.2023.03.09.11.07.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 11:07:05 -0800 (PST)
Message-ID: <e75a1c0f-886e-fd89-0876-dc883f75c809@gmail.com>
Date:   Thu, 9 Mar 2023 11:07:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] serial: 8250_bcm7271: Fix arbitration handling
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Cooper <alcooperx@gmail.com>
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230309190224.687380-1-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230309190224.687380-1-opendmb@gmail.com>
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

On 3/9/23 11:02, Doug Berger wrote:
> The arbitration of the UART DMA is mishandled for a few
> exceptional cases when probing and releasing the driver.
> 
> It is possible that the DMA register spaces are not defined in
> device tree for an instance of the driver, so attempts to access
> the registers in brcmuart_arbitration() would use NULL pointers.
> 
> It is also possible for the probe function to return an error
> while still holding the UART DMA. This would prevent the UART
> DMA from being claimed by an instance that could use it.
> 
> These errors are addressed by only releasing the UART DMA if it
> is held by this instance (i.e. priv->dma_enabled == 1) and
> directing early error paths in probe to this common release_dma
> handling.
> 
> Fixes: 41a469482de2 ("serial: 8250: Add new 8250-core based Broadcom STB driver")
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

