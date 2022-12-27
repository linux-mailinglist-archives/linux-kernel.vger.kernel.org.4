Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F56656CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 16:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiL0Pz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 10:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiL0Pz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 10:55:56 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE89DC0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:55:55 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id x44-20020a05683040ac00b006707c74330eso8384443ott.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 07:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fe45rFYfSm2HbigixmWKAkwrW9ACl6r8YGAqEd7Zx00=;
        b=lujBgaGh9t1eTVAiI3m+hTSpzZ+GGGMLGHOhLQy02BjUC/3zs6dh825vM6jbzAspGX
         BCCSn3nP62rmMdM3zOi3HE74FBAOnllRboZWf7yPgS5x73NISahYQHI9Ifp6mCT4P1Gw
         LRRIIEcs/6Xf/13AKyvLbT/kbSzVuvzMVVMkfmoA3uj+JYYOoFTszPvOAVzbQgFxi/JG
         LnvAKGRI4GPMKyAK/bROcmRVNCFmX/xtvIzftM+TI4uKDCHGWzLTyWr8MlkwVTurgYal
         VY2RLlnK5jrZL+YfnhacaGL+sEzhYZRQdC5Pg+jQCtuyGwxP3HwP0mX5aZOGE28u4eZ7
         n5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe45rFYfSm2HbigixmWKAkwrW9ACl6r8YGAqEd7Zx00=;
        b=tHafEIoT+hgJy3FfxG2bm33kPNy01xcHR041uC74Gd4N25mO/nb6D1TprK5NOCNGwP
         JGtiW3PZeVCbduKZzCaa+ihsNw3uYhSQqwCwR0jfDdvgvJ0fcabVbbcuHGTy5gVv+f20
         Q5dWWvFoNKz6eHH6XQvDsQhpigXXqc5aYbYxid3rWRQM6HUlRzv06vfJn8nxh5IVQrZE
         WEN88l6iPSVYcTK763aidJBbuGjvheRNApsYpfns6cJRFX2idFytXPypRGkdZQ54UqmZ
         YPzivSVag62SHDxA2D5E76IgIsnUL6ro9/hlOB5xdCfKcyXxwMLRXGhgqbkDE1FL1w9R
         cMsQ==
X-Gm-Message-State: AFqh2koJ9qcU9qLNFSILx+oshNCdx2yB7B72FtcXjiUxW+S77jy0evI2
        bjAJ7mID5Ig6OZnMIBMsPes4La1GTpwBaA3YASo=
X-Google-Smtp-Source: AMrXdXvuSoSdQsOkCuE55fO4itoYf8YbnH0Qj1pGcdv+byyJE+7NaYkg7O2fC/C1kB89A5ox7l1i2EKoUOPcIQovYh0=
X-Received: by 2002:a9d:6ac6:0:b0:671:cacb:681f with SMTP id
 m6-20020a9d6ac6000000b00671cacb681fmr1424604otq.233.1672156554384; Tue, 27
 Dec 2022 07:55:54 -0800 (PST)
MIME-Version: 1.0
References: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
In-Reply-To: <3AFB9142-2BD0-46F9-AEA9-C9C5D13E68E6@live.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 27 Dec 2022 10:55:43 -0500
Message-ID: <CADnq5_NiDE7a5dmhhuLntQe88DS5JmiZTGqQ6ongXuWyh1A4wg@mail.gmail.com>
Subject: Re: [BUG] AMD Radeon Pro 5600M with 8GB of HBM2 memory shows blank
 screen on Linux
To:     Aditya Garg <gargaditya08@live.com>
Cc:     "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

On Mon, Dec 26, 2022 at 8:19 AM Aditya Garg <gargaditya08@live.com> wrote:
>
> The AMD Radeon Pro 5600M with 8GB of HBM2 memory GPU is found in MacBook Pro 16 inch, 2019 (MacBookPro16,4).
>
> The GPU fails to work on Linux, thus a blank black screen gets displayed on boot.
>
> If nomodeset is added as a kernel parameter, we are able to access Linux easily.
>
> The link below contains the journalctl of the failed boot :-
> https://gist.github.com/AdityaGarg8/dfe1a1c23bf2b92b640dad89f55b73c7

Can you file a bug report:
https://gitlab.freedesktop.org/drm/amd/-/issues/

What sort of monitor are you using?  It looks to be failing mode validation:
[drm] Mode Validation Warning: Urgent latency failed validation.

Alex

>
> Thanks
> Aditya
