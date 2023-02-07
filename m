Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD2968D178
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 09:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjBGIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 03:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjBGIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 03:31:28 -0500
X-Greylist: delayed 152 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Feb 2023 00:31:26 PST
Received: from a27-20.smtp-out.us-west-2.amazonses.com (a27-20.smtp-out.us-west-2.amazonses.com [54.240.27.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552DF1E9D7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 00:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ude52klaz7ukvnrchdbsicqdl2lnui6h; d=aaront.org; t=1675758534;
        h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding;
        bh=DIGix3F5T9og6+WxgGgK886KZaBCASdhWQMNzU+2lIE=;
        b=FENvOgWfFQTbFoXrEp0uH557hqLhKJlE4JXvvna+POIXGPqqVtPXc+VzzEVU5sar
        vgkJ1t+Xv8FNARWuKgPZBFqsGZUqfSHOo2FBq2U8NkoZLaxLpjwOl/YOkvZbR5aKT4f
        NZVaNSgs0xeyc87qSoQ9LwdAKDdyi+CbZ+GW7NbA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1675758534;
        h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=DIGix3F5T9og6+WxgGgK886KZaBCASdhWQMNzU+2lIE=;
        b=FKPuf/QYn2kk8uGO272Mi6QAdZhAMfPXrvQHG+L8hKdS9y68Ifuj3MqATf2bJwvm
        goXZ2wqABSDn2Hu+f+cpc889KTeITOVi1nHMt4j2a3RZBhDF876HFGlYW/1AgGAgUGM
        CjJ3BXZIYccCuTvNkZlLKrzDqdQGi43t7Z2jUzgk=
MIME-Version: 1.0
Date:   Tue, 7 Feb 2023 08:28:53 +0000
From:   Aaron Thompson <dev@aaront.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix memblock_free_late() deferred init bug, redux
In-Reply-To: <Y+IFmA1FVNRtpEFZ@kernel.org>
References: <20230206071211.3157-1-dev@aaront.org>
 <Y+IFmA1FVNRtpEFZ@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <010101862afdfc6b-a0abd268-f5d1-4d24-b7e5-c0af94bdb933-000000@us-west-2.amazonses.com>
X-Sender: dev@aaront.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: 1.us-west-2.OwdjDcIoZWY+bZWuVZYzryiuW455iyNkDEZFeL97Dng=:AmazonSES
X-SES-Outgoing: 2023.02.07-54.240.27.20
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2023-02-07 00:02, Mike Rapoport wrote:
> Hi Aaron,
> 
> [snip]
> 
> At this point of the release cycle I prefer to revert 115d9d77bb0f 
> ("mm:
> Always release pages to the buddy allocator in memblock_free_late()") 
> and
> to work on the proper fix for the next release.

Makes sense. I just sent a revert patch, and I'll work on a better fix.

Thanks,
-- Aaron
