Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A260B6B9105
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjCNLGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCNLFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:05:53 -0400
Received: from out199-15.us.a.mail.aliyun.com (out199-15.us.a.mail.aliyun.com [47.90.199.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A0763CA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 04:05:16 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vds.3uU_1678791867;
Received: from 30.221.131.40(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vds.3uU_1678791867)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 19:04:28 +0800
Message-ID: <b27307e0-2c7d-bcad-cbc8-f587fdf0eaa0@linux.alibaba.com>
Date:   Tue, 14 Mar 2023 19:04:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [BUG REPORT] arch/x86/include/asm/uaccess_64.h:119: Error: junk
 at end of line
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <a9aae568-3046-306c-bd71-92c1fc8eeddc@linux.alibaba.com>
 <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20230314102316.GAZBBLFHKqQr9RSeM+@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/14/23 6:23 PM, Borislav Petkov wrote:
> On Tue, Mar 14, 2023 at 11:12:13AM +0800, Jingbo Xu wrote:
>> 	gcc (GCC) 6.5.1 20181026 (Alibaba 6.5.1-1)
> 
> Looks like you should complain to whoever patched this gcc and broke it
> in the process. Unless you can reproduce the issue with an official
> compiler...
> 

Yeah, thanks for the reply.  I will try if I have a chance, though I
doubt if I could compile the official compiler from the ground.

-- 
Thanks,
Jingbo
