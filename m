Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD0623E44
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiKJJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiKJJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:07:47 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26268C58
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:07:44 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id C315C32009AE;
        Thu, 10 Nov 2022 04:07:43 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 10 Nov 2022 04:07:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1668071263; x=1668157663; bh=T3x34a1H/C
        1mLXlkkNwiCjUxEoL7S4kayB67+oVUgAE=; b=Ys2eGsJq14k2wljt9UkNox4R7L
        Vh/hLFeCjBW1jANTj/8E4aXSa+bvR64Gnp/nNtqjEARjVC+ML2G9XMApmws6LOGt
        ISxq4igoH7fv+AwUEkKHeO+h6lyUoBWdPtbOm1mAaAvgGZHpxMwVtvtcGS227a0F
        5CGb7yAcOGaLVAdsA2M9mv031RaP0WjDNDrUjc5vJvDUaSfJYn2j0Z7WPHld/K16
        fGUXT0De82eQC5YowgLFoVwm8MBKVIjJfobjrjDdYOrSQ88dFGnLKE1BkSxLvrpv
        Lp/vmn3Gw3WGXVWs7nSKkIfZ6quMBNOponRNp8R6cMnDSyGexuGjjk+Jf81g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668071263; x=1668157663; bh=T3x34a1H/C1mLXlkkNwiCjUxEoL7
        S4kayB67+oVUgAE=; b=bGrSX443f0T4seUQJakO4BaPI/we3l0LuzzAmNSbLCOb
        V9ZdAxnfSnPbXahKRm2hDADXR36IK4+59tbcXLXAAl7tMYcrJnBRHsU6oU6+MExT
        2/mgo4hbMg2u87WYZ2Nw+bqw4+zchPEgLxrFVNjf2WLSGXxRcZ2EdyfLMdxFtPgw
        grKfPGlZwo2cV8aC9UAOqgrTK9uV67t1p8kQBbOfH1zXXe327pBlu6Hx5TcX+orh
        tRCH6sQNDid2aQsdWZHMTU+pxNqvle8a0gK+BeuulOO72iE4xuT/qUVZMM2RSLWb
        +VmGCiA0bAwtcxUCpV4yjm0bEfEFcnevDpEgtdzWag==
X-ME-Sender: <xms:Xr9sYwkHVshbsMbBvxcxBHbuwCqOobPYphq_ek2LDMJ4mY6wDNZCuA>
    <xme:Xr9sY_0wNSlm9v1NVCyDuGYAjnOtaNOvf9ma0CDSMGbx-mxgbk367x9T9owNez4oK
    hcWFhX_xNPH2sZS9NU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeegucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtre
    ertdenucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgu
    sgdruggvqeenucggtffrrghtthgvrhhnpeehueeuvedtffejgefgieeikeejheduieevff
    fgvdfhveeugfeffffhfeehteefudenucffohhmrghinhepghhithdqshgtmhdrtghomhdp
    ghhithhhuhgsrdgtohhmpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:Xr9sY-qBRdxe8OVkPS3xbAMwHIhiZbJ_3NuF-FMe-1iefM3CQrwTwA>
    <xmx:Xr9sY8n46zBDN_xqNdgHUq9Rv5Vb2uTyzkYH3bWO4ElcbjkXMNeuEg>
    <xmx:Xr9sY-1HjbkiWnY5p0Mvq4irENpiAWnfZcN4OBDWDBzqiQdBxuBQWw>
    <xmx:X79sY4pAZ8XPZBRLVDc7EeuyVsSssEsZ0ZwLvZDwB5K7DrNl6xPjFQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 94645B60086; Thu, 10 Nov 2022 04:07:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <88fce16b-5092-4246-8bbf-23f2c03224f3@app.fastmail.com>
In-Reply-To: <202211101659.j9z9jLHv-lkp@intel.com>
References: <1667889638-9106-1-git-send-email-zhiguo.niu@unisoc.com>
 <202211101659.j9z9jLHv-lkp@intel.com>
Date:   Thu, 10 Nov 2022 10:07:21 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "zhiguo.niu" <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org,
        chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        niuzhiguo84@gmail.com
Subject: Re: [PATCH V2] f2fs: fix atgc bug on issue in 32bits platform
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022, at 09:33, kernel test robot wrote:
> Hi zhiguo.niu",
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on jaegeuk-f2fs/dev-test]
> [also build test WARNING on linus/master v6.1-rc4 next-20221109]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    
> https://github.com/intel-lab-lkp/linux/commits/zhiguo-niu/f2fs-fix-atgc-bug-on-issue-in-32bits-platform/20221108-153745
> base:   
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git 
> dev-test
> patch link:    
> https://lore.kernel.org/r/1667889638-9106-1-git-send-email-zhiguo.niu%40unisoc.com
> patch subject: [PATCH V2] f2fs: fix atgc bug on issue in 32bits platform
> All warnings (new ones prefixed by >>):
>
>    In file included from fs/f2fs/gc.c:22:
>>> fs/f2fs/gc.h:65:2: warning: field  within 'struct victim_entry' is less aligned than 'union victim_entry::(anonymous at fs/f2fs/gc.h:65:2)' and is usually due to 'struct victim_entry' being packed, which can lead to unaligned accesses [-Wunaligned-access]
>            union {

It looks like the problem is the extra unqualified __packed annotation
inside of 'struct rb_entry'. Removing that is probably better than
adding extra __packed annotation that just lead to less efficient
code.

     Arnd
