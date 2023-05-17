Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6706707514
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 00:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjEQWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 18:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjEQWHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 18:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E37526B9
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 15:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A91E1649FD
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 22:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2A8FC433EF;
        Wed, 17 May 2023 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684361240;
        bh=VjehE0JPi1U6hK2fAfPULsGtur6W4PD/LmTa6nOKBTw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PC599t2vbpkArTEkjFqPLD1uWPIwQxymIzqOOUzgA1+FxWT5/PnZyWM3+EAt9h7Zm
         DWfFjM6r07zRugZTKPsfeT2gsHROiByUef/lGaY35imBSR13uZDtG2+yJVCzPpi7dV
         GupIBMTEgx8H9ZFYCTIAv9jyR/CsMD6PNIYyoUoPSIXFuuxJ50y9OuMpaR1rry7Xia
         xQK7n1cDSpvBjyIzu+eQqxGScJN8oum0BY7b3bdW+89kKVelWpsIwoB+rlTDY1ffAz
         tZlb08MBonMf2/gGORYqrIpJmO1uK2fT1v190SfsRFx0SebkjXHLKfXXWysZB9YwLi
         SBHfwBWp+GC/w==
Date:   Thu, 18 May 2023 07:07:16 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: Re: kernel/trace/fprobe.c:59 fprobe_handler() error: uninitialized
 symbol 'ret'.
Message-Id: <20230518070716.7a1e28868990bf433cb7c49d@kernel.org>
In-Reply-To: <3cf28006-42f0-434f-8962-7403190a33e9@kili.mountain>
References: <d3467332-3d5f-488a-b156-064cbd3d7873@kili.mountain>
        <20230517204505.f6411ff8ed3f782ae23e1af9@kernel.org>
        <3cf28006-42f0-434f-8962-7403190a33e9@kili.mountain>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 20:47:02 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, May 17, 2023 at 08:45:05PM +0900, Masami Hiramatsu wrote:
> > Hi Dan,
> > 
> > Sorry, I missed my fix :(
> > 
> > https://lore.kernel.org/all/168100731160.79534.374827110083836722.stgit@devnote2/
> > 
> > That will fix the problem, could you test it?
> > 
> 
> It's awkward for me to test it right now...  :(  The fix looks good
> to me though and will obviously silence the static checker warning.

Thanks for checking!

> 
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

Regards,

> 
> regards,
> dan carpenter
> 
> 
> > Thanks,
> > 
> > On Mon, 8 May 2023 08:17:09 +0300
> > Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > 
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   2e1e1337881b0e9844d687982aa54b31b1269b11
> > > commit: 39d954200bf6ad503c722e44d0be80c7b826fa42 fprobe: Skip exit_handler if entry_handler returns !0
> > > config: i386-randconfig-m041-20230501 (https://download.01.org/0day-ci/archive/20230506/202305061702.6h3JzCPA-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> > > 
> > > If you fix the issue, kindly add following tag where applicable
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Reported-by: Dan Carpenter <error27@gmail.com>
> > > | Link: https://lore.kernel.org/r/202305061702.6h3JzCPA-lkp@intel.com/
> > > 
> > > smatch warnings:
> > > kernel/trace/fprobe.c:59 fprobe_handler() error: uninitialized symbol 'ret'.
> > > 
> > > vim +/ret +59 kernel/trace/fprobe.c
> > > 
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  23  static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  24  			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  25  {
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  26  	struct fprobe_rethook_node *fpr;
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  27) 	struct rethook_node *rh = NULL;
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  28  	struct fprobe *fp;
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  29) 	void *entry_data = NULL;
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  30) 	int bit, ret;
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  31  
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  32  	fp = container_of(ops, struct fprobe, ops);
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  33  	if (fprobe_disabled(fp))
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  34  		return;
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  35  
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  36  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  37  	if (bit < 0) {
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  38  		fp->nmissed++;
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  39  		return;
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  40  	}
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  41  
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  42  	if (fp->exit_handler) {
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  43  		rh = rethook_try_get(fp->rethook);
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  44  		if (!rh) {
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  45  			fp->nmissed++;
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  46  			goto out;
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  47  		}
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  48  		fpr = container_of(rh, struct fprobe_rethook_node, node);
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  49  		fpr->entry_ip = ip;
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  50) 		if (fp->entry_data_size)
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  51) 			entry_data = fpr->data;
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  52  	}
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  53  
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  54) 	if (fp->entry_handler)
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  55) 		ret = fp->entry_handler(fp, ip, ftrace_get_regs(fregs), entry_data);
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  56) 
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  57) 	/* If entry_handler returns !0, nmissed is not counted. */
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  58) 	if (rh) {
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02 @59) 		if (ret)
> > > 
> > > I reported this one earlier.  The code assumes that if there is an
> > > -exit_handler there is also an ->entry_handler().  You had said you
> > > would just initialized ret = 0;
> > > 
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  60) 			rethook_recycle(rh);
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  61) 		else
> > > 76d0de5729c056 Masami Hiramatsu (Google  2023-02-02  62) 			rethook_hook(rh, ftrace_get_regs(fregs), true);
> > > 39d954200bf6ad Masami Hiramatsu (Google  2023-02-02  63) 	}
> > > 5b0ab78998e325 Masami Hiramatsu          2022-03-15  64  out:
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  65  	ftrace_test_recursion_unlock(bit);
> > > cad9931f64dc7f Masami Hiramatsu          2022-03-15  66  }
> > > 
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests
> > > 
> > 
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
