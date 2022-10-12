Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5170E5FC43E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 13:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJLLSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 07:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLLSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 07:18:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68662C1DBD;
        Wed, 12 Oct 2022 04:17:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00664614A3;
        Wed, 12 Oct 2022 11:17:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF58C433D6;
        Wed, 12 Oct 2022 11:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665573478;
        bh=VPoWHfGC56w6Nz4ZbzrCyXpHayj5pSEGkbhIWaCVCIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mAdgf4yVBiWMYb6VkZovbWvi2bwjKwAAH04xyAk7nY9xGJ1VVkMd0pSdA85a3yuUW
         JshltfrGbISjdoUqf4EXFr67v3gySXn/v0pgTwAgWy1cwQRUm5nJDv1k9Q789zXWT/
         /5I+0uYZskqgKlP7WqP8sY5d2HzC5xtkfcB/xe+M=
Date:   Wed, 12 Oct 2022 13:18:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Lin <jilin@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] xhci: tegra: USB2 pad power controls
Message-ID: <Y0aikRq2Yi5kYW9j@kroah.com>
References: <20221012102511.3093-1-jilin@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012102511.3093-1-jilin@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 06:25:11PM +0800, Jim Lin wrote:
> +static inline struct tegra_xusb *hcd_to_tegra_xusb(struct usb_hcd *hcd)
> +{
> +	return (struct tegra_xusb *) dev_get_drvdata(hcd->self.controller);

No need for the cast (and if there was, no need for the extra space).

thanks,

greg k-h
