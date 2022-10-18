Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384E6602495
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 08:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiJRGig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 02:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJRGiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 02:38:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B78F8A7DC;
        Mon, 17 Oct 2022 23:38:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D6A6B81CF6;
        Tue, 18 Oct 2022 06:38:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C78C433C1;
        Tue, 18 Oct 2022 06:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666075099;
        bh=CBasv0SfFeTkDgNOu8LtkJ/XXXXbw/Q3Aisnay4Fmvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSOlmS3DFb7STQ/G3n5VwNnD/Q5iKB7+rXRIeCvpK5xifzUI2x//idkPpQ1w4Lzmt
         mgaIEdzs7fOb3SYBVVWqHPlk5ojtsBWRjqOX90xJF3E+HIrAwTEaNTsGakIjKRJqnQ
         /WLKoWBSwO9VnlAXU6ZYebk7N0mHE+XURi2ZF+Do=
Date:   Tue, 18 Oct 2022 08:38:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kartik <kkartik@nvidia.com>
Cc:     ldewangan@nvidia.com, jirislaby@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, swarren@nvidia.com,
        akhilrajeev@nvidia.com, linux-serial@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: read DMA status before terminating
Message-ID: <Y05J19PplpDuOfR/@kroah.com>
References: <1666074311-12764-1-git-send-email-kkartik@nvidia.com>
 <1666074311-12764-2-git-send-email-kkartik@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1666074311-12764-2-git-send-email-kkartik@nvidia.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:55:11AM +0530, Kartik wrote:
> To get the valid data, read DMA status before terminating the DMA. As
> dmaengine_terminate_all() deletes the DMA desc.
> 
> Fixes: e9ea096dd225 ("serial: tegra: add serial driver")
> 
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> Signed-off-by: Kartik <kkartik@nvidia.com>
> ---
>  drivers/tty/serial/serial-tegra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Why send this twice?

confused,

greg k-h
