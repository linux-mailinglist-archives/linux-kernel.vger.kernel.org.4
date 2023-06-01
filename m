Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079D071F062
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjFARM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFARMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:12:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD48E2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:12:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so1717675a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 10:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685639542; x=1688231542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zN+Iz8iy1OdFPcTqO+tGqAKxTpsLm6Wu34sfJYFaDB4=;
        b=Rmfv/7AS/T6IhRwWMUDtMKZXevyfYNNzN+x7SujEpEwyBqVlx3kNFAo1HB1iDAAN5i
         HIYyO70/yCUKx4Nq6TZBT8OknFcbW3cIYh4rU+Q2AJoxtDsklSksDLJ9jOuMqytrbMcX
         RImRKDTc9M8W3c0nqt/JcRn7X2TIOa0MdVlpoIlxKFFVLsYeVWacNyaO4jgqxAzRuyN7
         pSgCE97pLuHD2ZT9uFICfPh6gpynGypVbGrnWhaMfJGl2C40/ErnRvLRC+lwe1QmM73/
         SHKbTj24F4+Xu6xQFw3iwHmFYdIOwrbYQUKIt29+f0dcD2TPHOPLuJS94M/0E0bJh8A6
         KQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685639542; x=1688231542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zN+Iz8iy1OdFPcTqO+tGqAKxTpsLm6Wu34sfJYFaDB4=;
        b=cdl+rskBZI9ZlSt3rFl6zDKVQsQxOQT0UQvlwMLhGmkwwZCzqBTxz+Nn77XaQ+XjMR
         1AmZGul7/4sydjkR18AZT9Ypm8CCtygx9lWt7BgeHFtHF0NAhvGxQ0q29zzufCQZpu1n
         PhPi3ydsAkCQThBmlzRsxNeV32wetyZebmW+8xPxrbvbUgYzXSTYjt6i7GURhXsYiMA3
         hboPb50+TiSor9LImlqkbFhth0XfpiMzLZvk8MhqnramHsAYm9yiae4VCNBifP1juUGi
         e/PW6GbI3dV+P8pn4LjY7jQWW70c/JVvt96rcX4rdMVrrVOKo2nJWHsRlEXcSipv3x4L
         M7Rg==
X-Gm-Message-State: AC+VfDx70xM0TvVhXfXsRWBIXelcueHyV2jLxLbxuFndfonqSWQj2mlR
        j0hfXttNW5bnbLLabOwRZQh4SckzImh54V4+ooc=
X-Google-Smtp-Source: ACHHUZ5tbdqIlWXh3ppNIGyLPzCSZo4nvtvSIJcMrD+Rx6dN75SJFKz9/v5Rhku80RuOYFI2n64Nvg==
X-Received: by 2002:a17:907:84b:b0:973:9492:bcd6 with SMTP id ww11-20020a170907084b00b009739492bcd6mr8974670ejb.38.1685639541889;
        Thu, 01 Jun 2023 10:12:21 -0700 (PDT)
Received: from krzk-bin.. ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id se24-20020a170906ce5800b009662b4230cesm10949491ejb.148.2023.06.01.10.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 10:12:21 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [GIT PULL] w1: drivers for v6.5
Date:   Thu,  1 Jun 2023 19:12:14 +0200
Message-Id: <20230601171214.1187837-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

My first W1-bus drivers pull.  I collected current and ~1.5 year old patches
from the list.

The git tag for pull is signed with my usual key which you can get
from kernel.org pgp keys repo: keys/1B93437D3B41629B.asc

Best regards,
Krzysztof


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.5

for you to fetch changes up to b332af5398a3aa1a2fdd69bb6968a8f866cc39aa:

  w1: Replace usage of found with dedicated list iterator variable (2023-05-13 21:15:02 +0200)

----------------------------------------------------------------
1-Wire bus drivers for v6.5

1. Several older cleanups and minor improvements like dropping redundant
   match function, fixing indentation and typos, simplifying sysfs
   attribute show, removing redundant variable initializations, using max()
   instead of open-coding it and constifying pointer to
   struct hwmon_channel_info.

2. w1_therm: fix inverted lock handling causing spurious temperature
   reads.

3. sgi: Use strscpy() over strlcpy().

4. w1 bus fixes:
   - Correct missing OF node reference put in error path.
   - Correct iterating over master device list while removing items from
     it.
   - Don't use loop iterator past the loop.

----------------------------------------------------------------
Colin Ian King (2):
      w1: remove redundant initialization to variable result
      w1: ds2438: remove redundant initialization of variable crc

Dan Carpenter (1):
      w1: fix loop in w1_fini()

Haowen Bai (1):
      w1: w1_therm: Use max() instead of doing it manually

Jakob Koschel (1):
      w1: Replace usage of found with dedicated list iterator variable

Jason Wang (1):
      w1: no need to initialise statics to 0

Julia Lawall (1):
      w1: w1_therm: fix typo in comment

Krzysztof Kozlowski (2):
      w1: Fix Kconfig indentation
      w1: therm: constify pointers to hwmon_channel_info

Liang He (1):
      w1: Add missing of_node_put() in w1.c

Lizhe (1):
      w1: Remove driver match function

Stefan Wahren (1):
      w1: w1_therm: fix locking behavior in convert_t

Wolfram Sang (1):
      w1: sgi: move from strlcpy with unused retval to strscpy

zuoqilin (1):
      w1: Simplify the atribute show

 drivers/w1/masters/sgi_w1.c   |  2 +-
 drivers/w1/slaves/Kconfig     |  4 ++--
 drivers/w1/slaves/w1_ds2438.c |  2 --
 drivers/w1/slaves/w1_therm.c  | 37 +++++++++++++----------------
 drivers/w1/w1.c               | 55 +++++++++++++++++--------------------------
 5 files changed, 42 insertions(+), 58 deletions(-)
