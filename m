Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39167A4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjAXVPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234793AbjAXVPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:15:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C33D518E2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:15:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r8-20020a252b08000000b007b989d5e105so17686903ybr.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 13:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WA9MjEuF43tMKfr9FO5ZwkGRlVknWr7fM9p8Jq9lrFg=;
        b=kCItKcqb9mxzYz3z/05NPMgWdhhEiKN1t6MP3E6b+1hOWeq5u4AxfE54rIaeE9Jwvv
         R5RzQrXkFpq1f09OmZWdEtX1JYsVY9J+rsqw/FQFevPjW+U5g4KUJlyH37pP7xj7Xvgk
         Qt27G4z6o2rjZER9uXXDCNWu+U82zd1Vi+jlGkDF+3X4gMSAE4YGtwnI15Yf8S9dXmke
         VGrq3l8vFpdXAyNA4Aqiev3fSmv46suDU6mintTk90BpxZwpUpUgfFz2rkUw+tVjhnEc
         HI+l8AB6UO9Api08cSmfZC9Vl8oZjrKA1IutF9r6p8PyJzpuhgxm8RijOuwg3x0y2Mw8
         jHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WA9MjEuF43tMKfr9FO5ZwkGRlVknWr7fM9p8Jq9lrFg=;
        b=2NEsGlYmeKWdhVs3m5MsemBp5nWswD4mLT+LN13tuurCsJcBCCEfPpcTJ9a4tEjxw8
         lq19yynswRdIit5ESPnmpnjB4x82YmppOarGMhgRGlejthiMb5TMx6rNjF3LHDxnYlTa
         vMQzFnHtQdbuxr8AihBKLwk/V6eeLxRldFulWwntEnSGYlvW4ajWnM5saal60BR6AkO5
         mDglEZdmOCOXoe85XpS5Pf4IkGzfmOQf+ninBXo4a279I9CHZkesphyBEl2F/Sh867SP
         HG81X0oes+FO5aIQGTJQJepFjGUp7BaTtGesv+ZDrF7BktgldK6utsVgB3haG390XUCe
         Evsg==
X-Gm-Message-State: AO0yUKXOv4/RfDYgIjk3vrsKR5UJZlvvW3Sm9RSnLB2UTu+x82FNEeLM
        BWLUh6+KDMRGMCddYkPFpanevTqeGFA524pndNEuPef9flFICZEMQbqN7EBhLgWCsQDO0gyCzdA
        O0RvM2QVuT1NdS+hU7dqPYlW/y6I5qp+1Xwn2P9ZjZyXeIvSXXZXfi2VM1X15tO1G+SPGa0Is6F
        h8CTu4xZ4=
X-Google-Smtp-Source: AK7set/wMKhHzgESi55DIfWARBESMLxsY3+8suZd8EK82EvxFL0eCv+Pgd5Rv7QcjB8N9TJreEOyq0cWic7/hlSN9Q==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:dc13:0:b0:80b:92bb:e2d9 with SMTP
 id y19-20020a25dc13000000b0080b92bbe2d9mr100420ybe.230.1674594917517; Tue, 24
 Jan 2023 13:15:17 -0800 (PST)
Date:   Tue, 24 Jan 2023 21:14:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230124211455.2563674-1-dionnaglaze@google.com>
Subject: [PATCH v13 0/4] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>
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

Changes from v12:
  * Reordered fix patch to the beginning and kept it minimal.
  * Changed documentation in same patch as the respective change to the
    header.
  * Changed exitinfo2 in dev_alert to print in hex.
Changes from v11:
  * Squashed all type changing patches into 1 that modifies both sev-guest
    and x86/kernel/sev.c.
  * Removed fw_err field from sev-guest command struct (renamed exitinfo2).
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

Dionna Glaze (3):
  virt/coco/sev-guest: Add throttling awareness
  x86/sev: Change snp_guest_issue_request's fw_err
  virt: sev-guest: self-throttle guest request retries

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   | 21 ++++---
 arch/x86/include/asm/sev-common.h       |  3 -
 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 13 +++--
 drivers/crypto/ccp/sev-dev.c            | 22 ++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 77 +++++++++++++++++--------
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++-
 8 files changed, 114 insertions(+), 51 deletions(-)

-- 
2.39.1.405.gd4c25cc71f-goog

