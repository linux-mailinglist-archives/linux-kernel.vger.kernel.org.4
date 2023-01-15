Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9211866B223
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 16:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjAOPgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 10:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjAOPgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 10:36:18 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CE05B83;
        Sun, 15 Jan 2023 07:36:17 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id j16-20020a056830271000b0067202045ee9so14887309otu.7;
        Sun, 15 Jan 2023 07:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pRCLnfO5D50aLUIqRH3Be5ElBGG7mevjFvkDgjByEkg=;
        b=ESYN/lgtsCJz1vk5hIWF8P0XT3zE4HOkfbCef61dEh9nfpUszGpqaILDdbRYwRpBaS
         Gq0n3cdms6iw0aRSFDJpioaByPmQbKCQP0DMmTGvyCsapfKPYKjs4KTwwNR87Zitspdn
         tniK5INo56zs/GSaaJc39/v4ceiIJC1pB59guwU6dk/ST7wHrW1GsjBxDt0fMLpUe9Og
         1v9Whb4AApgIKVhjQbVH2MHL30mD29abfoMS+VPtLoheVkY7LhOupZe8UcHafZllZEmR
         Q02XH5CuaiXHw9on84tyYVxbzt6ZWhdpxJ/RGI0Gk5dJ5RFTO2+nukuT+lKm/LaCi8GD
         Tvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRCLnfO5D50aLUIqRH3Be5ElBGG7mevjFvkDgjByEkg=;
        b=g9f7Piy/Nq3PFywGEVd18+BFVQ/jYGX1rjf15FY+4/ZsQXR3JUOzNER+Nr/dyI2qqK
         t0dlW65vbjI0IDyRgVfUEtEyQM8AFmMLMjT9CbadShDF2l8c13GPt3ANBv6UkjGS5WHq
         LtenkYbMBb4+ipZy0V6N6XbZjg6Ku1c1VaYVIJ4bXqp3T5WMHNwNq1BaATKDkVutPFq6
         MNZAtO3KdB6uaeLXDfoksNRnarhsMv2vxefCJ61+ICYmJ/VTgoKb2oxcNcKK+kv/mDXD
         A6u9O6fRVDwF/u8O22CGHXYS9FzjEqKrMn8icCiirhgA56zBwVYAXt+RHj/7cLmh8lVq
         QaOw==
X-Gm-Message-State: AFqh2kpqpxwuVaqZTqlWgYBWAlX9LSol4gywmZC0biwr0sjd5Pyyrc35
        Tq09VdHwZIX0WGG1AX7ic8ms9/QsdsQQtwGhCv4=
X-Google-Smtp-Source: AMrXdXu/zET195jKhsFTVp5xxmwIScKWmACgEKUi1QrBdrbk6v28T2qMy0jJBHOkkSBc+MnjFZnNZuARMBSt9P0VdRA=
X-Received: by 2002:a9d:489:0:b0:684:bedc:4f54 with SMTP id
 9-20020a9d0489000000b00684bedc4f54mr837621otm.233.1673796976794; Sun, 15 Jan
 2023 07:36:16 -0800 (PST)
MIME-Version: 1.0
References: <20230114194741.115855-1-sj@kernel.org> <20230114194741.115855-2-sj@kernel.org>
In-Reply-To: <20230114194741.115855-2-sj@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Sun, 15 Jan 2023 10:35:57 -0500
Message-ID: <CADnq5_OUnkzoZcCdW0X-=gJsXSRgY=GLrbmfNj0geDCzL5a7eQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Docs: Add some missing SPDX license identifiers of
 subsystem docs
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jean Delvare <jdelvare@suse.com>, linux-crypto@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-input@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Guenter Roeck <linux@roeck-us.net>
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

On Sat, Jan 14, 2023 at 2:48 PM SeongJae Park <sj@kernel.org> wrote:
>
> Some subsystem documents are missing SPDX license identifiers.  Add
> those.

It would be good to split this up per subsystem.

>
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  Documentation/crypto/index.rst     | 2 ++
>  Documentation/driver-api/index.rst | 2 ++
>  Documentation/gpu/index.rst        | 2 ++
>  Documentation/hwmon/index.rst      | 2 ++
>  Documentation/input/index.rst      | 2 ++
>  Documentation/mm/index.rst         | 2 ++
>  Documentation/scheduler/index.rst  | 2 ++
>  Documentation/sound/index.rst      | 2 ++
>  8 files changed, 16 insertions(+)
>
> diff --git a/Documentation/crypto/index.rst b/Documentation/crypto/index.rst
> index da5d5ad2bdf3..95b0870e09b8 100644
> --- a/Documentation/crypto/index.rst
> +++ b/Documentation/crypto/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ==========
>  Crypto API
>  ==========
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
> index b208e0dac3a0..7a2584ab63c4 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ==============================
>  Driver implementer's API guide
>  ==============================
> diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
> index eee5996acf2c..ff06a6b12c5e 100644
> --- a/Documentation/gpu/index.rst
> +++ b/Documentation/gpu/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0

Most of the DRM code is MIT.  I'd expect this would be MIT as well.

Alex

> +
>  ============================
>  GPU Driver Developer's Guide
>  ============================
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c2b3c1a822dd..2186d732654f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===================
>  Hardware Monitoring
>  ===================
> diff --git a/Documentation/input/index.rst b/Documentation/input/index.rst
> index 35581cd18e91..d60bf9cfe005 100644
> --- a/Documentation/input/index.rst
> +++ b/Documentation/input/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===================
>  Input Documentation
>  ===================
> diff --git a/Documentation/mm/index.rst b/Documentation/mm/index.rst
> index 5a94a921ea40..c4e9fbacaf38 100644
> --- a/Documentation/mm/index.rst
> +++ b/Documentation/mm/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===============================
>  Memory Management Documentation
>  ===============================
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 1aac972a652f..ae0229f5a9cf 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  =========
>  Scheduler
>  =========
> diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
> index 5abed5fc6485..7e67e12730d3 100644
> --- a/Documentation/sound/index.rst
> +++ b/Documentation/sound/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  =============================
>  Sound Subsystem Documentation
>  =============================
> --
> 2.25.1
>
