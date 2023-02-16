Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD14699312
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBPL0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBPL0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:26:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDC815546;
        Thu, 16 Feb 2023 03:26:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA0B5B8270F;
        Thu, 16 Feb 2023 11:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECCFC433EF;
        Thu, 16 Feb 2023 11:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676546766;
        bh=JqT5yEXAhkCwICUXym7xZD6xerD9j/fbKb8DiKLW/PQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O0+OK3Mh13UboitR3ivXNTKZvVBkNZE/4/RVTm3G2EaNyGe2CWO0OW/DVCWU768bx
         t1Qm8md+bRuzWk61XbrjAq3cnMNYStihqaL0ZDvOhUvZozm6sUNJV/XNZOAI9aVHXL
         5ABna7wpf/AlkIicgkNTQI1aWFpJUvcVjjx4/tAs=
Date:   Thu, 16 Feb 2023 12:26:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daisy.Barrera@siriusxm.com, Cliff.Holden@siriusxm.com,
        arnd@arndb.de, tony@atomide.com, jdelvare@suse.de,
        neal_liu@aspeedtech.com, linus.walleij@linaro.org,
        egtvedt@samfundet.no, biju.das.jz@bp.renesas.com,
        herve.codina@bootlin.com
Subject: Re: [PATCH 2/4] usb: cdns2: Add main part of Cadence USBHS driver
Message-ID: <Y+4SzL2zDC1xVmk7@kroah.com>
References: <20230216105411.364157-1-pawell@cadence.com>
 <20230216105411.364157-3-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216105411.364157-3-pawell@cadence.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:54:09AM -0500, Pawel Laszczak wrote:
> +static void cdns2_pci_remove(struct pci_dev *pdev)
> +{
> +	struct cdns2_device *priv_dev;
> +
> +	priv_dev = (struct cdns2_device *)pci_get_drvdata(pdev);

Nit, no need to cast for this.

thanks,

greg k-h
