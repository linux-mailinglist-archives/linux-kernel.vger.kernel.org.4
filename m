Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A40665B375
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjABOoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjABOoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:44:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0D30F;
        Mon,  2 Jan 2023 06:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3abYtQz00Ho8MUIaQc419FUMQv0zxwLp5CSF4d93iUc=; b=RWoVjNzAZNyvEK852wGAuBmmNW
        do7M/6J9XtkeN7Rk6Y+2KwnWqFt7TO66SBRzT5yFZCgLgw8sZl5mEynW8uTo9zYmdCt4lq1NL5Yh7
        PuzIBu8jP8z6vjWekwuTWvIqjmB3QTnidUG2n8cy8VGH08x+F6dGiPeLEMhQNJxy+vL7i5VONQ6vU
        2FK2/8GtIb6/WV0dnU2vk5pFmO7PicNTmGhcyud+HZYB2edvOnd3mpAch+R3bitlRh65i/LZe9zSW
        lKcAFGRijVgWDJ+P7yQdhHaXsoWnuqrDYc1WnRrvYyBwbhxFmtpjaWaUPx0BWp8r4ySOaz1Awducy
        bvZyuE2w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pCM34-00DEQk-1y; Mon, 02 Jan 2023 14:44:22 +0000
Date:   Mon, 2 Jan 2023 14:44:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Federico Vaga <federico.vaga@vaga.pv.it>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: monospace style for inline code in botching ioctl
Message-ID: <Y7LtxnBKkpCmx83I@casper.infradead.org>
References: <20230101132758.12560-1-federico.vaga@vaga.pv.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230101132758.12560-1-federico.vaga@vaga.pv.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 01, 2023 at 02:27:58PM +0100, Federico Vaga wrote:
> +   that diminishes the checking tools like sparse can provide. The macro
> +   ``u64_to_user_ptr`` can be used in the kernel to avoid warnings about

Should probably be u64_to_user_ptr() instead to get both the monospace &
the hyperlink.

