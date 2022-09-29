Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3EB5EECBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 06:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiI2E3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 00:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbiI2E3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 00:29:08 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D49B128735
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:29:03 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id jm5so216423plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 21:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=csie-ntu-edu-tw.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=fL/YVt32+LkMJ+jfDCGE6ZE2He6/7IYbDthzRh5pnvM=;
        b=AElxDwUieDY8mEsTpWSXaFLpS8oD1MUWBAh1CUxxyJN+b6j24HSBv7JEUfKXlLtKsi
         cLKDpROmRCvV+Y8sHJK16CF2LFU6uwC3oTLY2lEv9o6CpBqXMVkEGdyb3Ye3Ezaw5Er8
         Cr7EVfedosxaTiCWZ65iB+E8a3taYuQuO/tqSukmM6YHH0hTU1baymPP6DQyNeCw5JK+
         laOhBuSjhUpTb+e1e865wJTCld0dFM7M25UIgzp80BLmpZM7pnzyA5VqQepDBkH0nG4d
         iCPitaf08/tc8YTN9CV1TTmICxcAgz9+yGmqEPeVCnTT2l/1DzHyNpvafoRgF5dE8/cY
         xbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=fL/YVt32+LkMJ+jfDCGE6ZE2He6/7IYbDthzRh5pnvM=;
        b=gB/zXzLr1yjOm5PeKb2do6C3KxUEt+gYhk1QCR/uXylotlZRpbr7Ui3U8FxmOvxgXP
         krYlc1cSkR/Az+CsMtUWY/V07MniRk+mNlbD+xO4vVEHmAUwpj+/MPwUxwY6kHaUOsda
         IgsOgjqycfvVyjm7xaZfvyqpL+0r+02lQM64Nd4IWCNod0vZRhRQQFkDnidD5NForJsy
         e9M704rS1E42rZZluxdgQLXU4xOVTYbwPfQwXKtIE9j+vDmD1SFcV4Xq7ekjWbrybq7u
         Chd0FyZvFAnh5vtuTEjGE6zfxqHImmNDq+HWVzNF3ixlxCAwXCPUILoz3gkAX0RS7J6H
         Fn+Q==
X-Gm-Message-State: ACrzQf23OxsKyBUUefZDIkpAEYl9bCUQUXJvYbXX1yagOXplJs4SUVO1
        xfkiZeDDprTXD3aUDucuLgaTpXI3EkUPRqL7DeW0nnEB4/Y9zEOw0RxU8XYypGblHH4TaqyoR5l
        wbL+m8YBOG9WcXY0WPLSBvgW2FoH1pZFzBBJfISPizmDDOPvkAbUdfYj2xy1ZwsYvWvPcRoFtaa
        rW4hHxvYC4qTg20+KFg25PfzY4z2M=
X-Google-Smtp-Source: AMsMyM6qX0Qnf209vtdE+DFtjxiOkuDMuJSP5S1HwwY2rKsE82B67+H4BY9VlVAy93ptwYz9rWR4gg==
X-Received: by 2002:a17:902:d88b:b0:178:264b:5aa4 with SMTP id b11-20020a170902d88b00b00178264b5aa4mr1494832plz.44.1664425742876;
        Wed, 28 Sep 2022 21:29:02 -0700 (PDT)
Received: from localhost.localdomain (2001-b011-3803-35e2-b9d6-2b48-c1fa-3056.dynamic-ip6.hinet.net. [2001:b011:3803:35e2:b9d6:2b48:c1fa:3056])
        by smtp.gmail.com with ESMTPSA id h4-20020a63f904000000b00412a708f38asm4442441pgi.35.2022.09.28.21.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 21:29:02 -0700 (PDT)
From:   Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
To:     maz@kernel.org
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
Subject: [PATCH] KVM: arm64: Fix comment typo in nvhe/switch.c
Date:   Thu, 29 Sep 2022 12:28:39 +0800
Message-Id: <20220929042839.24277-1-r09922117@csie.ntu.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the comment of __hyp_vgic_restore_state() from saying VEH to VHE,
also change the underscore to a dash to match the comment
above __hyp_vgic_save_state().

Signed-off-by: Wei-Lin Chang <r09922117@csie.ntu.edu.tw>
---
 arch/arm64/kvm/hyp/nvhe/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 9f6385702..8e9d49a96 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -143,7 +143,7 @@ static void __hyp_vgic_save_state(struct kvm_vcpu *vcpu)
 	}
 }
 
-/* Restore VGICv3 state on non_VEH systems */
+/* Restore VGICv3 state on non-VHE systems */
 static void __hyp_vgic_restore_state(struct kvm_vcpu *vcpu)
 {
 	if (static_branch_unlikely(&kvm_vgic_global_state.gicv3_cpuif)) {
-- 
2.34.1

