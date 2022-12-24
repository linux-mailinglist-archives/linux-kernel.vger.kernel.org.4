Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759596558A9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 07:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiLXGhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 01:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiLXGhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 01:37:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14756330;
        Fri, 23 Dec 2022 22:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4415B81CD9;
        Sat, 24 Dec 2022 06:37:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A653BC433D2;
        Sat, 24 Dec 2022 06:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671863856;
        bh=/38IVuA7PEniyulc/5p3MH83Z0S0l/GkZGr7fxcOHlU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e/xs47NrvMxbZrOcspCL/f131I/YtyPzR+JHr+exRnFQOLDCy3RH30sVbJvJUQ/X5
         AUoKWGqQubnv5O4Nbjwoid1bx+c2taE7D7KNKgLFAKE9j7JtXN3cS4aKzXX4XvNxEb
         bOfWEIWXSLwgIA9fZLyZBh6mHnagkn1EMNXa36Us=
Date:   Sat, 24 Dec 2022 07:37:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     neal_liu@aspeedtech.com, joel@jms.id.au, andrew@aj.id.au,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v3] usb: gadget: aspeed_udc: Add check for
 dma_alloc_coherent
Message-ID: <Y6aeLMAu+XCYTxt6@kroah.com>
References: <20221224025001.24503-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221224025001.24503-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 24, 2022 at 10:50:01AM +0800, Jiasheng Jiang wrote:
> Yes, it is the same as mine.
> As the previous patch had not been merged into the Linux kernel,
> my tool found the same error and report it.
> And both of us chose the most concise way to fix the error.
> That is why the patches are the same.

I have no context at all here, what does this refer to?

confused,

greg k-h
