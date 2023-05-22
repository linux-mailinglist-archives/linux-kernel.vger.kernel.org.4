Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35A070C34D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjEVQ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjEVQ2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E5103;
        Mon, 22 May 2023 09:28:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DF11624D6;
        Mon, 22 May 2023 16:28:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403DBC433EF;
        Mon, 22 May 2023 16:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684772897;
        bh=0G+BjRlERK213agABDQEfeN2x8giGivLETu1ftBbrWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDpRZOSM20Rkd1/jsgBMmIM8+6Kf7jBTEub5YU3wFH3og5t/qY9MFrHt/P8CR5ARe
         pJxeipYQRKZQZRCdTmMDOBZxRBktBSsKf1LI9/DklVbcoAlRXVcpox1wrrNmtgchcp
         EKhHRQZNNt8y7mS6FMOcWDHDF5ngZWv770Gj6uEgznJPP60a2rw4hKBrdmlJ/QcnNT
         t7OMLQUpEWjVkXj17w0PocDCkQCE+NNZJ5q3O1RcUxLfm750gmaCDFunsSCv50xzgL
         sk3Tb2veqR06HwrfIlOa0oS7LPonNC8/gbDd39J47CIwApMlFATtmE9aL1Ewgmzj00
         hxATMnLDH7HRQ==
Date:   Mon, 22 May 2023 17:28:12 +0100
From:   Lee Jones <lee@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org, lwn@lwn.net,
        jslaby@suse.cz
Subject: Re: Linux 5.15.104
Message-ID: <20230522162812.GQ404509@google.com>
References: <1679511203203220@kroah.com>
 <20230522102355.GA2009088@google.com>
 <2023052236-passivism-equate-5cb8@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023052236-passivism-equate-5cb8@gregkh>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Greg Kroah-Hartman wrote:

> On Mon, May 22, 2023 at 11:23:55AM +0100, Lee Jones wrote:
> > On Wed, 22 Mar 2023, Greg Kroah-Hartman wrote:
> > 
> > > I'm announcing the release of the 5.15.104 kernel.
> > > 
> > > All users of the 5.15 kernel series must upgrade.
> > > 
> > > The updated 5.15.y git tree can be found at:
> > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
> > > and can be browsed at the normal kernel.org git web browser:
> > > 	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > > ------------
> > 
> > [...]
> > 
> > > Budimir Markovic (1):
> > >       perf: Fix check before add_event_to_groups() in perf_group_detach()
> > 
> > Anyone know why this didn't make it into v5.10 with it's friends?
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=80102f2ee715ab07be476df443bba388d5458fd1
> 
> That's a merge point, how can that go into stable kernels?
 
 There are only 3 commits in the merge.

> What specific commits are you thinking were missed?

The one I quoted above:

  perf: Fix check before add_event_to_groups() in perf_group_detach()

The other two applied successfully to v5.10.y:

  perf: fix perf_event_context->time
  perf/core: Fix perf_output_begin parameter is incorrectly invoked in perf_event_bpf_output

-- 
Lee Jones [李琼斯]
