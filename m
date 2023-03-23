Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8406C5E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCWExr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCWEx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:53:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C019C52
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F49EB81D52
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B259DC433D2;
        Thu, 23 Mar 2023 04:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679547202;
        bh=uzFB9x1Hyc+9dE/aF2h2WsJuyCGoBehuwnjCIfIgx9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qJH1K80Ut1jTFOeSeJ0oczI8vlBDCcDlz733wVGgqktOQpPcvaiz8r2ACB6i+CLuR
         B4uHzC9C6OEBiicvIQj8lVg1/OyXjbRKTRFqA+613Dw4PRwe+9olkSAp65nOAYD/nv
         r4R3lV4RYgvPOERBee8IfTOsnUlON7hI+p9T4Zh0=
Date:   Thu, 23 Mar 2023 05:53:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
        Christian Gromm <christian.gromm@microchip.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: most: fix line ending with '('
Message-ID: <ZBvbP8ugDFjSoVp/@kroah.com>
References: <ZBsSOlPbaGZcAaSY@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBsSOlPbaGZcAaSY@khadija-virtual-machine>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:35:38PM +0500, Khadija Kamran wrote:
> Splitting function header to multiple lines because of 80 characters per
> line limit, results in ending the function call line with '('.
> This leads to CHECK reported by checkpatch.pl
> 
> Move the first parameter right after the '(' in the function call line.
> Align the rest of the parameters to the opening parenthesis.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/most/dim2/hal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

You have 2 patches here with identical subject lines, yet they do
different things :(

I've dropped all of your pending patches now for the most driver as I'm
totally confused.  Please resend them all as a proper patch series with
updated subject lines.

thanks,

greg k-h
