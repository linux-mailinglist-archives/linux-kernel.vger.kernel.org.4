Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC95073B2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjFWIbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjFWIbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D028C118;
        Fri, 23 Jun 2023 01:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB96619B3;
        Fri, 23 Jun 2023 08:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E068C433C0;
        Fri, 23 Jun 2023 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687509089;
        bh=66MXiuwIvFxFwdGrIKR+sbt1nglBjbPrdRoFgC+oPpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOv86CoV/dL6YzsEsgasewUBqv0eVxnDDG2V2l0nChPC8HJBZt21orkNuZnSnADxi
         66NGXDaIfuYrLEEJW1bgnXdBXYcRPDQVqPksAB3PvrrDJhiZ3PHlvZ5KfiJdcFsjx7
         4exUe6xo12MJvcDSRXZHPIFixlmrvH3MI1B34T78=
Date:   Fri, 23 Jun 2023 10:31:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        arnd@arndb.de, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com,
        michael@walle.cc
Subject: Re: [PATCH RESEND v13 char-misc-next 0/2] Add OTP/EEPROM
 functionality to the PCI1XXXX switch
Message-ID: <2023062354-rejoice-preschool-5251@gregkh>
References: <20230620143520.858-1-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620143520.858-1-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 08:05:18PM +0530, Vaibhaav Ram T.L wrote:
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch integrates OTP and
> EEPROM to enable customization of the part in the field. This patch adds
> OTP/EEPROM functionality to the pci1xxxx switch.
> ---
> v12 -> v13:
> - Moved release_sys_lock() from patch#2 to patch#1

This series is not showing up on lore.kernel.org at all, are you sure it
is getting to the mailing lists properly?

thanks,

greg k-h
