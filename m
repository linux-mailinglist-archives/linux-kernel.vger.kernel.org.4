Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9686962D3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 08:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239160AbiKQHPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 02:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbiKQHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 02:15:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7CD6F35C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 23:14:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EAE7B81BA4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 07:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B0BC433D6;
        Thu, 17 Nov 2022 07:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668669297;
        bh=f+5O57P5ui3Q/tzR+LBa6AHXgRobOIxWOJ/6DL0ZHdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IQcpTRI0BhVaigGLuynSmrO2/XCsaNtn28fNDm8P+31Tc01IANtP0Q0j6lI1NuOGG
         +R7jXQ01euJuaPGu9yuntuP4nvW/JhMfOdN1gTqQYPOieNIUUmrLs8gfbPn1FY+Kjs
         f8vG/WRUsZJyZWtbXcPxovPv/x5aMQMfqI1tgSFXYrzkzb7oF9zx0q5OxU8CuxDFiI
         ifnZXI9Mfjh2n6SUjhIgQ2DDeo9FVr1KzfHAlE0ZCEqMXZCgZPiZxoXVM5TZygIzvy
         hf6rBrrF/lpHDv0GciW7Dxu8QaZq6XnG0QVneuWF2Kcai+vFP61i1yYFphoI3bW9M+
         zlB0NFF9AGmjg==
Date:   Thu, 17 Nov 2022 16:14:53 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>, <zanussi@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] tracing: kprobe: Fix potential null-ptr-deref on
 trace_array in kprobe_event_gen_test_exit()
Message-Id: <20221117161453.e1dc1c98358017d86a4d5a11@kernel.org>
In-Reply-To: <20221116215536.120b0b74@gandalf.local.home>
References: <20221108015130.28326-1-shangxiaojing@huawei.com>
        <20221108015130.28326-3-shangxiaojing@huawei.com>
        <20221108233846.fcff734a2f4b1a2a091fb831@kernel.org>
        <20221116215536.120b0b74@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2022 21:55:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 8 Nov 2022 23:38:46 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > Fixes: 64836248dda2 ("tracing: Add kprobe event command generation test module")
> > > Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>  
> > 
> > This looks good to me.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Hi Masami,
> 
> Did you want me to pull these on top of your probes/urgent branch?

No, I think these patches are already queued on probes/urgent :)

https://kernel.googlesource.com/pub/scm/linux/kernel/git/trace/linux-trace.git/+/210880de4e3945d0ac028894df578063205bef61

> 
> I'm going through all my patches now and will be starting the testing
> hopefully later this week.

Thanks!

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
