Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16DD628C60
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237159AbiKNWzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbiKNWzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:55:49 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A5218E15
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 14:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668466548; x=1700002548;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=EZ/crrnadC6FZuL7yBtXGWmT4C8UtSxOOH2Ei2CQ/g8=;
  b=C+RhvfDE9PrdGibCs+5lX261yP6E4seqQBS/G1iGgBH7HE6puu7bDMhC
   edmDgtS93lAi+3cW/XcFbP9HQsEVX3ASCa2vaMbKbjS0PSw82jGZ50DV3
   abhfw+scxaqxIVpbqsVJW+w31gE3MH9G/RDEZyaAz+8X/Zur5eHn9wyZi
   pGY8S7s/f2OYkp03awLkVAdnCcNEPusB1TM3rfIOZdlQn8j8tqoQ3rMvA
   K9pas13zQWaS3ZK96gB74/HLOLKKwfYHTKkIOx3HAEfuk9Lk5c5RhaGn9
   Lffo7ZU+kht8D62CJaMEKi5MlVxReYPmli/rf8M/1qAoe8DYS6KSeA5k3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295465772"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295465772"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 14:55:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="763671861"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="763671861"
Received: from satyanay-mobl1.amr.corp.intel.com (HELO [10.209.114.162]) ([10.209.114.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 14:55:47 -0800
Content-Type: multipart/mixed; boundary="------------kmmSIrzdsbBte0dHQX96MiNE"
Message-ID: <fdae3de9-db03-b04d-1992-bc8efd053053@intel.com>
Date:   Mon, 14 Nov 2022 14:55:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [tip:x86/mm 5/16] sound/core/hwdep.c:243:24: sparse: sparse:
 incorrect type in assignment (different address spaces)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>
References: <202211150551.T7mpZomP-lkp@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <202211150551.T7mpZomP-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------kmmSIrzdsbBte0dHQX96MiNE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/22 13:41, kernel test robot wrote:
>    sound/core/hwdep.c:243:24: sparse:     expected int [noderef] __user *__ptr_clean
>    sound/core/hwdep.c:243:24: sparse:     got int *
>    sound/core/hwdep.c:273:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
>    sound/core/hwdep.c:273:29: sparse:     expected int [noderef] __user *__ptr_clean
>    sound/core/hwdep.c:273:29: sparse:     got int *
>    sound/core/hwdep.c:292:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected int [noderef] __user *__ptr_clean @@     got int * @@
>    sound/core/hwdep.c:292:29: sparse:     expected int [noderef] __user *__ptr_clean
>    sound/core/hwdep.c:292:29: sparse:     got int *

I think the sparse ends up throwing away all of its annotations once it
dereferences a pointer.  So, '*(int __user *)' boils down to a plain
'int'.  Confusingly, a '*(int __user *) *' boils down to an 'int *'.

That's what happened here.  A __user-annotated point got dereferenced
down to an 'int' and then turned into a pointer again.

I think the trick in this case is to avoid dereferencing the pointer too
early by just moving the dereference outside of the casting, like the
attached patch.  But, it also feels kinda wrong.  I'd love a second
opinion on this one.
--------------kmmSIrzdsbBte0dHQX96MiNE
Content-Type: text/x-patch; charset=UTF-8; name="lam-sparse.patch"
Content-Disposition: attachment; filename="lam-sparse.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaCBiL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaAppbmRleCAwZGI2ZjU0NTE4NTQuLmI4OTQ3YjYyM2M3
MiAxMDA2NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdWFjY2Vzcy5oCisrKyBiL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL3VhY2Nlc3MuaApAQCAtMzksNyArMzksNyBAQCBzdGF0aWMg
aW5saW5lIGJvb2wgcGFnZWZhdWx0X2Rpc2FibGVkKHZvaWQpOwogI2RlZmluZSB1bnRhZ2dl
ZF9wdHIobW0sIHB0cikJKHsJCQkJCVwKIAl1NjQgX19wdHJ2YWwgPSAoX19mb3JjZSB1NjQp
KHB0cik7CQkJCVwKIAlfX3B0cnZhbCA9IHVudGFnZ2VkX2FkZHIobW0sIF9fcHRydmFsKTsJ
CQkJXAotCShfX2ZvcmNlIF9fdHlwZW9mX18oKihwdHIpKSAqKV9fcHRydmFsOwkJCQlcCisJ
KihfX2ZvcmNlIF9fdHlwZW9mX18oKHB0cikpICopX19wdHJ2YWw7CQkJCVwKIH0pCiAjZWxz
ZQogI2RlZmluZSB1bnRhZ2dlZF9hZGRyKG1tLCBhZGRyKQkoYWRkcikK

--------------kmmSIrzdsbBte0dHQX96MiNE--
