Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327845F7B8A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiJGQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbiJGQeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:34:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37E73C0C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F292661DAD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09941C433C1;
        Fri,  7 Oct 2022 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665160444;
        bh=Ll86tsDtN9FBu1Rdi+PItpsqPG8aV6HPyhB5PwRZosk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OHcl67aAquadS4T2x06Pg32LJyG5K+C46lpfkQx6GjtS/Cd+Nm9EsiJcv6xIw0uCq
         ZnHf4/q4Ap9wuVxFip8f12DbkvDSEYwYZj3eoiHk9dgODiO6hXotjp8K7ruxNYbY72
         qyjTrYe6xufUQSaDajcW7DhGawno6qeaJU1hGJGw=
Date:   Fri, 7 Oct 2022 18:34:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carl Dasantas <dasantas2020@gmail.com>
Cc:     kaiwan.billimoria@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y0BVJRx1J8ODVFDu@kroah.com>
References: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
 <Y0BHYPat6L+FZFGQ@kroah.com>
 <CANNVxH_fDjD2TU0ccW19hSKXwTL+m6kDPr6n7=36uipStgwzGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNVxH_fDjD2TU0ccW19hSKXwTL+m6kDPr6n7=36uipStgwzGA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 12:07:05PM -0400, Carl Dasantas wrote:
> It's moreso the fact that initial Rust support is being added.

Again, specifics, I do not think you actually looked at the code as your
next sentance does not reflect reality:

> Yes I know it's just initial support/NVMe drivers.

That is not true, please look at the code.

Feel free to disable it if you don't like it, we do not do LTS releases
based on content, but rather time.

thanks,

greg k-h
