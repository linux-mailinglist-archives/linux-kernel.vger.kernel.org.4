Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA4654CED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 08:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiLWHkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 02:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiLWHkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 02:40:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC9612A9E;
        Thu, 22 Dec 2022 23:40:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D8C961E59;
        Fri, 23 Dec 2022 07:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C3AC433EF;
        Fri, 23 Dec 2022 07:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671781237;
        bh=KTUubI0BHL09Dsjc8ugI3jb5QrMgDW2Khn7LPdXgi1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tJNYqGft3JZpEgnUY3zvq1NF7Zfm/5y2altZnmi+Wc5fBUrzM6ze2QdqDtMMyGFAV
         tWm6uti7JrNiuJtwZe+3s33xruT0+ByH/MJhctfB93hWsiY//p04Yjgw09rGHpKD91
         CF1NqoYXS977H1WNaxBT+DZkAL0FNDOPud1OA+B4=
Date:   Fri, 23 Dec 2022 08:40:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?am9ld3Uo5ZCz5Luy5oyvKQ==?= <joewu@msi.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        Benson Leung <bleung@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>,
        Furquan Shaikh <furquan@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: Re: [PATCH v2] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y6VbckwldHFKcPRO@kroah.com>
References: <e23628e2cb464d238eb1c33a9e1e516b@msi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e23628e2cb464d238eb1c33a9e1e516b@msi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 07:18:06AM +0000, joewu(吳仲振) wrote:
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
