Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296D56EFF05
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 03:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbjD0Bne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 21:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242556AbjD0Bnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 21:43:33 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99630CA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:43:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-94f7a0818aeso1224483566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 18:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682559810; x=1685151810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TLWZrM6G4E8kyAJ3+hqX8NPwV4Y3xpLTC/w/EM11mYI=;
        b=PJQiXtBkhSZjq404pH2L5nHxMU/QJEmILV0rBc0uWQuEX/GZtcH58vHc7uzQbb+jpz
         fblEUhBhdAdu6zHxhPwKTwHHwuA3m4mkN3Xz1T7Wzhc/eu9Tzi3TtQ72Zlr5GRI8oXjw
         C438pR63pQr3HQMfR2MbA6GiI6gPYaaFoenbwMPSk7X8gRv0WX4vSEORCmnoDEubwAxz
         a41w5GB95N0ooQR/g+PiLDTkMicsmyxxM6ddmrtwJ0FGmD/oaOgElOjwEjuqF7QmyGFX
         Uc9vS50wwK/JaMnmgAvrdyv9V7vyy+mc5ngjAVhXG7uNRzVisVmM2crM0dN+62EuGzkr
         Nvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682559810; x=1685151810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLWZrM6G4E8kyAJ3+hqX8NPwV4Y3xpLTC/w/EM11mYI=;
        b=lh/fIMWetcswtMZ75CIRD6NgIPQ226EbhxQ/NfpMAhty9oY/XdZu27OP3ko6ie1B3I
         sU/aXwL6eGL5tWtokTPdwTiZ7hzoU7SiyuBD8gWElJwrqsI8mvpmr39GwBzfto1h1Rnq
         Ww6+jzU9jP+qNQiJT7mifTvoEL0THgCJx4DZeA9au5qa16g+CHH0qxsWy03SmMdJtXnV
         OyOuU88w6MInxedS7JxjobVlnBE0AByfUBsqgRk6xd06cuK/saq2V0HoGDew7GFvHn8i
         Z2z6AChhz9FIF1T4HkhZ0rTcgyqVBU132fMwExfNhMJCef4TU+NaqxEQuLey3GcH1U9E
         7hyw==
X-Gm-Message-State: AC+VfDwzfY2SMwq0KdyXwsqw6MeEIOQ6ZRada+wKRGeqnYBCiVwUKmVf
        /+XySTOjmhSpxjGnUGG9HcRGu/9SN+MimE+1uOBtSzY4SRwFWQ==
X-Google-Smtp-Source: ACHHUZ4DbuKsaZlJwyNtmw3hFB9SA23R5V7wmj7FOeBjSn9C9jyPXXToChmHTrrxjqwCTmipfDvYt7b42di4zffByGA=
X-Received: by 2002:a17:906:eec8:b0:953:8322:a99f with SMTP id
 wu8-20020a170906eec800b009538322a99fmr67601ejb.0.1682559809797; Wed, 26 Apr
 2023 18:43:29 -0700 (PDT)
MIME-Version: 1.0
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 27 Apr 2023 11:43:17 +1000
Message-ID: <CAPM=9tw2xUZQJkzmt5aj=F8erC3cv9aAB+KqTQgn7=B7D8haFA@mail.gmail.com>
Subject: [git pull] drm next fixes for 6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

A bit out of routine fixes pull for rc1, there's a build breakage on
some platforms due to ttm, this has that fix + qaic uapi removal +
minor panel fixes.

Dave.
drm-next-2023-04-27:
drm-next fixes for 6.4-rc1

ttm:
- Fix TTM build on archs where PMD_SHIFT is not constant.

qaic:
- Revert uAPI from accel/qaic.

panel:
- Improve error handling in nt35950.
- Fix double unregister in otm8009a when removing the driver.
The following changes since commit 289af45508ca890585f329376d16e08f41f75bd5=
:

  Merge tag 'exynos-drm-next-for-v6.4-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos into
drm-next (2023-04-24 10:50:15 +1000)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-04-27

for you to fetch changes up to cf03e2956af307dc25e8c41fd4cffe44482a6ec1:

  Merge tag 'drm-misc-next-fixes-2023-04-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next (2023-04-27
11:29:34 +1000)

----------------------------------------------------------------
drm-next fixes for 6.4-rc1

ttm:
- Fix TTM build on archs where PMD_SHIFT is not constant.

qaic:
- Revert uAPI from accel/qaic.

panel:
- Improve error handling in nt35950.
- Fix double unregister in otm8009a when removing the driver.

----------------------------------------------------------------
Christian K=C3=B6nig (1):
      drm/ttm: revert "Reduce the number of used allocation orders for
TTM pages"

Dave Airlie (1):
      Merge tag 'drm-misc-next-fixes-2023-04-26' of
git://anongit.freedesktop.org/drm/drm-misc into drm-next

James Cowgill (1):
      drm/panel: otm8009a: Set backlight parent to panel device

Jeffrey Hugo (1):
      Revert "accel/qaic: Add mhi_qaic_cntl"

Konrad Dybcio (2):
      drm/panel: novatek-nt35950: Improve error handling
      drm/panel: novatek-nt35950: Only unregister DSI1 if it exists

 drivers/accel/qaic/Makefile                      |   1 -
 drivers/accel/qaic/mhi_qaic_ctrl.c               | 569 -------------------=
----
 drivers/accel/qaic/mhi_qaic_ctrl.h               |  12 -
 drivers/accel/qaic/qaic_drv.c                    |  10 -
 drivers/gpu/drm/panel/panel-novatek-nt35950.c    |  10 +-
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c |   2 +-
 drivers/gpu/drm/ttm/ttm_pool.c                   |  30 +-
 7 files changed, 21 insertions(+), 613 deletions(-)
 delete mode 100644 drivers/accel/qaic/mhi_qaic_ctrl.c
 delete mode 100644 drivers/accel/qaic/mhi_qaic_ctrl.h
