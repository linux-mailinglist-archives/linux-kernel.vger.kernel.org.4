Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634E25B6D93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiIMMsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:48:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25150734;
        Tue, 13 Sep 2022 05:48:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 385E86144A;
        Tue, 13 Sep 2022 12:48:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E295C433C1;
        Tue, 13 Sep 2022 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663073327;
        bh=I6oTbatHobNlYjYHGyHKwqANjbSQjrxFlVZfO84Q1lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boJkZRu26fOHzXLLainwggBwKA3boKCYYOovR/2wxdln4d79gQfnBP79ZHDw+JPHB
         nhBTYUzrdi12Fxw0dtfgfIAuZGjOLUhr1McBB2m1wcoCzjHy2D+JZCSVF488luYsEz
         ma7ujIbRhLoph26nSzLgsfydsLaHX+AiAXKOfSOF+p6A4jDNlWZ7UlnDiVpXziZHme
         l9u81x6fiXMiJG+MmDFujR+JqslgR+fmWIg8cd/DZxCzi6AF69DtCUgVE3jHBoF3tK
         lT80yf8q6wwINEZd9Kn5VEJenAcsu6h976w3cORsfJ4j3Rf/Zb4dCU2PfA8Mv2HMq3
         iMb/7GZa3bEoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY5LL-0003as-0y; Tue, 13 Sep 2022 14:48:47 +0200
Date:   Tue, 13 Sep 2022 14:48:47 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3] USB: serial: ftdi_sio: Convert to use dev_groups
Message-ID: <YyB8L5+R2s7Np/DP@hovoldconsulting.com>
References: <20220905100101.343861-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905100101.343861-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 06:01:01PM +0800, Jiasheng Jiang wrote:
> On Fri, Sep 02, 2022 at 10:52:52PM +0800, Greg KH wrote:

> >>> And again, have you tested this change?
> >> 
> >> Every time I change the code, I recomplie it and check whether there are
> >> errors.
> >> Are there any other tests I need to do?
> > 
> > Yes, boot with the device and make sure that the sysfs files are still
> > there.  You do have access to one of these devices, right?  They are
> > very very common.
> 
> Sorry, I still have no idea how to boot with the device.

You need to buy an FTDI device and plug it into a machine with your
patch applied to the running and make sure that you did not break
anything.

> But if there is any wrong with the patch, you can tell me and I will continue
> to revise it.

It is your job to test your patches.

Johan
