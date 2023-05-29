Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C547151DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 00:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjE2Wbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 18:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjE2Wbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 18:31:34 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A07CF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 15:31:31 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 8d9f3b95-fe70-11ed-b3cf-005056bd6ce9;
        Tue, 30 May 2023 01:31:29 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 30 May 2023 01:31:28 +0300
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
Message-ID: <ZHUnwNNcU_EnS4bo@surfacebook>
References: <20230529140711.896830-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529140711.896830-1-hugo@hugovil.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 29, 2023 at 10:07:02AM -0400, Hugo Villeneuve kirjoitti:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series mainly fixes a GPIO regression and improve RS485 flags and
> properties detection from DT.
> 
> It now also includes various small fixes and improvements that were previously
> sent as separate patches, but that made testing everything difficult.
> 
> Patch 1 fixes an issue when debugging IOcontrol register. After testing the GPIO
> regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> this patch is also necessary for having the correct IOcontrol register values.
> 
> Patch 2 introduces a delay after a reset operation to respect datasheet
> timing recommandations.

These two patches are w/o Fixes tag, they should be moved in the series further
as I explained before.

> Patch 3 fixes an issue with init of first port during probing.
> 
> Patch 4 fixes a bug with the output value when first setting the GPIO direction.
> 
> Patch 5 is a refactor of GPIO registration code.
> 
> Patches 6 and 7 fix a GPIO regression by (re)allowing to choose GPIO function
> for GPIO pins shared with modem status lines.
> 
> Patch 8 allows to read common rs485 device-tree flags and properties.
> 
> Patch 9 improves comments about chip variants.
> 
> I have tested the changes on a custom board with two SC16IS752 DUART using a
> Variscite IMX8MN NANO SOM.

-- 
With Best Regards,
Andy Shevchenko


