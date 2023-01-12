Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D564D666C11
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 09:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbjALIHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 03:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjALIGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 03:06:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3515277A;
        Thu, 12 Jan 2023 00:04:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA3F8B81D8E;
        Thu, 12 Jan 2023 08:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0AC433EF;
        Thu, 12 Jan 2023 08:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673510656;
        bh=koLKpmR7ubXGcPEHDSKdztFLkRuLvsXTAAg0oK49fCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BH2eOAP2N1/PKcKtBn/evtrff8U5dXDtKGnj7XIOJPpUjGiCqfJhvryMZFqPBDJZ7
         eC46jq1aTVqQjK3rf3IxyEzSyYmx1Pn5S4T0Pe0uBR9pDw+/aTVVfvLpcXQkmOREHr
         eWQWfHOJUmEej//9n74g9xZHwnd0DYVyFx/2KrfU=
Date:   Thu, 12 Jan 2023 09:04:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, unglinuxdriver@microchip.com,
        kernel test robot <lkp@intel.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v2 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y7+++EBuNgpmK5VB@kroah.com>
References: <20230112200619.2336505-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112200619.2336505-1-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 01:36:19AM +0530, Kumaravel Thiagarajan wrote:
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer, industrial,
> and automotive applications. This switch integrates OTP and EEPROM to enable
> customization of the part in the field. This patch provides the OTP/EEPROM
> driver to support the same.
> 
> Reported-by: kernel test robot <lkp@intel.com>

The robot did not report the lack of this driver in the kernel :(
