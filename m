Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074E74A52C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjGFUtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjGFUtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 16:49:07 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E680A1992
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 13:49:00 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b70357ca12so2998671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 13:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688676539; x=1691268539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GThZ4Ggr15+pqAxnjvQ9kC8BtTk0gsdP1wNAHgEDJFo=;
        b=HxuOF9aF7fpVGvklE/EfYzn18Uu4zZnT56MUJ8z9GLWccoq4ZAc5ltJjTUAMP9TEgz
         cd9BcYsX/dTBgSXpACCHgcG/tNveEdwq3vOVG99ilif9Bzys5ubyj4mFecMkAIS4AD/9
         kX33TgOh1chkHquSf+pi2frP6jScMJu9auR9AQKNHbtWQLe/g1VcXZaKLZjmtJq8YCi6
         C/4RlHFSAFKQdi8lWRniNCtJ2Odk8IL8p5l8LY53yukgmc4rS8dfJRz/Lw0geTeZnoPL
         LaP7GAub5mttCqfSwc7O2tdFueSmq12ZxN6oa5CB5lZLC7i7XvuzJxiWHc2zrtfV84zA
         Lr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688676539; x=1691268539;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GThZ4Ggr15+pqAxnjvQ9kC8BtTk0gsdP1wNAHgEDJFo=;
        b=EMcdJcdbXJJBU6mmB5rl7vUI9FmOwJcdlJPrDBcSdiegVAZpCDI0zw8T/UKUEnEa5o
         yQwg3K7FmLZCIs+RPWWUGFJrDlSCbG7aYK+RCD0+HXL1k4W+AlLpMSPDEhJg6gwFNaQH
         cn5UR5wpJykkI/ns93ac+5Q5krfVOI3I9m0LrpwzLZM8Zk8D3uY+oWFepDhf1H/pa6nk
         l7X3Yw2urQW4w4M0Zo14Wugph0W6hlqfJfvqk/03sgZI3iF6eFUuwfc3g9hRoAvnuA0g
         2Gbd15PtWX9hL9TGulfi/HwOd4ss9M50ocpj9ygwJrKoIMjs2o2oriU+SUdpCgO94p9i
         eoZA==
X-Gm-Message-State: ABy/qLYnVTY+g7nJhSYNuTWluRxQxDt1rYQ6YWRoHquJEYrXbW1QAm9I
        hRQawJm/MVDzP+kb4tF/UaEPs41QuiE=
X-Google-Smtp-Source: APBJJlHH8LCapShEIup2bqszsjZ/kGTp0spSi0HkqSsEF4l8ErdI9N4ncbf5ZYHa8fsZfkFRbJE3ig==
X-Received: by 2002:a2e:a10b:0:b0:2b6:9a47:c4bd with SMTP id s11-20020a2ea10b000000b002b69a47c4bdmr2288618ljl.1.1688676538550;
        Thu, 06 Jul 2023 13:48:58 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906355a00b00992b2c5598csm1249745eja.128.2023.07.06.13.48.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 13:48:57 -0700 (PDT)
Message-ID: <6dee04ae-4129-cd7c-0d31-70d29b86c8ff@gmail.com>
Date:   Thu, 6 Jul 2023 22:48:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] staging: rtl8192e: Rename variable bCurrentHTSupport
Content-Language: en-US
To:     Tree Davies <tdavies@darkphysics.net>, gregkh@linuxfoundation.org,
        dan.carpenter@linaro.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <ZKYgH/BvkE9bdcPm@kimchi.darkphysics>
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

On 7/6/23 03:59, Tree Davies wrote:
> This patch renames variable bCurrentHTSupport to bcurrent_ht_support
> to fix checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Tree Davies<tdavies@darkphysics.net>
> ---
>   drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
>   drivers/staging/rtl8192e/rtl8192e/rtl_wx.c   |  2 +-
>   drivers/staging/rtl8192e/rtl819x_BAProc.c    | 12 ++++++------
>   drivers/staging/rtl8192e/rtl819x_HT.h        |  2 +-
>   drivers/staging/rtl8192e/rtl819x_HTProc.c    | 16 ++++++++--------
>   drivers/staging/rtl8192e/rtllib_softmac.c    | 16 ++++++++--------
>   drivers/staging/rtl8192e/rtllib_softmac_wx.c |  2 +-
>   drivers/staging/rtl8192e/rtllib_tx.c         |  8 ++++----
>   8 files changed, 30 insertions(+), 30 deletions(-)


Hi Tree,

when I try to apply your patch on the top of all the other patches I get 
the following error message:

kernel@matrix-ESPRIMO-P710:~/Documents/git/kernels/staging$ git apply -v 
~/Downloads/20230706-\[PATCH\]\ staging_\ rtl8192e_\ Rename\ variable\ 
bCurrentHTSupport-10002.txt
Checking patch drivers/staging/rtl8192e/rtl8192e/rtl_core.c...
Checking patch drivers/staging/rtl8192e/rtl8192e/rtl_wx.c...
Checking patch drivers/staging/rtl8192e/rtl819x_BAProc.c...
Checking patch drivers/staging/rtl8192e/rtl819x_HT.h...
Checking patch drivers/staging/rtl8192e/rtl819x_HTProc.c...
Checking patch drivers/staging/rtl8192e/rtllib_softmac.c...
error: while searching for:
	crypt = ieee->crypt_info.crypt[ieee->crypt_info.tx_keyidx];
	encrypt = ieee->host_encrypt && crypt && crypt->ops &&
		((strcmp(crypt->ops->name, "R-WEP") == 0 || wpa_ie_len));
	if (ieee->ht_info->bCurrentHTSupport) {
		tmp_ht_cap_buf = (u8 *)&(ieee->ht_info->SelfHTCap);
		tmp_ht_cap_len = sizeof(ieee->ht_info->SelfHTCap);
		tmp_ht_info_buf = (u8 *)&(ieee->ht_info->SelfHTInfo);

error: patch failed: drivers/staging/rtl8192e/rtllib_softmac.c:816
error: drivers/staging/rtl8192e/rtllib_softmac.c: patch does not apply
Checking patch drivers/staging/rtl8192e/rtllib_softmac_wx.c...
Checking patch drivers/staging/rtl8192e/rtllib_tx.c...


My be the previous send patches are not taken then your chance is better 
that this one will fit. Will see what happens.


You need to put your patches into a patch series.
This reduces email traffic as the reviewer can just send one email and 
does not need to send four.

A possible command for a patch series is looking like this:
git format-patch -o ~/Documents/kernel/patches/ --cover-letter -n 
--thread=shallow --to="Greg Kroah-Hartman 
<gregkh@linuxfoundation.org>,linux-staging@lists.linux.dev,linux-kernel@vger.kernel.org" 
4bbbd60d84e15fdb7bffde98a687ed168a4dfbbd^..HEAD

Use the git commit id of your first patch.

Bye Philipp












