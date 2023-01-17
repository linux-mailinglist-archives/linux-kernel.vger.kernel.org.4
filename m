Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0C566E724
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjAQTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbjAQTfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:35:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF8638002
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:39:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB01CB819C5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A23FC433D2;
        Tue, 17 Jan 2023 18:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673980746;
        bh=vM2fqHktL0s7+JaqK1Vmzmomp2n2N/6TF7pZeT0CVy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Go7Tgsc9fvKPhQV3ISeb9wf27R/HrBG7OyXZiIYs+WoaiHmZaJOIozYkvjp9o+dJb
         MtQrBcJU0IBs3tdMTWyaB5ishvDTLxVn67fOpFQAkPwoVwPvFD/B8bA6hV0M5usoe/
         VcHDT8f/QYQ9VCZiCFQtbp9kOInkjDt1aoEogMdk=
Date:   Tue, 17 Jan 2023 19:38:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/20] staging: r8188eu: pass struct adapter to usb_write
Message-ID: <Y8brJFAjan6DuhwF@kroah.com>
References: <20230111195640.306748-1-martin@kaiser.cx>
 <20230111195640.306748-19-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111195640.306748-19-martin@kaiser.cx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 08:56:38PM +0100, Martin Kaiser wrote:
> The usb_write function takes a struct intf_hdl only to extract the struct
> adapter from it. We can pass struct adapter directly.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  drivers/staging/r8188eu/hal/usb_ops_linux.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

This commit did not apply to my tree so I stopped here in the series.

Please rebase and resubmit the remaining ones.

thanks,

greg k-h
