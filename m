Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1495467A5C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbjAXWbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234613AbjAXWbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:31:14 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEB851C53;
        Tue, 24 Jan 2023 14:31:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9F7B699C;
        Tue, 24 Jan 2023 22:31:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9F7B699C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674599465; bh=XqcEf/qNRLT2aV1bbKur1IhHtd76BW7B0JhjDT5HwFI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZApMAIuRAyoIabeOgjAMNxRwU/2kNRV273PbxciM9O36U73aGeWc/DO8VSevQ5rCi
         ROCdgLKEh6MVSCZ5u8GADIkyUrD5ZeCNS2hM07r9fheqr0U3WWgS6Q4C7HlU/Kv8r+
         Y9Yn4Me05P5ArehCeyXNdZO9UVEdpjoo5PM451G3BC3P9e4tmpgD1L0I+S2JVd/iTH
         cn6xIDH7KqfMZIFB7H6VJoGNaZoZ0SFwmbUDNL6cOGUEQJCESq1Asb8q6SRkvhXpJw
         4k8RsMK/Umllp9557D2GafnWs/7OYF4E6yf+4AUSiK4TCgxYIXpuHfEVLzO8bLfGv1
         YHORfjJnVTYTg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jaroslav Kysela <perex@perex.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Docs: Add missing SPDX license identifiers of
In-Reply-To: <20230122213650.187710-1-sj@kernel.org>
References: <20230122213650.187710-1-sj@kernel.org>
Date:   Tue, 24 Jan 2023 15:31:04 -0700
Message-ID: <87a627ftuf.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae Park <sj@kernel.org> writes:

> Some subsystem documents are missing SPDX license identifiers on index
> files.  This patchset adds those.
>
> Changes from v1
> (https://lore.kernel.org/lkml/20230114194741.115855-2-sj@kernel.org/)
> - Separate from index file content changes
> - Separate patch for each subsystem doc (Alex Deucher)
> - Use MIT license for gpu (Alex Deucher)
>
> SeongJae Park (8):
>   Docs/crypto/index: Add missing SPDX License Identifier
>   Docs/driver-api/index: Add missing SPDX License Identifier
>   Docs/gpu/index: Add missing SPDX License Identifier
>   Docs/hwmon/index: Add missing SPDX License Identifier
>   Docs/input/index: Add missing SPDX License Identifier
>   Docs/mm/index: Add missing SPDX License Identifier
>   Docs/scheduler/index: Add missing SPDX License Identifier
>   Docs/sound/index: Add missing SPDX License Identifier

So I've applied patches 2 (since I wrote the initial file) and 8 (with
Takashi's ack).  The others are also fine, I think, but I hesitate to
apply license texts to files without knowing that they match the
author's intent.  I hate to say it, but I think the best approach is to
send each of the remaining patches to the appropriate maintainers for
the subsystem involved.

Thanks,

jon
