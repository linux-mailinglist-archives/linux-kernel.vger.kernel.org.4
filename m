Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080A7641475
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 07:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiLCGRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 01:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLCGRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 01:17:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E88140B1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 22:17:05 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t11-20020a17090a024b00b0021932afece4so10209704pje.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 22:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWHy4LSWfbG3UbLnEYU1lddWQD7NxoRBXBkZf7NJaq0=;
        b=Y8mIF98OAkQn1548VV0fJrwva7hbWILj1DDI8/FZ8U4mognnaifodvSjq9k5OtVywn
         XlY+DNTWFUFOkcXDU5yf8eqJQJlE7bpj63vDYSE3Symp2wf9HlbVWdEWDaskcjO5DVBc
         ByWTPFSZiwrQotHzc+bA3tjCerzcWGdIFF/O8cku1qkn9pZtI9EjFkInfsgP16qnVsgh
         pjeb8yjZ/hebennxOwWoVVcPodk/RwjhZf8xIsS9JIrgM2OlmVAs82yKM2lMxk6HXJma
         JOVX40yCu5NrCU2qbxX4kpX+jaGate+MUTXabn0SdKbgL7AewqD+6Y9dWzSRD/RVookB
         UuJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWHy4LSWfbG3UbLnEYU1lddWQD7NxoRBXBkZf7NJaq0=;
        b=SX7kHQ00QpmBLRl+bIkR1IK1X9THmJ3q7aaBrOOP7Z8zQy8Eb5uGpeGG7H0LJE67sN
         N16CTNMsFklEQVgeLe+3MuViXrjB77YcjCbFWC1ZuZkcpQ2cpSionnnsNFFDo9eRUMfM
         BMKYcMHoR/tqL2atge1oH3cLYFFhd6WfJEqayIDjwDF3qfdLFvUw30LqI+MWDA4hKzmL
         +LZDXSj16ZxI66n0tZqAVLbIHmiq7qT7AnNwKVLJ5nwMSnCxp32ShR7fLP1m3dpW/Kv3
         FFWx70yPVkCPWwboY0EiDO5mDZb/ATQ6eaq/cJIHBV9WRDfmdIfsL46TKSOmh6iFNopU
         PtdA==
X-Gm-Message-State: ANoB5pl6xLNqcN221SB00qbhzI6EK7JHwK91O7StAa3ROqp1QP3TZGH6
        wZKCGtvrxz4BA8Fyu+Pl9R8=
X-Google-Smtp-Source: AA0mqf4U3a61fhwVJZmegC9LzWWxUr0Ji7q4jwJbYu+txOORBjAPXhu/DaT21It5ScCayY/I2f9nOQ==
X-Received: by 2002:a17:902:ecd2:b0:189:5f79:6ac2 with SMTP id a18-20020a170902ecd200b001895f796ac2mr43665887plh.132.1670048224818;
        Fri, 02 Dec 2022 22:17:04 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id v7-20020a631507000000b004788780dd8esm1778313pgl.63.2022.12.02.22.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 22:17:04 -0800 (PST)
Message-ID: <2d54b0bb-9252-a4be-7de5-a5b1bf7f2c37@gmail.com>
Date:   Sat, 3 Dec 2022 15:17:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: [GIT PULL] extcon next for 6.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v6.2. I add detailed description of
this pull request on below. Please pull extcon with following updates.

I'm sorry for late pull request. If possible, could you apply this pull request?

Best Regards,
Chanwoo Choi

The following changes since commit eb7081409f94a9a8608593d0fb63a1aa3d6f95d8:

  Linux 6.1-rc6 (2022-11-20 16:02:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.2

for you to fetch changes up to 5313121b22fd11db0d14f305c110168b8176efdc:

  extcon: usbc-tusb320: Convert to i2c's .probe_new() (2022-12-03 15:03:40 +0900)

----------------------------------------------------------------

Update extcon next for v6.2

Detailed description for this pull request:
- Replace irqchip mask_invert with unmask_base
  to remove deprecated mask_invert flag for extcon-max77843.c

- Convert to i2c's .probe_new style for extcon-fsa9480,
  extcon-rt8973 and extcon-usbc-uusb320.c

----------------------------------------------------------------

Aidan MacDonald (1):
      extcon: max77843: Replace irqchip mask_invert with unmask_base

Uwe Kleine-König (3):
      extcon: fsa9480: Convert to i2c's .probe_new()
      extcon: rt8973: Convert to i2c's .probe_new()
      extcon: usbc-tusb320: Convert to i2c's .probe_new()

 drivers/extcon/extcon-fsa9480.c      | 5 ++---
 drivers/extcon/extcon-max77843.c     | 3 +--
 drivers/extcon/extcon-rt8973a.c      | 5 ++---
 drivers/extcon/extcon-usbc-tusb320.c | 5 ++---
 4 files changed, 7 insertions(+), 11 deletions(-)
