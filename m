Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0573C60EC03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbiJZXE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbiJZXEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:04:25 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D6D1758C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 16:04:24 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so2836613wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8J4HR94C6CytlEgPPH3UzuFzQgZKA2q0qAfjJCCQDVo=;
        b=KMOGWKe5pbx2OHD7SeQZ+vmsD5Z2cjqHBl4dT3rpRSXgUKsb31bLjR24AVTRsuktzO
         MkV+mJppJ2y7o7eOpaKmY6k2uMQlYbRi08g5JqHaX3RgoOgVfQEo5bWkKsSBq8AWKJkW
         ladODhW1gISm56tz7INFlETjArkfIa6SD41VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J4HR94C6CytlEgPPH3UzuFzQgZKA2q0qAfjJCCQDVo=;
        b=p+LZqUF2taIE32wCqnMeIZeejTQGQcA286LDFWCT7r+OCttt0fyRt9S7IaB0X/N9xk
         NS1HzoWjwCwmIs5wi+tdReptFPr0jdbe+XkSsgAxZ7aqeSB/oNzWKZyB0iGLzyAAhN0d
         f1pEe0+cnEE4TyBbIjajUmCOHa0bs88q6ihPoEnPXZ4QxRJZOoewGgyqgtAQ0d+Bo8l2
         ejYPRbPtX3z5qEialREBR0SRSnxnc7dYWlRlRP9JtNsF8yCAhGYAlZNPXv/7PhWVyqyD
         2hfjUNFuesJMakwkRCzXNWAmP0ERVny4vmFwwjHvEwllrMtccZ7xD+Fl1OfdPrdUTRWV
         6uCg==
X-Gm-Message-State: ACrzQf0KmTmnD/cW2YCOy9hJhJ9IMxy/ZYo6IJqUrPtaNr8kC32wB6I2
        Q9DiL9hV/GHIxsRUc1ijknza/EyWfwkAODpxPrH9VQ==
X-Google-Smtp-Source: AMsMyM6n1CDhA06FDaawyOojqQup/+/t9ECUWMEIUXhTkL0k29z3MqZbywYRmKKHEleWjnQwul0R5/hki+RpLhSWMEw=
X-Received: by 2002:a05:600c:1d1a:b0:3c6:d715:2d69 with SMTP id
 l26-20020a05600c1d1a00b003c6d7152d69mr3941641wms.145.1666825462508; Wed, 26
 Oct 2022 16:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220930220606.303395-1-jwerner@chromium.org> <8489ce0a-3278-5509-4f82-f3d9d5ddd4c0@linaro.org>
In-Reply-To: <8489ce0a-3278-5509-4f82-f3d9d5ddd4c0@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Wed, 26 Oct 2022 16:04:10 -0700
Message-ID: <CAODwPW9S+6Qh1zMxzXWFkd6d1kdOWpTOe4S1sZB8hvQ-36MbNA@mail.gmail.com>
Subject: Re: [PATCH 1/4 v5] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> For the future, write cover letter which describes why you are doing
> this. You explained the "why" some time ago in responses, but all such
> information should be in cover letter (plus the applicable part in the
> individual patches).

Sorry, I did write a cover letter here:
https://lore.kernel.org/lkml/20220831013359.1807905-1-jwerner@chromium.org/

Are you saying I should have kept resending the cover letter on every
new iteration of the series? I thought since we were already
discussing detail questions and there seemed to be no general concerns
on the series as a whole that wouldn't be necessary, but I can keep
resending it next time if you prefer.
