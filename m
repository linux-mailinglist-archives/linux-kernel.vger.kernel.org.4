Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A907E6A407C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjB0LVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjB0LVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:21:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913411E285
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0MX07b53AdXKTA2DvdsdwCeNYBekr9+C8dxxnEXp46A=; b=sjBC8e88e2ZBceEDiR6v33cR/P
        cmwLxZDQDXR/5B7OJsI25RF4PBhoX+gdYPjbk6xjPbJcq8YpGezyp0ukAi5Xu5WMavPdbHa1YpmlF
        Zv8F2BZZb9y9e4V3emC3wLHckD6XUo52Kd1hITabrEFR08h0jqVzAPM6XUmSIyd/mAelbu6x9ZCqA
        VYayYCkUD076G4XwxFQ8+wq9LB5uD0ogtTcsmqy5hKZwemQakmS0qX9TQP4O9oDByQDygQLLAXJCW
        Nh9aSUmbxIdw+6hwGI6VfhoWa5NMeBXV4JjqxpIzveGZTspvjPX78PeiWU3g+8sbihK236Vz70fF1
        7wBQh5Yw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pWbYW-00048U-5J; Mon, 27 Feb 2023 11:20:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 19D5B300632;
        Mon, 27 Feb 2023 12:20:29 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFC7A22F1DD87; Mon, 27 Feb 2023 12:20:28 +0100 (CET)
Date:   Mon, 27 Feb 2023 12:20:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cocci@inria.fr, mcgrof@kernel.org,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        buytenh@wantstofly.org, johannes.berg@intel.com,
        gregkh@linuxfoundation.org, tomba@kernel.org, airlied@gmail.com,
        daniel@ffwll.ch
Subject: Re: [RFC PATCH] cocci: cpi: add complete api check script
Message-ID: <Y/yR/LypvJQXRhAr@hirez.programming.kicks-ass.net>
References: <20230227075346.69658-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227075346.69658-1-schspa@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:53:47PM +0800, Schspa Shi wrote:
> When DECLARE_COMPLETION_ONSTACK was used, the user must to ensure the other
> process won't reference the completion variable on stack. For a
> killable/interruptiable version, we need extra code(add locks/use xchg) to
> ensure this.
> 
> This patch provide a SmPL script to detect bad
> DECLARE_COMPLETION_ONSTACK(_MAP) API usage, but far from perfect.

Documentation/process/submitting-patches.rst:instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy

But also, wth is SmPL, the actual thing included is a coccinelle script.

> This is a common problem, and a lot of drivers have simpler problem. The
> fellowing is a list of problems find by this SmPL patch, due to the complex
> use of wait_for_complete* API, there will still be some false negatives and
> false positives. This RFC patch is mainly used to discuss improvement
> methods. If we introduce the wait_for_complete*_onstack API, it will be
> easier to modify these problems, and the patch rules of SmPL will be very
> easy. In the process of trying to write SmPL scripts, I strongly recommend
> introducing two onstack APIs to complete this operation.
> 
> file:/Users/schspa/work/src/linux/drivers/infiniband/ulp/srpt/ib_srpt.c::2962 was suspected to return a variable on stack

What's with this retarded file path? Are you running on Windows or
something daft like that?

Please, make them relative to srctree.

> file:/Users/schspa/work/src/linux/drivers/misc/tifm_7xx1.c::268 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/firmware/arm_scmi/driver.c::1001 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::595 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::491 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::538 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c::645 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::3175 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2360 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2314 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/video/fbdev/omap2/omapfb/dss/dsi.c::2634 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1804 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::1758 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/gpu/drm/omapdrm/dss/dsi.c::2034 was suspected to return a variable on stack

These don't seem buggy, they take the whole DSI out -- which lives on
stack too.

> file:/Users/schspa/work/src/linux/drivers/net/wireless/marvell/mwl8k.c::2259 was suspected to return a variable on stack

Heh, they seem to have the right idea but a buggy implementation.

> file:/Users/schspa/work/src/linux/drivers/net/wireless/mediatek/mt7601u/mcu.c::317 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/net/wireless/ti/wlcore/main.c::6674 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/net/wwan/t7xx/t7xx_state_monitor.c::416 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::647 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/soc/apple/rtkit.c::653 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/soc/qcom/rpmh.c::269 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic94xx/aic94xx_tmf.c::339 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_ctl.c::242 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1811 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2266 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::1603 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/snic/snic_scsi.c::2073 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1807 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/qla2xxx/qla_os.c::1328 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/ibmvscsi/ibmvfc.c::2466 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::844 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic79xx_osm.c::2334 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/aic7xxx/aic7xxx_osm.c::2297 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/lpfc/lpfc_nvmet.c::2119 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/ipr.c::5153 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/scsi_error.c::1157 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_main.c::1215 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c::996 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c::867 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/isci/task.c::317 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::1844 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2310 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2086 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/scsi/fnic/fnic_scsi.c::2579 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::6752 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/ufs/core/ufshcd.c::4074 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/thunderbolt/ctl.c::604 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i2c/busses/i2c-hisi.c::206 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/s390/cio/vfio_ccw_drv.c::71 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/messaging.c::154 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::894 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ngd-ctrl.c::932 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/slimbus/qcom-ctrl.c::377 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/usb/core/devio.c::1142 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/usb/core/hcd.c::2229 was suspected to return a variable on stack

These do usb_kill_urb() in the fail case. IIUC this avoids the UaF
problem this script is trying to finger, no?

> file:/Users/schspa/work/src/linux/drivers/spi/spi-hisi-sfc-v3xx.c::337 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/bluetooth/hci_bcm4377.c::955 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v1.c::336 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/cmd_v2.c::278 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::360 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::312 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/i3c/master/mipi-i3c-hci/core.c::238 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/ata/libata-core.c::1558 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::285 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::233 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/drivers/w1/masters/ds1wm.c::262 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/lib/kunit/try-catch.c::76 was suspected to return a variable on stack
> file:/Users/schspa/work/src/linux/sound/aoa/soundbus/i2sbus/pcm.c::264 was suspected to return a variable on stack
> 
> To fix this, we can add introducing two new API for this.
> 
> +
> +void complete_on_stack(struct completion **x)
> +{
> +       struct completion *comp = xchg(*x, NULL);
> +
> +       if (comp)
> +               complete(comp);
> +}
> +EXPORT_SYMBOL(complete_on_stack);
> +
> +int __sched wait_for_completion_state_on_stack(struct completion **x,
> +                                       unsigned int state)
> +{
> +       struct completion *comp = *x;
> +       int retval;
> +
> +       retval = wait_for_completion_state(comp, state);
> +       if (retval) {
> +               if (xchg(*x, NULL))
> +                       return retval;
> +
> +               /*
> +                * complete_on_stack will call complete shortly.
> +                */
> +               wait_for_completion(comp);
> +       }
> +
> +       return retval;
> +}
> +EXPORT_SYMBOL(wait_for_completion_state_on_stack);

So going by the 3 random samples above, only 1 would use this pattern.

Does that mean you 'forgot' to audit all these results before proposing
a fix?

What does that mean for this script?

> Link: https://lore.kernel.org/all/20221115140233.21981-1-schspa@gmail.com/T/#mf6a41a7009bb47af1b15adf2b7b355e495f609c4
> Link: https://lore.kernel.org/all/7d1021f1-c88e-5a03-3b92-087f9be37491@I-love.SAKURA.ne.jp/
> 
> CC: Julia Lawall <Julia.Lawall@inria.fr>
> CC: Nicolas Palix <nicolas.palix@imag.fr>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> CC: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Steven Rostedt <rostedt@goodmis.org>
> CC: Ben Segall <bsegall@google.com>
> CC: Mel Gorman <mgorman@suse.de>
> CC: Daniel Bristot de Oliveira <bristot@redhat.com>
> CC: Valentin Schneider <vschneid@redhat.com>
> 
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  scripts/coccinelle/api/complete.cocci | 160 ++++++++++++++++++++++++++
>  1 file changed, 160 insertions(+)
>  create mode 100644 scripts/coccinelle/api/complete.cocci
> 
> diff --git a/scripts/coccinelle/api/complete.cocci b/scripts/coccinelle/api/complete.cocci
> new file mode 100644
> index 000000000000..d4cf32187180
> --- /dev/null
> +++ b/scripts/coccinelle/api/complete.cocci
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0
> +///
> +//  Copyright: (C) 2023 Schspa Shi.
> +//  Confidence: High

I'm thinking that 'high' is somewhat premature, 2 out of 3 false
positive rate does not inspire confidence.

> +virtual report
> +
> +@r1 exists@
> +declarer name DECLARE_COMPLETION_ONSTACK;
> +declarer name DECLARE_COMPLETION_ONSTACK_MAP;
> +position p;
> +identifier done;
> +identifier func;
> +@@
> +
> +func(...) {
> +...
> +(
> +DECLARE_COMPLETION_ONSTACK(done@p);
> +|
> +DECLARE_COMPLETION_ONSTACK_MAP(done@p, ...);
> +)
> +...
> +}
> +
> +@locked exists@
> +identifier func=r1.func;
> +identifier done=r1.done;
> +position p1,p;
> +@@
> +
> +func(...) {
> +...
> +(
> +mutex_lock@p1
> +|
> +mutex_trylock@p1
> +)
> + (...)
> +...  when != mutex_unlock(...)
> +done@p
> +...
> +}
> +
> +
> +@elocked exists@
> +identifier func=r1.func;
> +identifier done=r1.done;
> +position p1,p;
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +e = &done;
> +...
> +(
> +mutex_lock@p1
> +|
> +mutex_trylock@p1
> +)
> + (...)
> +...  when != mutex_unlock(...)
> +e@p
> +...
> +}
> +
> +
> +@has_wait_for_completion exists@
> +position p;
> +identifier done;
> +identifier func=r1.func;
> +identifier fb = { wait_for_completion, wait_for_completion_io};
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +(
> +...
> +fb(&done@p);
> +...
> +|
> +e = &done;
> +...
> +fb(e@p);
> +)
> +...
> +}
> +
> +@has_while_wait exists@
> +position p;
> +identifier done, ret;
> +identifier func=r1.func;
> +identifier fb =~ "wait_for_completion.*";
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +while (...) {
> +	...
> +	ret = fb(&done@p, e);
> +	...
> +}
> +...
> +}
> +
> +@has_while_wait2 exists@
> +position p;
> +identifier done;
> +identifier func=r1.func;
> +expression fb =~ "wait_for_completion.*";
> +@@
> +
> +func(...) {
> +...
> +while (fb(&done@p, ...) == 0) {
> +	...
> +}
> +...
> +}
> +
> +
> +@r2 depends on (!has_wait_for_completion && !has_while_wait && !has_while_wait2) exists@
> +declarer name DECLARE_COMPLETION_ONSTACK;
> +position p!={locked.p, elocked.p};
> +identifier done=r1.done;
> +identifier func=r1.func;
> +expression e;
> +@@
> +
> +func(...) {
> +...
> +(
> +wait_for_completion_interruptible(&done@p)
> +|
> +wait_for_completion_killable(&done@p)
> +|
> +wait_for_completion_timeout(&done@p, ...)
> +|
> +wait_for_completion_io_timeout(&done@p, ...)
> +|
> +wait_for_completion_interruptible_timeout(&done@p, ...)
> +|
> +wait_for_completion_killable_timeout(&done@p, ...)
> +|
> +try_wait_for_completion(&done@p)
> +|
> +wait_for_completion_timeout(e@p, ...)
> +)
> +...
> +}
> +
> +
> +@script:python depends on report@
> +fp << r2.p;
> +@@
> +
> +print('file:{:s}::{:s} was suspected to return a variable on stack'.format(fp[0].file, fp[0].line))
> +
> -- 
> 2.37.3
> 
