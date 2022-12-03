Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A77641460
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 06:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiLCFzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 00:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLCFzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 00:55:08 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0193165A7;
        Fri,  2 Dec 2022 21:55:08 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so10185375pjs.4;
        Fri, 02 Dec 2022 21:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTHDa295CBWIk+1vhMIy+MTRnCaDXV9tIFZkRldLOFk=;
        b=WCM4rFFLuNVDg5vHE/cPD2ioLVFfmpBFVj/gQtp7jGorYlitAYDy1KDOgpyOK0dtEw
         iojHK4s2+H67T+/ssGjMC7YQLkM1V3MJNkorOcuumlxx1OG8Jge+NQTwe+7CwIQeENe3
         4MUvs1gvni+Oq9HO+tlTycaLYaisVpIm78SQDFmOjP+mxFILNOLFsVGZQiacAi8eawmh
         PDLITU/C8XrxGrcuAx8GAOSLt3jbE0hIZTCf2DJlreHsWsouGLSJgbiILiFEqLyjx3sR
         nSh6XN6cfBXhWI+VlVoWUEhbomUs/+jSvGpJvhTzY3Y6yITxNtrmKk43AOvRvPC+W+gt
         42GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:content-language:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OTHDa295CBWIk+1vhMIy+MTRnCaDXV9tIFZkRldLOFk=;
        b=MB5xHEuiHkAaw4fqAR6SqelvSTSMxbctnGK0B6nnb6GrNn+8K8+hCIuA4GXvCNjJDm
         D979G6XxGUdTIzZuk6MUluXFefx9V9rjFqC1lNSok04iX3nvEnkrdulyjJbwcG5TdTDr
         qWYWkgkPSIu+2Wj80hSF8IlDQ158HDX6a0S/psAIasaUcDvLf/lHeiHxNNn9Q5cnRxom
         iwwLhgPzjAVekH3lAGh09HkBFIifchDpeOK/71BFN44M+17EfKqiAmJeiwsd2/KUjHfm
         QccXNu2tpOOa2m9fV8WeONeKCPXhjuxVs8wVbSIORHiEyHOMIqWX/3uHD0e+bq807CI7
         XOpg==
X-Gm-Message-State: ANoB5pleHYpy1/9MISRwtlR4T0CKUMgZ2t3J0qfR0OLUFLfbIzdWLcsM
        BgBSJOICbzVObM/VhrgPVFc=
X-Google-Smtp-Source: AA0mqf67QfVNIiUGRgSiBOyiHVO+tE8OYN+Eyih3Br3uK3XXPBkXpauVLtADWFtjl6j+8Hi5QwQODQ==
X-Received: by 2002:a17:90a:9f46:b0:219:b1db:f7e3 with SMTP id q6-20020a17090a9f4600b00219b1dbf7e3mr258444pjv.64.1670046907245;
        Fri, 02 Dec 2022 21:55:07 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y1-20020aa79421000000b005765a5ff1fasm2390494pfo.213.2022.12.02.21.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 21:55:06 -0800 (PST)
Message-ID: <13b17bbe-8b72-8c87-0a08-073cafd04d71@gmail.com>
Date:   Sat, 3 Dec 2022 14:55:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v6.2. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

I'm so sorry for late pull request.

Best Regards,
Chanwoo Choi

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.2

for you to fetch changes up to 378e392fa97e869cb5f90e42ae2959444dac7d47:

  PM / devfreq: event: use devm_platform_get_and_ioremap_resource() (2022-12-03 08:22:12 +0900)

----------------------------------------------------------------

Update devfreq next for v6.2

Detailed description for this pull request:
- Add a private governor_data for governor. The private governor_data
is allocated and handled by governor regardless of passing the data
from devfreq driver via devfreq_add_device. The added private governor
keeps the governor own data when switching from userspace
governor and other governors.

- Replace code by using defined functions of
  device_match_of_node and devm_platform_get_and_ioremap_resource

----------------------------------------------------------------

Kant Fan (1):
      PM/devfreq: governor: Add a private governor_data for governor

Minghao Chi (1):
      PM / devfreq: event: use devm_platform_get_and_ioremap_resource()

ye xingchen (2):
      PM / devfreq: Use device_match_of_node()
      PM / devfreq: event: Use device_match_of_node()

 drivers/devfreq/devfreq-event.c      |  2 +-
 drivers/devfreq/devfreq.c            |  8 +++-----
 drivers/devfreq/event/exynos-nocp.c  |  3 +--
 drivers/devfreq/governor_userspace.c | 12 ++++++------
 include/linux/devfreq.h              |  7 ++++---
 5 files changed, 15 insertions(+), 17 deletions(-)
