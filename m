Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF1C67A69E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 00:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233791AbjAXXDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 18:03:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbjAXXDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 18:03:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5EE49548;
        Tue, 24 Jan 2023 15:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F9A7B81717;
        Tue, 24 Jan 2023 23:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AC5C433EF;
        Tue, 24 Jan 2023 23:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674601423;
        bh=FInAJGM6hitQqEWREbqfiZT6RW4VKmJRYiGIyELSJQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VDav27OxxZTsAQgsUUqCRxbi02UJHTXeQ4BNvRR2EVcVurslbfZQ1hQbAIbZQ0Dfe
         d2YSKzxKcs/H8PX8n256ShJsj1Yt/HpEuQvjdnXNW7LxK4qClB/5cWjD9N85pUzOHq
         f9gUdwmJmO9TH4Nu6ulKdR7s5iitURCwPLteuRHaK6g42tTBOlrwyVzrc/b54PXQrm
         FbSFiUK1nyUKX9eWCnkged8yubqQAufRoj0a6bqC3EvH/1rfsEWHb0Tb9HTxrVTird
         q9ZhjkXbmN7rMAWQP3zs8stWUwCCsCvl/nEQ1sr2UBHleUHB7lQ7F6o7uEEzUcCbTU
         KQ4JYbXPqsgEQ==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
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
Date:   Tue, 24 Jan 2023 23:03:40 +0000
Message-Id: <20230124230340.113608-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87a627ftuf.fsf@meer.lwn.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jan 2023 15:31:04 -0700 Jonathan Corbet <corbet@lwn.net> wrote:

> SeongJae Park <sj@kernel.org> writes:
> 
> > Some subsystem documents are missing SPDX license identifiers on index
> > files.  This patchset adds those.
> >
> > Changes from v1
> > (https://lore.kernel.org/lkml/20230114194741.115855-2-sj@kernel.org/)
> > - Separate from index file content changes
> > - Separate patch for each subsystem doc (Alex Deucher)
> > - Use MIT license for gpu (Alex Deucher)
> >
> > SeongJae Park (8):
> >   Docs/crypto/index: Add missing SPDX License Identifier
> >   Docs/driver-api/index: Add missing SPDX License Identifier
> >   Docs/gpu/index: Add missing SPDX License Identifier
> >   Docs/hwmon/index: Add missing SPDX License Identifier
> >   Docs/input/index: Add missing SPDX License Identifier
> >   Docs/mm/index: Add missing SPDX License Identifier
> >   Docs/scheduler/index: Add missing SPDX License Identifier
> >   Docs/sound/index: Add missing SPDX License Identifier
> 
> So I've applied patches 2 (since I wrote the initial file) and 8 (with
> Takashi's ack).  The others are also fine, I think, but I hesitate to
> apply license texts to files without knowing that they match the
> author's intent.  I hate to say it, but I think the best approach is to
> send each of the remaining patches to the appropriate maintainers for
> the subsystem involved.

That makes 100% sense, thank you, Jon!


Thanks,
SJ

> 
> Thanks,
> 
> jon
