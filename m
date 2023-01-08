Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF88E661978
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 21:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbjAHUoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 15:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjAHUoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 15:44:44 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7726DB7F1
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 12:44:42 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id tz12so15493736ejc.9
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 12:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hHU34fbQrjB1Qqz5z5awRpIvUJ++jyxNnJsf9y8SvPo=;
        b=fxDHseu/N/B28EDLadap2GVakUP7NDgCuUPIoHeR3xsP1p2G2ojrn1V52crgUKnLw1
         wq8UXhddqtt36EtIUu/Dihvq68/kWAYWv0v574XCkvkoWOyzwfoFYxbrGne6kwq/Rv/b
         Em2QqTMe8qgwp086FtQufxHQEfmaM8njaTlvwuoTkwtCA+FVc1BW+eUT70zRLImjCAQR
         ckH7M6MpWZ+0WJJDau/fFuvH3Wv6huTWuViBb5gB5/XWKNNIJehn3s3YJ5OG6d8Z/okV
         hnjhR4HwKWBTPN5O0FRyWAsvs048SY8VIM1UXZLRE0BLC5t15l90n11hjl6MP2FYthX4
         BviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hHU34fbQrjB1Qqz5z5awRpIvUJ++jyxNnJsf9y8SvPo=;
        b=fd/oTGUyPNGfBsoPzivWzWUz3WMJTOxosBJntPOvHCGb+t/jJMeObkFiAmA98LrCUV
         JmobXrs8esu2C3qsLHMia8yesJ21EC1Q2BniMTN46YShAaBu+vhlDCgMgL/Rvh4p+Qgh
         S4TeiKBSwuqfU60z/SZJMgxGpAI0IZ5wcNoVkp1wcyu/KtJAznNm+hEmDwz2oFKbJR+j
         t+ev8GPRYvqbPkF2TEYY4f1sXmQGq11eQkJHMs+6a7f+Raf47b8Z0SsQgAm62LMIMA9W
         tpz5VUgx4QcK4oeWNjYSlC3Na9YfVGdD+wQprumjAJElVZZF7Ehik9z8ZBYQp7X6MC3I
         0QKg==
X-Gm-Message-State: AFqh2kphmA6/AQyu8AC2/rTyiU0XZ44r8M7fwk4YAYR6UU8aLXAEagIt
        j5lZLUYoloMJnWlO2b6WB+Rvv+Pg4TE=
X-Google-Smtp-Source: AMrXdXusCFLDrSpf9WFllGE2rYwpAPpLwd/Z3OKX+HSxKkfxcX/yVcXKxDNInM+Ymgi/j6vjpk2HDQ==
X-Received: by 2002:a17:906:5494:b0:841:e453:af80 with SMTP id r20-20020a170906549400b00841e453af80mr14443921ejo.5.1673210680941;
        Sun, 08 Jan 2023 12:44:40 -0800 (PST)
Received: from [192.168.1.102] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id bs3-20020a170906d1c300b008490dcae01asm2897283ejb.214.2023.01.08.12.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 12:44:40 -0800 (PST)
Message-ID: <83a4a92f-6123-964b-6ca7-f50e7e60005a@gmail.com>
Date:   Sun, 8 Jan 2023 21:44:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/13] staging: r8188eu: some more xmit cleanups
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230108185738.597105-1-martin@kaiser.cx>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230108185738.597105-1-martin@kaiser.cx>
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

On 1/8/23 19:57, Martin Kaiser wrote:
> Here's another set of xmit cleanups, based on my previous patches.
> 
> Martin Kaiser (13):
>    staging: r8188eu: beq_cnt is write-only
>    staging: r8188eu: bkq_cnt is write-only
>    staging: r8188eu: viq_cnt is write-only
>    staging: r8188eu: voq_cnt is write-only
>    staging: r8188eu: replace switch with if
>    staging: r8188eu: make rtl8188eu_inirp_init a void function
>    staging: r8188eu: dir_dev is unused
>    staging: r8188eu: remove unused hal_xmit_handler define
>    staging: r8188eu: txirp_cnt is write-only
>    staging: r8188eu: remove unused QSLT defines
>    staging: r8188eu: xmit_priv's vcs_type is not used
>    staging: r8188eu: xmit_priv's vcs is not used
>    staging: r8188eu: xmit_priv's vcs_setting is not used
> 
>   drivers/staging/r8188eu/core/rtw_mlme.c       |  5 ---
>   drivers/staging/r8188eu/core/rtw_xmit.c       | 42 -------------------
>   drivers/staging/r8188eu/hal/usb_halinit.c     | 14 ++-----
>   drivers/staging/r8188eu/include/drv_types.h   |  1 -
>   drivers/staging/r8188eu/include/hal_intf.h    |  2 +-
>   .../staging/r8188eu/include/rtl8188e_xmit.h   | 11 -----
>   drivers/staging/r8188eu/include/rtw_xmit.h    | 10 -----
>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 --
>   .../staging/r8188eu/os_dep/usb_ops_linux.c    | 23 +---------
>   9 files changed, 5 insertions(+), 106 deletions(-)
> 

When applying first the 4 patche series and then the 20 patche series 
this series is working.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150
