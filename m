Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB795FFE98
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 12:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJPK35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJPK3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 06:29:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51814178B6;
        Sun, 16 Oct 2022 03:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1D4AB80025;
        Sun, 16 Oct 2022 10:29:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD5C433C1;
        Sun, 16 Oct 2022 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665916186;
        bh=eSz9RbvC7QKvJeQ19j0Vy1Sowd+3QjiSvlLPjMNyw9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JykGNxMNNy1PPIPJYqrsDf8JZcP/TFkTruGWxzbeCIw8UaxCdtQVHxtmC/1n5VH0i
         AwEki0PA3hTQQyqUcBmnzsJ/Gnhbw8H798HFA0Q9JwubS86c5J4e80lZKujr2YWIpx
         9+qApWsHG2KECvHeVhulIStFctwcop8wpg7cDecM=
Date:   Sun, 16 Oct 2022 12:30:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Conor.Dooley@microchip.com
Cc:     Brice.Goglin@inria.fr, atishp@rivosinc.com, sudeep.holla@arm.com,
        stable-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Patch "riscv: topology: fix default topology reporting" has been
 added to the 6.0-stable tree
Message-ID: <Y0vdSPh3+vDJczzf@kroah.com>
References: <166591276524312@kroah.com>
 <f97b84b7-9086-f83d-4edf-751873b7b26a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f97b84b7-9086-f83d-4edf-751873b7b26a@microchip.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 09:58:10AM +0000, Conor.Dooley@microchip.com wrote:
> On 16/10/2022 10:32, gregkh@linuxfoundation.org wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > This is a note to let you know that I've just added the patch titled
> > 
> >     riscv: topology: fix default topology reporting
> > 
> > to the 6.0-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      riscv-topology-fix-default-topology-reporting.patch
> > and it can be found in the queue-6.0 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Hey Greg,
> This breaks the build on 6.0 (and I can only assume on the other
> stable queues too).
> 
> I put:
> > CC: stable@vger.kernel.org # 456797da792f: arm64: topology: move store_cpu_topology() to shared code
> in the patch itself, did I specify the dependency incorrectly?

No, that's my fault, you specified this wonderfully, I just missed it :(

Now fixed up, thanks!

greg k-h
