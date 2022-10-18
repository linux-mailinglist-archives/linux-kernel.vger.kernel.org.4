Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB6860319B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJRRbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJRRa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:30:56 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEECA915C4;
        Tue, 18 Oct 2022 10:30:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id b2so34049241eja.6;
        Tue, 18 Oct 2022 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y+Fo3p/xxotQ/CF0EbvnD4ZW7ILoDB1SHNyzK93wBg=;
        b=aZuV7q3WRMFcN0walr7Cu4KS/1nM5dD4lc593RWSCv9gSbvnAABsvK4igZWq91o1bz
         dcWtyD2e0d9B4rKBMTFrukgnel3XZWB54aWCE2gf2J7vL2+jvAcpfWhe84/QJvHuKgbb
         Oy4yA0bJlf2r6TQ2EjJALQI815CjUPkqv5ucZnAUNLMlF6d/RW40v8DTtdJjplAiHbNO
         GqyhfvD8ELsfRJMg4QA58cw3qu68XZHw1XndTyGOJ6mJ/yiXf0LREGH2Hduc0BXOklXG
         fM4tFxOGaA+ICXktFCDxruVpY/lVzcB/RA5/kMkBWaleVw7eHx4Kd8bOqCyH5pd2gqlY
         AJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y+Fo3p/xxotQ/CF0EbvnD4ZW7ILoDB1SHNyzK93wBg=;
        b=EfuQG+x7xaVvgdLCFuG+ODfFhp0ADiG4V0LfNucBNZEaKf40j0K48sV/SwaYEVLcrG
         PZuemgbPUgAFk0Dp4yIdHxKmGcNElRKlvtT2YQD8shEvVybDKBajpDUvu+1/XD1Wa3yX
         UH0Ug+UhbHw1bmN9Hct54WjMtVzmIKOKfTjHHtSXSMtpD0DH6D/wV8qoVN6gjWzEECQe
         bDWsDchfyXQ+dJfLH42Y5vcv1+NfH5KQHbAQ/PvZ9JXhl1GKw9lyKiB3AS7fcd4xUzwC
         jVDQ4jhUQwcHLz7of9UgWuGeevz5Pb6R6QwPW1HaNlQNWVU/eAL5vcwbMrOPBmO83zIs
         7s9A==
X-Gm-Message-State: ACrzQf0POwrGsp7nDW1svzqQQwWxFs2Xr4PhJNtvRrnSgXo4IRAbPXyQ
        V/PvgLJOeaqTXWSZP/iIDiLUZohfCpOUHA==
X-Google-Smtp-Source: AMsMyM6wtmAZWncOXNWDQucF1pKISZKu4akISFg+8MUv6tAmKL10VZcHLE2Y2H6I70DzsckA/rzoTA==
X-Received: by 2002:a17:907:9713:b0:78d:8e23:892c with SMTP id jg19-20020a170907971300b0078d8e23892cmr3298345ejc.449.1666114253359;
        Tue, 18 Oct 2022 10:30:53 -0700 (PDT)
Received: from NB-100745.open-synergy.com ([2a02:8109:9cc0:1f6c:99ac:492:d524:d338])
        by smtp.gmail.com with ESMTPSA id q5-20020aa7d445000000b0044bfdbd8a33sm9157683edr.88.2022.10.18.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 10:30:52 -0700 (PDT)
From:   Igor Skalkin <igor375@gmail.com>
X-Google-Original-From: Igor Skalkin <Igor.Skalkin@opensynergy.com>
To:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, jasowang@redhat.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Skalkin <Igor.Skalkin@opensynergy.com>
Subject: [PATCH v2 0/1] virtio_bt: Fix alignment in configuration struct
Date:   Tue, 18 Oct 2022 19:30:49 +0200
Message-Id: <20221018173050.581812-1-Igor.Skalkin@opensynergy.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

According to specification [1], "For the device-specific configuration
space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
and aligned accesses for 32 and 64 bit wide fields.".

Current version of the configuration structure has non-aligned 16bit
fields.

This patch adds a second, aligned  version of the configuration structure
and a new feature bit indicating that this version is being used.

[1] https://docs.oasis-open.org/virtio/virtio/v1.1/virtio-v1.1.pdf

Changes in v2:
  The first version of this patch just changed the configuration
  structure in uapi/linux/virtio_bt.h
  This can not be done, because it will break the userspace, so the
  second version offers a less radical approach - it introduces a new
  feature bit and a new configuration structure that both the device
  and the driver will use if this bit is negotiated.

Igor Skalkin (1):
  virtio_bt: Fix alignment in configuration struct

 drivers/bluetooth/virtio_bt.c  | 16 +++++++++++++---
 include/uapi/linux/virtio_bt.h |  8 ++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.37.2

