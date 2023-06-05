Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784FE721D0A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjFEEOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjFEEOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:14:05 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45B19B7;
        Sun,  4 Jun 2023 21:13:02 -0700 (PDT)
Received: from pendragon.ideasonboard.com (om126156242094.26.openmobile.ne.jp [126.156.242.94])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 185F32BC;
        Mon,  5 Jun 2023 06:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1685938356;
        bh=CZ/iSGxAVh4MrVNHCFz4+VlApnEOxh3Yuneh4ItbDcg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vzGckR6qmGX4/FII4gi6lIGpTK/uZFGNLtgWiLPxla5e+CqEbNRCl6DOfQceU2WXH
         hBl2hE/htcGpb4n8vmBy4zRAkDKuHWN376z7QGNOtgqijQqRH/v5YOWI9Tadv6DI0G
         Zm3CqSfdGAS2T5uHp/6AYC1rVj2YBsr5QXY3xsNg=
Date:   Mon, 5 Jun 2023 07:12:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Randy Dunlap <rdunlap@infradead.org>,
        James Seo <james@equiv.tech>, Jonathan Corbet <corbet@lwn.net>,
        Kalle Valo <kvalo@kernel.org>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc' lists
Message-ID: <20230605041258.GA22604@pendragon.ideasonboard.com>
References: <20230603151447.29288-1-james@equiv.tech>
 <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
 <20230603160659.GA5182@1wt.eu>
 <20230604112644.49ac2035@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604112644.49ac2035@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 11:26:44AM -0700, Jakub Kicinski wrote:
> On Sat, 3 Jun 2023 18:06:59 +0200 Willy Tarreau wrote:
> > > I think that is going overboard (too far). As long as a maintainer
> > > is a direct recipient of the email (patch), that should be sufficient.  
> > 
> > Or it could be simplified, saying that all those who are expected to
> > play a role on the patchset (review, test, merge etc) should be in the
> > 'To' field while those who might possibly be interested in having a
> > look are in 'Cc' (lists, other people having expressed interest in the
> > patchset, single-time contributors to the file being changed etc). It
> > could be hinted that usually people read mails sent to them faster than
> > those they're CCed. This implies that maintainers have to be in To and
> > lists in Cc.
> 
> It's useful when maintainer (or group thereof) who are expected to apply
> the patch are in the To:
> Who applies the patch is not information a noob may know but it may be
> worth writing down as best practice?

Note that some maintainers process pull requests from patchwork, not
from their mailbox, and prefer not to be aadressed in the To or CC
headers. I don't know how widespread that is. If I recall correctly,
this was something that maintainer profiles
(maintainer-entry-profile.rst files in Documentation) were supposed to
address.

-- 
Regards,

Laurent Pinchart
