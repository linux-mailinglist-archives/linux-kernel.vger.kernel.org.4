Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5CB6F4659
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjEBOvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjEBOvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:51:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079DB1BD8;
        Tue,  2 May 2023 07:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=xRd8948Rcur7p+AyV/ClewooI+HHz+axyJ/J+7e04cU=; b=dWYZLifTtQdNxW8QJ/u6b6l1tP
        OyFHnp69RP7UtLVU2KnRHM6NTKyPhKT5GFlI0FP1gRZ6Xfa5sepiExl0qjx/PJbE7Paz0mESUjuu2
        cze4qvY0ennY1Zytm7GpXjgh3uAq3afUiC+fQzlOQjpWtmKKUAzlwnXlDJgu5IM0Ps6+dpnpFriqj
        skZc/WJfVfQu1/2V+ZcJP6dpZpRBQ04cDkDS/VQbULFvf0hX9eSukLwz0b9h3fBkiy16jqZE3PTR8
        hTTHSrD2BVijs0fMNfyI/VoXRQYEHRwAzg2QnDAe//oLsAEiASNr7uGEeF8zU3QX43KNoRLzXqmNq
        I0fSz0BA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1ptrLS-001rl5-2t;
        Tue, 02 May 2023 14:51:10 +0000
Message-ID: <749e60bd-b861-8766-93b0-b421bfeefd47@infradead.org>
Date:   Tue, 2 May 2023 07:51:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] docs: consolidate human interface subsystems
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        open list <linux-kernel@vger.kernel.org>
References: <20230501154258.277866-1-costa.shul@redhat.com>
 <202305021306.dKifEdb7-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202305021306.dKifEdb7-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi bot,

Already reported and fixed.
Thanks.

On 5/1/23 22:37, kernel test robot wrote:
> Hi Costa,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on lwn/docs-next]
> [also build test WARNING on linus/master v6.3 next-20230428]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Costa-Shulyupin/docs-consolidate-human-interface-subsystems/20230501-234438
> base:   git://git.lwn.net/linux.git docs-next
> patch link:    https://lore.kernel.org/r/20230501154258.277866-1-costa.shul%40redhat.com
> patch subject: [PATCH v2] docs: consolidate human interface subsystems
> reproduce:
>         # https://github.com/intel-lab-lkp/linux/commit/2df620e4b9e2c2827f8a5519f6c266e9e5ef85be
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Costa-Shulyupin/docs-consolidate-human-interface-subsystems/20230501-234438
>         git checkout 2df620e4b9e2c2827f8a5519f6c266e9e5ef85be
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>         make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305021306.dKifEdb7-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Documentation/subsystem-apis.rst:14: WARNING: Title underline too short.
> 
> vim +14 Documentation/subsystem-apis.rst
> 
>     12	
>     13	Human interfaces
>   > 14	---------------
>     15	
> 

-- 
~Randy
