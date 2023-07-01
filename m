Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8FF74479C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjGAHSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAHSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC5136;
        Sat,  1 Jul 2023 00:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8ED860FAA;
        Sat,  1 Jul 2023 07:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01DC433C7;
        Sat,  1 Jul 2023 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688195887;
        bh=yvU1B9CzY4SoNHJbzm1vKiLG5Gv1vNDPYNbKeP43u5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9sd+ds8NNXBaPzb97EyfMjwaWZSB7OX8TgcZAvmlU9S5E6OVU3GDLMWpVZ7/wH2Y
         ySxNaRxGHUUJKG8zCQpPHX2B8PD301aXLkXDwpTP23gcap9/BodaMuITwI3LVaaGlI
         ViPruNDtv+PvmwLQCIpRkW87GazGFUVGtVnkdujw=
Date:   Sat, 1 Jul 2023 09:18:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     VaibhaavRam.TL@microchip.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        arnd@arndb.de, Kumaravel.Thiagarajan@microchip.com,
        Tharunkumar.Pasumarthi@microchip.com, UNGLinuxDriver@microchip.com,
        michael@walle.cc
Subject: Re: [PATCH RESEND v13 char-misc-next 0/2] Add OTP/EEPROM
 functionality to the PCI1XXXX switch
Message-ID: <2023070155-annually-abdominal-b61d@gregkh>
References: <20230620143520.858-1-vaibhaavram.tl@microchip.com>
 <2023062354-rejoice-preschool-5251@gregkh>
 <DM4PR11MB623829DD125CA15D628FB4B0972BA@DM4PR11MB6238.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR11MB623829DD125CA15D628FB4B0972BA@DM4PR11MB6238.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 07:08:44AM +0000, VaibhaavRam.TL@microchip.com wrote:
> On Tue, Jun 20, 2023 at 08:05:18PM +0530, Vaibhaav Ram T.L wrote:
> >> Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer, 
> >> industrial, and automotive applications. This switch integrates OTP 
> >> and EEPROM to enable customization of the part in the field. This 
> >> patch adds OTP/EEPROM functionality to the pci1xxxx switch.
> >> ---
> >> v12 -> v13:
> >> - Moved release_sys_lock() from patch#2 to patch#1
> >
> >This series is not showing up on lore.kernel.org at all, are you sure it is getting to >the mailing lists properly?
> >
> >thanks,
> >
> >greg k-h
> 
> Hi Greg. I too can't find the root cause for this issue. 
> 
> I have used get_maintainer.pl script to get the Maintainers list and it looks like this:
> 
> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRIVERS) Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and MISC DRIVERS,commit_signer:2/3=67%) "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com> (supporter:MICROCHIP PCI1XXXX GP DRIVER,commit_signer:1/3=33%) Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com> (supporter:MICROCHIP PCI1XXXX GP DRIVER,commit_signer:3/3=100%,authored:3/3=100%,added_lines:15/15=100%,removed_lines:1/1=100%,added_lines:3/3=100%,removed_lines:2/2=100%)
> Tharun Kumar P <tharunkumar.pasumarthi@microchip.com> (commit_signer:1/3=33%) linux-kernel@vger.kernel.org (open list) linux-gpio@vger.kernel.org (open list:MICROCHIP PCI1XXXX GP DRIVER)'
> 
> This is the command I have used: 
> git send-email --to "linux-kernel@vger.kernel.org" --to "linux-gpio@vger.kernel.org" --cc "arnd@arndb.de" --cc "gregkh@linuxfoundation.org" --cc "kumaravel.thiagarajan@microchip.com" --cc "tharunkumar.pasumarthi@microchip.com" --cc "UNGLinuxDriver@microchip.com" --cc "michael@walle.cc" *.patch
> 
> Is there anything am I missing?
> 
> As of now, I have sent Patch V13 from Kumar's email id. Kindly check.
> Sorry for inconvenience

This email shows up fine, and so did your new resend, thanks!

greg k-h
