Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAF45FC7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJLOua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJLOu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:50:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C9640BFA;
        Wed, 12 Oct 2022 07:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2D413B81B34;
        Wed, 12 Oct 2022 14:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A283C433D6;
        Wed, 12 Oct 2022 14:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665586222;
        bh=eVKl0wqt9W+ZZ9zWc15s27SxTrfKi2PuqJ1GwfcNviw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y3GTmsFg9zuySZkZgvOYCgdgrRc1VQroZzkpifVrkvoGYatmDgweAWvOjfZKmPw5X
         ZuD3KsLgvB/MpUOyftWrdOedWgED/duw2zGIChHrucc5z4v/vbt+qYKgq2jlTsQvSe
         1pkLLZ+vZq7lYqBr8mP9QYLINkgQCG+0EaPVua57MXE8u2Sa6TE3C4r2kX5Q6qron1
         LXmgvAn4/W1/HJxGctgurtd4I86xISr/WIBoT8HZBwrC6eCc06CC1HV3pVpxgZgYkq
         SdozyyqzbAGQ5WHU0F+9m431kRadiEBY9gRz696p+X8x+RiPlg3J4OsUKfLYedV2Ia
         794wGulGYaAbA==
Date:   Wed, 12 Oct 2022 17:50:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Message-ID: <Y0bUK6krEQdnFlOg@kernel.org>
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <Y0BEV+Xgkrln8xoh@iweiny-desk3>
 <Y0ZphugZZBhlv/vT@kernel.org>
 <711f8036-787a-571e-1c0d-1a258175ebb2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <711f8036-787a-571e-1c0d-1a258175ebb2@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 07:13:26AM -0700, Dave Hansen wrote:
> On 10/12/22 00:15, Jarkko Sakkinen wrote:
> > There's no data to show that this change would be useful to do.
> 
> Jarkko, I think the overall transition to kmap_local_page() is a good
> one.  It is a superior API and having it around will pave the way for
> new features.  I don't think we should demand 'data' for each and every
> one of these.
> 
> Please take a look around the tree and see how other maintainers are
> handling these patches.  They're not limited to SGX.

Sure, I'll take a look for comparison.

BR, Jarkko
