Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620026439CD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 01:10:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiLFAKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 19:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiLFAKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 19:10:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764A1834E;
        Mon,  5 Dec 2022 16:10:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g10so12357365plo.11;
        Mon, 05 Dec 2022 16:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1d6azkoMx+wYQ6ybc9BfX8jifk/2ngAE1j6INpsRQhs=;
        b=VkA0qRksnnNUCz8hgZN4tt80YmP0ZEiafD7R4E6A9f7sDbd4LnLvZpBy3oqGzhMk7W
         ubgwm11WvHY3CpNIhAelRKoYCF8nk25tST40pR9nk+aYSRQ1Wl15jXLX3aacUE9eRD5y
         9NKdwdOYk3d1z0AYsy4rLz+NjC2wbTv0bFCpcEY5jYhkNL3dmHxVI7j1LatS7ygUD+YQ
         f2IoqOYi0z5ZG0+Phc3z9bTyLjIF/Z2yDnDy8r323ein9wdtf2EuXYW4DaR9ZutHOEVM
         qNbHOW5eHsNfZTk+xAOEQvew/Pm7+BuJHfdlf7Ko64F+u/j1OCGFG8H/1nE0fETJC052
         g03g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1d6azkoMx+wYQ6ybc9BfX8jifk/2ngAE1j6INpsRQhs=;
        b=bLswIdMWsRYODJhdxm5oHMKueyH5wMUYG2vJft10SAIEBLNPq0YnJQrR5N8sV0AOhT
         rx0Ge1/+oW8JuZ5DWWv6/Lghp4I3N9FPoPeH9qcsnk7t3NwszdT5h2L83AIemyq02Ils
         ubfB3boCPqH0bb8rKApd6vNigthXjyyZ8LEfB33Z1IJEjD3sKx0GHR4jxwixlOdqSnG7
         mVLq1A1WSCH8Qy4DYPI+SnKAFIKp5T0AQlb7AZMLSK8R2HXkfvBHB+Bb3RmIVy9Wc4Bk
         ucUrux/B4aWn+jp3cKuzwI/IZdT2qq/XXHq5PK6sgMswKcZ1Q6pQoPlsYBz1+/9/VXXg
         snAQ==
X-Gm-Message-State: ANoB5ploLrvyvzWM+OsM+eP8neBlVJVEQiKrBRlyeaT7slHCt0gguaet
        dbnlJ2ZswpNJOugJwK7l16k=
X-Google-Smtp-Source: AA0mqf4OGjimZ6j13eDhruYyAcTL31kz+/U8N0ROuNsoOb3yp+af5gp70/k0M+Zd3oq9tyzRKpfO0w==
X-Received: by 2002:a17:90b:3641:b0:219:d636:e5de with SMTP id nh1-20020a17090b364100b00219d636e5demr7383815pjb.134.1670285421263;
        Mon, 05 Dec 2022 16:10:21 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i9-20020a17090a058900b00210039560c0sm11400938pji.49.2022.12.05.16.10.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 16:10:20 -0800 (PST)
Message-ID: <524a240a-3aa4-08bb-2d85-4eb6798af5fb@gmail.com>
Date:   Mon, 5 Dec 2022 16:10:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Resolve "unused" warnings with
 CONFIG_OF=n
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        kernel test robot <lkp@intel.com>
References: <20221205160353.1.I5fa28f1045f17fb9285d507accf139f8b2a8f4b5@changeid>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221205160353.1.I5fa28f1045f17fb9285d507accf139f8b2a8f4b5@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 16:04, Brian Norris wrote:
> With W=1, we can see this gcc warning:
> 
> drivers/mmc/host/sdhci-brcmstb.c:182:34: warning: ‘sdhci_brcm_of_match’ defined but not used [-Wunused-const-variable=]
>    182 | static const struct of_device_id sdhci_brcm_of_match[] = {
>        |                                  ^~~~~~~~~~~~~~~~~~~
> 
> Rather than play around more with #ifdef's, the simplest solution is to
> just mark this __maybe_unused.
> 
> Fixes: 1fad8422c989 ("mmc: sdhci-brcmstb: Allow building with COMPILE_TEST")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/all/202212060700.NjMecjxS-lkp@intel.com/
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

