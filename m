Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04B96B1AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 06:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCIFvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 00:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCIFvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 00:51:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46646AF6AB;
        Wed,  8 Mar 2023 21:51:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0C16619C0;
        Thu,  9 Mar 2023 05:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC44C433D2;
        Thu,  9 Mar 2023 05:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678341105;
        bh=tia+rGgQW30HhE+6t0Bm3z/xnsI8KB5lF3h8emJHFe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u2D77y48gaUUUOVnzpFF9d265HqofuV7VFmqGJFxcCNyDdPcjhYNidkNT1a8Mlq/T
         Fnm4pcZVVBHkOsGWdIZBbUTzoGNJMHJHlJ/mjEHg4CHIWM2ccYZEq3x0PsxZTXMT9X
         5jWJYRZmV6lYAuwQzjx9yQeSOMFTSU204adyU/O4GywE5GF0YRsQ3EFHW8ce6VInXd
         GG73BTf+3gD6Q5/QG20uCCckZ7N7Eg7l3S2fys3tASQbIZXk41+SfXP7/g+ewr8aNj
         HmCwLpd0Kl8FGe+QzVVXCSKjoWznXd3W2Ayj5Y+3wCv2jdcK3gsYZCPNz2+1JUPSk2
         3vmQY8IiNw3XQ==
Date:   Thu, 9 Mar 2023 06:51:35 +0100
From:   Simon Horman <horms@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Simon Horman <horms@verge.net.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: error while fetching the ipvs-next tree
Message-ID: <ZAlz581aBJewZLw3@kernel.org>
References: <20230309085415.0b738f0a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309085415.0b738f0a@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thu, Mar 09, 2023 at 08:54:15AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Attempting to fetch the ipvs-next tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs-next.git#master)
> today produces this error:
> 
> fatal: couldn't find remote ref refs/heads/master
> 
> Should I switch to using the "main" branch?
> 
> I also notice thet the ipvs tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git) has both a
> "master" and "main" branch.  Should I be using "main" there as well?

Sorry for not letting you know in advance.

Yes, please use main for both the ipvs-next and ipvs trees.

I plan to remove master from the ipvs tree too.

Kind regards,
Simon

