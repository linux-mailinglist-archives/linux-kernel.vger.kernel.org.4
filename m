Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9CF709423
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjESJxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbjESJxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475B910EC
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0794651D1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:53:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E659BC433EF;
        Fri, 19 May 2023 09:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684489980;
        bh=pXT5G7GIfAG3cHt/TuPWUd8eE05/Rb/6OMK/u2kjf+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+Jtmpp5535AImvAJE6WdKEql6cRLybsTaE08hy/322AEaEmFNsWoohv4tr3eAZAW
         T9lHWuAY9kmr45hRehlQBkYzUrw46Fo03vBGVJ4jKxrAgz7CUGmf9dYgSz1/dAfPuX
         97pWhvziomlDlKy6D+je69Ucsp3JXM8u2wLp/3GQ=
Date:   Fri, 19 May 2023 10:52:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Ertman <david.m.ertman@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, dan.j.williams@intel.com
Subject: Re: [PATCH v1] MAINTAINERS: add entry for auxiliary bus
Message-ID: <2023051916-candle-diploma-6d2f@gregkh>
References: <20230511164501.3859674-1-jesse.brandeburg@intel.com>
 <131145d8-4334-eb73-15c1-a830266a936b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <131145d8-4334-eb73-15c1-a830266a936b@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 01:33:32PM -0700, Jesse Brandeburg wrote:
> On 5/11/2023 9:45 AM, Jesse Brandeburg wrote:
> > When auxiliary bus was added to the kernel the MAINTAINERS file wasn't
> > updated with a mention of the files, contributors and reviewers. Fix
> > that oversight by adding Dave and Ira, with GregKH as (same as current)
> > owner.
> > 
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> > Acked-by: Dave Ertman <david.m.ertman@intel.com>
> > Acked-by: Ira Weiny <ira.weiny@intel.com>
> 
> Hi Greg, any comments or guidance here? Wasn't sure to add you as the
> directly mentioned maintainer or just let the fallback select you via
> the directory. Overall the goal was to get get_maintainers to suggest
> Dave and Ira as reviewers of any auxiliary changes.

It looks fine, just let me get through the hundreds of other more
important fixes in my review queue.  This will make it into the tree
eventually...

thanks,

greg k-h
