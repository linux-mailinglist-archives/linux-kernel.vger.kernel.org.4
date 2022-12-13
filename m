Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED05064B76B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235925AbiLMOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 09:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235794AbiLMObw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 09:31:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68C020BC5;
        Tue, 13 Dec 2022 06:31:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FD7DB810FB;
        Tue, 13 Dec 2022 14:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FC1C433D2;
        Tue, 13 Dec 2022 14:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670941908;
        bh=BP2D20qqRsIgeqfE7Stzv2DTidQHJtwB4teSCmQKVj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jlmq5QByNg1QkkSq1g5C/mXAcKM4f6kMEiusL6jQY3OvCgdwnRbntw2b+Rl6mLtl0
         iZo1H/SzhFO1b4iYIDXzsVtWcp/stnRzk8YOTP9FGJm8+0cN3iu5IVPVjnj3wVZUjp
         vs1dU1UTxlp+eGO4d/UtDwpX0kA7RV7jDZnJKBTg=
Date:   Tue, 13 Dec 2022 15:31:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     neal_liu@aspeedtech.com, joel@jms.id.au, andrew@aj.id.au,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-aspeed@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH] usb: gadget: aspeed_udc: Add check for dma_alloc_coherent
Message-ID: <Y5iM0LG2V5zN2D9u@kroah.com>
References: <20221213121520.18088-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213121520.18088-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 08:15:20PM +0800, Jiasheng Jiang wrote:
> Thanks, I found my mistake and I will submit a v2.
> 
> > And how did you find this potential problem?  What tool did you use and
> > why did you not follow the documentation for properly describing the
> > tool?
> 
> I used a tool I wrote myself to find it, which is unpublished.
> Therefore, I think it is okay to submit patches without description of the
> tools.

Nope!  Please read:
	Documentation/process/researcher-guidelines.rst
for what you must do.

thanks,

greg k-h
