Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 229AA6A413B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 12:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjB0Lyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 06:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjB0Lyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 06:54:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D6AD15;
        Mon, 27 Feb 2023 03:54:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D439EB80D1D;
        Mon, 27 Feb 2023 11:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E509C433EF;
        Mon, 27 Feb 2023 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677498889;
        bh=3+0/i8GC+xWIbr+yJtM7BHcr58CXIKhSiMJd0Dac0SQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iquXKamEaZyEN/S0fEwBfCjDh7TXBd+7JvqoZfJO6rKSARtEIX01ideQGWoXCG2Wc
         cK3K685plNkCkbXmXXZSEPdTy3su3Pwrp8zoKg/lKEk+1pVM8n5EceTORB98w9MDHV
         97gM5p53YWaLazrPIvIlylW2ZwSYn26pTTIoy5gs=
Date:   Mon, 27 Feb 2023 12:54:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Karina Yankevich <k.yankevich@omp.ru>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] usb: storage: sddr55: clean up variable type
Message-ID: <Y/yaB2A8qwgRkqVO@kroah.com>
References: <53bc0584-51eb-8bb7-de48-ca07fccafc19@gmail.com>
 <20230227112541.14849-1-k.yankevich@omp.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227112541.14849-1-k.yankevich@omp.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 02:25:41PM +0300, Karina Yankevich wrote:
> SVACE static analyzer complains that we're possibly
> losing information by shifting an 'unsigned int pba'
> variables in sddr55_{read,write}_data().
> It is a false positive, because of the card's total capacity
> is no larger than 128 MB. But 'unsigned int' is more
> suitable in this case.

Please wrap at 72 columns.

> Found by OMP on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.

What is "OMP"?

What is "SVACE"?

And why change anything if there is not a real issue?

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

That's obviously not the correct commit id for such a "fix" as this is
not a real issue.

thanks,

greg k-h
