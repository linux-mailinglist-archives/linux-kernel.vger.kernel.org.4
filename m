Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBA369F35E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjBVLW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjBVLWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:22:25 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633FD32E4C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:22:24 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536e8d6d9ceso34445357b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0net9U3CbYNje/Gglte/4WW6u4hogiAk1dLkHGk2bt8=;
        b=XQpkBrCc23TUNlKWVQ5NlL4ZCYp0Qsh/OjHjcGcJSldg54UNIA1tIqvXmJRbVDPfpW
         rQGg0zGwY77N+S1d96M65QDedGFVsq0a5v4LkuP0LyGpdrOpCsWG3CF7yr6+Z1rDRGng
         9E3dq1D2dorSht0OGkXZ1LY6ZxJs5ZwDF2acIx+P3UY7ygj/4jKjbBRALT3kiSF20ZUv
         dt8X/UXPbXP+6TUnef896CmgLti2Ff17tEPqyGrsqcFWkAKx3aZ9XFhxLrj+UfOUoGt5
         w35k1OQWtstInhWHxSbEMTzzU+PES30Qxuea4+BK3yhBgss4qNaS0yypA8VLtd6B3MzK
         ZpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0net9U3CbYNje/Gglte/4WW6u4hogiAk1dLkHGk2bt8=;
        b=2Iv48PPLlHd2u0BhVb41nuN1mdeSzTUdsMjqf7GBnmK+vp8m/ucP+WnMpNAUIxa2Sp
         3Gq7Fu3KVZPzLw+J1PIjOG042gD9ABIUPBhwxwoM4UnGwCGCkwSw+yHrteRUeGHM+QkS
         MRpE+eZjohcC038suE1FMiM0QklA1FZbAUjBjijMZotCE+HhkW78g/aJQSy5aRZb/fy3
         1WZn67bjQQwsebbwXof1JHXQZmJl4Hn6JDWQ0naSFMgdmI3z8nyU/WsXIVVLYhTRCuSt
         98vCq7/sZEwlvwaJvC35s1eKLAsbKCJJC2FIDeG4/aVZwXzd3An3U3EKMqm6NNXWaDq/
         WWuw==
X-Gm-Message-State: AO0yUKUwYt0jiA6hD3078nxTPjzHARB7itB6waXOmHoXLuzE/gVgGZZI
        aeVdebI6KJoKW5B5AGP+M/9teu/h+as+Qeju2OWQGXEw57oSHQIVtMyqPVoXXNNoD/ZihSepDNw
        AIS11d2dvDKJuUASPky4IMDXDg5wI2DKEmGt22men0Q6BGtsfV43W2t7siWdvjXoTO7h6r8KDVK
        U=
X-Google-Smtp-Source: AK7set+uyXY/IYoT+WfH5P06v11Y1dLs4HWBdjX7R6Sv+pg5qFfgnE+fearbv2O86j4e2l0Qk7bCJASrB5JkYg==
X-Received: from lux.lon.corp.google.com ([2a00:79e0:d:209:35a9:4800:d90c:e9bc])
 (user=maennich job=sendgmr) by 2002:a05:6902:1024:b0:8da:3163:224 with SMTP
 id x4-20020a056902102400b008da31630224mr1005683ybt.0.1677064943540; Wed, 22
 Feb 2023 03:22:23 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:21:37 +0000
In-Reply-To: <20220201205624.652313-1-nathan@kernel.org>
Message-Id: <20230222112141.278066-1-maennich@google.com>
Mime-Version: 1.0
References: <20220201205624.652313-1-nathan@kernel.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH 0/5] Allow CONFIG_DEBUG_INFO_DWARF5=y + CONFIG_DEBUG_INFO_BTF=y
From:   maennich@google.com
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, maennich@google.com,
        stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
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

From: Matthias Maennich <maennich@google.com>

Can we please pick this series up for 5.15? I am particularly interested
in the last patch to enable BTF + DWARF5, but the cleanup patches before
are a very reasonable choice for stable@ as well as they simplify the
pahole version calculation and allow future BTF/pahole related patches
to apply cleanly as well. I intentionally kept the config
PAHOLE_HAS_BTF_TAG and hence its patch complete, even though there is no
user for it.

Cheers,
Matthias

Cc: <stable@vger.kernel.org> # v5.15+
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Matthias Maennich <maennich@google.com>

Nathan Chancellor (5):
  MAINTAINERS: Add scripts/pahole-flags.sh to BPF section
  kbuild: Add CONFIG_PAHOLE_VERSION
  scripts/pahole-flags.sh: Use pahole-version.sh
  lib/Kconfig.debug: Use CONFIG_PAHOLE_VERSION
  lib/Kconfig.debug: Allow BTF + DWARF5 with pahole 1.21+

 MAINTAINERS               |  2 ++
 init/Kconfig              |  4 ++++
 lib/Kconfig.debug         | 12 ++++++++++--
 scripts/pahole-flags.sh   |  2 +-
 scripts/pahole-version.sh | 13 +++++++++++++
 5 files changed, 30 insertions(+), 3 deletions(-)
 create mode 100755 scripts/pahole-version.sh

-- 
2.39.2.637.g21b0678d19-goog

