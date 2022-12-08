Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7AD64695A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:38:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLHGiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:38:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiLHGh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:37:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EC01A226;
        Wed,  7 Dec 2022 22:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670481477; x=1702017477;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=ShT+ZD6fVU/pCoOfY8/3F97mt4AfaTyb9fhvY7J7pvU=;
  b=ZS5Nkz3Kz5Hd7inLAs651smHn8TrXbso07gnA+pG0trhfmepbfWivnVt
   GQv40vPsJ/eXIXCYIW0gDM/VtkWSxcgpaBGu1q0ybukyaVfWSj/CF4jmO
   PCGkQTNxBn9ebku8ULncRPCflEyWNPaNWJ6Q0WZrjhzMPV4fBs2XcL3yU
   F2NWo/0e03rk/s5rL4PQgWBcuSjTX8gLozOwM1dktapm1NeHpgVsdw5nY
   hmE6OvwhJCdXK+qQn6LnqEAo6HNCmDDgNX7c+b630/lDud7HggdvaDwtK
   Txh3I7QlalwdfIvZuKka06AcC7Pg+4rK8xXrPLOgJkNxLv/XGtqGkMAhc
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="318942206"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="318942206"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 22:37:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="753428003"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="753428003"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.215.59]) ([10.254.215.59])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 22:37:47 -0800
Subject: Re: lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of
 1120 bytes is larger than 1024 bytes
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        kernel test robot <lkp@intel.com>
Cc:     "Jason A. Donenfeld" <zx2c4@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
References: <202211072109.qvrnjNKo-lkp@intel.com>
 <Y5Flnb8jadyDebx3@gondor.apana.org.au>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <d25ac395-4335-be88-9dc5-364f5715554f@intel.com>
Date:   Thu, 8 Dec 2022 14:37:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y5Flnb8jadyDebx3@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/2022 12:18 PM, Herbert Xu wrote:
> On Mon, Nov 07, 2022 at 09:18:05PM +0800, kernel test robot wrote:
>> Hi Jason,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   f0c4d9fc9cc9462659728d168387191387e903cc
>> commit: 2d16803c562ecc644803d42ba98a8e0aef9c014e crypto: blake2s - remove shash module
>> date:   5 months ago
>> config: i386-buildonly-randconfig-r006-20221107
>> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
>> reproduce (this is a W=1 build):
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2d16803c562ecc644803d42ba98a8e0aef9c014e
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 2d16803c562ecc644803d42ba98a8e0aef9c014e
> 
> This was fixed months ago with
> 
> commit d6c14da474bf260d73953fbf7992c98d9112aec7
> Author: Jason A. Donenfeld <Jason@zx2c4.com>
> Date:   Mon Jun 20 09:52:43 2022 +0200
> 
>      crypto: lib/blake2s - reduce stack frame usage in self test
> 
> Why is LKP still testing the old commit?

Hi Herbert,

Thanks for the information, I checked the result of the fix commit,
it reduced the stack frame but the warning still exists:

lib/crypto/blake2s-selftest.c:632:1: warning: the frame size of 1056 
bytes is larger than 1024 bytes [-Wframe-larger-than=]

We'll ignore commit 2d16803c56 to avoid reporting it again.

Best Regards,
Rong Chen


> 
> Cheers,
> 
