Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6AA62954C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbiKOKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238135AbiKOKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:07:44 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE100C0C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:07:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id g12so23179733wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q2Q6yJygbHr4Zzn8DwsSexLuA37VlJWO80Y9Cecq2Tc=;
        b=ldTcu4lAZ9Nb1vfUt/8/tmhk4NLnsg+lnkGw6d/E9P+LJjF3f+p9ctzhpWJXLt5f5g
         iMS6Q6Izmo8ZK58YP8pPEHOGd9uqfnpGmRsChbbdnRTE/eFd03CUTEhNHUvpV52s9+HX
         fFth3Dnr9DDF+lAQMFsaEMq6kCJEHkOnVPawj61VZRQ66gzXWSFhIM/6GyekX+XiiDly
         Gwky9iImKC0fHf2nuJgmshPawDEWg1TUz39ei3Y6dJL7lwMQmLwI+lDm4Pj0z+KaUD2V
         AibrEaryl9/9hzJHaLYq3dnnsL+fZ9i+JQP1tckJDkgq4KalyMgHmvZO8+73CrIbbbWP
         iEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2Q6yJygbHr4Zzn8DwsSexLuA37VlJWO80Y9Cecq2Tc=;
        b=mCzraCEViyVzw+QORVYvrx3Hc92wbEKRpfAnJGzBd3XC06N5V5xFazejGlzTzbJfPs
         FKfCnwJQyI2ZD213j3RugqjoIg3UVXCASTUZ8PjgJexyQGUMa5jrTGi1VqNJtzO84nWc
         XOCjZoBP/HxMT+WsRsevNZ3SraSO6jqom5/NsNvcHTZ4lof8HWhcOogEcDT1dUsttiRJ
         f1AikhrxB3wpGhhLz6J0zwXIaM6c0ujeMbMx2BgACwXF3D3mFShxJ7y/gg7cWES0Q97+
         FQmoIk7BHMJeT8AZxu6Nu/kmvZL/fZSmBh86ILSPoHK+bpR8yZ+ZnxhiKHlnSsnp9qql
         skVA==
X-Gm-Message-State: ANoB5pnxEvXxNdR7X8B6vBUMPwoRx6+E+eRus+YoPc7bjcqwXuDxpGIk
        7rDDy5zrr+70GurBl4l13Lw=
X-Google-Smtp-Source: AA0mqf4DIb09ZJ8bJgz2g4Qcxd7TZcE+jJufPZvq/psp84nQCJJJjtYxQO79PXCgKWFWpUDQxfriCw==
X-Received: by 2002:a05:6000:137b:b0:236:59ab:cf32 with SMTP id q27-20020a056000137b00b0023659abcf32mr10145821wrz.629.1668506861535;
        Tue, 15 Nov 2022 02:07:41 -0800 (PST)
Received: from arch.localdomain ([119.160.120.210])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003a3170a7af9sm16577154wms.4.2022.11.15.02.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:07:41 -0800 (PST)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCHv2 0/2] default driver params and phonetic spelling while arrowing
Date:   Tue, 15 Nov 2022 15:05:28 +0500
Message-Id: <20221115100530.91174-1-mushi.shar@gmail.com>
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
