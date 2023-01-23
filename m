Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0E4678779
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232738AbjAWUSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjAWUSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:18:25 -0500
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Jan 2023 12:18:23 PST
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4075D30B18;
        Mon, 23 Jan 2023 12:18:23 -0800 (PST)
Received: from [192.168.0.2] (chello089173232159.chello.sk [89.173.232.159])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id DE7FC7A033B;
        Mon, 23 Jan 2023 21:02:52 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     linux-usb@vger.kernel.org
Subject: Re: Getting Backpack USB drives to work - looking for lost firmware
Date:   Mon, 23 Jan 2023 21:02:49 +0100
User-Agent: KMail/1.9.10
Cc:     linux-kernel@vger.kernel.org
References: <202206181935.01392.linux@zary.sk>
In-Reply-To: <202206181935.01392.linux@zary.sk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202301232102.49680.linux@zary.sk>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_05,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,USB_DRIVES autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2022 19:35:01 Ondrej Zary wrote:
> Hello,
> I'm trying to get Micro Solutions Backpack USB CD-RW to work and maybe write a simple firmware loader module. It's based on Cypress EZ-USB FX2 so it should be easy (the loading code is already present in the kernel for other devices).
> 
> Micro Solutions released firmware and load scrips for Linux - it used to be called bpck-usb-firmware-1.1.tgz but seems to have vanished from the web, even archive.org does not have it. Frugalware distro used to include a package bpck-usb-firmware-1.1-1-i686.fpm until version 1.7 (it was removed in 1.8) but I was not able to find it anywhere (even tried Frugalware developers).
> 
> At least the load script can be found here:
> https://www.linuxquestions.org/questions/linux-hardware-18/external-usb-backpack-cd-rewriter-problem-212360/
> Firmware filenames extracted from the script:
> BP1SCAN.HEX, BP2SCAN.HEX (scan firmwares)
> BP1CD5.HEX, BP1CD6.HEX, BP1HD5.HEX, BP1HD6.HEX (for USB 1 chips)
> BP2CD5.HEX, BP2CD6.HEX, BP2HD5.HEX, BP2HD6.HEX (for USB 2 chips)
> BPINTCD.HEX, BPINTHD.HEX (for internal USB 2 chips)
> 
> So there seems to be two kinds of external USB adapters/cables - with FX (USB 1) and FX2 (USB 2) chips. First, a "scan" firmware is loaded that identifies the drive type and changes the ID appropriately. Then a final firmware is loaded, depending on the chip type, drive version (5 or 6) and drive type (CD or HDD).
> The latest devices have integrated USB support - no scanning is needed, just a CD or HDD firmware is loaded, depending on the ID.

Finally found the lost firmware files!

There's a Frugalware Linux 0.6 DVD 1 ISO at PC World Poland which contains the bpck-usb-firmware-1.1-1-i686.fpm file:
https://www.pcworld.pl/ftp/pobierz/linux/1582.html

-- 
Ondrej Zary
