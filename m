Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84CD604CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiJSQKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbiJSQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:10:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C25143A76;
        Wed, 19 Oct 2022 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9vOa0+msvviK5V7ZlQiw3aFY3XiVnsGVWrJcmPEHwWI=; b=D5Vriblg+tFApNhrbvyUBH9YK+
        O6JtPYdppx8i6ctqGiud/iZLz5NCZyImk4Firnmq0WZ0pyl19LaQWaSyEZr1TOpcW0mervHlzg/m8
        FBc9PWYH3hgAc2bIoCZBF18w87NLdo/RevlzcsHqizCfCq6RulaJkW1TVtQGtveT1t0kt8iIcvGBz
        8N7Vf3ACHXRYAG6sJK2vFDvL52MZ3u4zyIMTPYEqafLWxO9pnc0yz+e7bFWFYFflwexYo97RZJj6o
        p2IjeUw/SRZAvzmJNuIAkwmyvHO3R3hnWP2kwFooTwyk3NjHUaNJduPckXMmKOj/sbKjV4gLymvSG
        FizyZuuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1olBeK-003lRO-20; Wed, 19 Oct 2022 16:10:32 +0000
Date:   Wed, 19 Oct 2022 09:10:32 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Dirk =?iso-8859-1?Q?M=FCller?= <dmueller@suse.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] lib/raid6: drop RAID6_USE_EMPTY_ZERO_PAGE
Message-ID: <Y1AhePTKiBS1WKf6@infradead.org>
References: <Y0/Yt4uJWg4knNoc@infradead.org>
 <20221019160407.7550-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019160407.7550-1-giulio.benetti@benettiengineering.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 06:04:07PM +0200, Giulio Benetti wrote:
> RAID6_USE_EMPTY_ZERO_PAGE is unused and hardcoded to 0, so let's drop it.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
