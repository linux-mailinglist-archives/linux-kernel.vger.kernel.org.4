Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E56DA7E6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjDGDKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDGDKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:10:01 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D925361AA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 20:09:59 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33739wfL009909;
        Fri, 7 Apr 2023 05:09:58 +0200
Date:   Fri, 7 Apr 2023 05:09:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Bhaskar Chowdhury <bhaskarlinux73@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: I can not send mail from my primary mail address
 unixbhaskar@gmail.com to lkml and anybody having kernel.org mail domain
Message-ID: <ZC+JhjYn/TuLdydk@1wt.eu>
Reply-To: LinuxKernel <linux-kernel@vger.kernel.org>
References: <ZC+CVYgKzer4NElF@Gentoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZC+CVYgKzer4NElF@Gentoo>
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ dropped Linus and Konstantin who have other things to do of their time]

On Fri, Apr 07, 2023 at 08:09:17AM +0530, Bhaskar Chowdhury wrote:
>  THIS IS A REAL HUMAN HERE..and who is concerned about blocking..
> 
>  I am getting spamassassain blocking for sending mail to kernel.org mail address and
>  the mail to list not showing.
> 
>  It's been happening for last 2 days.
> 
>  What is going on?? Why my primary mail id get blocked???
> 
>  My primary mail id IS: unixbhaskar@gmail.com
> 
>  It also led me to think, what have I done to get blocked here??

Bhaskar, I can reassure you that your other addresses are not blocked,
we all have the pleasure to read all your tests... Your test messages
even represent more spam than the rest we get from the list. I'm sure
it's just your filter that is causing problems (probably that it rejects
incoming messages from your address), but please use another method to
run your tests. There might even be dedicated lists for such purposes.

Thanks,
Willy
