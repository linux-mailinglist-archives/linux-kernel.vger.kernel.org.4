Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21CE261EFAD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231944AbiKGJyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:54:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKGJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:54:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF9F263C;
        Mon,  7 Nov 2022 01:54:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA36FB80F9F;
        Mon,  7 Nov 2022 09:54:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DC1C433C1;
        Mon,  7 Nov 2022 09:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667814845;
        bh=TL6caa0Q0MOS19RlX7tnUaF/QNVZc9/JMhrEHvxpbKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jn4vVbPciz+Pd8UD0JuAeyeOLmzT0biwtH2yFqpIgH9zXIi3KCRx3xRTY3fUhhGIS
         sRa8DvQgw8m91fsqZDGBqFpU7QQqwKSkG5129ybYhTtgsuVu7l3nMooFCwkzbRgeEV
         CJ/7m0vJ8qK2/KD9yazyXs6Ic9lGJLegowgb2FZQ=
Date:   Mon, 7 Nov 2022 10:53:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     mani@kernel.org, loic.poulain@linaro.org, dnlplm@gmail.com,
        yonglin.tan@outlook.com, fabio.porcedda@gmail.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v2] bus: mhi: host: pci_generic: Add macro for some
 VIDs
Message-ID: <Y2jVtWPdTybNCYqX@kroah.com>
References: <20221107084826.8888-1-slark_xiao@163.com>
 <Y2jJpT5//xBUOQMq@kroah.com>
 <28f1e702.28d7.184516dbbbb.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28f1e702.28d7.184516dbbbb.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 05:30:56PM +0800, Slark Xiao wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-11-07 17:02:29, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Mon, Nov 07, 2022 at 04:48:26PM +0800, Slark Xiao wrote:
> >> To make code neat and for convenience purpose, use macro for
> >> some VIDs. These macros are supposed to be added to pci_ids.h.
> >
> >No, they are not supposed to be added there at all.
> >
> >And they are not a "macro", it is a "#define".
> >
> >> But until the macros are used in multiple places, it is not
> >> recommended. So adding it locally for now.
> >
> >Again, these are not macros
> >
> >thanks,
> >
> >greg k-h
> 
> Hi Greg,
> Thanks for your comment.
> In my opinion, MACRO almost same as a '#define'.  May I know how do 
> you call such definition?

As I said, this is just a define, not a macro at all.

> And could you give your comments in previous patch, not the 'final' one?

I do not understand, what previous patrch?  What "final" one?  What is
the "latest" patch?

> In another pci_ids patch, you break it in v3 and break it here again in v2.

I broke what?

> Honestly,  it's positive for whole project. But it's negative  for contributor 
> and maintainer. 

I am totally confused here and do not understand what you are referring
to, sorry.

greg k-h
