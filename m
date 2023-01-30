Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9BD6814A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjA3PS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238121AbjA3PSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:18:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2C876AC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:18:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6FB62B81185
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4717C433EF;
        Mon, 30 Jan 2023 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675091888;
        bh=cetnjI2pIEvb88AtbDqKJWriBmwrANJ8A5ZPKyKWqZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIyCwwil78M1e388tlGTouqOIRBa3us8+y8ZgiZbYp2pTDQEezh3G+zwikJKpEL4O
         mycxSyZ5CORESO+o/yQcn/x5dG3XFDiEYNh1tJnKnHXEOEy0cA9tCRa9jf3Gy+4046
         rBQZ4NqJ54Epc0u8StrBzzBaP+uvmbQs1Dcb2+Bs=
Date:   Mon, 30 Jan 2023 16:18:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jongwoo Han <jongwooo.han@gmail.com>
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vc04_services: mmal-vchiq: fix typo in comment
Message-ID: <Y9ffrfjQ6ElhV3/Z@kroah.com>
References: <20230130145400.40890-1-jongwooo.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130145400.40890-1-jongwooo.han@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:54:00PM +0900, Jongwoo Han wrote:
> Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
> ---
>  drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I can not take patches without any changelog text at all, sorry.

greg k-h
