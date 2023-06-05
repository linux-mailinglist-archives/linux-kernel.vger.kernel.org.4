Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212D2722DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjFERat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjFERad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 13:30:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37421A7;
        Mon,  5 Jun 2023 10:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB6CE628A3;
        Mon,  5 Jun 2023 17:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB9D6C433EF;
        Mon,  5 Jun 2023 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685986231;
        bh=9m6zpJRHDtWhs+jhcP594GpAc8H96hqh8ddH++zqf1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SDnrCzc34KaXkUdrLiONT/0h6AKmjJN9NOmZPmYxSq0ECrIMaOnL8V2VypkZ1RS53
         6EuWirew/W3OH+kiik8LIeGNBNhr+4q5s6ACBbWHEMKlL9Mc9PnkTz2BwNVhoRHjPc
         O99Vmhepi+WK5ueSlvR3dg2m48gWcI+TxsR4IwD1oqlFTtu4j9foz+QCguNvBR3A4c
         yumAKnAxsWIa06zgvztYzZ4ro+N3pSARZf2DP/UZNMiDwGFLpPO5srNpHTnnKizER3
         Po1tCQU5ov8l1aXXWG5HW6RRhtBwVnoEvNfXVhGNGxfzPA1Th27ptgj7eVSXMkGRpj
         2t8bxXcVUIcJw==
Date:   Mon, 5 Jun 2023 10:30:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Willy Tarreau <w@1wt.eu>, Randy Dunlap <rdunlap@infradead.org>,
        James Seo <james@equiv.tech>, Jonathan Corbet <corbet@lwn.net>,
        workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] docs: process: Send patches 'To' maintainers and 'Cc'
 lists
Message-ID: <20230605103029.3fb821db@kernel.org>
In-Reply-To: <87v8g2hwm1.fsf@kernel.org>
References: <20230603151447.29288-1-james@equiv.tech>
        <975d35cb-e0aa-8ea7-5520-238d1aa4cbaf@infradead.org>
        <20230603160659.GA5182@1wt.eu>
        <20230604112644.49ac2035@kernel.org>
        <20230605041258.GA22604@pendragon.ideasonboard.com>
        <87v8g2hwm1.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2023 16:22:46 +0300 Kalle Valo wrote:
> > Note that some maintainers process pull requests from patchwork, not
> > from their mailbox, and prefer not to be aadressed in the To or CC
> > headers. I don't know how widespread that is.  
> 
> FWIW I belong to this group and prefer not be in To or Cc, I'll always
> check the patch from patchwork.

Ah, I didn't realize this. 
