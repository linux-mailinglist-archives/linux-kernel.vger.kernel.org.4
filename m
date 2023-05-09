Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484F26FC886
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 16:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjEIOHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 10:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjEIOHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 10:07:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FBF1FE3;
        Tue,  9 May 2023 07:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683641236; x=1715177236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=itta2RabQFLCVWDvddFM5G10qfVra9oGOcBsE7R9+is=;
  b=hXldW5HE10/ofCLJGrc2WHVuc7pzdnsq+uxeu8Xq8Lkq4VRL4drlaz49
   cl2rnZ2c+ViY9t5u+0CP8d4E0zERjHKMBSw7enr9Zf/R5n6oHB2Nh6MLh
   gi1bJC1YIhmJ3O14d7xkREPsink/0r6geE+mwgApLVhfcE1Oy9ZH+2CFN
   TEbCvZQtTa4EoNW9D6W2MN6m4e08NYOs1l3hKwLIrzUar5+E1OwT/SjdG
   N8PP5eGDZqCOK573R2Jfbh8hgsCLGUOvM5uFe8Du6AaF5g1IKrL10VeA+
   ls0WYNXUJO3qTRSTFQZu/GgYsxLuIT0JmcGWFi0avxB2qU/RIZP/wSm4a
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="436252058"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="436252058"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 07:07:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="788543999"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="788543999"
Received: from dcourtn1-desk1.amr.corp.intel.com (HELO [10.212.182.218]) ([10.212.182.218])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 07:07:15 -0700
Message-ID: <7cbe80f0-dcc3-bfc3-3bd8-c9f96704618d@intel.com>
Date:   Tue, 9 May 2023 07:07:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] x86: make config X86_FEATURE_NAMES visible with EXPERT
Content-Language: en-US
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230509084007.24373-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/23 01:40, Lukas Bulwahn wrote:
> Commit 6a108a14fa35 ("kconfig: rename CONFIG_EMBEDDED to CONFIG_EXPERT")
> introduces CONFIG_EXPERT to carry the previous intent of CONFIG_EMBEDDED
> and just gives that intent a much better name.

That was quite the changelog, and I'm still not quite sure:

What is the problem with the existing code?

What is the end user visible impact of this problem and of this proposed
change?


