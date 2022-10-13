Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B35FDE51
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiJMQhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJMQh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6415D147077;
        Thu, 13 Oct 2022 09:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F32296188A;
        Thu, 13 Oct 2022 16:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84E9C433C1;
        Thu, 13 Oct 2022 16:37:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="FCV2oPJp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1665679045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmeCPn/fxSK1XcuXoft40rN7Z/AJPRNDXC688MYJmxU=;
        b=FCV2oPJpb15o3hlo9A+6Es+zOLTFKhZ2otGoyP9woQHyI85LVU+6TPxQkgcjHrw62Dm1yu
        tTUPN8EBYqbVzoMx0YW4LVCnzE3LyUsHwjXt6B4+NbdlLLaolS4yNbcfP60EG1liprulMP
        rKY8gpxnkXfE1tydTDRV3u+yNKF8NNs=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 11f654bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Oct 2022 16:37:25 +0000 (UTC)
Date:   Thu, 13 Oct 2022 10:37:21 -0600
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-toolchains@vger.kernel.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: gcc 5 & 6 & others already out of date?
Message-ID: <Y0g+wTTJmlaFVLzr@zx2c4.com>
References: <CAHmME9prBJHmo9Bw6aobuGLjtxLsjxKJ9wopOv5+BY6ZtuKaNg@mail.gmail.com>
 <Y0gLyLbdOCetX5LN@sirena.org.uk>
 <Y0gteD0QYVlYxSZh@zx2c4.com>
 <Y0g8HEYHZYHGdwlf@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y0g8HEYHZYHGdwlf@sirena.org.uk>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 05:26:04PM +0100, Mark Brown wrote:
> Note that I'm not saying we shouldn't upgrade our requirements at all,
> just that I'm worrying about going from one extreme to the other in
> terms of version requirements - it feels like there's a step change when
> you move from things you can get in current release distros people are
> likely to be using to things that will require a large proportion of
> people to install extra stuff.  At the minute we're more at the other
> end where it can be hard to figure out who'd even have the oldest
> versions we support without deliberately seeking them out and keeping
> them going is noticably making work for people.

Regarding "one extreme to the other", I suspect that in spite of my
arguments, which would seem to justify an extreme, the actual thing I
suggested is a bit more moderate: let's support the latest 2 or 3 gccs
at the time of kernel release. If we choose 3, that's roughly 3 years of
gccs, right? 3 years seems like a fairly long amount of time.

Jason
