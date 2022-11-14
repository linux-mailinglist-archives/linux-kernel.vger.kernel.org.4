Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C459627D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236062AbiKNMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236659AbiKNMEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:04:30 -0500
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1E5CE32
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:03:47 -0800 (PST)
Received: by mail-vs1-xe31.google.com with SMTP id t5so11148121vsh.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gpdanuSwwO6X3X7T6r4R8z4NqpyKIrM5g/Eo+jbe8s4=;
        b=qTU0knnzgVorZuppvxBh4xwHQOp02pgeF6gbZoD+ipfckmrFcp2kWD++6KlgM2XHj7
         5w2On67PQ/+Uw3++eStaBdXi7f0vkT/XfZIO4zkPFWQCkiN0FFrYLK2obcMNcASXBzMX
         aUPVWrqC3hBIg2Wy308gRoVlICevrJszIhe3WvyB0BpSGJKxPkJV12Qk/m8B23tfv0GX
         0f3BYFBDg3hfaNhmBuUZCp1nL1Hi06cCVrk1aNkjCmgYUxBs1MLSqbo+n/lcWmDpaY+y
         Zse47tNU+zmAXkQBV78b8QvnXxOiVK89BsdpknG2pRJ3hyTiYHdGM7JG7Z+kcpcJ7K4h
         jvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpdanuSwwO6X3X7T6r4R8z4NqpyKIrM5g/Eo+jbe8s4=;
        b=PjwRpIVlJW19xY/HNRwTl9q0MMqgjRVKBYYbm1i2EqgdvRf0LnSMguIjJmdrp8uq2Y
         DZ7J9+3Tcj9B7k+24s1o+8CFexRQmLaV/eQyjyiTpiTu2lp4rwyF9j4g10uCSXwfGluK
         vVzM54WAzSOePCwTto5zZDC4Frl76XKbsySh8BF4pclY2F4EOFkibn1RkNNJf9S9EeIq
         Rl69p50cnNv2Xu3snjdMkXhWpr7a7R+sd16rLpy7Xg3pW65NPpl2fSQUtDg0JiihsCA8
         9U41ztm3N5Ov7rspP8TcghiCcIm6LluswUozpCDdT2LScSNgxeWTiew9IH31dV97sy8o
         mdSg==
X-Gm-Message-State: ANoB5pnpY7mTM0azhdLUfpIyVl1jXecTEf2nW4gO6ivUoo4n0rkfx+Zj
        Jo2Q1tDDznZwR+2nRtC8CnBrGM5tgwUWAYY8zbY=
X-Google-Smtp-Source: AA0mqf7pkKuFk4tE9fl+T9CticDFgkHAKochY0B2QzfVfymqfKAPEq9f8MR4s10cLi8hp5eVpX//sJkwwr8ixMAWUdw=
X-Received: by 2002:a67:c415:0:b0:3ab:89bb:2066 with SMTP id
 c21-20020a67c415000000b003ab89bb2066mr5717549vsk.21.1668427426182; Mon, 14
 Nov 2022 04:03:46 -0800 (PST)
MIME-Version: 1.0
References: <20221027073200.3885839-1-nunes.erico@gmail.com>
 <20221027080519.lfpduyt7jcwh3b4k@vireshk-i7> <CAK4VdL2V+Rnpb-rr=ov_81GUTDt=6i+6QRnKaYztZ7xfkvmMzw@mail.gmail.com>
In-Reply-To: <CAK4VdL2V+Rnpb-rr=ov_81GUTDt=6i+6QRnKaYztZ7xfkvmMzw@mail.gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 14 Nov 2022 20:03:34 +0800
Message-ID: <CAKGbVbsLS7PdePan+fPkVhtexc36CViC7iREdcwR1+vnjLxrwg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/lima: Fix opp clkname setting in case of missing regulator
To:     Erico Nunes <nunes.erico@gmail.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-fixes.

On Mon, Oct 31, 2022 at 6:35 PM Erico Nunes <nunes.erico@gmail.com> wrote:
>
> On Thu, Oct 27, 2022 at 10:05 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> Thanks.
>
> Could someone take a final look and apply this? I don't have drm-misc
> commit rights.
>
> Erico
