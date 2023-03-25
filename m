Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170C76C8CB3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbjCYIhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjCYIhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:37:05 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C715193EA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:55 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t15so3875639wrz.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 01:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679733414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FmwKZTyx9Z9VsH3coz8KtKIUIkVFs5TGDymBrUlW+VY=;
        b=nSdPmhPFeqM8PxiyL9536x3V5AVdqBfQuWHjSiTAfYcThUoM66QHsxP0n0Z56fLjpz
         7LKB3DZyL7KCtPqeznklYToKAdNWtn8kIRW0ytcBeBDKvswcE/WnipOzp7Xhhc7hQX32
         1Y0BqEq002MtCvNmT8ELPVjrxy4PaGYmnsLZXkui50XNGjYJmUpPNsndH7V1TD2K/peB
         4NhxcHoTPzYZ4gMIcfiT+kQwD8LFnlQ//TA4nVL4ZUQ8/ZKNZsaM31ZAEEXvCiufj8Qx
         BskHuet930W06whR4/RdM2imXw1r8C2Dl6v3YOYVXsSHpK+DfEQ/PSrnLyBargQdEg7D
         EswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679733414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmwKZTyx9Z9VsH3coz8KtKIUIkVFs5TGDymBrUlW+VY=;
        b=DRpcU5YfFOab0jrrI5BWLgI+g2uVvmjN1S/YeF5qGpPjPEEUbeLkufbtSpEbXr9/Bu
         9cOiEnLl5YRnmNnfL1YFZVdP6lgmJCKnSm3CNy8zawkmS/PvXW/W5zAq8dZSdUdlW4p0
         AD+L3L9jy9NY5Fa8+8Vz4oSL9U1ZbWPlHV10IQT06q/yCUuQGyh4WHNZhU6hZZMcKslw
         62iRqJbpBT1682U2r8OogmNw9Fdw/euCU4EW/B8jFrd/QkGrhqHEf3YNYukcfsKn2z24
         GL4DaHZxmr2hz0qqF1b+Fn+4FhkZUBlRmKJIqgMZa3AmyKieatuBXw4C4SWTk6XqLiKG
         nqTw==
X-Gm-Message-State: AAQBX9dSSu8l7ZRH5hJOBWmmf29rhUyK+580sATcAgClMgi0/P3sb7MG
        EWsYdNRfd1AQIND4B+MAi9oGHhznWQU=
X-Google-Smtp-Source: AKy350b9CWWzsdEZarwhYE+Q+QjWZTkaNpSjlJgYXcm32An/25brR65A1UXP3A0fnebplApa6Ayizg==
X-Received: by 2002:adf:ee51:0:b0:2ce:98fc:f289 with SMTP id w17-20020adfee51000000b002ce98fcf289mr3790656wro.49.1679733414260;
        Sat, 25 Mar 2023 01:36:54 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm20108204wru.40.2023.03.25.01.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:36:54 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] Implement DMIC support in WM8903
Date:   Sat, 25 Mar 2023 10:36:42 +0200
Message-Id: <20230325083643.7575-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to comments in wm8903, driver lacks DMIC support.
My wm8903 based devices (ASUS TF300T and TF101) require DMIC
support for correct internal mic work. I have used downstream
sources to implement DMIC input support for this driver and
I can confirm that internal mic now works as intended.

Svyatoslav Ryhel (1):
  ASoC: wm8903: implement DMIC support

 sound/soc/codecs/wm8903.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
2.37.2

