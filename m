Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541696C9B47
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC0GIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0GIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:08:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 199154209
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 23:08:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBCBD4B3;
        Sun, 26 Mar 2023 23:09:26 -0700 (PDT)
Received: from [10.162.42.7] (a077893.blr.arm.com [10.162.42.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB7193F6C4;
        Sun, 26 Mar 2023 23:08:39 -0700 (PDT)
Message-ID: <4feeae36-f6fe-1422-9f0f-081b9106e91c@arm.com>
Date:   Mon, 27 Mar 2023 11:38:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] arm64: Disable EL2 traps for BRBE instructions executed
 in EL1
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
References: <20230324055127.2228330-1-anshuman.khandual@arm.com>
 <202303250802.KytExIHw-lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <202303250802.KytExIHw-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/25/23 06:07, kernel test robot wrote:
> All errors (new ones prefixed by >>):
> 
>>> <instantiation>:36:14: error: expected compatible register or logical immediate
>     orr x0, x0, #HFGITR_EL2_nBRBIALL
>                 ^
>    <instantiation>:10:2: note: while in macro instantiation
>     __init_el2_fgt
>     ^
>    arch/arm64/kernel/head.S:577:2: note: while in macro instantiation
>     init_el2_state
>     ^
>    <instantiation>:37:14: error: expected compatible register or logical immediate
>     orr x0, x0, #HFGITR_EL2_nBRBINJ
>                 ^
>    <instantiation>:10:2: note: while in macro instantiation
>     __init_el2_fgt
>     ^
>    arch/arm64/kernel/head.S:577:2: note: while in macro instantiation
>     init_el2_state
>     ^

I guess these build errors are caused by unavailability of the pre-requisite
patches from Mark Brown, in this test environment ?

https://lore.kernel.org/all/20230306-arm64-fgt-reg-gen-v3-0-decba93cbaab@kernel.org/
 
