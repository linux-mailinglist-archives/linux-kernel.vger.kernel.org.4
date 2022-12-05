Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1B864217D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 03:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiLECWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 21:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbiLECWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 21:22:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B1726D2
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 18:22:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E0D0B80D3A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F293C433D6;
        Mon,  5 Dec 2022 02:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670206964;
        bh=Cn3ezycj/hgkYZSmnsbG0Xf6HdocRNCz4W3bOYWZQHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6QV3gQL8KdKQRtnI97RBRU33hThuDBre20wmHsLq78A9IKp+XoYphbNbQuHIRPJD
         MwnMGMcJ/1UVyXycSk0K4yspT5/g1Any32rkVrgzPZNm3hYaPS1CYwE/nQnT2glgKh
         A3MkF3dCf5cFjBHfs9MxuAmgBWYpY0yR/+Cbch9EbBeKtAk1Wgp+1/X79GqmlYqA8K
         dYvwEmiFGzoPL3RO5GhFpMXe2jB4WFqGVKAXqjFXCiD/LGGhVOeJffxCMUqWTuGpQj
         eehc0VzDGR5Lz8B19fNpQAfttLJ74Ls7umlEEdZHdpJqNxFa+je00YB4lkRnngW4he
         Dqa55b2OZz22Q==
Date:   Mon, 5 Dec 2022 11:22:36 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     David Howells <dhowells@redhat.com>, rostedt@goodmis.org,
        mhiramat@kernel.org, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trace: Fix some checker warnings
Message-Id: <20221205112236.f99c6104e988aa4f3dd89cd0@kernel.org>
In-Reply-To: <202212022034.OqPXTS9u-lkp@intel.com>
References: <166992525941.1716618.13740663757583361463.stgit@warthog.procyon.org.uk>
        <202212022034.OqPXTS9u-lkp@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 20:43:15 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi David,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.1-rc7 next-20221202]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/David-Howells/trace-Fix-some-checker-warnings/20221202-040957
> patch link:    https://lore.kernel.org/r/166992525941.1716618.13740663757583361463.stgit%40warthog.procyon.org.uk
> patch subject: [PATCH] trace: Fix some checker warnings
> config: i386-randconfig-a012
> compiler: gcc-11 (Debian 11.3.0-8) 11.3.0
> reproduce (this is a W=1 build):
>         # https://github.com/intel-lab-lkp/linux/commit/90c2da2e191f0b26e8194f45579e8227c9950fa8
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review David-Howells/trace-Fix-some-checker-warnings/20221202-040957
>         git checkout 90c2da2e191f0b26e8194f45579e8227c9950fa8
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/trace/trace.c: In function 'trace_create_maxlat_file':
> >> kernel/trace/trace.c:1725:48: error: 'tracing_max_lat_fops' undeclared (first use in this function); did you mean 'trace_min_max_fops'?
>     1725 |                                               &tracing_max_lat_fops);
>          |                                                ^~~~~~~~~~~~~~~~~~~~
>          |                                                trace_min_max_fops
>    kernel/trace/trace.c:1725:48: note: each undeclared identifier is reported only once for each function it appears in
> 

This is not an error introduced by this patch, but the osnoise introduced this.
tracing_max_lat_fops is used from max latency tracer, hwlat tracer and osnoise
tracer, but it is defined only when the CONFIG_TRACER_MAX_TRACE and
CONFIG_HWLAT_TRACER.

commit 424b650f35c7 ("tracing: Fix missing osnoise tracer on max_latency")
may not enough. We need to add more CONFIG_OSNOISE_TRACER checks like below.

I think it is the time to introduce a shared config CONFIG_MAX_TRACE
for all those users to simplify the #ifdefs.

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5cfc95a52bc3..14f18edfe5bc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6572,7 +6572,8 @@ tracing_thresh_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
+#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
+	|| defined(CONFIG_OSNOISE_TRACER)
 
 static ssize_t
 tracing_max_lat_read(struct file *filp, char __user *ubuf,
@@ -7587,7 +7588,8 @@ static const struct file_operations tracing_thresh_fops = {
 	.llseek		= generic_file_llseek,
 };
 
-#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER)
+#if defined(CONFIG_TRACER_MAX_TRACE) || defined(CONFIG_HWLAT_TRACER) \
+	|| defined(CONFIG_OSNOISE_TRACER)
 static const struct file_operations tracing_max_lat_fops = {
 	.open		= tracing_open_generic,
 	.read		= tracing_max_lat_read,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
