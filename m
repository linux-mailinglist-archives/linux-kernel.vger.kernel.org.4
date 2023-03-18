Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAD16BFB0F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 16:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjCRPAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 11:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCRPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 11:00:06 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFAC650
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h19so8666377qtn.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 08:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679151603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0O2Se05WZykb6gnl2tgkCz0qj3TrHgbValu61eHs1Ig=;
        b=f1H3d6rT8sOXwm8g5R2YhTL5c6LGovcedBeMAXNfaa0gdFKC+ddWlepsEY5T0+7KS1
         ZOhYfeyHEmtkcUn+DnZl72OWv0CYuxCndrWZSqeSN+2b73ladCEqw7xpAd+QNkLAzwGp
         yrJZePsSofZvzjAyzVK9vqdaqohQl0ZAl9zKxSYHfDBaPeCJOKrXHYlrjrQyn6+ET8Vz
         /68JLo2HE8U20FCK/kj2xjHBQ9nkq3P/Cy0bxeqcoeEwfqETlyyL0mI2Pvq9ToDDfBqK
         a6ZITvdLt0PAs6fPgTv64fV2Y45x+sOcH8vtfIfPNyAPjEkBUUU6nh63aBdmZG2U+Wug
         UnJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679151603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0O2Se05WZykb6gnl2tgkCz0qj3TrHgbValu61eHs1Ig=;
        b=Njhhqn2OuwRbKtB0fVTmMzQkORoWnm4wunzBBx9EQprCAKykN45VOVXMRBONCX9UOM
         hv2n45mUghlqwe5ofQ64Mxuo+aXToeS4VTnwmCFvoS9P7GtSdW9vbLcqFSL2HqVRx8fo
         gSGHdBVhn8PvjEHkqo4kybjlNWWhSfgfaYeX+EegiiEF8ve9J2Xl3kpuD5tncajFbVl0
         ZmLDVVAawEuTN0tx5d+mdVVr8dNclI9vOByU72Z3wVy+NSeLEI112zZjmiQYovgI+gf2
         XgQXLC5wDEEKAzWPO4rA/23RCApvkW6wKUhMbySKvgRy5FqRmotDksFrst71S0/RDMzj
         pOpg==
X-Gm-Message-State: AO0yUKUJw9G2iQGlfOaBq4qkgo9tS0TVwLzqf2TL0obH920VpXgNLqmw
        +5XARqI+XKb4SmAWJAjXMUazoQxiShCWSS6uUJU=
X-Google-Smtp-Source: AK7set80/4ii9N8RbVKZ/Jx8z5jCS6iho/1z5zvzCd4CEPc3rQ4iSkcD42pxAoO5p+QgvaZ8MIA2kA==
X-Received: by 2002:a05:622a:1106:b0:3dd:eed:93b3 with SMTP id e6-20020a05622a110600b003dd0eed93b3mr3557058qty.46.1679151602759;
        Sat, 18 Mar 2023 08:00:02 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f67-20020a37d246000000b00745daadd210sm3709162qkj.71.2023.03.18.08.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 08:00:02 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 0/4] Refactor 104-quad-8 to match device operations
Date:   Sat, 18 Mar 2023 10:59:47 -0400
Message-Id: <cover.1679149542.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 104-quad-8 driver was initially introduced to the IIO subsystem
where it didn't quite fit with the existing paradigm [0]; these
differences eventually led to the creation of the Counter subsystem[1].
As a result of its awkward beginnings, the design of the 104-quad-8
driver was structured around maintaining abstract state buffers that
would eventually be converted to match the actual device registers
states on-the-fly as needed.

The original design approach for the 104-quad-8 driver was neither
efficient nor easy to troubleshoot, but it did allow us to focus on
implementing and supporting necessary APIs for the nascent Counter
subsystem. Now that development for the 104-quad-8 driver has shifted
to maintenance, it is a good time to refactor and clean up the code to
match closer to what is actually happening on the device. This patchset
is an attempt to rectify the situation as such.

The primary change is a transition from maintaining individual
configuration states independently, to storing buffers of the device
register configurations. To that end, the bitfield API is leveraged to
access and retrieve field states. Modifying bitfields is a common code
pattern so a FIELD_MODIFY macro is introduced to facililate such.
Finally some helper functions are introduced to abstract the handling of
the PR, FLAG, and PSC registers.

Modifying a buffer state in-place is a common pattern, so should we also
consider adding a field_replace() function similar to bitmap_replace()?

[0] https://lore.kernel.org/r/b43e2942b763b87afc85bfa9fe36e5695cba4c44.1475079578.git.vilhelm.gray@gmail.com/
[1] https://lore.kernel.org/r/cover.1554184734.git.vilhelm.gray@gmail.com/

William Breathitt Gray (4):
  counter: 104-quad-8: Utilize bitfield access macros
  bitfield: Introduce the FIELD_MODIFY() macro
  counter: 104-quad-8: Refactor to buffer states for CMR, IOR, and IDR
  counter: 104-quad-8: Utilize helper functions to handle PR, FLAG and
    PSC

 drivers/counter/104-quad-8.c | 526 ++++++++++++++++++-----------------
 include/linux/bitfield.h     |  18 +-
 2 files changed, 283 insertions(+), 261 deletions(-)


base-commit: 00f4bc5184c19cb33f468f1ea409d70d19f8f502
-- 
2.39.2

