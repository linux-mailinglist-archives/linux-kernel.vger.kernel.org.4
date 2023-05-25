Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3084B710320
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 04:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjEYC5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 22:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEYC5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 22:57:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423F612F
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 19:57:43 -0700 (PDT)
X-QQ-mid: bizesmtp63t1684983419t85lva7q
Received: from localhost.localdomain ( [221.226.144.218])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 10:56:57 +0800 (CST)
X-QQ-SSF: 01200000000000303000000A0000000
X-QQ-FEAT: 6m2HWuPn8APBKt63b3ah3TllQMoQddj48JDVm4Iepq5vRZSuXhWkDmIyJiEkQ
        MMvn40T53r5LmKlVQsPdr7bAyetskT7oogCcohGJNvN7UewCTkHFngfiLwsab7GI7lkPqoL
        hUOlodi0YIdrXuTQoCL2ILEPmt9iEG19lXfRne5e00JAyBeo/LRJVJK11hYEmya4nTQXBeh
        wj3H4AoK/LJVOpUmO4+6EMM+p22e9We1hFNY4tMXwU/U1dN+3DTmK0EOBfo5m1dvTT2Jkex
        CH+oS9ZeiuMRrxsyOK8JZr0YuD8zCH3Y92kgw/8TnFCP9w7Nl3QIj3OvbR+CgWtZcG3NKp8
        TUruhAgK+guXxTnDBFbCZ4wFEx43f1gw7hB8RcF
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14888827228828076966
From:   Song Shuai <songshuaishuai@tinylab.org>
To:     catalin.marinas@arm.com, will@kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, chris@zankel.net,
        jcmvbkbc@gmail.com, songshuaishuai@tinylab.org,
        steven.price@arm.com, vincenzo.frascino@arm.com, pcc@google.com,
        wangxiang@cdjrlc.com, ajones@ventanamicro.com,
        conor.dooley@microchip.com, jeeheng.sia@starfivetech.com,
        leyfoon.tan@starfivetech.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH 0/4] Remove WARN_ON in save_processor_state
Date:   Thu, 25 May 2023 10:55:51 +0800
Message-Id: <20230525025555.24104-1-songshuaishuai@tinylab.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During hibernation or restoration, freeze_secondary_cpus
checks num_online_cpus via BUG_ON, and the subsequent
save_processor_state also does the checking with WARN_ON.

So remove the unnecessary checking in save_processor_state
for ARM,arm64,riscv,xtensa architechtures.


Song Shuai (4):
  ARM: hibernate: remove WARN_ON in save_processor_state
  arm64: hibernate: remove WARN_ON in save_processor_state
  riscv: hibernate: remove WARN_ON in save_processor_state
  xtensa: hibernate: remove WARN_ON in save_processor_state

 arch/arm/kernel/hibernate.c    | 1 -
 arch/arm64/kernel/hibernate.c  | 1 -
 arch/riscv/kernel/hibernate.c  | 1 -
 arch/xtensa/kernel/hibernate.c | 1 -
 4 files changed, 4 deletions(-)

-- 
2.20.1

