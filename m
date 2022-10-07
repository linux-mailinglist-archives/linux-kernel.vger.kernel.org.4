Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406965F7A9E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 17:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJGPf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 11:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJGPfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 11:35:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3DF53013
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 08:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB1B7CE17A3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 15:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A270C433C1;
        Fri,  7 Oct 2022 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665156918;
        bh=9aQBnldkKCucza+AHOo1t0G61zNJPHLGLoQAO+P6aXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iOoyHWHZAiWBheNrQxX+I75XualNKHSxJEoZmCIlmom5WGcoQB9e5Okmc6xaHKiqb
         3eePnaBVBFZgf5UjMubc8oSjfUd4KCLnGNPbirnX5dXruCxiRKYzGBUOFmF75CRdYN
         TJ4QKxPwUeFL/nkAKtHuHTWh6DsWBdFqPEaLFemY=
Date:   Fri, 7 Oct 2022 17:36:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carl Dasantas <dasantas2020@gmail.com>
Cc:     kaiwan.billimoria@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y0BHYPat6L+FZFGQ@kroah.com>
References: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANNVxH_uwnz31kak4fKAVuj8UP4wbWcFiDQ+kFwTametBvixGA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 11:04:04AM -0400, Carl Dasantas wrote:
> Please reconsidrer using 6.1 as the next LTS.
> 
> 6.0 or 5.19 is much more fitting due to not having Rust support, a
> major  change.

That makes no sense at all given what Rust code will be in 6.1.  Did you
look at it?  What specific functionality does it provide that is going
to be a problem for ANY platform that Linux currently supports?

greg k-h
