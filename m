Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952835EE1B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiI1QWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbiI1QV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:21:57 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BCEE21E5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:21:50 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lh5so28236572ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=E6GAxNGwAZ9+d2NCHkyVR7P/hkQZgRQ6SAVfz32XrwI=;
        b=EmIBVHvrGf6bx61bpNzm6C32On6+8uIKSqf4cy3kyG8fpjs024mfwUn/fU63eb4ipS
         /WKNYFnJcrdqH1OC4MDrEAAL7wA6gwjXI8R2LUFob1Yd9IouzjIslzRpV0FgWAZfnshE
         xnhEf/sGVN3VxXC8xOL8dfKd5P8szDvlv5HAbO144aCDZrhZDZQ+jG8kr6WCFzh4fL0i
         9ZonhyfyauiGdKGr3DRzPaAVufQSBzQtdiS2K3Gt4GztdLrTTyR7OTT2NZQ3ngXOMIKQ
         WADr6vOKtBGmvLKH58Giz7P+KHSLWb2mHkYi8Km6fN/Pm/wkCQf/ZGJ/xB/KnItZvOmF
         F19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E6GAxNGwAZ9+d2NCHkyVR7P/hkQZgRQ6SAVfz32XrwI=;
        b=yDMaZfnCFLqgnGcnXovAUT7UZuRF7cI1y0QB8r6Vx5YIbJFGxiwqnhzJ/EUKd6k7pR
         t9PKh5Xh6e5V6p9kQAsdsWw8gLoJ6ldxwn/BsU6DPO69if4uwyy1so+jb0a9Mo4oB5bv
         lZwavcUJR8m/jAiMbBC1kafbdDipJotbyH8/jCxcwFi5FTKFMIJ6BCzxSlpSSRjhhPYO
         cdF1ORnSmzqXFADD2f3NDbNWjjsTWORF/ghh7yldl3xk22syjVXP319ta6ZO6IzYLSf7
         GM/TRDAzVScNaP8pd5F3i9XwfGBKan+Puu64842vSpLL8Nn/CbtjFA4bsocIeJ9CYdUS
         Fo/w==
X-Gm-Message-State: ACrzQf2syMHNQ/UZHqf6j1ABq+UlPi0D7vZQAm5nvtkblavi20GELRea
        ib6G7zHnHRGJzFDO56hN02MMXr+Dt+U=
X-Google-Smtp-Source: AMsMyM4GoAj0LMnlX8ofQsn9ceCLf5DecAlT3bxmhHfrNQUoDWyx3jboM00TPktzP0jGeegmoRkNzA==
X-Received: by 2002:a17:907:d15:b0:781:e347:723 with SMTP id gn21-20020a1709070d1500b00781e3470723mr27635524ejc.723.1664382109465;
        Wed, 28 Sep 2022 09:21:49 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906260f00b0077e6be40e4asm2694019ejc.175.2022.09.28.09.21.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 09:21:49 -0700 (PDT)
Message-ID: <93142822-2ad0-338b-4cfd-887e2dbd94fd@gmail.com>
Date:   Wed, 28 Sep 2022 18:21:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/4] staging: r8188eu: remove enum HAL_STATUS
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220928144323.13164-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220928144323.13164-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 16:43, Michael Straube wrote:
> This series converts four functions from return type 'enum HAL_STATUS'
> to 'int' and finally removes enum HAL_STATUS.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (4):
>    staging: r8188eu: convert ODM_ReadAndConfig_MAC_REG_8188E() to int
>    staging: r8188eu: convert ODM_ReadAndConfig_RadioA_1T_8188E() to int
>    staging: r8188eu: convert ODM_ReadAndConfig_PHY_REG_1T_8188E() to int
>    staging: r8188eu: convert ODM_ReadAndConfig_AGC_TAB_1T_8188E() to int
> 
>   drivers/staging/r8188eu/hal/HalHWImg8188E_BB.c | 18 ++++++++----------
>   .../staging/r8188eu/hal/HalHWImg8188E_MAC.c    |  9 ++++-----
>   drivers/staging/r8188eu/hal/HalHWImg8188E_RF.c |  9 ++++-----
>   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c  |  6 +++---
>   drivers/staging/r8188eu/hal/rtl8188e_rf6052.c  |  2 +-
>   .../staging/r8188eu/include/HalHWImg8188E_BB.h |  4 ++--
>   .../r8188eu/include/HalHWImg8188E_MAC.h        |  3 +--
>   .../staging/r8188eu/include/HalHWImg8188E_RF.h |  2 +-
>   drivers/staging/r8188eu/include/odm_types.h    |  5 -----
>   9 files changed, 24 insertions(+), 34 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
