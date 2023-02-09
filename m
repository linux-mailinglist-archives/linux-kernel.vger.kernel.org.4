Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF56905C4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 11:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjBIK4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 05:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjBIK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 05:56:16 -0500
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B5056EE7
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 02:56:08 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id ba1so1343132wrb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 02:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:reply-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nI9T+AQz1+dV/jBLbAFGeWInH/0hQg7GP5KPwF46GRk=;
        b=pnPZUClwtDny6T/4lCnAt059GMF3QNW2oa1xrmqBi6T+lXUqJH7Y1Z0yG9foYzvksl
         XJxFTk+wm2hyKac62jv4cAaszCVifh3pljbC5B7IvSbxm7dpwik2AnHqhVeMNQRFCx56
         LfT+4CYLeJX9t5CA8wcwXCd7DcKEC6VQlRM8SQwUPNMB3B8p6kzVf3YyYwAoPb8pum4N
         xqMsH2T43MnjF9otsBTKw6G52ZVMbfC7qFib5i8ptQ6WZbNaHkKqgv1sRuDRkMhw+HDn
         bRsC1V0Rr35eGHYXb63m3kS8DRAUDLmPVUWVyszaqTsQMyEN+nI+KbCTHDCBKRd/ltiQ
         rNjg==
X-Gm-Message-State: AO0yUKVW+VtcEhTGS25dFy2LCN7POdJ4524/mjiHwMd0JdhOrZbN7anm
        fAJGwirSb8zy9zf4y/jJJ/Xz8w==
X-Google-Smtp-Source: AK7set+YuRliv5UJGRVt0f4Ijeerjk2JVeEcRsrOXrC9bWzwyBPD881P5rCMJgwHAoBTX/HMIouT6Q==
X-Received: by 2002:adf:f912:0:b0:2c3:db9e:4aff with SMTP id b18-20020adff912000000b002c3db9e4affmr9678292wrr.45.1675940166436;
        Thu, 09 Feb 2023 02:56:06 -0800 (PST)
Received: from fedora.fritz.box (p549440c4.dip0.t-ipconnect.de. [84.148.64.196])
        by smtp.gmail.com with ESMTPSA id q7-20020adfdfc7000000b002c3daaef051sm933969wrn.82.2023.02.09.02.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 02:56:06 -0800 (PST)
Date:   Thu, 9 Feb 2023 11:56:03 +0100
From:   Damian Tometzki <dtometzki@fedoraproject.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] objtool: Honey, I shrunk the instruction
Message-ID: <Y+TRQ862hrEokeqh@fedora.fritz.box>
Reply-To: Damian Tometzki <dtometzki@fedoraproject.org>
Mail-Followup-To: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jpoimboe@redhat.com, linux@weissschuh.net,
        linux-kernel@vger.kernel.org
References: <20230208171756.898991570@infradead.org>
 <Y+QEak2HWlkNuJ3U@fedora.fritz.box>
 <Y+TJbNHT3jDF8wov@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+TJbNHT3jDF8wov@hirez.programming.kicks-ass.net>
User-Agent: Mutt
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09. Feb 11:22, Peter Zijlstra wrote:
> On Wed, Feb 08, 2023 at 09:22:02PM +0100, Damian Tometzki wrote:
> > On Wed, 08. Feb 18:17, Peter Zijlstra wrote:
> > > Hi,
> > > 
> > > Boris complained he could no longer build allyesconfig on his 32G desktop
> > > machine without having OOM terminate either objtool or chrome.
> > > 
> > > After talking about these patches on IRC, Nathan mentioned the linux-clang CI
> > > was also having trouble of recent, and these patches appear to make it happy
> > > again.
> > > 
> > > In total these patches shrink an allyesconfig run by about 6G:
> > > 
> > > pre:	5:58.22 real,   226.69 user,    131.22 sys,     26221520 mem
> > > post:	5:03.34 real,   210.75 user,    88.80 sys,      20241232 mem
> > > 
> > > Also at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/log/?h=objtool/core
> > > 
> > Hello Peter,
> > 
> > with clang-17 the build failed: 
> > In file included from weak.c:10:
> > In file included from /home/damian/kernel/linux/tools/objtool/include/objtool/objtool.h:13:
> > /home/damian/kernel/linux/tools/objtool/include/objtool/elf.h:88:86: error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]
> > static_assert(offsetof(struct reloc, rela.r_offset) == offsetof(struct reloc, offset));
> 
> Oh urgh. Apparently the kernel wrapper went missing in this userspace
> project :-)
> 
> include/linux/build_bug.h:#define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
> 
> Anyway, it's that last patch and I meant to do that in a slightly less
> horrid way :-)

Hello Peter,

here a shortipossible fix: 
Then the build with clang works. 

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 83b100c1e7f6..b7c8b476db95 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -31,7 +31,7 @@ INCLUDES := -I$(srctree)/tools/include \
            -I$(LIBSUBCMD_OUTPUT)/include
 # Note, EXTRA_WARNINGS here was determined for CC and not HOSTCC, it
 # is passed here to match a legacy behavior.
-WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs
+WARNINGS := $(EXTRA_WARNINGS) -Wno-switch-default -Wno-switch-enum -Wno-packed -Wno-nested-externs -Wno-c2x-extensions
 OBJTOOL_CFLAGS := -Werror $(WARNINGS) $(KBUILD_HOSTCFLAGS) -g $(INCLUDES) $(LIBELF_FLAGS)

