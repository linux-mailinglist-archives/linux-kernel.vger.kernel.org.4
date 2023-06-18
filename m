Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3344E73482A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjFRU0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRU0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:26:42 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FFCF7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:26:41 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-97ea801b0d0so74498766b.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687120000; x=1689712000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JtpsaaTsTXJO+sfNJLIul5lew5oYM95owcw4xKGdHxI=;
        b=EZ4Mblc/3gcELGv63dRY6ntzs7K/IIz5+LSZRi2SoiyOE1osPjyASwslgQVCO2Q5pS
         g6t0kjz1jflwpYIFT2c0gXeJyBX045ALhajL0O/9yixKwDLTFJoG80yQYk4Aq5WoHLfi
         By7ixFv4YauvLk6RzWyGHl42YRn1HrlUGjI8ZyA4NtVeQgcsBJqHSEgCtalsde/vR+cn
         DxkEeLOZf5BiUq+ItrndHjChbc+Bb77LFhy+RKD+WYZV0lV+bx9JPL5dKVkplkvmpwnX
         GfpRfOSEaiyXB0ybL3XMtTxKtzYiK1I0ghAJhzNyRiqResKzZ4a5DmAsGww7+R7nz3iP
         NyeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687120000; x=1689712000;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JtpsaaTsTXJO+sfNJLIul5lew5oYM95owcw4xKGdHxI=;
        b=knOJRq2+ZJ/yPCvBz7mJ/0x+d2vlQWrDtt/1WEe3gYX4E069zHlc3Zhk1WdAzwm3KK
         K/biSvFRZndBK7HbOsMarTSd/CGS2bakuVSKwbBoT+hhf1XfPeEOjkwofsUGHM685Hmt
         BbgSQX4Dp3lZ2aiixG702itTV2UCDQ+tpmXkXM7Ym6BmmqS6jCGv6OHPyTgCY1RfLGeA
         fMFc7yShPUQ9mkOYBX9cDymmUKwotCIz9Uxu7tiyAB2YSy7955zH92KkQMyeQA9jMXBl
         IprGQa9q2TxjdH5DpVflzCVPdx2OYynLe/9QI6mOeWG6y3YAVN6xqV9+Rcruidf5D5ki
         Pqew==
X-Gm-Message-State: AC+VfDzDJppztjE6GCxV7gKNrU18xRRopXoABwGpkG7RfbXgQRqJtNHH
        zzR4RBB8VQ9efQBHhSw9poQ=
X-Google-Smtp-Source: ACHHUZ6jVRofnMnicdJKzt1bOfVINJNv2wm3DpK/rcO7hRC6oTxDDT2UKXTup18XZEz9CxlSn/8woQ==
X-Received: by 2002:a17:906:74cd:b0:987:f332:5329 with SMTP id z13-20020a17090674cd00b00987f3325329mr2607902ejl.1.1687119999834;
        Sun, 18 Jun 2023 13:26:39 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id gz17-20020a170906f2d100b00988936b142bsm825165ejb.147.2023.06.18.13.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 13:26:38 -0700 (PDT)
Message-ID: <e80d385d-5515-ed42-e5dd-f9c977f7d4d1@gmail.com>
Date:   Sun, 18 Jun 2023 22:26:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 0/4] Trivial code cleanup patches
To:     Yogesh Hegde <yogi.kernel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
References: <cover.1687092111.git.yogi.kernel@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1687092111.git.yogi.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/23 15:03, Yogesh Hegde wrote:
> Rename variables in struct rtllib_device to avoid CamelCase which is not
> accepted by checkpatch.
> 
> ---
> v3: The driver is split into 2 modules, calling the functions directly which
>      the v2 of the patchset does breaks compile. So reverting back to v1 of
>      the patch as suggested by Greg Kroah-Hartman <gregkh@linuxfoundation.org>.
> 
> v2: Removed the variable and called the function directly instead of
>      just renaming the variable as suggested by Greg Kroah-Hartman
>      <gregkh@linuxfoundation.org>.
> 
> 
> 
> Yogesh Hegde (4):
>    staging: rtl8192e: Rename variable SetWirelessMode
>    staging: rtl8192e: Rename variable SetBWModeHandler
>    staging: rtl8192e: Rename variable LeisurePSLeave
>    staging: rtl8192e: Rename variable InitialGainHandler
> 
>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  8 ++++----
>   drivers/staging/rtl8192e/rtl819x_HTProc.c      |  4 ++--
>   drivers/staging/rtl8192e/rtllib.h              | 12 ++++++------
>   drivers/staging/rtl8192e/rtllib_rx.c           |  2 +-
>   drivers/staging/rtl8192e/rtllib_softmac.c      | 12 ++++++------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  6 +++---
>   7 files changed, 24 insertions(+), 24 deletions(-)
>
This patch series alone is fine. But when my patch series ([PATCH 0/9] 
staging: rtl8192e: Remove unsupported modes a and 5G) is applied before 
it fails as we change same lines. Will see what happens.

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>




