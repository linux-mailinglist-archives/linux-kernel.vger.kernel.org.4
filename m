Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F766D1590
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 04:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjCaCYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 22:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaCYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 22:24:18 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8F0E18B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 19:24:17 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=wuzongyong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Vf0OaZ0_1680229453;
Received: from localhost(mailfrom:wuzongyong@linux.alibaba.com fp:SMTPD_---0Vf0OaZ0_1680229453)
          by smtp.aliyun-inc.com;
          Fri, 31 Mar 2023 10:24:13 +0800
Date:   Fri, 31 Mar 2023 10:24:14 +0800
From:   Wu Zongyong <wuzongyong@linux.alibaba.com>
To:     kirill.shutemov@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, tony.luck@intel.com,
        wutu.xq2@linux.alibaba.com
Subject: Re: [RFC PATCH] x86/insn: support decode MOVSXD instruction for MMIO
Message-ID: <20230331022414.GB435@L-PF27918B-1352.localdomain>
Reply-To: Wu Zongyong <wuzongyong@linux.alibaba.com>
References: <1655f5dc49ab77f94e350ecbdc93e8d9b31acf61.1680058548.git.wuzongyong@linux.alibaba.com>
 <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330123951.b5vujv67c7q3dhay@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 03:39:51PM +0300, kirill.shutemov@linux.intel.com wrote:
> On Wed, Mar 29, 2023 at 10:59:37AM +0800, Wu Zongyong wrote:
> > It seems MOVSXD which opcode is 0x63 is not handled, support
> > to decode it in insn_decode_mmio().
> 
> Do you have a particular user in mind?
To be honest, I don't find a specific user which uses the MOVSXD.

But both Intel and AMD's instructions reference contains MOVSXD and lots
of MOVSXD instructions occur when I "objdump -S vmlinux", so I think it
may be useful to support it in insn_decode_mmio().

Are there some special consideration about this instruction?

> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
