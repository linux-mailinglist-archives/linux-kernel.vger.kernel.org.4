Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12301610A52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiJ1G1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 02:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiJ1G1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 02:27:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2E51B7F11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 23:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78D64B82684
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:27:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92064C433B5;
        Fri, 28 Oct 2022 06:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666938455;
        bh=rJJMlMZr+oaSjhuIxJDzTGpBIT5j3UlrV9qsu3WYFng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RL3iN8qOQNP9i5i8nLxebxHpWygeiKgwDrhx/S0vR1LhILrl2JWx1j7qFsUE2Y/ga
         UhrxYPraVjcPHmjNsaf0zdTqpLbZw54N3RsghNIm942NbBJLuZo3KlnwOyLqJ5XOqg
         iZR20sxsg7YI8A4qYNoiwCxPH7bVsGDVCuzEC21E=
Date:   Fri, 28 Oct 2022 08:28:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jovial umwari <umwarijovial@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] WARNING: Possible repeated word: 'very'
Message-ID: <Y1t2jffoLPxdOqJ3@kroah.com>
References: <20221028051420.GA30073@rdm>
 <Y1tx8XjmR5QKV9lQ@kroah.com>
 <CAMk1CBOdgwnt3E7ByZMASv+O1WAmgKvsvMv5Gy9UNgg=kMBRJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMk1CBOdgwnt3E7ByZMASv+O1WAmgKvsvMv5Gy9UNgg=kMBRJQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Fri, Oct 28, 2022 at 09:13:14AM +0300, jovial umwari wrote:
> Thank you
> working on it now
> 
> Best Regards
> Umwari Jovial

As you spell your name this way in emails, please use the same format
for your signed-off-by lines in your patches.

thanks,

greg k-h
