Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF7620D9E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiKHKsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbiKHKsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:48:04 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BC429BE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:48:03 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id k2so37538696ejr.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NLSZQDOdS774Nz52CcTIDX3lJJfQJqLZXfRGXtR9Ekg=;
        b=Q/9aeYAvohkURoWlz1zGEDYuDkN2MX0lw+Kk0YRLwtj9goOQOAF9xG0NgpAkIK3Vou
         aRnXhbvzVWvGcHLNMfTBTN8fXWdoGK9hQj8Hf+aqs2EDM++WUjhIAR2L7ZimVj11vzkk
         WaT/Hni/SPZACleYu1QbfipP3b0DdDLSxNcTxcNg9hRcEiTN3rH6acxDChexGFMj4kn8
         OWC/amXtKTXEk2ldm5eSpTw/7D7fUjvYWrVveuaf+i2VvBRlmqVfL1vNp+zK5OKwXgZw
         sXFfIQHFxKtjDHZv9q+05JY7Y89zc91ioC3rwXcefBOliuZ/iovPcxJGRvuI47FOy3cl
         2YoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NLSZQDOdS774Nz52CcTIDX3lJJfQJqLZXfRGXtR9Ekg=;
        b=poWSbJx9tPG8QK5e+0jsC0t8QC0ElPh2pPrK12OenGm1mnv0zcb72yFa4uUzALobNW
         vj6QJP2My/v/pInFJlmHrzKSacdPIxvSzAZMt/kTJm0IrgVljC7nstobAl5C3KFBh/dp
         yFexhI6rZTh4FOX4V6WYHkIzcEniHolTxbPGLna2EHNuELWwtO0kK2Vhk2pSb3W/l93W
         2VLUEGPT2+huWds2bmB+OfheC+hUJ5esqGFAdeCeGuZeFYElvq/Vv9ZjqYLouU8c4RJL
         jhcFoO9y5anXHzpoVg4gwfuheZka0AysdH6W6Y6wp0Rd2gmc1dNias1ARGh2w68uCgk1
         qkzw==
X-Gm-Message-State: ACrzQf0tehkzs6w45sIxPf4N3EW7+ZTzwXEtGL5cj6rkgM5ool73i3D9
        9GI2JXkCJZiZJx3+wCxG5BmaXNJP14ATqZPWeTeCoA==
X-Google-Smtp-Source: AMsMyM4AKmqQtElrAYKhu/RuZpiMiFWRy6OpfbPMp/rWEBwBmcX73CFRJ6uB1YEN9d/PjYiVETR77As0iG1GsQhAgS8=
X-Received: by 2002:a17:907:c1e:b0:7ae:31a0:571e with SMTP id
 ga30-20020a1709070c1e00b007ae31a0571emr20557470ejc.690.1667904481920; Tue, 08
 Nov 2022 02:48:01 -0800 (PST)
MIME-Version: 1.0
References: <20221103180643.79352-1-andriy.shevchenko@linux.intel.com> <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
In-Reply-To: <CAMRc=McicB36evBh5thWPtnMPuzbfY+4m29i6Mp-1tJSw9OvjQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 8 Nov 2022 11:47:50 +0100
Message-ID: <CACRpkda0aLXxZn4DJdo0BjwhLYWBjmG+_iEtDz84F9e1srqXGA@mail.gmail.com>
Subject: Re: [rft, PATCH v2 1/1] gpiolib: Get rid of not used of_node member
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>
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

On Fri, Nov 4, 2022 at 4:10 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Thu, Nov 3, 2022 at 7:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > All new drivers should use fwnode and / or parent to provide the
> > necessary information to the GPIO library.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
>
> This looks good to me. I'm thinking about just applying it and giving
> it a spin in next right away.
>
> Linus: any objections?

No objections, sorry for taking some days to respond.

Separation of concerns is always good :)

Yours,
Linus Walleij
