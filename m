Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0482D5E95B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbiIYTbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIYTbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:31:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EB62CC91;
        Sun, 25 Sep 2022 12:31:47 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so10519439pjq.3;
        Sun, 25 Sep 2022 12:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=+3IK3pFoCq1IDclAzp/yEBkAzKdxOedEmePMP2CALaQ=;
        b=c7IDDWcPc8j6i/ENkMAd9kNLRO+igJPE/5PtRJx8lnrqyAmIscPaSWeN92Dq78M8jt
         ZMW7/INFJcqJFWvNdIK7ZZHDmvzMODgjDPDYOX+LZia7gdCwfbWwfKuLUZyiTfIcPp9i
         0yyh3mdb03T7H6EHynXC4j/p9aSzCMRGpO6/bfCC+4FqPQFOsgehR2tb8RnDgM2o9Lr+
         hW4GF/u5egBpEYB9K9u/I73PU/W59a+xFSFgLIJU9QVh37Zb7Ejx9V3fzLSxL+Bl+P1Q
         rWiMkY1T14Fsip60FOmUGXISKJqANiv8ZIhnNXzXDwE3Ecupqv4qinzm2kq21MfcACUS
         N9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=+3IK3pFoCq1IDclAzp/yEBkAzKdxOedEmePMP2CALaQ=;
        b=PXjrx0pfhRovlEBrs0ewgbJE7E9SxP7SYrVcEo53IqO8jA7gA7OwmAgammsXvm3mdB
         sWbFWAjvr84RfuaFHRP63wxyW7vfEPAx6Linh0O68vCluJXAvrZ58UFUQRwZk4JiZevE
         HH0Xq8+4cibFfO48ErlVU9K1uyLJqfXjcq5D09IXDGptF1c0kcJdhWVPqntoAL2eplNq
         l7hMIFEIgY/j2Ocny6TI5llaDp820S3tVDiivZ0Q/oD6EE43P43HfC7MmGqIv873XWjT
         7s8CoQGvTpCvKHOqrdFgiEvuD1CbsLBdyESQohZ9QEbFDQhly7r/4lN8pxNo2I1kHUMN
         GquQ==
X-Gm-Message-State: ACrzQf09DnuVt8vkVU4R1syLPrbFXNydy9y8Hg2LUzYP+z5JaA9RuuIA
        DZOdP5dulPRvtGoebieeZrA=
X-Google-Smtp-Source: AMsMyM4OHaF88CQjb+/3KGgoRErUNHlknA1HUifhPG51c5DuSiTRhd8Jk/t+OFCBg9CoddhabSJ3Wg==
X-Received: by 2002:a17:90a:d982:b0:203:814d:dde6 with SMTP id d2-20020a17090ad98200b00203814ddde6mr32874440pjv.66.1664134306604;
        Sun, 25 Sep 2022 12:31:46 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id fu1-20020a17090ad18100b001fd6066284dsm5238807pjb.6.2022.09.25.12.31.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 12:31:45 -0700 (PDT)
Message-ID: <c09e06cf-2461-a3f9-9288-402fbdc94e0d@gmail.com>
Date:   Mon, 26 Sep 2022 04:31:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
From:   Chanwoo Choi <cwchoi00@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.1
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

This is devfreq-next pull request for v6.1. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 521a547ced6477c54b4b0cc206000406c221b4d6:

  Linux 6.0-rc6 (2022-09-18 13:44:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.1

for you to fetch changes up to fb2ac84f8acccdec644d26dfc8ba6554f30cd6c0:

  PM / devfreq: rockchip-dfi: Fix an error message (2022-09-26 03:59:43 +0900)

----------------------------------------------------------------
Update devfreq next for v6.1

Detailed description for this pull request:
1. Handle -EPROBE_DEFER when regulator is not probed on mtk-ci-devfreq.c
2. Use dev_err_probe to reduce the error log on rockchip-dfi.c

----------------------------------------------------------------
AngeloGioacchino Del Regno (1):
      PM / devfreq: mtk-cci: Handle sram regulator probe deferral

Christophe JAILLET (1):
      PM / devfreq: rockchip-dfi: Fix an error message

 drivers/devfreq/event/rockchip-dfi.c | 7 +++----
 drivers/devfreq/mtk-cci-devfreq.c    | 8 ++++++--
 2 files changed, 9 insertions(+), 6 deletions(-)
