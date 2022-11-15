Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A0762A461
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiKOVm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238517AbiKOVme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:42:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F86D2E9D8
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:42:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt23so39490061ejc.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Nl9X2dBBteRxXc88z+X5/Ev/rJGuG6QGv1Den2poAo=;
        b=QwtGfdLExqGEA3JBttYR2zaNYjZe26Vt6/fFPWMuk54OnoMDs1FRgye8GpGvi457VX
         Ehd3UvkUHaqnWVtNl5Yhok3ciBieqGeJ9smgarRrEGrMZD8wJ+RyK21O1kVfszahcKAQ
         1JfCR6GMKLmQcAF9S1lxq4qq8ETCraVQ14j3eil805xRkwv8JB1xNJfzM70HMHId4Jt1
         PnNeXtzsgQz4YFIlo84bs2XPdiyl8yg7hne1bsU55rk10UVgYx+/WPW3qNUlFy+MHL95
         y6N/nWy8aDChycA4rZleL+UpFoFcldr4dg3+v8PTbq1siLVeRsRHll6eGEfTe1Mtm8Mc
         kP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Nl9X2dBBteRxXc88z+X5/Ev/rJGuG6QGv1Den2poAo=;
        b=ejRF+kEBeHt9F2ddRyE2KNflWHpApqgxrZl7UQmiiczPitSCZdwMG1gQjRPx0y9jxe
         TJGz4yVILnHnpVdLS7odsg4tuJEP+A/1nNPBIHJ2pJKsY2B3bi5I/HWCbOnMbtonwRtW
         7dYyHVsWvKjyDR4hTqzxIue7h+Jd+RhE/tZ9INJF1M7uoyN8yb4xClUGo2e8AnSg24jC
         5QCSY+JdWZpyZmhIseFRHA8gh5pPy5CJ+kzvTi+GuAVJdNN0uQe2m+m0zzcl7U70loLE
         1ElltUBmdQShWxPVXc54wwgQ4vWEc1ExUfTLA4mkggEDmcYfHvYlsOL0Y/C/N1bjzqV3
         Il/Q==
X-Gm-Message-State: ANoB5pnD4Zlsr4Gq+cJzD7tYITU7/HYReQM24bEFkXOf0W8b9fNw108c
        rdCAOzZN6RdW6jg3yfvJsuJ0qoYBO+SBeLSTbP8iDw==
X-Google-Smtp-Source: AA0mqf4Cv2JnITywTHhrkvL/GTP6vT4b3f6IswQJeiG7a8Mg9w83igu2bpdNd9+ZL4uYMG7Wi/gfCKeZ/s/hdK39c9A=
X-Received: by 2002:a17:906:4911:b0:7ad:9891:8756 with SMTP id
 b17-20020a170906491100b007ad98918756mr15884330ejq.203.1668548533646; Tue, 15
 Nov 2022 13:42:13 -0800 (PST)
MIME-Version: 1.0
References: <deab9696fc4000499470e7ccbca7c36fca17bd4e.1668458274.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <deab9696fc4000499470e7ccbca7c36fca17bd4e.1668458274.git.christophe.jaillet@wanadoo.fr>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Nov 2022 22:42:02 +0100
Message-ID: <CACRpkdY4+FtRc63GY_A2Gwr-cstMfsMvojHmQ_o2UQP0ymasig@mail.gmail.com>
Subject: Re: [PATCH] usb: fotg210-udc: Remove a useless assignment
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 9:38 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:

> There is no need to use an intermediate array for these memory allocations,
> so, axe it.
>
> While at it, turn a '== NULL' into a shorter '!' when testing memory
> allocation failure.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Fair enough!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I have sent some other cleanups to this code only
yesterday, so they might collide and they you might have
to rebase.

Yours,
Linus Walleij
