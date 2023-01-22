Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033A167721F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjAVTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:50:56 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1BB41E28A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1674417051; bh=1yc39F3zR9jQL2xuYmQVhDaIU/61ctWcQiiZB1Ks46M=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=WPJ40noIlBV1+twDBbpuoTC34ZYVPhJOMT47sZ9u0MbI8yRg4+uB/azRyqh5Zw9eo
         3K3c3X3MPx/1csRJohAQAp3y1Ld6bGILSKF2xmRKHPGx5lo7z65Yfh23FT9RMn9sfy
         tWtYi582q7PSK1J+c9/biy88sh1LVZ8Ne4XC49Es=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 22 Jan 2023 20:50:51 +0100 (CET)
X-EA-Auth: M58oePYdSJhui/C60B5rP6iRQo9mgkk5IqAIkf/fBfaD3agnU0xQsPJK6A/DQ+RfXroocRsn2J5jEbmhrj1JFvf7ptubOKl0
Date:   Mon, 23 Jan 2023 01:20:47 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] w1: Use kfree_sensitive to clear sensitive information
Message-ID: <Y82Tl92T7k7LoyJa@ubun2204.myguest.virtualbox.org>
References: <Y6TcmtlRvvblvL2f@qemulion>
 <Y7nR5iBW3fdvVhFO@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7nR5iBW3fdvVhFO@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 08, 2023 at 01:41:18AM +0530, Deepak R Varma wrote:
> On Fri, Dec 23, 2022 at 04:09:22AM +0530, Deepak R Varma wrote:
> > Replace combination of 'memset(0) + kfree()' by kfree_sensitive() as it
> > prevents compiler from optimizing away from zeroing out memory at the
> > end of a scope. kfree_sensitive() is also safe in case the memory
> > pointer turns out to be null, which simply gets ignored.
> >
> > Issue identified using kfree_sensitive.cocci coccinelle semantic patch.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> 
> Hello,
> Requesting a review and feedback on this patch proposal.

Hello,
Requesting a review and feedback on this patch proposal please.

Thank you,
./drv

> 
> Thank you,
> ./drv


