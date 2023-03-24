Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F412E6C78D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjCXH1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 03:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjCXH1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 03:27:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB8C13509
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:26:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id kc4so1064346plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679642814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOWL7nV1WlBQFqJTXaBmWX6r0g27OV1XFhs05mfe2aI=;
        b=lBy36qf99v/akTnZfqIbBpJAhkBbS4hxyhr2Jne8gCswaxvp2Jp3FENopQ1quN9LoI
         VNuHMsYgqHlORnlmEX5zvB8hUlcw5EI8Jo5JrbapUgAEo7Oq3ti0/E82h0tC8TzSqJ5s
         azjhTEJfus9EQxuW9F6Rf2F5Ev3ZauxqzemQkoefrGtuiPmPtQJmW84WtnIRYXkqFVPj
         0Dii2BOGoEZoreA9YJaOiMY8VFyd40yrv/taVZvEHLLJ7kt35WHW/hqNylXgavwDXuIJ
         BSy+9n59hPfxosCDqWYllWUNRvxdD5iIWjj/KnkorjkQvS2/0Gu1kLM9135Ei678N/38
         vy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qOWL7nV1WlBQFqJTXaBmWX6r0g27OV1XFhs05mfe2aI=;
        b=ym1FHoClZ9QQLs9RLAgZ9DntPwSNl8PfxuhpoawXBekxDbZtVe7MhY7YehtRk/Ahna
         WCNUaJBLof37vsNzDWw91tsZP17PjdqR3sutgVb/u/eetDphefd5Sf2jV0DVoL4wutbw
         9Mt2nuSYfwX37XY+HeMTTZcdVlKGJvTugIZdmJ8Kosj03Gg6Ux1b+88h3n9u9K5mOS1u
         H0/Bpox3ts6zlIVU4fcPntrhCMLk0tbgnATS/j7Br5NtMECDm7wp28FXVnAeruIEq6dN
         E2LMkyUX6yG2JAoxqghVWOxCL/GE0G3AvhV+81M1rP3f2r+1qQesmdMwWOSE/Rx1SqVB
         z8cw==
X-Gm-Message-State: AAQBX9eDFPbcm9emmympv+Ul9VxB1AslesT4I1CoYgeI71OHCtWN2suI
        OW1hA9s7svg2QvsU1/Vx5uk=
X-Google-Smtp-Source: AKy350aNhUPcRlU0iL4dePfhEGfhG/kuFnHgs06JnlqWlbVOTtQooldC9zpf0rhCQpaxh7fGZUPo8Q==
X-Received: by 2002:a17:90b:1d02:b0:23d:133a:62cc with SMTP id on2-20020a17090b1d0200b0023d133a62ccmr1902114pjb.17.1679642814428;
        Fri, 24 Mar 2023 00:26:54 -0700 (PDT)
Received: from ubuntu.localdomain ([59.89.175.90])
        by smtp.gmail.com with ESMTPSA id b16-20020a17090a991000b002311c4596f6sm2345152pjp.54.2023.03.24.00.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 00:26:53 -0700 (PDT)
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: [PATCH v2 0/3] Staging: greybus: Use inline functions
Date:   Fri, 24 Mar 2023 00:26:15 -0700
Message-Id: <cover.1679642024.git.sumitraartsy@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert macros to a static inline function, to make the relevant 
types apparent in the definition and to benefit from the type 
checking performed by the compiler at call sites.

CHanges in v2: Change patch subjects, noted by Alison Schofield 
<alison.schofield@intel.com>

Sumitra Sharma (3):
  Staging: greybus: Use inline function for macro
    gpio_chip_to_gb_gpio_controller
  Staging: greybus: Use inline function for gb_audio_manager_module
  Staging: greybus: Use inline function for pwm_chip_to_gb_pwm_chip

 drivers/staging/greybus/audio_manager_module.c | 7 +++++--
 drivers/staging/greybus/gpio.c                 | 7 +++++--
 drivers/staging/greybus/pwm.c                  | 6 ++++--
 3 files changed, 14 insertions(+), 6 deletions(-)

-- 
2.25.1

