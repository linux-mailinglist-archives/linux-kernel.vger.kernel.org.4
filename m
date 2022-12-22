Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C56653BE2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 06:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiLVFvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 00:51:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiLVFvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 00:51:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971602A2;
        Wed, 21 Dec 2022 21:51:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 429AFB81CF7;
        Thu, 22 Dec 2022 05:51:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558A9C433EF;
        Thu, 22 Dec 2022 05:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671688273;
        bh=gztgrP+lGDWx+pboL1x3QVUonCOW/rqRT649jwqAW8s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTBUgATBlzR4xjtGWjCda5bOqbz70n36sGPs0Sv4hnetKghJHkoG2POwXn8COGtLy
         yT6KHhuze8Ojk9lHtkzXCJoCncwrdvWSrZ0HvrIkdBeQbLvuWoywk/B8Soke8PL8QB
         lqCeYTRFd/2pzI4AW50W6X/5C+AEBfNfqmJc3I6o=
Date:   Thu, 22 Dec 2022 06:51:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?am9ld3Uo5ZCz5Luy5oyvKQ==?= <joewu@msi.com>
Cc:     Joe Wu <joewu@msi.corp-partner.google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Derek Huang <derekhuang@google.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y6PwTu2xWjjprBCR@kroah.com>
References: <20221220080226.17904-1-joewu@msi.corp-partner.google.com>
 <Y6K1sjCTM2Z6d4iU@kroah.com>
 <6fa20adbcc4b43f4947a52d50083eedc@msi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fa20adbcc4b43f4947a52d50083eedc@msi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:50:15AM +0000, joewu(吳仲振) wrote:
> *****CONFIDENTIAL INFORMATION*****
> 
> This email is intended only for the use of the person or entity to whom it is
> addressed and contains information that may be subject to and/or may be
> restricted from disclosure by contract or applicable law. If you are not the 
> intended recipient of this email, be advised that any disclosure, copy, 
> distribution or use of the contents of this message is strictly prohibited. 
> If you are not the intended recipient of this email, please notify the sender 
> that you have received this in error by replying to this message. Then, 
> please delete it from your system. Our Privacy Policy is available here 
> https://www.msi.com/page/privacy-policy. Thank you.

Now deleted.
