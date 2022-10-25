Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018FE60C0EF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 03:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiJYBXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 21:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiJYBX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:23:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019B2BF0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666659167; x=1698195167;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=nRE6A5lmAxWlU7CVYMs4FmrAg+9rjTqNys4/K0xdBQY=;
  b=KLk1zq70cZn6Pr2fwANyG7gju8P2PQ4R7j1Ob/vekDLJzix21JLUVysa
   fhQzw7oMME9m8GkkdT+gth5dLvrILI9gn8GjSrtkRhldh30sNyLbyQ1Mz
   2HINTip9kAJFYdlbRM2donqP30OSAZWFILUnAS94xb9Lr8FMsA0x/PsD2
   CZi6WerlS/1LFvIG4WEgWOiwnEZdE76XmJWY+iYJ81kp2VQE6nHTgIMRZ
   OUliPzycUp1UtEMLiLB9yluGosxhicsZixut/bzRZsyPPZS9cggkfQ8dw
   6VYS+3uuAwnT48hlwO8cGVMSLW3ifO2eYGrgflzrwOpKfdQzfrTf3xXPs
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="290859287"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="290859287"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:52:46 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="626249962"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="626249962"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.208.181]) ([10.254.208.181])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 17:52:45 -0700
Subject: Re: [kbuild-all] Re: {standard input}:24403: Error: Insn slot not set
 in unwind record.
To:     Kees Cook <keescook@chromium.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210211348.RQ11yRji-lkp@intel.com>
 <202210210913.11F9095@keescook>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <99f595f0-cbd7-f142-2249-5dfbb8f5a006@intel.com>
Date:   Tue, 25 Oct 2022 08:52:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202210210913.11F9095@keescook>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/2022 12:13 AM, Kees Cook wrote:
> On Fri, Oct 21, 2022 at 01:32:16PM +0800, kernel test robot wrote:
>> Hi Kees,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   aae703b02f92bde9264366c545e87cec451de471
>> commit: a82adfd5c7cb4b8bb37ef439aed954f9972bb618 hardening: Introduce CONFIG_ZERO_CALL_USED_REGS
>> date:   1 year, 3 months ago
>> config: ia64-randconfig-r024-20221020
>> compiler: ia64-linux-gcc (GCC) 12.1.0
> 
> This feature isn't supported on ia64 -- I don't see how this commit
> could be causing the warnings.
> 

Hi Kees,

Thanks for your reply, we will disable CONFIG_ZERO_CALL_USED_REGS for ia64.

Best Regards,
Rong Chen
