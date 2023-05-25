Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD1710E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241643AbjEYOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241637AbjEYOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:34:52 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512D1101;
        Thu, 25 May 2023 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dmJE33FZIZmlTmfMzbCfmAi7/ICgaK239XoyyuZANyk=; b=i8QNqmiaxtOqyV5/L9vmwOcddQ
        X1sPVmGMnt3wycGCbVIGfpG1tmhycIU1UhX0wkxvqfbLiZrw69YmJbSiziMHZPsRkICvXc/xBkaXr
        ztqGgp3AsJODvGWs85O1yrYWHuIf3j8hWFmPSaibnX9iDmkz480ANeRbbHfu6QlX3smw=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49690 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q2C3A-0008KV-5y; Thu, 25 May 2023 10:34:44 -0400
Date:   Thu, 25 May 2023 10:34:43 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230525103443.d3d31e80221aed1ebceef30e@hugovil.com>
In-Reply-To: <ZG9CWhiTbLBKjPC9@surfacebook>
References: <20230525040324.3773741-1-hugo@hugovil.com>
        <20230525040324.3773741-8-hugo@hugovil.com>
        <ZG9CWhiTbLBKjPC9@surfacebook>
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
Subject: Re: [PATCH v3 07/11] dt-bindings: sc16is7xx: Add property to change
 GPIO function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 14:11:22 +0300
andy.shevchenko@gmail.com wrote:

> Thu, May 25, 2023 at 12:03:21AM -0400, Hugo Villeneuve kirjoitti:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Some variants in this series of uart controllers have GPIO pins that
> 
> UART

Hi,
fixed.

> > are shared between GPIO and modem control lines.
> > 
> > The pin mux mode (GPIO or modem control lines) can be set for each
> > ports (channels) supported by the variant.
> > 
> > This adds a property to the device tree to set the GPIO pin mux to
> > modem control lines on selected ports if needed.
> 
> I'm wondering if we can convert this to YAML first and then add a new property.

Hi,
I also thought about it, then decided to focus on simply adding the new property first since I am not an expert in YAML.

I think it would be best to do it after this patch series. Keep in mind that the original intent of this patch series, and this new property, was to fix a regression related to the GPIOs, and I think that converting to YAML would simply delay and add much noise to the discussion at this point.

If someone wants to do it as a separate patch after this, fine. If not, I an willing to give it a go.

Hugo.
