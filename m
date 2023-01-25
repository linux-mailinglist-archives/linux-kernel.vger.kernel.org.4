Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE29567AFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjAYKiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjAYKiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:38:07 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16131C154
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:38:06 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4c24993965eso256986967b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=odxE+/0tpdyoRm8qkT42p6042uj773CpM5pTyPAni5g=;
        b=Gk0KIMZLiGWr1Ssc+TpmExGW2squacCg8tqyAtNIBX3nvFXn8i5GiFD396KFi5qJOF
         u+MSWTgm1mplmHP+ytFfTfvNK1bkBH4EZUmPEV4ShC723oiaHrAW1ZCRfZ3F4o2evH1b
         /bet1XoGawqak2cSOdayBMhNRZZSjZAh9/nFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odxE+/0tpdyoRm8qkT42p6042uj773CpM5pTyPAni5g=;
        b=g73z2jkgZXqYfrqs0HFhvVW4RyRBlN8DaOQECmlkBl3mpnoSvprKXZIHZXxnHe9oij
         GZ2GOTFMueuN6HMFZXNQvNW0tJweJ2F/xSlVR9S7nTlZ+YRtpb7vtKvgwzu1bHhpd576
         cky0uvc2gxAAVSOCcd5xyYq18g2TG14Snynn9ZBcSaeWtrFzoxwIbM4DItqgHRMqpRNQ
         /VvxaygJD/p2w+MKImf3/QjMNjmhg5i+454N6zHxZja7MdjHJII6/CYKMo4o4dKbVCOe
         Z+K+YsTrQQdRI8CLCD4gexzeG3hU4iKWlY9rvPf7/oLx+fepa1Ss56OCcZkcPL2ZRgB6
         qDQQ==
X-Gm-Message-State: AO0yUKWN27q08a954zL6uCYPX+sxJP1uQCVcd68P6SrjHht9Zff0S85R
        6lb5ZJw34Nt3ZcpoUKCBM8+yNSr0fdzcVpCzh3+5ChrLWtNOBCBxou4=
X-Google-Smtp-Source: AK7set84nDUF2Ddilsop1Z0UvuPJMppKyWSdyNFlhI/pWiiqqDPbTa3H4PPPLTqvWj0AzBM2pd6P5ooUH9I4IaWJNJk=
X-Received: by 2002:a81:7302:0:b0:506:52b5:94e2 with SMTP id
 o2-20020a817302000000b0050652b594e2mr613326ywc.230.1674643085291; Wed, 25 Jan
 2023 02:38:05 -0800 (PST)
MIME-Version: 1.0
References: <20230124233442.22305-1-rdunlap@infradead.org>
In-Reply-To: <20230124233442.22305-1-rdunlap@infradead.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 25 Jan 2023 16:07:53 +0530
Message-ID: <CAMty3ZDkVZpSnD8HMXLHUjSOimE4eSMYAy2rr6vmB7t-Rk0R5w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: Kconfig: fix a spelling mistake
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 5:04 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Correct a spelling mistake (reported by codespell).
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
> --

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
