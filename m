Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F806622FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236303AbjAIKSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237079AbjAIKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:16:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF16169
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:16:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id k26-20020a05600c1c9a00b003d972646a7dso8591078wms.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mH4f9OANiE6I82Rid3V8ENaOi03PPyxh8l5jpzwCQ2g=;
        b=moQWNsgTXKScXgCJUB9sQ+uMKOIfJExITq8dYoMSPNwcVjlG8F3+FhYxyVh4mGab5D
         WPiXjNjY6lbEwvUtN9024Wrnx3OUzFIw0m/ZG8q1W6rCDpa1OoN0eTzHWcgTYugr7EDL
         YuY02QZRv0AJ8p+UNO/6Ogy0wV3o+Iz78jfaTQzZ7ei9W5SH4b6Rj2NS4RVOQ1RmtqYD
         AwOrO3RLmFBkhvmD+X+7RozXxiVNmh0qKURl1hGhMdJYI4NTFZPDH0blYgsP/9otzFgP
         K01EH5s5q7BmAd84+euEhlkabIW9Ub+SNuvUL391QaNXzwQqDIupg5ItSsvCS8YlK+/2
         oHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mH4f9OANiE6I82Rid3V8ENaOi03PPyxh8l5jpzwCQ2g=;
        b=1IaqZj2V/Rd7INjf5n+7Le85FsJB0pEjeEYr9j8cMb4X9qkan9Dnkrze8dTf1Jco+s
         J7HdkN2OoNb5gN4CU0rlHKLaiQzF70BDJcyxtgimD9yf8DzHDewtNpOprxPyQR72XE/L
         pwLslGbEgzgPM2066RGll99q6kGufbpyikNoADlN7sYKNw56yB7LTjn7JgcEnNaUiFj4
         NgieOkgQA1wU2Zqikissv7JTmcTjXNnER79uPq6Qd3YT0esisu1gBSrkk9iADoH3s5OI
         NbueFRoNgDJhQP4+39/aNMyy2R74TtCB3Sg8/xEy8aYa6meJ67RqilY83z3uKyWh8d9c
         elfA==
X-Gm-Message-State: AFqh2krDje3LPIkLs7XMYjyu0TLnWPM23A2nWMWtXMSCO4wSkHeEiu6/
        P9weuJk2k3+pn02+c4tc387VjA==
X-Google-Smtp-Source: AMrXdXsACLbkYa2fzH0tS4O/LJpxq4OHjiRZNRCmRiAMjrrNnwIY8/sgFFZXOY2oEtev7X11zGWG7Q==
X-Received: by 2002:a05:600c:220c:b0:3d2:3831:e5c4 with SMTP id z12-20020a05600c220c00b003d23831e5c4mr49516520wml.40.1673259400970;
        Mon, 09 Jan 2023 02:16:40 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c19c800b003d9780466b0sm11970130wmq.31.2023.01.09.02.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:16:39 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:16:37 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] backlight: aat2870: Use backlight helper
Message-ID: <Y7vphX2Ohyv/xZz7@aspen.lan>
References: <20230106164856.1453819-2-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-2-steve@sk2.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:52PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

This RESEND seems to have dropped the Reviewed-By tags provided the
last time is was circulated:
https://lore.kernel.org/all/20220608143233.l5pbopafqc4n6uwq@maple.lan/

There's only four patches so I guess I can add them again so the tools
can pick them up.

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
