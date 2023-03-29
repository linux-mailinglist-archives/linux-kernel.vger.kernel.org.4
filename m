Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75966CF622
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjC2WFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC2WFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879B9E9;
        Wed, 29 Mar 2023 15:05:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23F6F61E1A;
        Wed, 29 Mar 2023 22:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5D6C433D2;
        Wed, 29 Mar 2023 22:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127511;
        bh=9ytjOI5n/EsCibM/HKfPJKwRhZY+C3PIo2X6Dmdyr0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWoGHzSloWo/6k47znYzMNYdCD2X9D1mPAuzoZvKpnwz4RVFZDkASuyrUJb/RSbfR
         VeuYmlaMDHJzd3h2R6uWPLv9Xxt7K2oedq+EVdI4UVdODuD0rUfPwU/infyQNPBdMb
         7PGcch4guUyYHwzV7MzXm3CdqvZU3GM0MaPIYWpBw3jgrflVonnbOx3ycUENRTyRsD
         axOnLiz7h/kpoU3pbK29WHyko2xCG1h0mG4GoQHIv0GAnUOjzUnxKvd0Abv4Lqt1Wf
         +EGG/bZcXNsjzsazJGjqveA0EH4frulVC4Lq+EFvV5Hh9E+2/ckGaX0W3jTcfYoRHw
         G1A2/TEU4xSfA==
Date:   Thu, 30 Mar 2023 01:05:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
Message-ID: <20230329220508.qdbjvmveolujj326@kernel.org>
References: <20230321115413.106fa139@canb.auug.org.au>
 <20230324132050.050d4780@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324132050.050d4780@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 01:20:50PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 21 Mar 2023 11:54:13 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After merging the tpmdd tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > drivers/char/tpm/tpm-chip.c: In function 'tpm_amd_is_rng_defective':
> > drivers/char/tpm/tpm-chip.c:531:15: error: too many arguments to function 'tpm_request_locality'
> >   531 |         ret = tpm_request_locality(chip, 0);
> >       |               ^~~~~~~~~~~~~~~~~~~~
> > drivers/char/tpm/tpm-chip.c:35:12: note: declared here
> >    35 | static int tpm_request_locality(struct tpm_chip *chip)
> >       |            ^~~~~~~~~~~~~~~~~~~~
> > 
> > Caused by commit
> > 
> >   923c8dfa9a36 ("tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk")
> > 
> > I have used the tmpdd tree from next-20230320 for today.
> 
> I am still getting this build failure.
> 
> The commit above is trying to fix a build failure that does not exist
> in the tmpdd tree!
> 

Hi sorry for the latency, I got sick on Friday and was sick leave
up until Tuesday.

The offending commit has been removed.

BR, Jarkko
