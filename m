Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EADC5652D47
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 08:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiLUH26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 02:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLUH2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 02:28:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995331EAF7;
        Tue, 20 Dec 2022 23:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DA98616FD;
        Wed, 21 Dec 2022 07:28:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC7A9C433D2;
        Wed, 21 Dec 2022 07:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671607733;
        bh=cRF0ar5xp1O4E9/pzfz6d06fa4kFJnLgBYrOdMd0uiQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=he4Iyu4JlNtCB7ZxQFKuVG4TQzlGi6l4zzRS4oor133YItAYFQmxHJDM8FR95eJFa
         USBviq1kCtMdCWQb+Sd3GDLr+aY2c6uDd6MEKiDXLgitcg7R0Q0Qb1P+zte1jGrQ2N
         CtgIHAUCaaAQ2zfyfBfCs+moCI+7lIMh8R5FLl38=
Date:   Wed, 21 Dec 2022 08:28:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Wu <joewu@msi.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        "Dustin L . Howett" <dustin@howett.net>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-input@vger.kernel.org,
        Prashant Malani <pmalani@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Derek Huang <derekhuang@google.com>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y6K1sjCTM2Z6d4iU@kroah.com>
References: <20221220080226.17904-1-joewu@msi.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220080226.17904-1-joewu@msi.corp-partner.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 04:02:26PM +0800, Joe Wu wrote:
> Add 3 extra buttons: 'brightness up', 'brightness down'
> and 'screen lock' to support monitor manipulating function.
> 
> Signed-off-by: Joe Wu <joewu@msi.corp-partner.google.com>

Note, this is a "fake" email address, please always use your real one
and not a google-gerrit-assigned address.

thanks,

greg k-h
