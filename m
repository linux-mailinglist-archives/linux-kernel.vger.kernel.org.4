Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79325710A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 12:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbjEYK2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 06:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235904AbjEYK17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 06:27:59 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6626F183
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 03:27:57 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id ce3a9d81-fae6-11ed-a9de-005056bdf889;
        Thu, 25 May 2023 13:27:53 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 25 May 2023 13:27:52 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 00/11] serial: sc16is7xx: fix GPIO regression and
 rs485 improvements
Message-ID: <ZG84KCeMIINFVTMh@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040324.3773741-1-hugo@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, May 25, 2023 at 12:03:13AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series mainly fixes a GPIO regression and improve RS485 flags and properties
> detection from DT.
> 
> It now also includes various small fixes and improvements that were previously
> sent as separate patches, but that made testing everything difficult.

> Patches 1 and 2 are simple comments fix/improvements.

Usually we put fixes at the beginning of the series, but these patches are
missing Fixed tag. Are they really fixes or can be simply moved to the end of
the series?

> Patch 3 fixes an issue when debugging IOcontrol register. After testing the GPIO
> regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> this patch is also necessary for having the correct IOcontrol register values.
> 
> Patch 4 introduces a delay after a reset operation to respect datasheet
> timing recommandations.
> 
> Patch 5 fixes an issue with init of first port during probing. This commit
> brings some questions and I appreciate if people from the serial subsystem could
> comment on my proposed solution.
> 
> Patch 6 fixes a bug with the output value when first setting the GPIO direction.
> 
> Patch 7, 8 and 9 fix a GPIO regression by (re)allowing to choose GPIO function for
> GPIO pins shared with modem status lines.
> 
> Patch 10 allows to read common rs485 device-tree flags and properties.
> 
> Patch 11 add a custom dump function as relying on regmal debugfs is not really
> practical for this driver.
> 
> I have tested the changes on a custom board with two SC16IS752 DUART using a
> Variscite IMX8MN NANO SOM.

Other comments are per individual emails.

-- 
With Best Regards,
Andy Shevchenko


