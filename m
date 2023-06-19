Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A588735E21
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 22:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFSUE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 16:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFSUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 16:04:25 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9DE68
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:04:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f3284dff6cso9135075e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687205061; x=1689797061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tcn+J35INb3hFuMDcDSiz8xDpOjqS6XsU0Ov32vheoY=;
        b=BkIDGp9FpReMXXMGkFcd26WoGyQiMHLBN7jA7QTTjk2ZDcG8/7Ju5rXn4YkYR3M5rf
         qiXwO8my894B8qybcvyBjmNCQ+2o7wwii19kFtHOYfPkxLB2gPDDfpTU8IasCThMBst8
         eBNR+BhGa2v/uykN67xqK9YANNoQN0LpNUpedGKg2Af6cyLpXs88iQ1R8B1KsDJCcJwy
         cL7fWSfAcMFELmurhRparFV8qk4t5KhKZ4UWCg9F+nbrXOWbmnyVsBneMj+TbThFArEh
         30fFs2MGj0X/1VMVE+FgG6xv+NeEdX5HDqlz/4mrc4k4WAwMok6DzZweLgLk76k2mrMZ
         JYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687205061; x=1689797061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tcn+J35INb3hFuMDcDSiz8xDpOjqS6XsU0Ov32vheoY=;
        b=TVPtP8rX95jU/31KOeX8UFgKahH72fCtV5YgHuuJg+tYd8K+v44x7K/aWkxr6CY+d6
         61U+AVfDulm7G+k15t6eYqvXKmnQUiaK5ObCgNKO/cvioQ2eTys5Da4EbGtLH2FytIEU
         uPbSuMKDp9akRG1mywb5f/ZXKVA+52NEMY5b8M02vdOwJKQidxbkdtRokyA3wfOUdKuy
         7iGEx6MUT/GzUtB8RSfwPpZqrGgdxeWjpBolQUbXlhXBQoZmUH92qReLKnvU5eh97f8O
         hqVRg3ZjRyIdbdiys2LRBXRSOJCK1Df9H/e5VmiuEfV4XVPTIuh5z/4kolxrbHzGrBEi
         +MCw==
X-Gm-Message-State: AC+VfDy10LB563iZmuBJZmQTNvOKxZKx4TfSckDoTM+QRZPd8tF2Y/p8
        Uoa3cAuxC5eOrhYeUcdUH+E=
X-Google-Smtp-Source: ACHHUZ7qFZxrOdeG2jCPahv1uG7n7QLqg6igoWM0kmtf4YS2nFMqKdX2ruUDtr7gQvQ2B0rvGBwWzw==
X-Received: by 2002:a05:600c:4e10:b0:3f9:9a6:eb68 with SMTP id b16-20020a05600c4e1000b003f909a6eb68mr4470009wmq.3.1687205060501;
        Mon, 19 Jun 2023 13:04:20 -0700 (PDT)
Received: from [192.168.0.104] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id x23-20020a05600c21d700b003f427687ba7sm543107wmj.41.2023.06.19.13.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 13:04:19 -0700 (PDT)
Message-ID: <d1030525-4b62-10dd-2b2e-1aedaf489324@gmail.com>
Date:   Mon, 19 Jun 2023 22:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/4] staging: rtl8192e: some simple cleanups
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230619150953.22484-1-straube.linux@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230619150953.22484-1-straube.linux@gmail.com>
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

On 6/19/23 17:09, Michael Straube wrote:
> Four patches with simple coding style cleanups.
> 
> Michael Straube (4):
>    staging: rtl8192e: clean up brace coding style issues
>    staging: rtl8192e: convert else if sequence to switch
>    staging: rtl8192e: remove return statement from void function
>    staging: rtl8192e: remove comparison to true
> 
>   .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  3 +-
>   .../staging/rtl8192e/rtl8192e/r8192E_phy.c    | 11 +++---
>   drivers/staging/rtl8192e/rtl8192e/rtl_dm.c    |  3 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_ps.c    |  3 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c    |  6 +--
>   drivers/staging/rtl8192e/rtllib_softmac.c     | 39 +++++++++++--------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c  |  4 +-
>   7 files changed, 40 insertions(+), 29 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
