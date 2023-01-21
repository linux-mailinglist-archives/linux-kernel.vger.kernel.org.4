Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B486764EE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 08:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjAUH04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 02:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAUH0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 02:26:54 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38DF6E822;
        Fri, 20 Jan 2023 23:26:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22BF6CE1D4D;
        Sat, 21 Jan 2023 07:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD741C433D2;
        Sat, 21 Jan 2023 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674286010;
        bh=dJ/yx41Bu83Mk/SGvl/isbFz7gan1Q9OejyPTg72ciI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z+QX6XADfzw5u/dOUk0mPTLrP8OD3PqfVEtA2CFrbbKewBLcHo1PJFfz4P+LEKzUN
         nAboJsALzofE0VwYpXKpqgr0X1T8fXOAKKMqkeVqk+p4M0HeROZ39GbQ/cAoqCX08b
         SRQApkODG1MuaqARrp/ypUoaeITwXzMDHe+9DEG0=
Date:   Sat, 21 Jan 2023 08:26:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Joe Wu <joewu@msi.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-input@vger.kernel.org, chrome-platform@lists.linux.dev,
        Benson Leung <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>, Joe Wu <joewu@msi.com>,
        Furquan Shaikh <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y8uTt3zXgGPmevkb@kroah.com>
References: <20221222063950.26018-1-joewu@msi.com>
 <Y8p6THz2jjKEoMrJ@kroah.com>
 <Y8rOQqhWcVAv8gmN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y8rOQqhWcVAv8gmN@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 09:24:18AM -0800, Dmitry Torokhov wrote:
> On Fri, Jan 20, 2023 at 12:26:04PM +0100, Greg Kroah-Hartman wrote:
> > On Thu, Dec 22, 2022 at 02:39:50PM +0800, Joe Wu wrote:
> > > Add 3 extra buttons: 'brightness up', 'brightness down'
> > > and 'screen lock' to support monitor manipulating function.
> > > 
> > > Signed-off-by: Joe Wu <joewu@msi.com>
> > 
> > From: line does not match the signed-off-by (and is an invalid email
> > address...)
> 
> What do you mean "it's an invalid email address"? You can definitely
> send emails there... I prefer people not to use Google partner domain
> accounts in the hope that their employment might outlast their
> involvement in Google projects, but that is it.

I was told that this was not a valid email address to send and receive
emails from, and was only an email alias given to companies to interact
with Google through their gerrit systems.  If that is incorrect, I'll
not complain about this anymore, but someone needs to please verify this
for me before I do so :)

But even if it is valid, should we accept it as a way to get in contact
with the original submitter over time?

> I think if we ask people to stick "From: <whatever the company address
> is" in the body of the patch we can ignore the difference between sender
> address and from/signed-off-by when they use partner domain accounts. If
> anything, such accounts have better vetting than a random gmail or other
> free email service account some vendors have to create to be able to
> send a plain-text emails that we require. I mean, we have
> "Signed-off-by: George Spelvin <lkml@sdf.org>" present in our git
> history and nobody bats an eye...

Oh lots of people "batted an eye" about that one, I've had too many
meetings with lawyers about that, which is one reason I now verify email
addresses like I did here.

thanks,

greg k-h
