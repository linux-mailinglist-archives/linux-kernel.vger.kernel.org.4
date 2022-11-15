Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9376294BF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbiKOJrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238074AbiKOJrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:47:16 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6BB23143
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:15 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 129-20020a1c0287000000b003cfe48519a6so2970951wmc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Q6yJygbHr4Zzn8DwsSexLuA37VlJWO80Y9Cecq2Tc=;
        b=FV5VwkZ1IfZRjMUjtq/DHYtS/RW1pivwQ8//c0u0hu14GYGpHTmd95HIOr7jRaKbUA
         vNuBOuGLWkLTRqjss8D8OPL5qNy8CkKpr1yBuODs4VuRNo2sr8BOw80VO4OQFBrWkHqG
         qx/ooriXmH8sErwGh1TZzUDB+UM8hiTz6uuUA+4At7AU8nkJPw8QhgwoF/SmFvxO1J40
         bm8ztUfrFGFwHMJrhL9FHxM6C6J0onJLRl/VPFgy5v0mA5oGX2B3bIXwML6ai8aMrG7Y
         2KmdjJCK9DBnV8PyVexQJdB/eQQnljf6itmQDiSjZLc52LJappSwr705q2zgcDJydMrH
         4v2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2Q6yJygbHr4Zzn8DwsSexLuA37VlJWO80Y9Cecq2Tc=;
        b=gafc7/eybVp5hDTExuZ37vLF1cNCKQsS1fKpQiEkSUyILFy8ClPkuY3s1wqKwk2rBa
         VotmifpEC70m+O1GxlERx2vHP4ydf+gSNbh9nEapD/2/gJjceqEmehPcITjJ7tiBxLY2
         I3luGuN+Iwq4h1M4knVWZa5Bf6Sw0FCQOpYW6hmJ8xIH7G0UeAS5BWl9rLcrDQQzaaqI
         lWv4HUtCnZpJ+XVCat5tXEu3uTYd/5rYB6f7HcLqOauDAgXKBk3ablL4AB1wJaKYDd+w
         8Rnzuh7X1ZsfORUX74F3WbP9nPvPOX/80il7Gr2L9pQvxETAVYJq7GWxJ018K3oREQtC
         AEYQ==
X-Gm-Message-State: ANoB5pmR5kQKfV9fFm9ei2baq4jgvdEwps9E1lsq1GeMmXk7tMyrdVvC
        p+Hruf+LzukEKc0YQZiLnoQ=
X-Google-Smtp-Source: AA0mqf4sOhhZhW9MgZUEy3zA93GOm3U2EjHeIRIUEb91/i2CI3qerYmnzX/KpsAWS+vPtUAE8jgJHw==
X-Received: by 2002:a05:600c:3acc:b0:3cf:a3e0:73e4 with SMTP id d12-20020a05600c3acc00b003cfa3e073e4mr180675wms.21.1668505633519;
        Tue, 15 Nov 2022 01:47:13 -0800 (PST)
Received: from arch.localdomain ([119.160.120.210])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d458e000000b0022eafed36ebsm11904866wrq.73.2022.11.15.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:47:13 -0800 (PST)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     okash.khawaja@gmail.com, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCHv2 0/2] default driver params and phonetic spelling while arrowing
Date:   Tue, 15 Nov 2022 14:48:10 +0500
Message-Id: <20221115094812.81632-1-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.1
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

This patch series allows specifying default driver parameters for speakup
as module parameters, and includes an additional parameter, cur_phonetic.

cur_phonetic is necessary to introduce an enhancement which allows
speakup to speak letters phonetically, when a user arrows a
word letter by letter. This functionality can be enabled
by setting /sys/speakup/cur_phonetic to 1.

When cur_phonetic is set to 1, speakup will speak letters as
phonetically when arrowing over a word.

This does not affect when a user is typing but only affects when a user
is arrowing over a word.

When cur_phonetic is set to 0, speakup will work as before, it will
speak letters normally when arrowing over them.

When a user does not set /sys/speakup/cur_phonetic to any value, the
default value is 0.

Only accepted values for /sys/speakup/cur_phonetic are 1 and 0.


1. It indexes spk_vars by an enum and allows specifying spk_vars
as module parameters.

2. It introduces a new variable cur_phonetic in spk_vars,
allows specifying it as a module parameter as well. It also makes
cur_phonetic accessible in sysfs at /sys/speakup/ as all other
spk_vars. cur_phonetic can be used by users to enable phonetic
annuncement of letters when navigated by the cursor.
 It also documents the cur_phonetic in
/Documentation/ABI/stable/sysfs-driver-speakup.



since V1:
	- removed unnecessary lines


Mushahid Hussain (2):
  accessibility: speakup: Specify spk_vars among module parameters
  accessibility: speakup: phonetic spelling while arrowing letter by
    letter

 Documentation/ABI/stable/sysfs-driver-speakup |  9 +++
 drivers/accessibility/speakup/kobjects.c      |  3 +
 drivers/accessibility/speakup/main.c          | 72 +++++++++++++++----
 drivers/accessibility/speakup/speakup.h       |  1 +
 drivers/accessibility/speakup/spk_types.h     |  2 +-
 drivers/accessibility/speakup/varhandlers.c   |  1 +
 6 files changed, 72 insertions(+), 16 deletions(-)

--
2.38.1
