Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0C647571
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 19:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiLHSUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 13:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiLHSUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 13:20:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6FA7E427
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 10:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A41B86202A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFBCC433EF;
        Thu,  8 Dec 2022 18:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670523606;
        bh=LjIY1Ttg9HywGnlTWGvWTLRjJQbCt+ROrm3V95k0884=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kgtKzbMgaYSdreUHxzmktHTUD3qjKxNR1addUi7Gn4pUX+mieKMhhvDROFnlkYLMj
         Hls58/uCE4lw80zzMVbqeq2rHrAEJho3EWywJMUHsNbs4+JJaz9QmGhFPMKfOOyeXf
         n04FTSLeMm8nov+WmTfLptbD7EEKpMGa7zoNddS0=
Date:   Thu, 8 Dec 2022 19:20:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?6Km55pWs5bmz?= <zoo868e@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v3 1/3] staging: vme_user: add the spaces around the "*"
Message-ID: <Y5Iq0vpqw/RzJTob@kroah.com>
References: <20221208140531.3840-1-zoo868e@gmail.com>
 <Y5IKUMH+mq++Kx9s@kroah.com>
 <CAB9pA+-2tZQDXxQ4JPrXb6K0HH=gv_9SAPKp1DSrk_M6OxL06g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB9pA+-2tZQDXxQ4JPrXb6K0HH=gv_9SAPKp1DSrk_M6OxL06g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 12:55:41AM +0800, 詹敬平 wrote:
> That's weird. The email send by command 'git send-mail' not appear in my
> '[Gmail]/Sent mail' folder, but the email send by mutt does. Maybe I need
> configure the .gitconfog?
> 
> Here is my .gitconfog
> 
> [user]
> email = zoo868e@gmail.com
> name = Matt Jan
> [core]
> autocrlf = input

No idea, sorry but do realize that when you send email, gmail will not
show mail that you sent, that's a common issue.

Also you just sent this in html format, which is rejected by the mailing
lists :(

thanks,

greg k-h
