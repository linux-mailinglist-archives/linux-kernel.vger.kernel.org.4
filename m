Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 102576CD733
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjC2KCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjC2KCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:02:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E410410F8;
        Wed, 29 Mar 2023 03:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D890B82212;
        Wed, 29 Mar 2023 10:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA64BC433D2;
        Wed, 29 Mar 2023 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084152;
        bh=fXnfM3/Y3Bz/nECqO6/ngDxN4TbMHj1QWyFdmNUOmjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dV07w0Io9rJzdnhgAwvY8daAfxLAzmIz6KXsNWgX3X+7pisaqVW6AaXUtEIqts7pk
         tEno9Mg2fTYuzaOvJ0KLfSMVzEOvULtyaSckJGLd6NywVreCgbIetUapMwI0cSLfzb
         tPrJm0lRRTH8JFcWHr/bji/8UaLZZBzi0MCREOkU=
Date:   Wed, 29 Mar 2023 12:02:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 char-misc-next 4/5] misc: microchip: pci1xxxx: Load
 auxiliary driver for OTP/EEPROM auxiliary device
Message-ID: <ZCQMtUAWAeCDmXlK@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
 <20230328144008.4113-5-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144008.4113-5-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:10:07PM +0530, Vaibhaav Ram T.L wrote:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> This patch contains driver to perform ioremap for the OTP/EEPROM 
> auxiliary device.

What does this mean?  What will it do?  Why is this needed?

thanks,

greg k-h
