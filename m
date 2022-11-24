Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5CB63710C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiKXDaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXDao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:30:44 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A1B2315A;
        Wed, 23 Nov 2022 19:30:43 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id q127so419721vsa.7;
        Wed, 23 Nov 2022 19:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwRmCRmi3ZvryaL+N9uJcgI/0W3kQm4cItEnoQ4LDrM=;
        b=fOxfeB4ETJvm6TfqH7ytBBCiCu2nHKDm3LqQSsXgcUKYifhoAvLPO0TD5AsfYDqX0N
         3WR0AsxvALUQ9sfH5K3yWb2cEKWA7cwl/rBBDub0gdWzAf7Qc0I40Qh+DGLGIu8MY1J5
         NMHpic69PCqfS0yrlw9VB2N3pCl9EJlgEk1JBq841Cjh/M4r1UJfKyGYVPOdz4mOPYH8
         2/rq7Io/ANn2Hj9Z6oDn9H0ZaN1uP+2ZY4rCbx2GeR/j2FSsG3AEwT686TEQXicNVCe5
         UMeZv6kei9qDHlLWX8M32eKLOv4uwmA+1iyChMlVjYglrl0jBHRfatr5JzN2T6wLbtaW
         yStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwRmCRmi3ZvryaL+N9uJcgI/0W3kQm4cItEnoQ4LDrM=;
        b=4WJQsZLA34Hcbj2jdkKbTwfd8IcZyuTQwcLqaqX948eY1l7+0sBovfak0ejelzsEVn
         ystt+qegF3pu4gOboPcGeAKZ2qUphXImf+BLihLEG7Zxk8i0rz3lYl4lPoB9QzYTc7V6
         mq0dRxG4YF4ypLcmKs8I/utEm31rcGHWlaSH68geT3r2rEgGhPOQESC88LLumzZN1GqH
         3mSKAgBvbyfW9YU5ChYggDlma9wCfRx8SLw9TO7Gf/zuwQnPfMhu+P8/j8c1lUVjqO3v
         wPdlKKvqrK7PfT4au3ykLMzcd5aZsA4jjgnxjH8nCcvRWQ2BnE+oM7a/+dH6ElQYImbJ
         UwHg==
X-Gm-Message-State: ANoB5plU6HkAT21CISDmX2HrMpdU+1J8uCvT0Tn/lDIZUGx2+GGbwZ1l
        TWQJ+WCC+hManiMNkhPIMP/ort36VU5iSANXB98FUKI75GE=
X-Google-Smtp-Source: AA0mqf43DGtDw64RH4d7Xu35K5Ub4Cq6LWt/uNj9Wm2mJNNpKKflKWy33nc8qP3bQDtWGgAXpUgeoto4vGisYt4K9zM=
X-Received: by 2002:a05:6102:1e:b0:3ac:3e44:e649 with SMTP id
 j30-20020a056102001e00b003ac3e44e649mr7818557vsp.63.1669260642313; Wed, 23
 Nov 2022 19:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20221122085724.3245078-1-milkfafa@gmail.com> <20221122085724.3245078-8-milkfafa@gmail.com>
 <78cded0f-c75d-819f-0aff-7e4f3b264f64@collabora.com>
In-Reply-To: <78cded0f-c75d-819f-0aff-7e4f3b264f64@collabora.com>
From:   Kun-Fa Lin <milkfafa@gmail.com>
Date:   Thu, 24 Nov 2022 11:30:31 +0800
Message-ID: <CADnNmFqKt_gVO8zonD3DYvM4PazKjKOgE2j_X8jZjSn9Pc9HzA@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] media: nuvoton: Add driver for NPCM video capture
 and encode engine
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
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

Hi Andrzej,

Thanks for the review.

> > +#define GPLLST                               0x48
> > +#define  GPLLST_PLLOTDIV1            GENMASK(2, 0)
> > +#define  GPLLST_PLLOTDIV2            GENMASK(5, 3)
> > +#define  GPLLST_GPLLFBDV109          GENMASK(7, 6)
> > +
>
> There's a bunch of register definitions. Given you're adding a dedicated
> directory for nuvoton maybe it makes sense to factor these definitions
> out to a local header file?

Agreed. I'll move these definitions out to a local header file in the
next patch.

> > +     for (i = 0; i < video->num_buffers; i++) {
> > +             head = &video->list[i];
> > +             list_for_each_safe(pos, nx, head) {
> > +                     tmp = list_entry(pos, struct rect_list, list);
>
> If we ever get here isn't pos guaranteed to be non-NULL?
> And so consequently is tmp.
>
> > +                     if (tmp) {
>
> Then this condition is always true?

Indeed the condition is always true, will remove the condition check.

> > +     video->rect = kcalloc(*num_buffers, sizeof(*video->rect), GFP_KERNEL);
>
> In practice "small allocations never fail", but what if kcalloc fails some day?
>
> > +
> > +     if (video->list) {
> > +             npcm_video_free_diff_table(video);
> > +             kfree(video->list);
> > +             video->list = NULL;
> > +     }
> > +
> > +     video->list = kzalloc(sizeof(*video->list) * *num_buffers, GFP_KERNEL);
>
> Or kzalloc?

Will add error handling.

> In this function there are 3 similar error recovery paths. Can nice "goto"s
> be introduced to handle them?

Will do it for sure.

Regards,
Marvin
