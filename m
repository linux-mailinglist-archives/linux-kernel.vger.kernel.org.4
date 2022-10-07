Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800C55F72FC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 05:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJGDEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 23:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiJGDDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 23:03:49 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5910ABD7A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 20:03:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w10so5297331edd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 20:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6/aYioF4N5ThTyHVeNoYcSeTR8mlwsDHQnEmk6vsWyk=;
        b=gmrIKuwlQuZQtmboltbIB71xhEuRmUxCcRm4pm4YJux0WLpJoGR+6eRFJsaQE9zGtC
         XzDK8wXvny2ImNsTZEgNZwcdguv+LMBc8HtsRdImlL0gKToERpQuLPjZNr4RstlniC4n
         6FsV9tryo2dVcOmp45gp9fqHJoiR1QqYowXRPzHjimTp/TKy0K9Wiv1wJd0t+J+d8z1J
         LHlr6K0B1+EVEs/c6ttJW0XqWVhwDYG8XQL1o/mPEG789FmVTx9RfQCVrFwJT5ekK0sO
         JbPDTjw2AFxxlqxNJfi8iO71gWbCU0T7jlJ3gfOPc23zS+7TbBCnG7Ekt3SiFvLRgD03
         buzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/aYioF4N5ThTyHVeNoYcSeTR8mlwsDHQnEmk6vsWyk=;
        b=IVVCu5rAilMDbsugU3neQDsoCqP84c8CtND4Ot8RwD/94zvaDVtqlluXA858/PwUq3
         tity9MmmNrjXPtZthaoya2f3UOugNyHPZKnv9tKljfxE/seiPJ16/oue/2CtwSQPukeh
         8Zm6/prUGprtIQ9AhS4CYTX+TKhJbXWtQ9XrFawEtCJd3C7R1WYK4C3seUcTJ+mIRd5n
         /Z3NqFpbEfke1q5rZ92r9qiUs0JI/CR3331bI6hwH6yEMMXtyXHtRMpwrglY71gZcDLD
         9/rAUjBNiI+elSEXQ9jWoxA2U1FOcS7hsxKtzAdjaO3hsMzNpYek1vp6NIn2QdPBeR4/
         uMkQ==
X-Gm-Message-State: ACrzQf2Y7RVO8wtQBtj4VZSrO+Ga77JlNC6+Vn5X5Rbg3PdP6hK6y9P9
        B7q5kZJ1wYVrSuIjMTaZzHScSVm27B5DdWxpqoyk5BiWCNw=
X-Google-Smtp-Source: AMsMyM6PQJQsK3xI5al/3JWJB4uphl/G9uZ9iXZo9hJPw8zdzuPKbI4MsJQgPVjzUaBLaivCBPEqBPo0K/0usIHWE80=
X-Received: by 2002:a05:6402:5c9:b0:446:fb0:56bb with SMTP id
 n9-20020a05640205c900b004460fb056bbmr2647543edx.173.1665111817323; Thu, 06
 Oct 2022 20:03:37 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 7 Oct 2022 13:03:25 +1000
Message-ID: <CAPM=9tzQnonp1KDSZ7ziUNdm8EfJX=VhmE9gA4L8wDO_AoYLuw@mail.gmail.com>
Subject: [git pull] drm regression fix
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
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

Hi Linus,

This reverts the patch I found with rough bisection to instability
around fences and the oops I got from netconsole.

Christian, I tried the two patches from drm-next, but the oops still
occurred, a good reproducer for me was to run vulkan cts with
deqp-runner in parallel here.

Regards,
Dave.

drm-next-2022-10-07-1:
drm fix for 6.1-rc1

sched:
- revert patch causing oopses
The following changes since commit 65898687cf7392c372ea8d04a88617e2cb794465:

  Merge tag 'amd-drm-next-6.1-2022-09-30' of
https://gitlab.freedesktop.org/agd5f/linux into drm-next (2022-10-04
09:42:24 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-10-07-1

for you to fetch changes up to bafaf67c42f4b547bf4fb329ac6dcb28b05de15e:

  Revert "drm/sched: Use parent fence instead of finished" (2022-10-07
12:58:39 +1000)

----------------------------------------------------------------
drm fix for 6.1-rc1

sched:
- revert patch causing oopses

----------------------------------------------------------------
Dave Airlie (1):
      Revert "drm/sched: Use parent fence instead of finished"

 drivers/gpu/drm/scheduler/sched_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
