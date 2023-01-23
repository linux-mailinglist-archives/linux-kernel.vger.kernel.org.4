Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA4678ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbjAWWe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:34:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjAWWey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:34:54 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3DE1EFFB;
        Mon, 23 Jan 2023 14:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o0pPKD/IbB/HNSCzL2tiBGfNTOYtSkdPG1+hbf5GZhc=; b=A5yTpWjNJ2Qe86pBskFLIrJeTi
        VwVI554DVVwoBllRnDJtdQNFLx8vrRbpOAywUh/w9l0vajcSLTwTvTnw1r1juVzYs3nDn10/M3570
        lIQr12g9rYWw/W0/WTU1W6t50/t5k7eyP4oH966OzC6OioQ1gGs1t+7BKBgW17Fomz2WlWMzFZ+B7
        xsjF165Z/O1tm+9jzyLbzmsDyobpx5OykEIMVZ5GUkvx9n+FKzk6+Pu8lV6PTioMuMz/wpFJxhpnR
        PdV33rUSVI6mjgsfzUbGTQi6s2TBDaRxA8NKIXkIOxP0BcNaM5CV9wJJjjoE9KJPfjQYbGw0jtOBo
        Nzz6VT8w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK5Os-001j83-DK; Mon, 23 Jan 2023 22:34:50 +0000
Date:   Mon, 23 Jan 2023 14:34:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     corbet@lwn.net, gregkh@linuxfoundation.org,
        javier.gonz@samsung.com, linux-doc@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>
Cc:     a.manzanares@samsung.com, dave@stgolabs.net,
        darren@os.amperecomputing.com, catalin.marinas@arm.com,
        ndesaulniers@google.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org,
        David Collins <collinsd@codeaurora.org>
Subject: Re: [RFC] docs: embargoed-hardware-issues: drop stale embargoed HW
 contact for Qualcomm
Message-ID: <Y88Lim2toVwE1wzC@bombadil.infradead.org>
References: <20230123222220.405622-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123222220.405622-1-mcgrof@kernel.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 02:22:20PM -0800, Luis Chamberlain wrote:
> Emails to tsoni@codeaurora.org bounce from different systems I've used
> and LinkedIn tells me he's now at Linaro since 2019. That's a 4 year
> gap where embargo stuff goes to /dev/null for Qualcomm if the first
> bounce happened in 2019, but I have no way of knowing when that account
> was disactivated for sure.
> 
> Cc: David Collins <collinsd@codeaurora.org>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
> 
> David, should we apply this for now until you guys figure out a proper contact?

collinsd bounced too. Wee. Maybe Kalle might know what the appropriate
contact is now or can figure it out for us.

  Luis
