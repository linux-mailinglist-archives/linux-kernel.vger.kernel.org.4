Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AE56ECC62
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjDXMxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 08:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjDXMxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 08:53:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E583E123;
        Mon, 24 Apr 2023 05:53:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814F861F3A;
        Mon, 24 Apr 2023 12:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BC7C433D2;
        Mon, 24 Apr 2023 12:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682340794;
        bh=pizmfrZUSRf4veHaMhTxro4FUdImZzYAFJhcRT/hlQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhO+owNpNXhtarly3IaJKJ9S4uOuJsCSC7Htwq5gZ7XAp6bVIcAyB9vo1UmX1enO0
         k6tOdOvWhFijGCncR/xB1NyNGqmo0wxmCSUKHCdaKutz8iI7qpF7q4Yh3sVMYSLdgu
         U9+RxiIvuD0pM+JwdBN77OLsfu9I+p7CF/g05ihY=
Date:   Mon, 24 Apr 2023 14:53:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Enderborg <peter.enderborg@sony.com>,
        Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <2023042421-landowner-magnitude-a38c@gregkh>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2023 at 01:32:14PM +0100, Mark Brown wrote:
> On Mon, Apr 24, 2023 at 02:20:45PM +0200, Peter Enderborg wrote:
> > On 4/24/23 13:54, Mark Brown wrote:
> 
> > > This is very much a question of taste with a range of use cases
> > > available.
> 
> > No. 
> > https://lkml.iu.edu/hypermail/linux/kernel/1901.2/05993.html

Please use lore.kernel.org links in the future.

> > We can do things with the debug information without filesystem enabled.

What exactly do you mean by this?

> There's issues with partially created debugfs structures getting in the
> way of people trying to debug things, just completely ignoring all
> errors can create confusion as the diagnostic information people believe
> is being shown to them ends up being partial or mistructured without any
> indication that this has happened.

How do you end up with partially created debugfs structures?

thanks,

greg k-h
