Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F2F610E99
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiJ1KfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJ1Kem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:34:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D7F1A3AC;
        Fri, 28 Oct 2022 03:34:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49997B80502;
        Fri, 28 Oct 2022 10:34:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95CA4C433C1;
        Fri, 28 Oct 2022 10:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666953276;
        bh=vbUQh2sICA0O+YdVcFaCsEzhcEqIniAEZEJg7KH51XU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mb1mY1Puw7lmCdsg/07UkdocMqy3bUsrUDvYLt9WxHJqwHIZ9Rd8BsSDMKGw3Zfzh
         RtiFDztnVGX15xC0sLiZvFoROWwZZIbE1BLNXkF4PdnG8mEGFwFEdEOaPpHlvx6baV
         bohOEFZ//UJpXYnv8t8MU8V1UH8V683y/wpXgecs=
Date:   Fri, 28 Oct 2022 12:34:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 0/1] vdec_vp9_if: add check for NULL for
 vsi->frm_bufs[vsi->new_fb_idx].buf.fb in vp9_swap_frm_bufs
Message-ID: <Y1uwOsYjx7EbOyHX@kroah.com>
References: <20221028100539.30925-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028100539.30925-1-abelova@astralinux.ru>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:05:38PM +0300, Anastasia Belova wrote:
> Null-pointer dereference was found with static analysis tools 
> in version 5.10. Seems this file doesn't exist since 5.18.
> This file was moved to 
>     /drivers/media/platform/mediatek/vcodec/vdec/vdec_vp9_if.c.
> Maybe it is necessary to create another patch for these updates.

Fix this in Linus's tree first, and then worry about any potential need
for stable backports.

thanks,

greg k-h
