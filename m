Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A5A669D19
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjAMQBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjAMQAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:00:41 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65076983F7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:51:33 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id q125so10877146vsb.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 07:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f5mLrAHoyJ5nE/w7T6hV9jO9ho9i+v76675RNWbUbP0=;
        b=yHRJb87NukQWnDBcg5WdqZfZ07lI6u6ys4J9MZyzZjGgWFD6i1KYUG5iukGhsbMBL4
         WPiiQagmylt6A5MJKZg40yDFd8qZ8ccY+6eMWL11aY4WIEGBXd/dqGBzZKRyMDOxqnPV
         HlQTyavSGQRfJrqVQ6wJTz+FSi7AQkTYovL2goYaAHH0dhm4QHhMabwof0unFZR7NqqK
         gUt1LFGzuwOgeO/eCmOJpww2XN1XsvqNGIJIMmVJuXLBFR9C8kmaS92T3u6hy41Z2Imp
         tldehpMR1TNgEDawB0c5upbO5pr+85OSL7ix7y/PoWI/EmHGpIFYdWyjiVMtq12T9Dpf
         K3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5mLrAHoyJ5nE/w7T6hV9jO9ho9i+v76675RNWbUbP0=;
        b=OdMPFHtg2xTl4eYiFGxsbTQqScP41hY4AMV2NFDmj8YjkPNbzuuDrESFffT8FI4nuY
         i6e1M4evC6anhUIwE3d3Htkx6wZViay88wZhH04+kIP9dsIhp5vq1/X2wRD7WMzK9aZL
         KzA2pUD0yzKqkGnBM4hablNbYC5BS7TPqzSCbNiow+0IT3icVyVH7k7wpfBoURXGgJ5x
         h0M0dt0fgJhnlpf/F0wyO4nCRztlYX6qjooN+CtNa/WnAFBPav4Oipt+ab74BjGoafTL
         Fn5l9jY6/O1PkJD01OiolW1XSa0iO6T1cd2K08ycsHpwlySl9fbohCDvWv2Wo/9N/zBj
         qpkA==
X-Gm-Message-State: AFqh2kph0jmZ+A+J/ot3uP8KSjXVONlIvtLoKA/6RAegMQdnLWSD4ZEc
        OkTpCQAs2MdGivI/KujHvUu1pBOUMlUjSnfRKkcyMg==
X-Google-Smtp-Source: AMrXdXsI3EMIQ7TOoOD/7p0LcC17cwRylvVtksQiQePxKwv+hwJDZMXOmlYE3f0gqSJLKso5mPtLAUlUwQRbqnkLpEw=
X-Received: by 2002:a67:df09:0:b0:3ce:88b3:d7da with SMTP id
 s9-20020a67df09000000b003ce88b3d7damr7008535vsk.62.1673625092385; Fri, 13 Jan
 2023 07:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230112133942.58471-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 13 Jan 2023 16:51:21 +0100
Message-ID: <CAMRc=McWPrODnwqHnKHx4V3buyWduMROnHpP1_jd3e-8EoU3tA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: Remove unused and obsoleted irq_to_gpio()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-m68k@lists.linux-m68k.org, linux-sh@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 2:39 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> irq_to_gpio() is legacy and unused API, remove it for good.
>
> This leaves gpio_to_irq() as it's used yet in many places.
> Nevertheless, removal of its counterpart is a good signal
> to whoever even trying to consider using them that do not.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Applied, thanks!

Bart
