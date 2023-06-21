Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A4A738E8A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbjFUSZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjFUSZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:25:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61184172C;
        Wed, 21 Jun 2023 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=TPXBsx8u0xndqzyud1NZ8c9PL61dW9ELHSP+d0BbT0o=; b=qUNpRJx+5v7JW1hZIz4149+kBr
        Flw33PF/PRzKokJNH5pmMRxb8Ydb9wt8x4hiIzYUGscsA5YLkssJEf5ENs8KV7MyVRDmgln0nx1yz
        bWAarsWKRT8f+RJcBPkOG0sF/ywsZT8rczHXpfRwRGUPytdYC6QAPFQH/UpCiXyK46v2p7kN5vog6
        JQSY3h0CwhiL13xROst7C/tjhQHPhgmaXqXEzJByCVH1+IsxQiY2HcsB34uxrYPBg1zWx88kVDRB7
        7igtuMLsJzarSPFR4RCEKiRTuiJrT3xNMqmdC3fH581lOI61bvrKJLCvkNpf9MO0RsdBkaruVUSG4
        wWR1M76w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qC2W2-00FNl3-2h;
        Wed, 21 Jun 2023 18:25:14 +0000
Message-ID: <14aa23d6-b4c2-190f-0d6c-22a82befa04d@infradead.org>
Date:   Wed, 21 Jun 2023 11:25:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 21 (riscv/errata/thead)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, wefu@redhat.com
References: <20230621145917.3635a2f1@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230621145917.3635a2f1@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/20/23 21:59, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230620:
> 

on riscv 32-bit:


WARNING: unmet direct dependencies detected for ERRATA_THEAD
  Depends on [n]: RISCV_ALTERNATIVE [=n]
  Selected by [y]:
  - ARCH_THEAD [=y]

WARNING: unmet direct dependencies detected for ERRATA_THEAD
  Depends on [n]: RISCV_ALTERNATIVE [=n]
  Selected by [y]:
  - ARCH_THEAD [=y]

WARNING: unmet direct dependencies detected for ERRATA_THEAD
  Depends on [n]: RISCV_ALTERNATIVE [=n]
  Selected by [y]:
  - ARCH_THEAD [=y]

../arch/riscv/errata/thead/errata.c: In function 'errata_probe_pbmt':
../arch/riscv/errata/thead/errata.c:29:22: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
   29 |         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT ||
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/errata/thead/errata.c:29:22: note: each undeclared identifier is reported only once for each function it appears in
../arch/riscv/errata/thead/errata.c:30:22: error: 'RISCV_ALTERNATIVES_MODULE' undeclared (first use in this function)
   30 |             stage == RISCV_ALTERNATIVES_MODULE)
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/errata/thead/errata.c: In function 'errata_probe_cmo':
../arch/riscv/errata/thead/errata.c:45:22: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
   45 |         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/errata/thead/errata.c: In function 'errata_probe_pmu':
../arch/riscv/errata/thead/errata.c:63:22: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
   63 |         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/errata/thead/errata.c: At top level:
../arch/riscv/errata/thead/errata.c:86:37: warning: 'struct alt_entry' declared inside parameter list will not be visible outside of this definition or declaration
   86 | void thead_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
      |                                     ^~~~~~~~~
../arch/riscv/errata/thead/errata.c: In function 'thead_errata_patch_func':
../arch/riscv/errata/thead/errata.c:95:41: error: increment of pointer to an incomplete type 'struct alt_entry'
   95 |         for (alt = begin; alt < end; alt++) {
      |                                         ^~
../arch/riscv/errata/thead/errata.c:96:24: error: invalid use of undefined type 'struct alt_entry'
   96 |                 if (alt->vendor_id != THEAD_VENDOR_ID)
      |                        ^~
../arch/riscv/errata/thead/errata.c:98:24: error: invalid use of undefined type 'struct alt_entry'
   98 |                 if (alt->patch_id >= ERRATA_THEAD_NUMBER)
      |                        ^~
../arch/riscv/errata/thead/errata.c:101:33: error: invalid use of undefined type 'struct alt_entry'
  101 |                 tmp = (1U << alt->patch_id);
      |                                 ^~
../arch/riscv/errata/thead/errata.c:103:34: error: implicit declaration of function 'ALT_OLD_PTR' [-Werror=implicit-function-declaration]
  103 |                         oldptr = ALT_OLD_PTR(alt);
      |                                  ^~~~~~~~~~~
../arch/riscv/errata/thead/errata.c:103:32: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  103 |                         oldptr = ALT_OLD_PTR(alt);
      |                                ^
../arch/riscv/errata/thead/errata.c:104:34: error: implicit declaration of function 'ALT_ALT_PTR' [-Werror=implicit-function-declaration]
  104 |                         altptr = ALT_ALT_PTR(alt);
      |                                  ^~~~~~~~~~~
../arch/riscv/errata/thead/errata.c:104:32: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
  104 |                         altptr = ALT_ALT_PTR(alt);
      |                                ^
../arch/riscv/errata/thead/errata.c:107:38: error: 'RISCV_ALTERNATIVES_EARLY_BOOT' undeclared (first use in this function)
  107 |                         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT) {
      |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/riscv/errata/thead/errata.c:108:59: error: invalid use of undefined type 'struct alt_entry'
  108 |                                 memcpy(oldptr, altptr, alt->alt_len);
      |                                                           ^~
../arch/riscv/errata/thead/errata.c:111:70: error: invalid use of undefined type 'struct alt_entry'
  111 |                                 patch_text_nosync(oldptr, altptr, alt->alt_len);
      |                                                                      ^~
cc1: some warnings being treated as errors


-- 
~Randy
