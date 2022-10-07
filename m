Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162A65F78B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 15:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJGNOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 09:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJGNOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 09:14:51 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230B515725;
        Fri,  7 Oct 2022 06:14:49 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id mx8so3031231qvb.8;
        Fri, 07 Oct 2022 06:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AzbAsuzX0C6YbjqXLy++AIOWnufxc1YAQDpDKuGwvH0=;
        b=QmnEpMRK65VegZLV3ihViFzn4hnbLxPFE7Z+19fXajLm4FMxfl1/JRRCCOROSTM48e
         69136BXMrGC3n8wxaC+loAUB6rL5H6SDKRzVcdB8Z2NFSCeqBbGICUna4pmR8Dm0qVNG
         yOej4vBYrhQPVGRccu0VyXgCmnzveFFCASAcUrtrn4Rone75P4eKKbf/maeWJHls7fF3
         arWnVCPnmxpT0kOCi+Mi9qx6pv0xE14vExdlZCfmHGMqA8+lYiJjJZV5qm403pLaeWP6
         89xacW4ILpctcIuDse8CUw9sBPfATKiq48xUwI0qlNICXB9aJXkqIgLdJOMO9Wnj7sjA
         KeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AzbAsuzX0C6YbjqXLy++AIOWnufxc1YAQDpDKuGwvH0=;
        b=WxRhCTuEOC21t1naWfBOaBZ72US2dh8WdPw7XjSPLX9I1Px0hgT6fn0qQHhhFb2NF5
         WvXxVscGNEtNC4qPNdKF+Q58NV/Zkb1E0bMndztsQ16gEbSJ9T6KbLmZ8mfSPHjXdl9W
         Tsq6a1yCTSj5NXZOMibSUCalyzatLuerUEp7QFQhiSTJx9QS5r7M9dp/znb+kobzCZIc
         uBI0qeKgL/O8xojoXFz5WAsqBYsCTRB6mBte6GrXMTIQtc+9REbpkhv6MlRNd6G951GE
         rG+R+g5XGbn0bPBhwIUUhLC1Me1nkBvmlDjj/WUiRJwv2d+scxdb97pgolukBW6VSHtg
         CNOw==
X-Gm-Message-State: ACrzQf2qg2cB5dy2UZl6RXprDGwXpL0Ih6NqdVdo0WkgAy0UXR4hA+jf
        MAFmWmvuDa+xP6OJfO8IB0ag481kbXQ+ZPeetok=
X-Google-Smtp-Source: AMsMyM5FnnPkT2Qie1lciKjHd7i0Qx9Zg1w71RR9bBTG8Xn1gboFF82194uF6xaubjxsBzT8OQxvNRnwXuEvMh2Y8UU=
X-Received: by 2002:a05:6214:300c:b0:4b3:cefd:fae0 with SMTP id
 ke12-20020a056214300c00b004b3cefdfae0mr685570qvb.48.1665148488225; Fri, 07
 Oct 2022 06:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220917081339.3354075-1-jjhiblot@traphandler.com>
 <20220917081339.3354075-5-jjhiblot@traphandler.com> <CAHp75VeAnJQt7kS8UE+OKcqnScYnmHnVvL+QNW6jR=yF0=oMAA@mail.gmail.com>
 <6d3d2dfd-4d44-c91a-2145-bae624926259@traphandler.com> <CAHp75VePiAs_qz2fxAheoGbq4wk39x5uoVUKZdbN254RDevgsQ@mail.gmail.com>
 <60fcb1ba-f5d4-deaf-d251-7d8c127c353b@traphandler.com>
In-Reply-To: <60fcb1ba-f5d4-deaf-d251-7d8c127c353b@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 7 Oct 2022 16:14:12 +0300
Message-ID: <CAHp75Vdg3JTvvzTZv3=wDsczBhtBc0u8_6x53q2Gq4W9jEsR0g@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 4/4] leds: Add a multicolor LED driver to group
 monochromatic LEDs
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        sven.schwermer@disruptive-technologies.com,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        marijn.suijten@somainline.org, bjorn.andersson@linaro.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, sha@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 3:03 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
> On 07/10/2022 10:53, Andy Shevchenko wrote:
> > On Fri, Oct 7, 2022 at 9:34 AM Jean-Jacques Hiblot
> > <jjhiblot@traphandler.com> wrote:
> >> On 17/09/2022 10:37, Andy Shevchenko wrote:
> >>> On Sat, Sep 17, 2022 at 11:14 AM Jean-Jacques Hiblot
> >>> <jjhiblot@traphandler.com> wrote:

...

> >>>> +               led_cdev = devm_of_led_get(dev, count);
> >>> Why _of_ variant? Please, make this OF independent since it's
> >>> pretending to cover not only OF-based systems.
> >> This is not OF independent. It could be, but that will wait until
> >> someone needs it. I don't know much about ACPI and have no hardware to
> >> test it on.
> >>
> >> I'll add the missing  dependency on OF in the Kconfig.
> > No, please consider getting rid of OF-centric API usage.
>
> The trouble is that the OF-agnostic API for leds doesn't exist yet and I
> don't really want to add it without any way to test it.

Yeah, that might be a problem due to unestablished descriptions
outside DT. Anyway, it seems harmless to call that function when there
is no OF dependency. In such cases it will fail with a deferred probe.

-- 
With Best Regards,
Andy Shevchenko
