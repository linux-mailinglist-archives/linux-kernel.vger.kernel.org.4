Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70A0723ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjFFIBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 04:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235725AbjFFIBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 04:01:14 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6F1FCB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:58:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b1c910ee19so26957251fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686038325; x=1688630325;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3k1irXTYukr99PsFNAkymM0Og80zDNstPLsK0k6o+Jk=;
        b=rL2FG1uuVGUyrvNG3McMCmB4ydldmGc4bEMB0o2gg28bdxcdSbAjvXkldJ3xX7uK2n
         bTd41UrD8iNypclzCFRPQsu8PCtmWvpl7VLnzzhB/aQ6699H39Hs+PmqLEo8v0qC2ydL
         LKW5YZLrUHqSBRQKHi5dTc/OL32bnnid33luzOvZrIKNilTeH8gNjpw2X5/8P/g96IcD
         QJ7rB/AH5QPjuUZQTl8bRVFad77eG/izX1PAqJqjBc1mBkQCec5Qfcy5NMJFTQzOtoAI
         agYrWXEflFntXYEvhY/iXFy0Oo/ZxcO1qcXX5AQ5t7SENQ1O2GQCwxX3446a7UWD/Q1F
         3rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686038325; x=1688630325;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3k1irXTYukr99PsFNAkymM0Og80zDNstPLsK0k6o+Jk=;
        b=G0hinlmT/LubbzdeiVspjo7JpkNjmHYwsuPHYwTa9rba+zV4bQO4OEiI00UP7y4/Og
         hCetqKa+vhfUL+0Xkc9Lv47XEAjzT0YHVb6lUDk4LBmmuQFqivsqy6s47NHfJ6DWwsms
         vROU8MTyZYunNqEE1MlC53Gmlxct/P3YYk0vzwtXzXy6jXHJZQdiH2J4mM1wVuDED4R6
         KSiN3sFJ7BzJ32Pf1/vEoVhE5cVRYS+e5PGblUZIxyImSQFJc8f00lrzPOE6IVd2QpPO
         6yeOrmgKMnH2GtoXtu1I+YNxoY9TN1YeJnQ75fwJLI/UVxAamddTNTkIuLMMVfHr3juS
         kkeQ==
X-Gm-Message-State: AC+VfDw+oXps3tN7lorozDWddGJBxZ13x/UE5tBU1d5/EOCxHZLsKxTQ
        tEBGNcfbH4Zz8CIidyoL329sKdkRxDw4/B5z/Yw=
X-Google-Smtp-Source: ACHHUZ518pQSHi1ktn+stGaMfzxkmsSSqAI6RmGocuetkundaUI/8yvnmw/gM4JX4uZKtIWhFzvJmA==
X-Received: by 2002:a2e:8010:0:b0:2b1:ae75:2781 with SMTP id j16-20020a2e8010000000b002b1ae752781mr867582ljg.27.1686038325151;
        Tue, 06 Jun 2023 00:58:45 -0700 (PDT)
Received: from rayden (h-46-59-78-111.A175.priv.bahnhof.se. [46.59.78.111])
        by smtp.gmail.com with ESMTPSA id a4-20020a05651c010400b002a8bc9918d4sm1736574ljb.97.2023.06.06.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 00:58:44 -0700 (PDT)
Date:   Tue, 6 Jun 2023 09:58:43 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Subject: [GIT PULL] AMDTEE fix for v6.5
Message-ID: <20230606075843.GA2792442@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this AMDTEE driver fix to add a return origin field to the
struct tee_cmd_load_ta used when loading a Trusted Application into the
AMDTEE. This change is backward compatible.

Note that this isn't a usual Arm driver update. This targets AMD instead,
but is part of the TEE subsystem.

Thanks,
Jens

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/jens.wiklander/linux-tee.git tags/amdtee-fix-for-v6.5

for you to fetch changes up to 436eeae0411acdfc54521ddea80ee76d4ae8a7ea:

  tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta' (2023-05-15 08:29:52 +0200)

----------------------------------------------------------------
AMDTEE add return origin to load TA command

----------------------------------------------------------------
Rijo Thomas (1):
      tee: amdtee: Add return_origin to 'struct tee_cmd_load_ta'

 drivers/tee/amdtee/amdtee_if.h | 10 ++++++----
 drivers/tee/amdtee/call.c      | 30 +++++++++++++++++-------------
 2 files changed, 23 insertions(+), 17 deletions(-)
