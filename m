Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FC76C2560
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCTXE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCTXEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:04:53 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A1F311DC;
        Mon, 20 Mar 2023 16:04:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id eg48so52922765edb.13;
        Mon, 20 Mar 2023 16:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679353491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qEmpGt53dG1aAw90RrCeKMXIYvRU8CrcxjpKorHZWHQ=;
        b=JIxCsluKKeA8eGbygKJZnSHIniF9YGj5R9z0IGKjE8bPbvCnXCvWHo3cPw+vn8quXR
         jGX/JXXa9m1eFNLYPNiq3S8g7yGR8GfdTHMEwOdB5RevVqdeDzKMJv++Yd5wSYP1sWFf
         qppmyjvcX/St6BzgvLg4EI8jJbRDsoLQssKaEF/UNQccmOPd8cgBiRlN8hNQxRaZLmWV
         zPJ3522sHxKIrzDJ+VqSp5k1iidtZPxnHFBjojhrUJKa+14yc1vcOdcCO/evvaID35dY
         qT1gW0HWj2Z6Lf3J4NxATpTMO5QQaA9zHEfb9bEfwPEgWFN4DiSL6beZee/wmQvrqQLV
         4Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEmpGt53dG1aAw90RrCeKMXIYvRU8CrcxjpKorHZWHQ=;
        b=Nx0wmShWu+rMMCE8sXTebXehovv+N14b4tcCwczgx6QkFeCiqgcU7w5YWEI8em1MVX
         SQLQK9EE6D+Kq4RjZPbhuwwjA+ujH4HTR6bWET9DyO4Q5ISoQkmPncRV8M47KQMGqYy9
         fckeIURWdv3IWPIs6Im7wyYs906fkU7j/O/5wTWfBPWHiltdkv/2YBXTb+3PP+DMVIE1
         jmwzvSpRL5AAum/GK+MQArs4yEEYG1gTRyKuQBZRIIcF2QLcC6L+wRoaKWluUQ/Kdv0Z
         84sPZe9fPBYZhpYjAdR4ysf3NAbdPodpgq9/nU+W/6TO/sX1XFM8FL2N7lPPnMDnRkeQ
         Uvvg==
X-Gm-Message-State: AO0yUKUfe2rAG4nPEol2rexpGdaVRkTylNUjoTMSFa/hgeT9zyd/u5ne
        FNynGK/4dAB/1LhdCeGXGINkq3laGo0=
X-Google-Smtp-Source: AK7set8bY4tQsS1n+cgIsIxiNbFRE4fOIz/6KbVW+k1ZEK69W9k81Dc5IwLOmPxCmyDgXD8b8PVhaw==
X-Received: by 2002:a17:906:fb0f:b0:8f3:9ee9:f1bc with SMTP id lz15-20020a170906fb0f00b008f39ee9f1bcmr1282495ejb.13.1679353490905;
        Mon, 20 Mar 2023 16:04:50 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id v5-20020a17090690c500b0093188e8d478sm4956403ejw.103.2023.03.20.16.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:04:50 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        vireshk@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-pwm@vger.kernel.org, eng.mennamahmoud.mm@gmail.com
Subject: [PATCH 0/3] edits in greybus driver
Date:   Tue, 21 Mar 2023 01:04:31 +0200
Message-Id: <cover.1679352669.git.eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset includes change happened in greybus driver in three
different files two of them patch one and three related to 
checkpatch issue and in second patch convert two
`container_of` macros into inline functions. 

Menna Mahmoud (3):
  staging: greybus: remove unnecessary blank line
  staging: greybus: use inline function for macros
  staging: greybus: remove unnecessary blank line

 drivers/staging/greybus/gbphy.h                  | 10 ++++++++--
 drivers/staging/greybus/greybus_authentication.h |  1 -
 drivers/staging/greybus/pwm.c                    |  1 -
 3 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.34.1

