Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702FE6591FF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 22:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234168AbiL2VG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 16:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiL2VGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 16:06:48 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9560CD9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:06:47 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id k44-20020a9d19af000000b00683e176ab01so7202849otk.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 13:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+yHonGhQ+U58uUS0jyslPVrKLC3sDduyu0s9k7MuOZs=;
        b=gBmWUGN11WcIq9eznUyhrhXJC+dJMe09abUHO0k06U95JePClNHH2Ur7gB94QY6VQ7
         NAfeKDSwI9yLVpc8jaoNHay0mxrbP2RtT1dbNktLG4/1J1MbJKPzz1rq2pqyAH8lZlL/
         TS6UTi1q1vk3+CRrNfDahlwTWno4JVIj4HK1PWeOzsm8psfdCuOHIPjL8lSbN1aafGYl
         /qdo/VEc0OHf5tW6lWvqqK/s8wlL0082kwsdq4oTnx71rRbqZ2ZG3nS0jv8zoSAc6Z3a
         7hgebQ6/Mec/dljnJq6uSS2p/nUgRqnGL2xyWwXj/de3ynx2ggHviWrsXf+gOkJwQhng
         MomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+yHonGhQ+U58uUS0jyslPVrKLC3sDduyu0s9k7MuOZs=;
        b=dG9JGP4N2UfSbEY7kOVrHd+1OXaQxncrxVXVAT1SXhqpUKUXURmqjsZT633pBHhNT0
         k2UkacPLGXCa3r7lHyeoWExahTx10qltr6Nw8SZ2busmiz9O4qV8gVQ82yPI37AyHvyV
         YUsVSsUAD7NDCQQiadx2uJMExuUZmLhLjjQlLdK9j7BSpvc6wg0f47YpZZKgt9wVv8at
         scwHkvj2qgOzNziiG4DM2dXpjMkqZXRqC43H9ALm5KklTEptnCIIO6dN67ikCRDpsuxy
         d7AJmWRoFbNlp60Ap1poEkRJQPuPLCbzdH9/f7mcjMeIa0eVg1UeiyqbQKMJ+8tYaOsF
         0KaQ==
X-Gm-Message-State: AFqh2ko8tgkD2mLWEKaf5Veg/+V4XcqqtYFlr1i/bP3YBQBA+7lZambx
        AGKW6EgEDR+9HLboxqKhlzsWZzT2qdjTwyosYOuQHg==
X-Google-Smtp-Source: AMrXdXuujWF8gx7voSqxkRTNv1kjsqLg4eRTHc6xFQCHkGHSgzYPaKhgFSkgb1IIJHEJN/NuVzgVX8rLozR+rdb/2dc=
X-Received: by 2002:a9d:750d:0:b0:66e:abbc:cfe4 with SMTP id
 r13-20020a9d750d000000b0066eabbccfe4mr1943058otk.102.1672348007150; Thu, 29
 Dec 2022 13:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20221219195233.375637-1-cbranchereau@gmail.com>
In-Reply-To: <20221219195233.375637-1-cbranchereau@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 29 Dec 2022 22:08:41 +0100
Message-ID: <CACRpkda4NpF9D=1zu6-MU5T9+eoNfSrNhXLUhYJizKmYs_b+jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add support for the orisetech ota5601
To:     Christophe Branchereau <cbranchereau@gmail.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@crapouillou.net
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

On Mon, Dec 19, 2022 at 8:52 PM Christophe Branchereau
<cbranchereau@gmail.com> wrote:

> Changes since v2:

This v3 patch set applied and pushed to drm-misc-next.

There were some minor checkpatch warnings that I just fixed
up while applying. Check the result in linux-next once it percolates.

Yours,
Linus Walleij
