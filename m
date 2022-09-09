Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7845B30E0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiIIHwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiIIHv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF0A80027
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35E0061E8E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:48:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C786C433C1;
        Fri,  9 Sep 2022 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662709692;
        bh=cembJTLzrsCcUN/TdAvvEAHow2IUj6Pixg3rsqu8vrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2LQaXzxBgKa0nuijX34MpyVVJeGBKhC7JtE6S9ENOUo7Rks/AoLMRwK7bUby2Q5nT
         phHrAe6sbGDnVoqVc21iaxfLveldSx/DrwXlzv9ICEbct5xJdSnvjxPeJcMFaWOPa3
         8mnH1wkJSK5pFVBJwjYljom+iO3GKU+ph0bfMRUE=
Date:   Fri, 9 Sep 2022 09:48:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xkernel.wang@foxmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: fix potential memory leak in
 rtw_init_drv_sw()
Message-ID: <YxrvuoVF+IGfUikb@kroah.com>
References: <tencent_61623C1C5469E9DF0E448B5936B78E239C05@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_61623C1C5469E9DF0E448B5936B78E239C05@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:31:25PM +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> In rtw_init_drv_sw(), there are various init functions are called to 
> populate the padapter structure and some checks for their return value.
> However, except for the first one error path, the other five error paths 
> do not properly release the previous allocated resources, which leads to 

You have trailing whitespace on your text :(

> various memory leaks.
> 
> This patch fixes them and keeps the success and error separate. As there
> is no FooBar device to test with, no runtime testing was performed.

What do you mean by "FooBar"?  Please fix that up.

thanks,

greg k-h
