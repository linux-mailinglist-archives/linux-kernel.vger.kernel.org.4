Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC453605914
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiJTHyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJTHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:54:00 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37412148FC6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:53:59 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a26so45028960ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIy6ZVMvppl/b0MZxwgJbi/e6Y3XMjUjdrp2vf+E0nw=;
        b=uhV0+YrtX7/80cANw90/dQxsRV8PBLKfv4W5FEPi/SR05BGohmBo1B7iIPtC2cvqaB
         3lDOp2RZ+ouBW+86Zymgx+FphPVGIBFIWgwGr2vVSEyC80rlgDyVn60Mfy8BNkV7J+6Z
         JYm1c7pft/bEhMCdR9oFN74JIgCucnzz8W3eku9GInNW41Z7k51MMifxTEyJqMsj6vxs
         BO3zS9AZsGJ3HlTgcmSKsyj4Ok/qc7mvvxDqMewE9Bx/Jlq8f47GE3r+UrLDHbKltF2S
         Be1Rx9equx103r/TY6a/i3IUepXQm1eTaje1JBHOrWHe69PbNjZp5wKdnqSAxw6F5Q0r
         1tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIy6ZVMvppl/b0MZxwgJbi/e6Y3XMjUjdrp2vf+E0nw=;
        b=zOlWzivIOaNSu4A0t2uNllRCX8rtlJ625o3SU9IG2ooajzgMqMtNm6tatW8L4zPY/T
         fXHYMns3WkoB9NK1S0NLDdldgKOSO39If0LS3QRP4Rsw03ZqOeGI6rCf/s6nvButuobj
         mulkaY4BZW55tZdNRq1wrqgb2kDCTZXTjIdo2Rs/tMD62/K6U7yCViywCw+EUTBGDCnd
         Cz4PIECTR8F41Q+mhKqUgQM7fYAmfENb/pONVVMeIrfOrOiBPmoLV/iXVivE7kygsnBQ
         EsJjhELvGVlZj4vabBMXeuIw6mwcNGlwZPvjAwhfMCNjECdnrE1ZOiKLEg4dCrwnVcCX
         xYlA==
X-Gm-Message-State: ACrzQf3Y4J2D7KoYkK1TknfMXPGF3odpQUL21k2Kq0DgndFsumdEkXWb
        /M3q4li+PA1tN9s1QROvJkg2aX8x4NKAcghGrlydHw==
X-Google-Smtp-Source: AMsMyM7/ruAcTPWuF5rV5RbQhEQhWNz5EL/tLxUjgT4VSPPoQX6EP+m2UULvHnVE3w+d69SONmEQvMmkuF++WGzeKAU=
X-Received: by 2002:a17:907:1624:b0:78d:d61c:2b4a with SMTP id
 hb36-20020a170907162400b0078dd61c2b4amr9754771ejc.208.1666252437594; Thu, 20
 Oct 2022 00:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-5-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-5-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 20 Oct 2022 09:53:45 +0200
Message-ID: <CACRpkdYxuPFV-uQCRUJX03VKSdDZvFH8aKunM+bak0eVbmEV-A@mail.gmail.com>
Subject: Re: [PATCH 04/14] clk: remove davinci dm3xx drivers
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        David Lechner <david@lechnology.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 5:33 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The davinci dm3xx machines are all removed, so the clk driver
> is no longer needed. The da8xx platforms are now using DT
> exclusively, so those drivers remain untouched.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
