Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346DD6EE187
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbjDYMBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjDYMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:01:07 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B4110F3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
        t=1682424049; bh=meMe2T6KKbX+l3+HBOMKvPki3tbvHHhySN0Qss7JmnY=;
        h=From:To:Cc:Subject:Date;
        b=A+4faKHURxUGtMw3r+rPlgzNJjnDWniodlm/n136XHJVmdzEKCPaiKbgmwSXH+B9j
         r0YYm+b0VWcR8Ant6LppLxgNoYJlIAGUYa5v5IjPAA9sm7a4GxxjMDb13r9/dN372T
         UjPBaxGvFKoFdcSuCZybxUpYPmT0v1HtsRhxoGpw=
Received: from cyy-pc.lan ([2001:da8:c800:d084:c65a:644a:13d7:e72c])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 1235043; Tue, 25 Apr 2023 20:00:18 +0800
X-QQ-mid: xmsmtpt1682424018txcilf7bg
Message-ID: <tencent_1647475C9618C390BEC601BE2CC1206D0C07@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCj/22F3Hkzg44Cma8g01zlNRT4DRJwi4CfhvQ5DYbNHtDz9LzPC
         mnwGEhmCouvCVQvGtB0o9RBIZ2mqU7tJVVkrmdBy9jZfSCT0wAI3Htz7WCF005Xwr1S/QO2qDUJs
         nlT3WXhuaV06q4Ag9f5yRvF2WIPkwXW24IZXF8Jvw1eTk7fgWDAthhZ8BVzCl1uilaad7w7w8L7h
         Mgxh4x+F7nvNVwsgB1tOKneigLiV0J/jxGUQ/O6td/k+Gnev/yUnh3hDNiGaXeW6inDu2uvmGelv
         HC1OkyBYHkabv9HJNP/4TZ2b4GBSlGQm1gK19LlimUp4lfVJyrV0NBk2eNPxgk/Bp+v2OTOLk5zM
         WcOJC8j5TolnmjXyu2OB46Lt6WtGIVn5uV/xdfv+eqem9PAl4FWPy2/zYJIhNhJCOtobs01F4HFJ
         c4ulEpwErguY3goPnfQYXTqFd1WtPm8794KUig73wkVCPKUwHmaXv3i8O3QrWqmzjqyZdK3YOXji
         CpbGQPGLqjH3bvpQ5Rvmhis6wM2KM6OpUpySopq590lNv5YOPyPnSve28F/MqMoGc5b/IIBzRsrI
         jpIHsHJmPN7POteRvPRREOQAJlwF4o9JN16aUycfO7kXGJ7WklbcavLifNv8g3k35TldJtuGugMc
         UXthK+w4gJp40TF5n0+Mh+xUBAgcHpPLpKwy9ccHWbFYz7bK9IG+nrmzJuQ9FA3FWIzEF/r7JBcq
         KL/NsfRE0jfZ3i7HAYwduBPWx+8hfVIHehBtANGV2gfNnbXFaYH0hQHiKwXJkw84IN1r652A3Hnn
         8CqbgVuAH/QM45Hlw1dIBEKOnwt+0ux2G3kWhEs5rdVNTtZAZb2fcyzNfP6MMmdMpECdhhEspFoV
         p6PRkVRn1yE4XVy1E/nlco3j1keqBTv097uIJsZ+emDz0Co3jeN0dQoU3Fs4b55cEDuiRX2G70mC
         3mJBDy7Ip/+HyGV2rPTSuljU5Us7IUFnRWe/CGqoWB88a+CGSOb5EBjyR6vS5VK8JCO23M35whVF
         rSdLPX+Qx13F+clTxuYeDJyiAMT88=
From:   Yangyu Chen <cyy@cyyself.name>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Wende Tan <twd2.me@gmail.com>, Soha Jin <soha@lohu.info>,
        Hongren Zheng <i@zenithal.me>, Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH 0/2] Allow case-insensitive RISC-V ISA string
Date:   Tue, 25 Apr 2023 20:00:14 +0800
X-OQ-MSGID: <20230425120016.187010-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to RISC-V ISA specification, the ISA naming strings are
case insensitive. The kernel docs require the riscv,isa string must
be all lowercase to simplify parsing currently. However, this 
limitation is not consistent with RISC-V ISA Spec.

The motivation for this patch series is that some SoC generators
will provide ISA strings with uppercase letters in the device tree.
For example, the rocket-chip will have "Zicsr_Zifencei_Zihpm_Xrocket"
in the ISA string. If we did not modify the ISA string manually, the
parser in the current kernel will have errors when the pointer meets
uppercase letters because it assumes the string only has digits, 
lowercase letters, and underscores. Then, the parser will fail and
the pointer of the parser will continue at the next position, which
will confuse the parser and cause the kernel to misbehave.

For example, "Zifencei" will be parsed as "ifc" since the parser will
fail at 'Z' and then continue at 'i'. Then, if we disable the FPU in
the CPU hardware and remove the "fd" from the device tree but leave
the CONFIG_FPU=y in the kernel, the kernel will panic at 
`__fstate_restore` function since the "Zifencei" (parsed as "ifc")
will confuse the current kernel that the CPU has "f", and the kernel
will save and restore the FPU registers during the context switch,
leading to illegal instruction exceptions.

However, it is not necessary to require the ISA string must be all
lowercase. The case-insensitive parser can be easily implemented
using `strncasecmp` and `tolower` functions. Moreover, the kernel
parser implementation should match the ISA specification rather than
using a more strict rule.

This patch series allows case-insensitive RISC-V ISA string:
* Patch 1 modifies the ISA string parser in the kernel to support
  case-insensitive ISA string parsing. It replaces `strncmp` with
  `strncasecmp`, replaces `islower` with `isalpha`, and wraps the
  dereferenced char in the parser with `tolower`.
* Patch 2 modifies the docs to no longer require the riscv,isa
  string to be all lowercase.

Yangyu Chen (2):
  riscv: allow case-insensitive ISA string parsing
  docs: dt: allow case-insensitive RISC-V ISA string

 .../devicetree/bindings/riscv/cpus.yaml       |  7 +++----
 arch/riscv/kernel/cpu.c                       |  6 ++++--
 arch/riscv/kernel/cpufeature.c                | 20 +++++++++----------
 3 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.40.0

