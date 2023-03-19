Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A4E6C007C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 11:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCSKGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 06:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjCSKG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 06:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CABBF19BA
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 03:06:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4342D60F84
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49869C433D2;
        Sun, 19 Mar 2023 10:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679220385;
        bh=3ijSRG+oKvJrjjwyo05Ah1n7JvdN7GTscK2Y03un6R0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nOUKqO5kxcq5aeCR/qNVgRAjDnP+/Dch4qMA9xvrPd3xHEuY65uVJLYtJ4KGK8mkn
         aqyMW1yIUYhi9FJ3Mi6/RqLlySaPte1Ebsv4ktxSm9pRECNZa8joX2gXLdgpMVvVSs
         Npf1MYarZcu0A3Dacbf9mBCGXUOraUuSaIg5BF4g=
Date:   Sun, 19 Mar 2023 11:06:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: kobject: introduce kobject_del_and_put()
Message-ID: <ZBbenkKv1mMED7FH@kroah.com>
References: <ZBbRDl4OYGZIlx7E@kroah.com>
 <20230319093636.7166-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319093636.7166-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 05:36:36PM +0800, Yangtao Li wrote:
> > Any reason you only sent me one patch?  I guess you don't want me to
> > review them?  :(
> 
> Sorry, I used the following git configuration to send emails, so it was
> not sent to you.
> 
> [sendemail]
>     tocmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nol"
>     cccmd ="`pwd`/scripts/get_maintainer.pl --nogit --nogit-fallback --norolestats --nom"
> 
> I amended the resent patch, the patch body states cc to you and Rafael.

Great, thanks, I got them now, I'll queue them up later next week if
there's no complaints.

greg k-h
