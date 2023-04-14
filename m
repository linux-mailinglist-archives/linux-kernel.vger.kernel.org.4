Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596E26E24E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjDNN5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjDNN5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 09:57:04 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53ADDAD25;
        Fri, 14 Apr 2023 06:56:53 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-94e8cdbc8ebso145259166b.2;
        Fri, 14 Apr 2023 06:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681480612; x=1684072612;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bOEwGTl98moAzUqFvKFWIb6Loh6mr1V32EmboH3l9A=;
        b=fE49pmr1+3Hl8g4lgmjlmNOKUY7c/TKGWGQv+Ry4iX3AgUZ9T6dXiJJiabmSwIB8zP
         0TXriskpjRXR2ziu9atDIJ8RbJTkcFGWQNJxBiTPx64gz0BLQ4Am8DdSWsyBrQfHRAwa
         vy+C1n/NaTIRAsC3l2ebE0lCWnHGec0vBGmJUeQBrEDRw4j8KAsLIERiiBLA79X+TwJq
         GhEHuu1lqa+RMGu02NlYvt2RZhEiPpJSowxk4rDojrfJxlq787StQaQc3YG86RPf/G3R
         MTCwx0OsPNfQKBoD1NCTZ/CjgXd06jLHwMF7wKzUw55iOqZQs8x/4523V1hKZw3Qf9HR
         Fbig==
X-Gm-Message-State: AAQBX9cmnySYRgaS1lHaBH/H1TRU3YIb6z0wNK2OLQwGN99IP+OY2GJp
        7B57e9icLcqJYEnd5JudtY6RlVdexX3nQ0RgCIE=
X-Google-Smtp-Source: AKy350b1aVA3LMIUWUKT/nUV8ETtU6j2DCW33hhtAn5L65SVKqzNVEwGAXX5BT+cXNEhemr1nO/9E7TYGoD4LqoODSM=
X-Received: by 2002:a50:9e45:0:b0:4fa:3c0b:74b with SMTP id
 z63-20020a509e45000000b004fa3c0b074bmr3122390ede.3.1681480611819; Fri, 14 Apr
 2023 06:56:51 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Apr 2023 15:56:40 +0200
Message-ID: <CAJZ5v0j9EZH-9DJzqGE+q=sB-y5FeZUv3k=X4BgkthSg-PFx3Q@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v6.3-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.3-rc7

with top-most commit 117e4e5bd9d47b89777dbf6b37a709dcfe59520f

 thermal: intel: Avoid updating unsupported THERM_STATUS_CLEAR mask bits

on top of commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d

 Linux 6.3-rc6

to receive a thermal control fix for 6.3-rc7.

Modify the Intel thermal throttling code to avoid updating unsupported
status clearing mask bits which causes the kernel to complain about
unchecked MSR access (Srinivas Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: intel: Avoid updating unsupported THERM_STATUS_CLEAR mask bits

---------------

 drivers/thermal/intel/therm_throt.c | 73 +++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 7 deletions(-)
