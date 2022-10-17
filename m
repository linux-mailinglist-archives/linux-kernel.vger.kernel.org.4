Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A436007F7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJQHoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiJQHnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:43:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983665AC6A;
        Mon, 17 Oct 2022 00:43:46 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b12so14790957edd.6;
        Mon, 17 Oct 2022 00:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HzEUJJelzyjW+5auI+Hjf750SOVJbqYXjyc8xQ8Ffqs=;
        b=igIgzf/VGcCX2b7W0upGeYtIgf/j5Ud9XCHMKDgMSWAvAITVOiQezIwIvLaqT5LhSj
         GWyRPoSINEqwTKwOqg18SqVGKDN+jJU7Jxs0iyMcamV6xtu8Vu6fc1gQMahUnxFZP2pX
         idN+Ro7+knnNjorftKjl4I50qkJS9dsKrgSnzFx0i+MasOayT84IxC/t0OvKCINawY/u
         3h5fEaCNO1cuGjcq+DObDW5yhv5ggtNMWLXYQ0Bo7/LYYL++6DxlmXwkDHs7G07Nu14z
         vYa27JneKcaQYDTE7WMaSRI06WEpSVS440CwReOC1cFqHvR6iSfEkGMCyf5a3wPmz3nQ
         micA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HzEUJJelzyjW+5auI+Hjf750SOVJbqYXjyc8xQ8Ffqs=;
        b=xERJfcv45MpwqzQcPuHtAhS05GYdxCGQMSH1j8clEVWAFSbAsZuzXbb6rzPHyU6O1i
         qQzDiVPgS9MEJCnqsZepqxlj8LnzIr6NxnU0k5tPcwT4lSvv2fUClK5eoAm2i/xcR2ZC
         z2NjTpxz3KGPT903P1oRXQz7Qz8wzRwdKd+gzR7LRB+va4Sg2Mci5NNAr+eUHEd9B6XJ
         pqnHRsM3RNlz23LF8s/iNybxd5WXaaPduCz15r/3jnwlUOmrwHV6/eJjEogt+NVycUUv
         8jrE4frgRsgCKbxJPn8e27pEJZ0swUv2rfRWL0tUmjTmiRUUmTOEDUbFRyJbDS1aHnx/
         ECzw==
X-Gm-Message-State: ACrzQf08gFH9LwDiupeKWIaAx2VmstlY36O3oE338xXj2QrUPddcX0nG
        3ggMp7Zf9tkBXRTRMBhZwDbX8vS6+tHK3s1U0DIF+nboYls=
X-Google-Smtp-Source: AMsMyM6UWBlVBFyY9kZ3VAO15n63NaLMSzxs1B9JRZbQWD7SHQ1cabFywZb2aRRvVjJbZvx81IRUBk89Z34BpkYDao8=
X-Received: by 2002:a05:6402:5485:b0:459:147a:d902 with SMTP id
 fg5-20020a056402548500b00459147ad902mr9358513edb.263.1665992624442; Mon, 17
 Oct 2022 00:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAL_JsqKC_BJDJLLFck_0CbQ-0rZ0oVWMAdiwwGep23nh2pP19g@mail.gmail.com>
 <CA+V-a8vMLuzJ8h5UDNXUiZRXPV1vJ9gguUMywe_+sPcU8tK+tA@mail.gmail.com>
 <20221014214029.GA2937999-robh@kernel.org> <Y0pLDFMsFmHhC/R8@pendragon.ideasonboard.com>
 <2928a80c-6c5d-c7e0-10f1-4c3b18dab525@linaro.org>
In-Reply-To: <2928a80c-6c5d-c7e0-10f1-4c3b18dab525@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 17 Oct 2022 08:43:18 +0100
Message-ID: <CA+V-a8uO4gTAObT+gZ-rROD2xyTXYP6kxfihMbgfbw1W2zXdPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] media: dt-bindings: ov5645: Convert OV5645 binding
 to a schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On Sat, Oct 15, 2022 at 2:17 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/10/2022 01:54, Laurent Pinchart wrote:
> > Hi Rob,
> >
> > On Fri, Oct 14, 2022 at 04:40:29PM -0500, Rob Herring wrote:
> >> On Fri, Oct 14, 2022 at 10:27:53PM +0100, Lad, Prabhakar wrote:
> >>> On Fri, Oct 14, 2022 at 10:05 PM Rob Herring <robh+dt@kernel.org> wrote:
> >>>> On Fri, Oct 14, 2022 at 1:35 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >>>>>
> >>>>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>>>
> >>>>> Convert the simple OV5645 Device Tree binding to json-schema.
> >>>>>
> >>>>> The previous binding marked the below properties as required which was a
> >>>>> driver requirement and not the device requirement so just drop them from
> >>>>> the required list during the conversion.
> >>>>> - clock-frequency
> >>>>> - enable-gpios
> >>>>> - reset-gpios
> >>>>>
> >>>>> Also drop the "clock-names" property as we have a single clock source for
> >>>>> the sensor and the driver has been updated to drop the clk referencing by
> >>>>> name.
> >>>>
> >>>> Driver requirements are the ABI!
> >>>>
> >>>> This breaks a kernel without the driver change and a DTB that has
> >>>> dropped the properties.
> >>>>
> >>> I already have a patch for the driver [0] which I missed to include
> >>> along with the series.
> >>
> >> You completely miss the point. Read the first sentence again. Changing
> >> driver requirements changes the ABI.
> >>
> >> This breaks the ABI. The driver patch does not help that.
> >
> > I'm not following you here. If the DT binding makes a mandatory property
> > optional, it doesn't break any existing platform. The only thing that
> > would not work is a new DT that doesn't contain the now optional
> > property combined with an older driver that makes it required. That's
> > not a regression, as it would be a *new* DT.
>
> You're right although in-tree DTS are now not compatible with older
> kernels. So it is not only about new DTS, it is about our kernel DTS
> which requires new kernel to work.
>
To confirm, we are ok dropping the clock-names property here right?

> DTS are exported and used by other systems, thus if someone blindly
> takes this new DTS without clock-names, his kernel/OS/bootloader might
> stop working.
>
> That is however a more relaxed requirement than kernel ABI against old DTS.
>
> >
> >>>> Also, with 'clock-names' dropped, you've just introduced a bunch of
> >>>> warnings on other people's platforms. Are you going to 'fix' all of
> >>>> them?
> >>>>
> >>> Yes I will fix them, once the patch driver patch [0] is merged in.
> >>
> >> Why? You are just making extra work. We have enough warnings as-is to
> >> fix.
> >
> > I agree that a DT binding change should patch all in-tree DTS to avoid
> > introducing new warnings.
>
> Yes.
>
OK, I'll send dts changes along with this patch series.

Cheers,
Prabhakar
