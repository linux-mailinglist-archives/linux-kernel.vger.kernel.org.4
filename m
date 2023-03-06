Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5616AD16A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCFWUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjCFWUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:20:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C436545E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:20:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBFF3B81136
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 22:20:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83812C433D2;
        Mon,  6 Mar 2023 22:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678141237;
        bh=WqfXto5v5JhP8rNlVVHSnk4v3F8owjQLa1cFEG0ODEw=;
        h=From:Subject:Date:To:Cc:From;
        b=KATh8VQH4UsUuvw6HeuKxqi87j/8wLugtzm5aEeYF7G2+eWmJB/A2QSKDVAGvtUm4
         s29miU6wHvV8ZM7Egg8XKR6/HMrCC1XBiXGWNnZQXHug2N5FrllL0hFTDtEYgkJt0j
         fqp6xQx+9iyyRcnh8qeSsvCFpxzkX/GtwjckE5HPbcsJIAwimVZpZG+pK0iJQ90MjO
         FbkIi/UuFE+v3uuoj8sx+6vzV9Dbszd94L4HbsBsV7TgVHqGq0y/GXRdz97W2+839o
         Htz000J1ZD1zSRRONRQxxn/oGhzfrhIgHhIsoIksHSqPNtoHY8fjmETCFFOOA5aQjy
         z8oIv/8ZIsOpQ==
From:   Mark Brown <broonie@kernel.org>
Subject: [PATCH 0/3] arm64/cpufeature: Use macros for ID based matches
Date:   Mon, 06 Mar 2023 22:20:22 +0000
Message-Id: <20230303-arm64-cpufeature-helpers-v1-0-b16cf36acaea@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACZnBmQC/x2NwQqDMBBEf0X23IUYQ4X+SulhjWMTqGnYqBTEf
 2+UOb2BN7NTgUYUejQ7KbZY4jdVaG8N+SDpDY5jZbLGdqaGRee7Y5/XCbKsCg74ZGhh6Y1tO7H
 OoaeqD1LAg0ry4RxY5ny2WTHF33X4fB3HH+ik2uGAAAAA
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=985; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WqfXto5v5JhP8rNlVVHSnk4v3F8owjQLa1cFEG0ODEw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkBmcxEtRKdBuG47lDJ9BMUMeDmBo5mwD8LDUOij05
 u+twaOeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAZnMQAKCRAk1otyXVSH0MgcB/
 9l8w+I9Dr8vBbYpHc5tM9JPhawCiQllLykMWDb84OoQ/68LnsKySUh2w0P9jdX1wf7/t7+4dFbiYqw
 NS/k0HKoObm9JkDVTGr/gsi4qG+34Ic9YmxRURx9Th/I23/xy1kQObBzk54J7NVzbqIL1HcnG+M+f/
 QCxncrHGzm4wkKVas6+s01QeuUi0p1HTlZt0LINXPpnjh76kEmHie95DMS2AJYSfCb109b9c8mAPV8
 dK8QINeTNM2t05r/KtF1x3bo99+N0a61brsuznHOi/dcjsqa1OG5ZBE+tvfaKuic5rrmqNqDcwZD7v
 ySjg5HLGTBihOirBCSUotF35q134OL
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As was recently done for hwcaps convert all the cpufeatures that match
on ID registers to use helper macros to initialise all the data fields
that the matching code uses.  The feature table is much less of an eye
chart than the hwcap tables were so the benefits are less substantial
but the result is still less verbose and error prone so still seems like
a win.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
Mark Brown (3):
      arm64/cpufeature: Pull out helper for CPUID register definitions
      arm64/cpufeature: Consistently use symbolic constants for min_field_value
      arm64/cpufeature: Use helper macro to specify ID register for capabilites

 arch/arm64/kernel/cpufeature.c | 272 +++++++++--------------------------------
 1 file changed, 59 insertions(+), 213 deletions(-)
---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230303-arm64-cpufeature-helpers-a70213a244e7

Best regards,
-- 
Mark Brown <broonie@kernel.org>

