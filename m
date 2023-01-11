Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE016663D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjAKTkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbjAKTkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:40:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200D1261D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:03 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id g18-20020a63f412000000b004aef17e314cso5461427pgi.21
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t3pPNIR+vfI2JtFFFL2A194GgC6alh3nRui8ZdOfwfg=;
        b=DgwTX7V6i1WLZiuRbnJKeZPUHr8JJ0GI5LkpvRMoaqBDf7UE1WQKP3NXHFu8gVQ/lm
         xpA6c5YV0w6Jjch/BpozSCOJp8Chhm/lWOhrMl0O4qAQPsO66Y3assj1gw1JzTmJxEwl
         isvWEd9An213Jqy++e7ozq0eUUW2/8+SUjKE/zUJ60pc4mi7NfbL3tNHEK2sZlMbgRnz
         CWp5CXFKL62cyW+OSUP9ADSzqTsJnRkL2E1f3rATg2/KxPWktSTzNfFPcJIFjHuzKhoJ
         THAZDL6GC103xm4PPIlzTkTzgLBhnv/vwXZ7a92LU1P+4zNHKH6OgvBIYK2fgMbAU9lK
         CEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t3pPNIR+vfI2JtFFFL2A194GgC6alh3nRui8ZdOfwfg=;
        b=ctKg1Hsp8bPW6XgI23y7RfN3J6ZjpuV659CWF+NBdY+c/t+VdNg/em5QBiVLIL8wZH
         s7mZEBvPfKnVVJ+6cwfha8JB+0p7QVd3ueJn9q6zOgBxLHXWIrcsYVyMANw4WWV8ZouC
         J9vAUlF0TpQtXcEPS9q4TF6dohJz+EuusA3vgAirPL80jht0DY79xjgxG8Y9Sc7tIJAa
         vZGQPgJh+MstkV5+a8Qp2oOJY5j1dYkYr/xnBp1wy2s2HB6CdqMaByBkrtzPqbSCCDDT
         bZ2aHML2nRJNxurag6WeeOYily22EvGXElIqOxxfVDinEMMX3DXJ3iKdDLIodE2wO5dv
         e0Rg==
X-Gm-Message-State: AFqh2krwOtdyOTZ/wamgQQI4vU3cN5L+aaIKk+vnvPUb9WKylkFRIyBB
        20c8NffotpooKgao8J/9soOu9CQB1p8IVHyFr4M/W9QvzFVCS2Q4FEvi8TURIGPTdh6eCwhnS1H
        5FwVLwyARSdP7KfzUg0uMwWGwS5HhvSZSXqYFiVFxd9ym5Bm/M4MqNDcBDdmBzdfkS+0Y1+qMUg
        EPPcNdFOo=
X-Google-Smtp-Source: AMrXdXs9dvfXuajea2m44h9V3Ohtz8jo8iIov4SvGR4kcpB5d7VBrvcE2xv7BS62/S+8EHpFd6EFhN03aIyz/3Q+4g==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:a25:0:b0:478:e14d:ffc1 with SMTP
 id 37-20020a630a25000000b00478e14dffc1mr4111497pgk.107.1673466002517; Wed, 11
 Jan 2023 11:40:02 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:39:54 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230111194001.1947849-1-dionnaglaze@google.com>
Subject: [PATCH v11 0/7] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest request synchronous API from SEV-SNP VMs to the host's security
processor consumes a global resource. For this reason, AMD's docs
recommend that the host implements a throttling mechanism. In order for
the guest to know it's been throttled and should try its request again,
we need some good-faith communication from the host that the request
has been throttled.

These patches work with the existing /dev/sev-guest ABI to detect a
throttling code.

Changes from v10:
  * Added sev_guestreq_err_t typedef early in chain to change a signature
    acress x86/sev and virt/coco/sev-guest in a single change. This makes
    all patches build. I have 3 cleanup patches to change the type and
    subsequently remove the typedef.
  * Changed exitinfo2 initial undefined value back to 0xff since Thomas
    indicated that a firmware error is only 16 bits.
Changes from v9:
  * Rebased on v6.2-rc3
Changes from v8:
  * Added documentation changes.
  * Changed commit messages to use passive voice.
  * Simplified control flow for __sev_platform_init_locked.
Changes from v7:
  * Replaced handle_guest_request arguments msg_ver and fw_err with a
    pointer to the snp_guest_request_ioctl argument struct.
Changes from v6:
  * Rebased on the IV reuse fix patch
  * renamed rate_hz to rate_s and fixed its MODULE_PARM_DESC to use the
    correct variable name.
  * Changed sleep_timeout_interrutible (not defined) to
    schedule_timeout_interruptible.
Changes from v5:
  * Fixed commit prefix text
  * Added all get_maintainers.pl folks to commits' Cc tags
  * Changed SET_RET_NO_FW_CALL commit's metadata to show pgonda signs
    off and is the author.
Changes from v4:
  * Clarified comment on SEV_RET_NO_FW_CALL
  * Changed ratelimit loop to use sleep_timeout_interruptible
Changes from v3:
  * sev-guest ratelimits itself to one request twice a second.
  * Fixed a type signature to use u64 instead of unsigned int
  * Set *exitinfo2 unconditionally after the ghcb_hv_call.
Changes from v2:
  * Codified the non-firmware-call firmware error code as (u32)-1.
  * Changed sev_issue_guest_request unsigned long *fw_err argument to
    u64 *exitinfo2 to more accurately and type-safely describe the
    value that it outputs.
  * Changed sev_issue_guest_request to always set its exitinfo2
    argument to either the non-firmware-call error code, the
    EXIT_INFO_2 returned from the VMM if the request failed, or 0 on
    success. This fixes a bug that returned uninitialized kernel stack
    memory to the user when there is no error.
  * Changed the throttle behavior to retry in the driver instead of
    returning -EAGAIN, due to possible message sequence number reuse
    on different message contents.

Changes from v1:
  * Changed throttle error code to 2

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Dionna Glaze (6):
  x86/sev: Change snp_guest_issue_request's fw_err
  virt: sev-guest: Remove err in handle_guest_request
  virt: sev-guest: interpret VMM errors from guest request
  x86/sev: Change sev_guestreq_err_t to u64
  virt/coco/sev-guest: Remove dependence on sev_guestreq_t
  x86/sev: Remove temporary typedef

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   | 21 ++++---
 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 10 ++--
 drivers/crypto/ccp/sev-dev.c            | 22 ++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 76 +++++++++++++++++--------
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 19 ++++++-
 7 files changed, 113 insertions(+), 46 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

