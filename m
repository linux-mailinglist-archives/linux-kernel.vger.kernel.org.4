Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E996F7A06
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 02:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjEEARX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 20:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEEARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 20:17:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D40F12086;
        Thu,  4 May 2023 17:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8P6fcTVxsMF519vNXnL9K7OSXAWwfB2dslsfi2BADrA=; b=U85b1ouWKxJgMjYKeI2BS1kt/x
        1ecu6ZjrDAB0Gece6y8Tx62OpQCKvlBJdTuEQH1ijqjEPEIYfXhdrPw5xBNcRwq3Eg538brhB4ZDO
        qYBPpLKlOD+CEw2fY6xAK3UO3dlR1OX/b/GYuwDkubtVfmXSdD9Og87O21QZYcdEwBoY11WxJnG3T
        wVT882c1dhHpCYHVJ87FU4NcmWYtqAPyJIL0yWBspd07tmrKb+Dre5PJE83hgZPu6APwO/37MGxyi
        XCtSutKM39jB+BDXHWfv29ow2fnQ37ebje+7qxW5HAnJZ02bCoWm8OqJh2XVSo+odiOgaviY69G4J
        eGqPdczw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1puj8M-009NV4-03;
        Fri, 05 May 2023 00:17:14 +0000
Message-ID: <aa2efa2f-70ea-09b4-f21b-8e69f18fad1e@infradead.org>
Date:   Thu, 4 May 2023 17:17:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [tip:master 4/4] htmldocs: Warning: arch/x86/Kconfig references a
 file that doesn't exist: Documentation/x86/shstk.rst
To:     kernel test robot <lkp@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-doc@vger.kernel.org
References: <202305050705.5V1x1V3i-lkp@intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202305050705.5V1x1V3i-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/23 16:13, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> head:   da1c4f07aa4dd227a57103fef1215e7cef3f35a9
> commit: da1c4f07aa4dd227a57103fef1215e7cef3f35a9 [4/4] Merge branch 'x86/shstk'
> reproduce:
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=da1c4f07aa4dd227a57103fef1215e7cef3f35a9
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip master
>         git checkout da1c4f07aa4dd227a57103fef1215e7cef3f35a9
>         make menuconfig
>         # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
>         make htmldocs
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202305050705.5V1x1V3i-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> Warning: arch/x86/Kconfig references a file that doesn't exist: Documentation/x86/shstk.rst

which has been moved to Documentation/arch/x86/shstk.rst.

+cc: linux-doc

-- 
~Randy
