Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C6E677E94
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjAWPCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjAWPCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:02:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397017DB5;
        Mon, 23 Jan 2023 07:02:38 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8D62E4E5;
        Mon, 23 Jan 2023 15:02:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8D62E4E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674486157; bh=wxSnxIUwdkEE3c/KbtJ9Rj/dEJdzd01IhaDBd3YRbOA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NmRRM54uhrNW9CPQE0Rj7FopmjfzAKSU48AkFmXI0PBahR3aZFhVv/eI2ez+LoQdt
         GAwYh6oeA5wECwc1VQwN51GdGKYJ3pRv9sjFAyB5PU6NyuPRJB5Fj49M9rtpAg90hA
         mGPUpT3XUv7qqmpuYvcPec8YgT+TOBIcluJ1TZ6CAVlJnVS8pi6FNVqF+QhufMW4B+
         FV+OdLKAsAKEypABjdte4J85m/2O/g6sbTnwMqgqCRN+jZ4f78bASoJqxscJz6dI3F
         Hho+mHPNvcZo038OgNds35wZPvtdAVg0kaVxnJntVPoQ1g5X7wLgwH/M1nzD8v/OGH
         XykY+7P/t3Ggg==
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
Date:   Mon, 23 Jan 2023 08:02:36 -0700
Message-ID: <874jshl2er.fsf@meer.lwn.net>
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

Documentation/ is far behind on the SPDX front, and I'm all in favor of
fixing that.  I do worry, though, about sticking license declarations
onto files that did not previously have them; do we know what the
original contributor's intent was?

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
>
>  Documentation/crypto/index.rst     | 2 ++
>  Documentation/driver-api/index.rst | 2 ++

I added this one, and GPLv2 is fine there.

>  Documentation/gpu/index.rst        | 2 ++
>  Documentation/hwmon/index.rst      | 2 ++
>  Documentation/input/index.rst      | 2 ++
>  Documentation/mm/index.rst         | 2 ++
>  Documentation/scheduler/index.rst  | 2 ++
>  Documentation/sound/index.rst      | 2 ++
>  8 files changed, 16 insertions(+)

Thanks,

jon
