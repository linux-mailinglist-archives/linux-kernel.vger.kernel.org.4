Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56EB728040
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236221AbjFHMmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjFHMmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:42:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC2226B1;
        Thu,  8 Jun 2023 05:42:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFCB064D18;
        Thu,  8 Jun 2023 12:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B55C433EF;
        Thu,  8 Jun 2023 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686228155;
        bh=gkgTenx1i0qZQfBHISvhcjd7PbwsAhLxgVxAEZgDex4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RkXXKrm1XcyA+fru3aRSaR0ZC0bPFdrljVEPzk24dF5/PqK7v3QC98rCjUfmfDMLY
         2NTJvIFsP7zGV32+zPdbglP2CT6FlTT3smAoLMFWMZQuj+teia/g4yrmLcd0RbCabk
         TNPAvRxpuYs/AeG/GHpkUxqK0e5qq0EheUIS4QN7+5OKabqXKBnhExD1M5Xb5/Zoyi
         if3EMb6Sd70Ai67OGxfov/+DNozrKnGcSd7n70E6oQyVKHN3yu9Cyj1tXIdC6Uj9oe
         I4khjD8bjFJZEKHNevztQCYiNebZJTqWdgPMJbp5GGKVxIu6nNU/ohpesLX5HrLKS0
         TzxFM8kIWCaCA==
Date:   Thu, 8 Jun 2023 13:42:30 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the regulator tree
Message-ID: <20230608124230.GH1930705@google.com>
References: <20230607163743.1c266a7f@canb.auug.org.au>
 <38913e8e-4578-4c4f-a6cd-6f6e628957af@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38913e8e-4578-4c4f-a6cd-6f6e628957af@sirena.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023, Mark Brown wrote:

> On Wed, Jun 07, 2023 at 04:37:43PM +1000, Stephen Rothwell wrote:
> > Hi all,
> > 
> > The following commit is also in the mfd tree as a different commit
> > (but the same patch):
> > 
> >   75c8cb2f4cb2 ("mfd: axp20x: Add support for AXP313a PMIC")
> > 
> > This is commit
> > 
> >   2f518d914bd3 ("mfd: axp20x: Add support for AXP313a PMIC")
> > 
> > in the mfd tree.
> 
> Hrm, that was a tag I pulled from Lee rather than something I applied -
> not sure what's going on there.

Mea culpa.  I hadn't rebased onto my own tag.

Should be fixed in the next -next cut.

-- 
Lee Jones [李琼斯]
