Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF57E5B2F01
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiIIGbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbiIIGbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:31:09 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1124115399
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:31:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 1C8FD2B05978;
        Fri,  9 Sep 2022 02:31:03 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 09 Sep 2022 02:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1662705062; x=1662708662; bh=K9iikWOA/1
        IVDDvIobqfcasOZlnOAxoVFr2dYUjzOz8=; b=gnstzkbAYpD8FW/LCtaRgzo9Ww
        XyWF209RJkz7P99RBvl6sfuxMvv1wj0J9QPiljEYk7BtMl5IdnO/7DkLiO/KXYJe
        BlsTTSIgn++QuzGG+ACL44TvrbXbiRRng2qKtxCXEbd1CC7CLAwuxf15I7keQdC2
        j8GuPlkaddm/ueZcSFp5u3zv4F62jv/yQg/tyPu24vVV8Mi4DgxRHF/DKMrjSnR3
        2nMn1Q3vN7S8cuHl0N660JifThm9wfAIcKH7G1YtdvmVq8p1BHw6E9gQM05EUxxA
        SYK3tMBB3Z9+rlIUrnxHbUS1S3RoqbVjSQ0NeNT6I0WECnUCOG5lHxyFC4yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1662705062; x=1662708662; bh=K9iikWOA/1IVDDvIobqfcasOZlnO
        AxoVFr2dYUjzOz8=; b=GT+MkfO4MhjamkwXxL0p8nmnrGqxlabJAqUod6w54PBn
        iMCjaDDogLmwfebjSk+K+u45wiM7HxEHQbeLAmebgkqP7cyyMGZa1I8Z/A/OdD1y
        XrN5LfCBsgN/xbwn3QUbHPS+fhltiWMIBP/HvIvnhybZH44kh70jHHULiqaqCVJs
        oJ7VYHT6Vdw5bgJ0T6QAQQdpyBE8QTyTKMI98O1IbDlHBk2PjXXd3+4XFS5AznYs
        rC8dF+BMACpwuVvfF77U8RKPAtI6iMYYYpq1IgaVjkG2UT9lfqxgMi4ePk4OQJIW
        4nFlEy8vE1PYgrwOwOPv7On/7CwoW8nulZI2cwRM0A==
X-ME-Sender: <xms:pd0aY7EkB4juCIdgtRHiW0_VBDR28QSPwhKCW8Wh0g3njAaxIH7IxQ>
    <xme:pd0aY4XBI--guxapbKyxyxM8jzYY7LRGq0kW_vR71-2PI6n-vYqOcphN8PAuVCy4b
    zddzl92ql8e2cJ-fOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedtgedguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeevuedtueejfeehleefveelueekjeeghfegjeduieegteetkeeiueeiveef
    iedtteenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhgihhthhhusghushgvrhgtoh
    hnthgvnhhtrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:pd0aY9I7E6Yq_kWXXrILipSIXZgmMmqLzlHlUQwsN20stDNJ2mMY5A>
    <xmx:pd0aY5GQaoTJSL1YUBRKlvVCIDGHEpzXSHWSJI4tdVEpVgjFaiJKgA>
    <xmx:pd0aYxWYMV9EvIsRAAC0Mi3y1R9HhRIpagZBbcJj3rnHttfmej19Yg>
    <xmx:pt0aY_fsKj8VRZ6qRESRYi5PETKVVLkYGmJPMzUs3kRtQpnW9DFOUaTcUOQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9A6DDB60086; Fri,  9 Sep 2022 02:31:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-927-gf4c98c8499-fm-20220826.002-gf4c98c84
Mime-Version: 1.0
Message-Id: <a37a1b71-e7b4-4b7a-9aec-a9ce64d13d84@www.fastmail.com>
In-Reply-To: <202209091157.akimiv18-lkp@intel.com>
References: <202209091157.akimiv18-lkp@intel.com>
Date:   Fri, 09 Sep 2022 08:30:37 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "kernel test robot" <lkp@intel.com>,
        "Qi Zheng" <zhengqi.arch@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "Ammar Faizi" <ammarfaizi2@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        "Catalin Marinas" <catalin.marinas@arm.com>
Subject: Re: [ammarfaizi2-block:arm64/linux/for-next/misc 2/2]
 arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function
 'do_softirq_own_stack'
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022, at 5:12 AM, kernel test robot wrote:
> tree:   https://github.com/ammarfaizi2/linux-block 
> arm64/linux/for-next/misc
> head:   2d2f3bb897a3de4190b1b6b296c3429d01327554
> commit: 2d2f3bb897a3de4190b1b6b296c3429d01327554 [2/2] arm64: run 
> softirqs on the per-CPU IRQ stack
> config: arm64-randconfig-r023-20220907
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 
> 1546df49f5a6d09df78f569e4137ddb365a3e827)
> reproduce (this is a W=1 build):
>         wget 
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # 
> https://github.com/ammarfaizi2/linux-block/commit/2d2f3bb897a3de4190b1b6b296c3429d01327554
>         git remote add ammarfaizi2-block 
> https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block arm64/linux/for-next/misc
>         git checkout 2d2f3bb897a3de4190b1b6b296c3429d01327554
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 
> O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/
>
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>>> arch/arm64/kernel/irq.c:81:6: warning: no previous prototype for function 'do_softirq_own_stack' [-Wmissing-prototypes]
>    void do_softirq_own_stack(void)
>         ^
>    arch/arm64/kernel/irq.c:81:1: note: declare 'static' if the function 
> is not intended to be used outside of this translation unit
>    void do_softirq_own_stack(void)
>    ^
>    static 


I think we are missing an "#include <asm/softirq_stack.h>"
in arch/arm64/kernel/irq.c

       Arnd
