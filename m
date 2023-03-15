Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C096BBBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 19:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjCOSU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 14:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjCOSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:20:22 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758D856AC;
        Wed, 15 Mar 2023 11:19:45 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 921EF378;
        Wed, 15 Mar 2023 18:19:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 921EF378
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678904381; bh=j5FgemK+JDdaFLaY3yStR1MCa6tiuLuhfjdneBnCDDE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=FswdtRSc+3jEJEJ+5cZqKM0mUX6YwkltD9Nuds7UZy2B+5OSBPHX0BMlPzWxAffqQ
         NemgWW/RX0RXiD93F99+5+pp+kMYpVm2zrQLQPoqRcZ4/vRwsOQHG0lg0qQ2bN/hti
         bQsRzBQ3o7qmkU+fsmGKm0otoEzHY5hMqGBIgKPrb0LkmcVRiPx48FxhZ11zxypAMD
         zEK+xOGsrt81lEmWy7EcmI+LVrVbkuuDepMGyZ1aH2SFzX3sUo+pGjbNE1zCiHQBil
         ufJmvdYxci6ZawuEqII8405pLEfffUdfJexXz+ZyPhBe7WUnn9m+VyIjkwAvBfDV6B
         vy7RG8kT4zBQw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthieu Baerts <matthieu.baerts@tessares.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Kai =?utf-8?Q?Wasserb=C3=A4ch?= <kai@dev.carbon-project.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, mptcp@lists.linux.dev,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Subject: Re: [PATCH 1/2] docs: process: allow Closes tags with links
In-Reply-To: <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
References: <20230314-doc-checkpatch-closes-tag-v1-0-1b83072e9a9a@tessares.net>
 <20230314-doc-checkpatch-closes-tag-v1-1-1b83072e9a9a@tessares.net>
Date:   Wed, 15 Mar 2023 12:19:40 -0600
Message-ID: <87zg8dop1f.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthieu Baerts <matthieu.baerts@tessares.net> writes:

> +In the same category as linking web pages, a special tag is also used to close
> +issues but only when the mentioned ticketing system can do this operation
> +automatically::
> +
> +        Closes: https://example.com/issues/1234
> +
> +Please use this 'Closes:' tag only if it helps managing issues thanks to
> +automations. If not, pick the 'Link:' one.

So if there is a consensus for this, I can certainly apply the patch.

I do think, though, that if we accept this tag, we should ask that it
only be used for *public* trackers.  A bunch of tags referring to
internal trackers and such aren't going to be all that helpful.

jon
