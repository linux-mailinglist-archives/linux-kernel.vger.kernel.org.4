Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999A7653C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 07:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiLVGIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 01:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235015AbiLVGIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 01:08:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D161A3BB;
        Wed, 21 Dec 2022 22:08:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD765619B6;
        Thu, 22 Dec 2022 06:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B09DC433EF;
        Thu, 22 Dec 2022 06:08:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671689296;
        bh=IBMOI28vrv+pLjApi+NOlADo7RFpLkKTRhUtlU6nMe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tdMDEg5OI/d5swV/a7ruh4m9wdx0a/8iNBDpArV6BLPkKOQnPP6DKT2iKJSlIeXTs
         191LhetDCVQp+zMFFt1Vd0T7tiK0LdP3TT+dkqj2cPToxe6pH9Syz6nAd3EBstTegD
         230vqKaqSq8M8GpxCHMb0VquE4+Y5s2u4ybZY+Aw=
Date:   Thu, 22 Dec 2022 07:08:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Wu <joewu@msi.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Daisuke Nojiri <dnojiri@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Derek Huang <derekhuang@google.com>,
        "Dustin L . Howett" <dustin@howett.net>, Joe Wu <joewu@msi.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-input@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>
Subject: Re: [PATCH] cros_ec_keyb: Add 3 buttons for monitor function
Message-ID: <Y6P0TVrVN+F6AxeC@kroah.com>
References: <20221222021542.11706-1-joewu@msi.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222021542.11706-1-joewu@msi.corp-partner.google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 10:15:42AM +0800, Joe Wu wrote:
> From: Joe Wu <joewu@msi.com>

Does not match the "From:" line on your email, why?

thanks,

greg k-h
