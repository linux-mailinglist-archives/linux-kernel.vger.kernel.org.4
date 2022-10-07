Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B69F5F7E4C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiJGTuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJGTuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:50:19 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5FD4CA25
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:50:17 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 297JoCDA008062
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 7 Oct 2022 15:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1665172213; bh=F3+KxvdxYbXXYL5Hb3QcEbLoY4S1F7GRg9bQWulklWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=mN75GxtK8Eteotnq4Rvju6OPcA08aupPcp0TEfrOmkJ3OIgujvOUcg8PSZlj9QnQp
         uKtCoqBdLb+S75ltky/DLZhbIkUvQmvQldBRsgIoZnNj/jwa13v7hrkZupWel3mQQ6
         p0UK5ibADM+yYy7krw82brY+KHOfzW0iAzBEaY+JiSk9b7Z2uuhgy6ZzVti5vSvwnH
         dbczVkb/ZfF9Xo9l4S5m7/kqJIokK7se07T0F4Es+8j6rLiCGrbbqN3/sXclACmgwd
         tULQ7yiiwSsN3x8sH3Jx3KGQwqEE5W5vzLf4ggESnlDKl8LEQ0hfYiDfIcZ7tW6GCS
         LLJTlxtaotKqg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1E89A15C35F2; Fri,  7 Oct 2022 15:50:12 -0400 (EDT)
Date:   Fri, 7 Oct 2022 15:50:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Carl Dasantas <dasantas2020@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, kaiwan.billimoria@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y0CC9IfhWj+/DXTp@mit.edu>
References: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
 <Y0BHYPat6L+FZFGQ@kroah.com>
 <CANNVxH_fDjD2TU0ccW19hSKXwTL+m6kDPr6n7=36uipStgwzGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNVxH_fDjD2TU0ccW19hSKXwTL+m6kDPr6n7=36uipStgwzGA@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:07:05PM -0400, Carl Dasantas wrote:
> It's moreso the fact that initial Rust support is being added. Yes I
> know it's just initial support/NVMe drivers.

Care to name a *single* functional kernel feature (whether a device
driver or not) that is dependent on RUST.  Have you tried building the
latest development kernel without rust --- what happens?  (hint: nothing)

> Also, Rust support isn't the only major
> change in 6.1, by the kernel.orgs own site (time permitting) an LTS is
> made if major changes are present.

This is simply not true.  The start of a new LTS kernel has always
been time-based, and there certainly have been attempts to get new
major functionality around this time of year in the hopes that it can
be made avcailable in distro kernels.  Of course, if the functionality
or change is too flaky, it could very well get reverted or the
distributions will simply not enable the feature because it would be a
support nightmare for them.

All of this does not apply for Rust.  Again, take a look at what is
*actually* been included during the current merge window.

Regards,

						- Ted
