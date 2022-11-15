Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0167C628E53
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 01:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbiKOA2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 19:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKOA22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 19:28:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189B7263D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:28:27 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so12356055pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 16:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/YrBEvXICaKRM/i8fkul3YbdI3Fttajyw5Qa3v7k3N0=;
        b=M+ej6YNUBtys0+exFhbo4qCurKGDseeKtD/FNxml2fj+guJ2+Qh87tuvTgtCCI/+Uv
         j+bPQN3fUWRNWLMO9+gJoZ2Vui1aMAfIgRe64Qc23smrrY7zT2RrX5ixOHMecW3VVJnk
         uI8ZMgXwAj6GSRSnC+XKN61I+q0r7ao+JdPX9fmJwR5O/qU/h5tG3l+wXUHwxzCs/P7f
         WGkFeYU032XfgZIyT+8CnxpveQByvSH4loZqqGJsrlv6jlNy4eOVNaq6RYVPif/MdgMX
         4o8IyebiCPcATxs5IdXrKIQnyVfTfVA4xy4fVXSJJFHBrab6InVZHCxL01OOPQg5UVf8
         EDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/YrBEvXICaKRM/i8fkul3YbdI3Fttajyw5Qa3v7k3N0=;
        b=O4fdfst5397ujtfxUw7ZB4S4HhI1GkcZtQvz48iDdvG4XLbo6UA12swQBEUtqhCB0F
         ElnuaQ7CGpKDN49Oo1u7C9KQ0TjJLnOwJoFPJzsGua+Bc5bEpxT0nCL3aUGx3D37x6Gd
         VoaQQETP9YgWu2ZsAG/xBrEGlwpah93nQs2z1kPXu6Xb30QgW/S5JhzYIZTw0QdcnO3O
         3zAka92YVfMLFSSynqNMYEFiQLkRt4vpltwq96sS9lkgiCYTMbGYaJ34sOjiU8tG1xua
         Ni69+BaQxJVayFPhIPJ9QQH1d1YFR/8qw63fRHKWiGuJ/TJieCw6x0U/ppnQhlyTkZgP
         Y8Ag==
X-Gm-Message-State: ANoB5pltNHVDcQz+MQMacac7SSyh/j2aDPIlcpQqyZvnFudSTFcvnvKD
        E/YBbO9ELx4v20XL60DvP9V4qVYkUV9QTw==
X-Google-Smtp-Source: AA0mqf7/q7b6ssCUspm+iaDMDQjlHFtniiQNz/nCrmpeJBmB2STO3egYNbOX8UvBl9efghoGio6uIg==
X-Received: by 2002:a17:902:b695:b0:186:6a1d:331d with SMTP id c21-20020a170902b69500b001866a1d331dmr1543431pls.168.1668472106475;
        Mon, 14 Nov 2022 16:28:26 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id i3-20020a636d03000000b0046f6d7dcd1dsm6487819pgc.25.2022.11.14.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:28:26 -0800 (PST)
Date:   Tue, 15 Nov 2022 00:28:22 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <yujie.liu@intel.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kasan-dev@googlegroups.com, Han Ning <ning.han@intel.com>
Subject: Re: [tip:x86/mm] [x86/kasan] 9fd429c280:
 BUG:unable_to_handle_page_fault_for_address
Message-ID: <Y3LdJni8+ye/soOV@google.com>
References: <202211121255.f840971-yujie.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211121255.f840971-yujie.liu@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed BUG:unable_to_handle_page_fault_for_address due to commit (built with gcc-11):
> 
> commit: 9fd429c28073fa40f5465cd6e4769a0af80bf398 ("x86/kasan: Map shadow for percpu pages on demand")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git x86/mm
> 
> [test failed on linux-next/master f8f60f322f0640c8edda2942ca5f84b7a27c417a]
> 
> on test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake) with 128G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> [  158.064712][ T8416] BUG: unable to handle page fault for address: fffffbc00012de04
> [  158.074534][ T8416] #PF: supervisor read access in kernel mode
> [  158.074537][ T8416] #PF: error_code(0x0000) - not-present page
> [  158.095763][ T8416] PGD 207e210067 P4D 1fef217067 PUD 1fef216067 PMD 103344b067 PTE 0
> [  158.095770][ T8416] Oops: 0000 [#1] SMP KASAN NOPTI
> [  158.095773][ T8416] CPU: 34 PID: 8416 Comm: umip_test_basic Not tainted 6.1.0-rc2-00001-g9fd429c28073 #1
> [ 158.107429][ T8416] RIP: 0010:get_desc (arch/x86/lib/insn-eval.c:660) 
> [ 158.107465][ T8416] insn_get_seg_base (arch/x86/lib/insn-eval.c:725) 
> [ 158.117492][ T8416] insn_fetch_from_user (arch/x86/lib/insn-eval.c:1476 arch/x86/lib/insn-eval.c:1505) 
> [ 158.117496][ T8416] fixup_umip_exception (arch/x86/kernel/umip.c:353) 
> [ 158.187382][ T8416] exc_general_protection (arch/x86/kernel/traps.c:733 arch/x86/kernel/traps.c:721) 
> [ 158.187386][ T8416] asm_exc_general_protection (arch/x86/include/asm/idtentry.h:564) 

...

> We are sorry that the testcase and reproducing steps are not available
> for this case. Hope the call trace can help to investigate, and we can
> also help to do further verification if needed. Thanks.

Luckily, it's a known issue.

https://lore.kernel.org/all/20221110203504.1985010-3-seanjc@google.com
