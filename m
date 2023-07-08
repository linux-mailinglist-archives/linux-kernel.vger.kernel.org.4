Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8466974BD52
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 13:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbjGHLKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 07:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjGHLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 07:10:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9EA129;
        Sat,  8 Jul 2023 04:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3784260B35;
        Sat,  8 Jul 2023 11:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E825C433C7;
        Sat,  8 Jul 2023 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688814632;
        bh=/eagb1g41jlYbYNVD/k/nT4mBSx2guvjO7rd3V9z7Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=byUOD5YF14hpBIR0uIdMKA8jpGyLsxjhCpB/SrabkT5MPGLXrLxxLjNWghMzp6SwO
         GcTxBXHYzF9s/JAuahyxdqIAODFbtj47Law+AHbkjCMFNNAu5maaINvndsogHkBlwI
         sTAtI7oRolezDqz+MO7jjLpMx571EC5iP/5rETaA=
Date:   Sat, 8 Jul 2023 13:10:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Madhumitha Prabakaran <madhumithabiw@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, skhan@linuxfoundation.org,
        ivan.orlov0322@gmail.com
Subject: Re: [PATCH] Add struct ad9832_platform_data to the include/linux/iio
Message-ID: <2023070858-brewing-outpour-764c@gregkh>
References: <20230707211553.GA110890@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707211553.GA110890@madhu-kernel>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 07, 2023 at 04:15:53PM -0500, Madhumitha Prabakaran wrote:
> Add struct ad9832_platform_data to the include/linux/iio
> for maintaining code organization and clarity.
> 
> Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c |  3 +--
>  drivers/staging/iio/frequency/ad9832.h | 34 --------------------------
>  include/linux/iio/frequency/ad9832.h   | 30 +++++++++++++++++++++++

No, not yet, sorry.  Staging drivers should be self-contained, why does
this .c file need a .h file at all anyway?  It should all just be in the
.c file, can you do that instead?

thanks,

greg k-h
