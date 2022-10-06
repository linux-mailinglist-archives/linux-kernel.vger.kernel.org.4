Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD15F7178
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiJFW7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiJFW7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:59:40 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625316464
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:59:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n16-20020a05600c4f9000b003c17bf8ddecso1451616wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 15:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=avEX5sX4fWSQDRhQ5zfAho1hTMVB7N6QeUvMMZK6eUs=;
        b=OKIqK8JAjQKBLYBDL7mNsO5e4cDNNxjykGWD5Nnz32y6EU/F65djn2Tl4IcJ+sMQz/
         ks8XmGQzqIaYgDpg4TWW4w1CTVnw8aJi/KtB5jdi7LXyEwjZ3xXy6ruz6/4kQl3NPA10
         kOGbOGS1nn2ykomkEwWdtQTuNdMeKpSLKChixUG3hGANrOxF9XIq7l6pft0Bdwk16gMb
         H6/6tv896O1QHuBSwsdYwN07vzRT0iR+fvpIWfr2o7ZkBr4n2kQ6hvXqKUM024h/8LEr
         Q4PX0iGulQdXxJ5WDP6MTg2oNAeFRAwSilt3iVsrfACACxvFx7G1JjyCDQJDvDAbBU8N
         hzDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avEX5sX4fWSQDRhQ5zfAho1hTMVB7N6QeUvMMZK6eUs=;
        b=Ir8tDbvcH4BsyOlnNFjU+QsIVIQVvHSTYwGlt5Kt/62bjYszt1oUv80vA3nLoi98Et
         /hEKLpKJrMZ3G8QRQIo2Bcq4g2YPy/nGqS5yzI1zk1aVNk4ttqbqy34zFnlFtWFROS4q
         QJt/xt/e/Mz/nMwyCq4aYpsR1X0mv7k2LDu5XD4/XvkDQ/JDF394P6Of5ICT3W7WwhmC
         ktIb6NtDdVfEzGUWbib4Q3LWan3n1ugQXbgdXqzMXU09G0s8cdMb6UEj9BiI/ZKa1Fhm
         keoj9U0R5RHZfLezcQXOPex7ZEB88S23lBK4P9nmnNo2kQ7JDyRI/Ol86gTBj9N9L+D/
         AZQA==
X-Gm-Message-State: ACrzQf3ZQK+zmcr9x1rOoDQq6SWrXd2EqnIWzOKAsjbeGKE7cazTQbJf
        wQog+T3K1fRYbwToCZd274RB67gL5GjrXI+84QjbdA==
X-Google-Smtp-Source: AMsMyM6aKn0eJCmhL/qmPs1UoQzTSUlh8VLvuzERiTJx+Wjq91flrs4ovRZO5TNSUKWy+KWyE8aLgG8HwI6lGRUygt8=
X-Received: by 2002:a7b:c8d5:0:b0:3b4:76bc:5dae with SMTP id
 f21-20020a7bc8d5000000b003b476bc5daemr1335097wml.122.1665097174896; Thu, 06
 Oct 2022 15:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220915004601.320198-1-pceballos@google.com> <87ilkzsd4f.fsf@intel.com>
In-Reply-To: <87ilkzsd4f.fsf@intel.com>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Thu, 6 Oct 2022 15:59:22 -0700
Message-ID: <CAO9JgFyCQAtBVvtNYa-jL5O0mM69g53XEO7DKP9yHXXXBudoNQ@mail.gmail.com>
Subject: Re: [PATCH] drm/i915/display/lspcon: Increase LSPCON mode settle timeout
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 10:38 AM Jani Nikula <jani.nikula@linux.intel.com> wrote:
> Got any bug report with more info, or any other details to back this up?
> This is kind of thin. What's the 800 ms based on?

This issue affected several different CometLake-based Chrome OS device
designs. The details of the original report are in the Google partner
issue tracker (issue # 178169843), but I believe this requires a
Google partner account to access:
https://partnerissuetracker.corp.google.com/issues/178169843

The summary is that we were seeing these "*ERROR* LSPCON mode hasn't
settled" messages in the kernel logs followed by the display not
working at all. We increased the timeout to 500ms while investigation
continued and this reduced the number of occurrences of this issue:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/7b2899fc1a6f9409e8075b3153baaf02c4d1fc75

The problem continued to occur on about 2% of devices even after
increasing the timeout to 500ms. The investigation continued in issue
# 188035814, with engineers from Parade and Intel involved.
Ultimately, the recommendation from Intel engineers was to increase
the timeout further:
https://partnerissuetracker.corp.google.com/issues/188035814

The timeout was then increased to 1000ms:
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/a16cfc2062e768c8e5ad8fa09b8ca127aa1ead9a

I recently ran 100 reboot trials on one device and found that the
median time for the LSPCON mode to settle was 440ms and the max was
444ms. But we know from the original reports that even after we set
the timeout to 500ms the issue continued to happen on some small
percentage of devices. So this is why I picked the larger value of
800ms.
