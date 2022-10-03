Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3595F35EC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 20:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJCSy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 14:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJCSys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 14:54:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF79655F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 11:54:44 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id au23so3393584ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 11:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ZWtjJZk+dGfZ5Cry9jnZ+BrR/YXPmSkUOKLcc77u3W4=;
        b=DY4r3/PicRAOO9FkdHH4rccSAGulqdS9/1tnOHNNVIGd1Ldqq1zVd6/XvoMeQ9W+k5
         wNrTt6AzXUy+hyiINs7EK5KT7PoBRGE1SQEtNiA6rm2wPYr5yjxIvla9g32Dj7XSNkqd
         ONMu0gXko05+tsPCpqfFo/Whw2uEyQjAlMBMilJzrZS+9xG5DwJnlGHJ0V7tChTbpiMy
         QFCf9nbZNFzagzahmVSbmOe2yVUbpA4bNAZgYcvkUZQNK1LmKhGY5HYFTfStwHTFqYcN
         DE+4B1ak8POvVUdq/GtJUzXp5AMU3vWPttE9Rx0p7L/cBOX/cgW8rYqHjkQU3Vlqapyj
         DnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ZWtjJZk+dGfZ5Cry9jnZ+BrR/YXPmSkUOKLcc77u3W4=;
        b=Fb6L/rptsxW1XwmAoHwTVMRl04nmCOFNabVaNP5KUqUYP3fmycrGoMl8ohVoA8Mz3s
         u8YH4BGLo67CGjrf/L5Bd+zXXxFHo9o8sRSJg6pquFq+x+xXHCatIfZX2SfBLzD2Eph5
         +pin7ph4+BSnvpPKbg8yQOBOBqy27G9IJQkf/o9xMvmxf/1YohE/CYenCQg+eOy0Xb1+
         QSIr5Zm27rRYo2Nbn9VjnhaVfCm8T/DSVQEqJzky7Fs2nSJai7rG2WJ7Np9So5C1auS+
         xqnbAbLaAtw2H1hCKERadlUKXQ3ZVSWlCOO4aAe3Gnlvk8kN4zdNOgbwZziEBTo2k2qb
         jNWg==
X-Gm-Message-State: ACrzQf1LeEE+AzmneH/M2OwVY9ycNEcPn5iiBWhCsJivtY67QD1YUbHp
        QugoWq/h5A590wmQ30gdhmF44GHfHpM3EsnjF7zHLNnnMZc=
X-Google-Smtp-Source: AMsMyM5g2fe/v9D9TU86UO8XUkvOTh5zkJrZWXucxKTmYfl8xARkrTTR7rXFy5Cn17tH4Qi/oJCqy5ktrjOgejVUGS4=
X-Received: by 2002:a17:907:a064:b0:78c:1511:a3cd with SMTP id
 ia4-20020a170907a06400b0078c1511a3cdmr3340550ejc.203.1664823282532; Mon, 03
 Oct 2022 11:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220928093103.64014-1-khalid.masum.92@gmail.com>
In-Reply-To: <20220928093103.64014-1-khalid.masum.92@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 3 Oct 2022 20:54:31 +0200
Message-ID: <CACRpkdbZWMk9+wH8ndFEzZyUwKecjNfgT2xJnZEQx0ACPzLWbw@mail.gmail.com>
Subject: Re: [PATCH] drm/tve200: Use drm_* variants for logging
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:31 AM Khalid Masum <khalid.masum.92@gmail.com> wrote:

> We have routines like drm_info/warn/err for logging. Use them instead
> of dev_* variants to get drm-formatted log messages.
>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>

So is this the new thing? We've been through:
- DRM_INFO_ETC BIG CAPITAL LETTER MACROS
- Just use dev_info() & friends like everyone else
- Now drm_info() & co

Note I don't wanna bikeshed about this, just tell me there is
consensus now so we know what to do.

Yours,
Linus Walleij
