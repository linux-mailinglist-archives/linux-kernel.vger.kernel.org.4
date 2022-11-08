Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5AB6217B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiKHPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiKHPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:11:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363F01D33A;
        Tue,  8 Nov 2022 07:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCDBAB81B2D;
        Tue,  8 Nov 2022 15:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB3FC433C1;
        Tue,  8 Nov 2022 15:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667920291;
        bh=bUhm8bPYBefFFA0xuG61eYa8uJmFZP0Vu2o13BUbaSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x8e+hjMnIsQ0CHkl5VCQ8dlJ+6Dm4XqSpYb45QwZC6A6edmx+Urdiz1jFivcY1u5b
         hWQP0QJfkTWu2oiSUXsnUxa9DoyJO0GbVZ9niK/A2dm7QYzcmR0msteAz2aleuQw32
         WSYDNqhncHJsbpm5xwZXV8Ezmt45EP5yM3RAx9l0=
Date:   Tue, 8 Nov 2022 16:11:28 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Zhangjiantao (Kirin, nanjing)" <water.zhangjiantao@huawei.com>
Cc:     =?utf-8?B?6Jab5rab?= <xuetao09@huawei.com>,
        stern@rowland.harvard.edu, jakobkoschel@gmail.com,
        geert+renesas@glider.be, colin.i.king@gmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?6JSh5Lqa5Lic?= <caiyadong@huawei.com>,
        =?utf-8?B?5b6Q5rW35rSL?= <xuhaiyang5@hisilicon.com>,
        =?utf-8?B?6IuP5bqE6Yqu?= <suzhuangluan@hisilicon.com>
Subject: Re: [PATCH] USB: gadget: Fix CFI failure during usb config switch.
Message-ID: <Y2pxoJySPpTkL6Rw@kroah.com>
References: <b71e1b4b-4d33-fc36-a35f-ea40904a40b6@huawei.com>
 <32d2bf3e-6730-f598-afef-e8d6f4a509b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32d2bf3e-6730-f598-afef-e8d6f4a509b0@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 08:39:52PM +0800, Zhangjiantao (Kirin, nanjing) wrote:

<snip>

Please fix your email client to not send HTML email, otherwise the
mailing list rejects it.

Fix that up and respond and I will be glad to reply.

thanks,

greg k-h
