Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782BC6CD739
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjC2KDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjC2KDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:03:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2824219A;
        Wed, 29 Mar 2023 03:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B178161C2E;
        Wed, 29 Mar 2023 10:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0982C433EF;
        Wed, 29 Mar 2023 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084217;
        bh=4dKTj8NkljpvIB3DLLAn5YLXV7ZuAu3YUNT8GNWZbSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd8UlwVEpeP+G3O2JRhvqW2CATLA+j+BRhXRKe7IRbgqtS43HV/CrlRe8TfLfFgUx
         //qsOT2PDUxyeBeZiBJezl8hzIc4ffn2d8WOpu6ORwacIcdGNpDVKtv5n6KtlFNYRp
         xu/Iw0ZlumEv2R7zZOszTJgYkfjRZK9rEhoneQ5g=
Date:   Wed, 29 Mar 2023 12:03:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 char-misc-next 0/5] Fix error handling in probe
Message-ID: <ZCQM9t5v2Dcet3gP@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:10:03PM +0530, Vaibhaav Ram T.L wrote:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
> industrial, and automotive applications. This switch integrates OTP
> and EEPROM to enable customization of the part in the field. First 
> patch provides fix for error handling in the probe function of 
> mchp_pci1xxxx_gp driver. Remaining patches add the OTP/EEPROM driver 
> for the switch.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>


Why are there signed-off-by for the 00/XX patch?

And the subject doesn't make sense to me.

thanks,

greg k-h
