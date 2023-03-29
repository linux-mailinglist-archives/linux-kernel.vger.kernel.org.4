Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5DA6CD730
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjC2KCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjC2KB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200635A8;
        Wed, 29 Mar 2023 03:01:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88A5E61BAA;
        Wed, 29 Mar 2023 10:01:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90622C433EF;
        Wed, 29 Mar 2023 10:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084105;
        bh=eTaLTH51j42o991eTgtmrlJcvrd3Rh2TJAp3hncZigg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TkiMaWTYSXaAWSKs2MY1t0Dm8y1IWZKMJWddZj/AWeiZFPsNG/RXshrxDnrAL4/K9
         hp37i9iVfFywnqp4RHa6JpZlChiAINvjJjShKgjg9e1WguYXcnrou43C3BRKZb8yI1
         S75b0yWrIcn8mw2rD7eYDw0rTSjYml9Gimp/MlaA=
Date:   Wed, 29 Mar 2023 12:01:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 char-misc-next 3/5] misc: microchip: pci1xxxx: Add
 EEPROM Functionality to read and write into EEPROM bin sysfs
Message-ID: <ZCQMh_TbPyLGhTD2@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
 <20230328144008.4113-4-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144008.4113-4-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:10:06PM +0530, Vaibhaav Ram T.L wrote:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch integrates OTP
> and EEPROM to enable customization of the part in the field. 
> This patch adds EEPROM functionality to support the same.

Again, why not use the in-kernel eeprom api instead?

thanks,

greg k-h
