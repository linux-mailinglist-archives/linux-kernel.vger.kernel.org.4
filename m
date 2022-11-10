Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1631623E64
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiKJJPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKJJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:14:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B668ACE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:14:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id b2so3358195eja.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e4toneR5KKcUIRDRiCFMakjH8j8yCqCNqAI0j4/x8+4=;
        b=sbnWxScSUVxpYlpBaYmPHODK7SFCvD3Yb5JP37A8gmtKph4XI6g6m6m8v2E006lQX/
         Nxmx+44Ps9VHfEN7Qu70D2uJOahzh901ZCUYmdGgtUT0koJ0T6mZV7Wg/+FsVbxwatyd
         inVpmy7imtQLOngTNw3XTGCbzvf2GNLFMN13FJjFuJcs0cWtX/VRn5BzndnuIuytV+EE
         AGvpUmsLvkZnsExGx6+LJBF78utIG3RChW4tF0y2zh6FMW9wGWXr/JgHZbqpk470Rgtv
         rgEBXIajf62NOOYPF4yXyQ1ERV0gqWjo6E4CsKF+UjjGIAD0vR3S16U5E6QW/Wi8yXEM
         qyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4toneR5KKcUIRDRiCFMakjH8j8yCqCNqAI0j4/x8+4=;
        b=GUQ3Kl2aEV3aiCwxMhVaTnQyf2fg5BSeJ64yf5FOWYPgtHafm2INej5x4WmmjI/+Fh
         SxSEPTFAzT95gpV0C7xdYPEm3M+0CGb9lqCVayVqoyTUVZ6rk+OwEluJCAP4yTjlnCnt
         RRUsizfw88FufX2dwnk+Bl8Y+fcRxMYb2YfXcVBpcYTTBoLYCdNMbsy4FPSayflLRpsD
         3IK5Fh6tZ3YGQKsCojf+9jRpGunjYXRG47u+kCNi8mQc/9AIM7O/z30qyMpBk/s07vFN
         URNDMZidd8qtvEEZyEXSa2EW8hXdf872smBvMLvVU68Z8vWoWxPrOjDt7cWjSI6veGKD
         JE2g==
X-Gm-Message-State: ACrzQf3WFl+39XpCxxVhCdZUimFodyZocSM5lPzJWiEG9VLpTJtNTLCO
        nI9cN+ctHbZq/KW+RYUSYW0RlFh3/Tr+zuIwv+MhtpgToTs=
X-Google-Smtp-Source: AMsMyM6/ZHf6gPgIdBAluiNYH4JlXtPc16lEDs5ypS46T9Olt2mejODm+cIV4A/Xqo6dKlJdUc4r5Av2tyz8Kr28D2g=
X-Received: by 2002:a17:906:95d1:b0:7ad:9891:8756 with SMTP id
 n17-20020a17090695d100b007ad98918756mr2535277ejy.203.1668071696498; Thu, 10
 Nov 2022 01:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20221110150951.1d9f0079@canb.auug.org.au>
In-Reply-To: <20221110150951.1d9f0079@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Nov 2022 10:14:45 +0100
Message-ID: <CACRpkdY=d8jSY4G1UsZ_17xLZbJ976ey23Jzq0DN1EMiFJzLMg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the pinctrl tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        zhanghongchen <zhanghongchen@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 5:09 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> After merging the pinctrl tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> ERROR: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pinctrl-loongson2.o
>
> Caused by commit
>
>   6b88d921f848 ("pinctrl: pinctrl-loongson2: add pinctrl driver support")
>
> I have used the pinctrl tree from next-20221108 again for today.

Fixed this by taking out the patches and waiting for a new revision.

Yours,
Linus Walleij
