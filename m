Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB28762111B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiKHMln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbiKHMlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:41:40 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033A951C0F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 04:41:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id q9so38382005ejd.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 04:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gi9G5NsNt+Ih2E7N83yfZTdIZYSFxlj5Rim1ZcoMIso=;
        b=qGVPRCWL/D+mJBt/YMpR/hJd+4+6vgRZYwr0Y/oVlUwH+qLV4eWqaggSLqst80bRSK
         33Dsc/PPoR4rNmTsCfQv/u1Pw3hKLnPKDz5ormbRqWS8C1px+0JIsCQxVc12d6egE9q8
         xoiJc7yxZ/0dpZvPdBcH1AV6g8/Sw2SOSMcRaNP74U48RoJQouqtX3bx/zsgRQoWp6LF
         Es3nd+BQmABuAYlGrosKrbyNePLh+BP7L2C4iFRzh7c/gtZERA2QOc+UHBlRtUzwdHQk
         k/Y0LH4KrXCmcThcVJNx6p2pfBDMyJwhjE0F1v7AK9NeV/c877ozDa6Dm7zDoN4Upd34
         Xrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gi9G5NsNt+Ih2E7N83yfZTdIZYSFxlj5Rim1ZcoMIso=;
        b=ZwlE2GoAOtwMnahekIgvifop3EyZRahQt9ML58sacxYppYK2URHyRYDRqTzOqvcWTo
         g5J3fGcSHW52XdQQemjv2rLQ0vjTYWRuQMr0YNSoV14ANQXwS8BNRXSDoQxibJ1Na92F
         xGdxTyfBfJQh5ZoxycgwC4al5jgm2NsUWWOX4CP5RCnkswkN9IWQHGR97zXlPB2V6kTt
         1Yt+sr3x5LvdfY/JiqNBHFRiJ52Nmgvbsk1IyzYSRhmrEKMsZ/LybymyKIymlTVN5YZR
         /rPYtcXkrTF47kgGx+G0oxuXbUwaEfZDFI/RHTSYk4ATNwwCCXZftszKEj50G0FIov3h
         pezg==
X-Gm-Message-State: ACrzQf3tY+IRY7oFiSr30oUoWDECCIYeQLg3pds6/4r6Qk3WnsSPbOMY
        2rYj9OPcJUvj7mt6BivXFZtAbBmV7Oz79Wbd+UEIDQ==
X-Google-Smtp-Source: AMsMyM4D93wKvgktKtF5pSLNAQhwJArnmkseAbPQu6Ig5bPJ7gB6T8TvEqq/MsHMHo31i9VmzOer9LWWXHAKTEwxw8g=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr20975544ejc.690.1667911298631; Tue, 08
 Nov 2022 04:41:38 -0800 (PST)
MIME-Version: 1.0
References: <20221101205159.1468069-1-lis8215@gmail.com>
In-Reply-To: <20221101205159.1468069-1-lis8215@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 13:41:27 +0100
Message-ID: <CACRpkdbKv_EBBpvSkGkftexJs4t2ani2bVz8vnRLN2YjpBVvAg@mail.gmail.com>
Subject: Re: [PATCH 0/2] docs/pinctrl: fix pinctrl examples
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 1, 2022 at 9:52 PM Siarhei Volkau <lis8215@gmail.com> wrote:

> The document has some typos in the examples related to using
> pinctrl_select_state function and out-of-context variables.
> The patchset aims to fix that.

Thanks so much for fixing this! My ages old mistakes...

Patches applied.

Yours,
Linus Walleij
