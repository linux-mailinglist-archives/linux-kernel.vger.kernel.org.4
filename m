Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3088F6E2897
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDNQog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 12:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDNQod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 12:44:33 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D4399;
        Fri, 14 Apr 2023 09:44:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id t16so6640256ybi.13;
        Fri, 14 Apr 2023 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681490672; x=1684082672;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wAR/IhYKHH1BsY9u5IUy+to3NaysIuJyB5TWYLo5Z2o=;
        b=jgw1Egh6P42XBDZUFH+yg9daQykHh6AKCpRtaq6i5d4z0SWxmXJyC9Ok71sjyVJicP
         RH0LiE+vojnEARQ3en7nskrXoVorpuhZsO6RVEjD6Hd7cGPy1Mso0rRHFXbReMsQg0FN
         yeJNpcibVJauTioPVRICssqgXafWOHvPSioGpa2B9C2StgTlVITvv3v3zq8YTkD4GeB0
         vHroOVsE1GKuENDRzg5oW4ZQ6Vv6YsOTXyREFE0yUj62ejLMAM+wv+x1HnzCat6TIMLD
         llKOWTBiF8xXdHmCjzxT/VlB+3XMij+gEX/usmx7hOr15yqX+RcOwuELD8kZAc2odWZ7
         csSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681490672; x=1684082672;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wAR/IhYKHH1BsY9u5IUy+to3NaysIuJyB5TWYLo5Z2o=;
        b=LgmlyJ0lXkRHIVbkJpDmIyQRc0ksVz7O00GKwnJwSpH2hEKY6l9/sFVX7+/V3zx3D4
         txNbXEgnGCT/CN1EfgTUkLbh3LGc8ugMEuYEkMvp6FZSa4aiZUIMp4iMT5Q8+6fmiVxz
         +fTZGVn78NWYIsUGSc1ck99lcZ8CXZygZBrUnPoItWZsL1W6tP8lIblaAvNXpguJhDt+
         5jR4a5WcVwMFS7ula10zZrIrwrSPDhaU2AKc8OFqOQMpB77BERfnh8V2WqqteN59ni9R
         TiemVzAKKThoS94rrKZg81HCugiMzUUExLF/vMtK0p6CttHhSb5KvCNxXJvKU/4ODoJc
         ED5Q==
X-Gm-Message-State: AAQBX9eFLnij8KnYk0SJScHRw5gMCT4FcAjUfT2UhND9FD63Yio6VXo+
        u6si3XgfSqSysK++tNrtSF+Ww9NypsovY5r9Yfi3o5UyBXw=
X-Google-Smtp-Source: AKy350b6HKZpFDxiN5KzVpVKgpmCmXy2oMcSdfGc7Ag0RnI02naKR3BtgrOX0ebmblQon+UaUXKyGFl0WOr0lQxaQKw=
X-Received: by 2002:a25:74d4:0:b0:b8e:cb88:1b8a with SMTP id
 p203-20020a2574d4000000b00b8ecb881b8amr4185958ybc.8.1681490671882; Fri, 14
 Apr 2023 09:44:31 -0700 (PDT)
MIME-Version: 1.0
From:   Muni Sekhar <munisekharrms@gmail.com>
Date:   Fri, 14 Apr 2023 22:14:20 +0530
Message-ID: <CAHhAz+gCGi3i9c4KLt9V+RhQypn7RXrfMnH9LJCTty3K_QTGFQ@mail.gmail.com>
Subject: ALSA: struct snd_pcm_hardware.formats
To:     alsa-devel <alsa-devel@alsa-project.org>,
        linux-sound@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

struct snd_pcm_hardware.formats (SNDRV_PCM_FMTBIT_S8,
SNDRV_PCM_FMTBIT_S16_LE, SNDRV_PCM_FMTBIT_U16_LE,
SNDRV_PCM_FMTBIT_S16_BE, etc.), are these sound card hardware
capabilities or something that needs to be taken care of on the
software (driver or userspace) side?

-- 
Thanks,
Sekhar
