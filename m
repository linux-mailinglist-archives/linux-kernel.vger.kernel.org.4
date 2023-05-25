Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2373710D39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbjEYN0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235319AbjEYN0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 09:26:36 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADE8E7;
        Thu, 25 May 2023 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O+fkr0z/7+sCqRoHFMKwbZJo5J70B+Y4nnwKZDooPGE=; b=H/KcOLrobUmps+UFkAM5r179/p
        6ztKhXMKtBX1hfVyQtRj3f9RNeUzFnwPTamYK4wQAvMkvOju79Gu6v2JohoCN77KEw56rcl70l7lP
        KMCA5XoKUj3fZlM2i4eRcbV1Ng5Lm/0WR5S2KZvJjETXXwfVny7aWB6VHv58CS6ulw+A=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:47010 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2Az6-0007jC-52; Thu, 25 May 2023 09:26:28 -0400
Date:   Thu, 25 May 2023 09:26:27 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525092627.edf4f7f9df4b9b1cf7b568a4@hugovil.com>
In-Reply-To: <ZG84KCeMIINFVTMh@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <ZG84KCeMIINFVTMh@surfacebook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v3 00/11] serial: sc16is7xx: fix GPIO regression and
 rs485 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 13:27:52 +0300
andy.shevchenko@gmail.com wrote:

> Thu, May 25, 2023 at 12:03:13AM -0400, Hugo Villeneuve kirjoitti:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Hello,
> > this patch series mainly fixes a GPIO regression and improve RS485 flags and properties
> > detection from DT.
> > 
> > It now also includes various small fixes and improvements that were previously
> > sent as separate patches, but that made testing everything difficult.
> 
> > Patches 1 and 2 are simple comments fix/improvements.
> 
> Usually we put fixes at the beginning of the series, but these patches are
> missing Fixed tag. Are they really fixes or can be simply moved to the end of
> the series?

Hi,
these are not code fixes, they are comments improvements. I was not aware that you need to put a Fixes tag for correcting syntax errors in comments, or adding comments to improve clarity.

I often submit such comments patches but was never asked to put a Fixes tag before. Seems strange to me...

Hugo.

> > Patch 3 fixes an issue when debugging IOcontrol register. After testing the GPIO
> > regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> > this patch is also necessary for having the correct IOcontrol register values.
> > 
> > Patch 4 introduces a delay after a reset operation to respect datasheet
> > timing recommandations.
> > 
> > Patch 5 fixes an issue with init of first port during probing. This commit
> > brings some questions and I appreciate if people from the serial subsystem could
> > comment on my proposed solution.
> > 
> > Patch 6 fixes a bug with the output value when first setting the GPIO direction.
> > 
> > Patch 7, 8 and 9 fix a GPIO regression by (re)allowing to choose GPIO function for
> > GPIO pins shared with modem status lines.
> > 
> > Patch 10 allows to read common rs485 device-tree flags and properties.
> > 
> > Patch 11 add a custom dump function as relying on regmal debugfs is not really
> > practical for this driver.
> > 
> > I have tested the changes on a custom board with two SC16IS752 DUART using a
> > Variscite IMX8MN NANO SOM.
> 
> Other comments are per individual emails.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
