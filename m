Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E2714C06
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjE2O03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjE2O0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:26:24 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45A2BE;
        Mon, 29 May 2023 07:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cx7ozsq4Ym7aNtqiQ+eL6o15aawxdE3rmyy6EdLqFFo=; b=iMTbp89jqd9wOwIM/GUMsMrfEK
        hz5MEXwocmqCGZwaX/PcpIgaefZvEl3A8HeokychVml8Ym32V1OZQCRbiEEI2kFQO5muZ50nGz1YY
        xx7mVyXo/QsM5d9KUi+e5vTKGN7yQ27Y4ITHvwJJCB14OCiYlBg92dcRJoLDjnjNiG2I=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:42490 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q3dow-0004VK-JV; Mon, 29 May 2023 10:26:04 -0400
Date:   Mon, 29 May 2023 10:26:01 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <jirislaby@kernel.org>, <jringle@gridpoint.com>,
        <l.perczak@camlintechnologies.com>, <tomasz.mon@camlingroup.com>,
        <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>, hugo@hugovil.com
Message-Id: <20230529102601.144e17eccefaedc891e76f3a@hugovil.com>
In-Reply-To: <20230529-seventy-stash-0446d9ae02e8@wendy>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <20230529140711.896830-7-hugo@hugovil.com>
        <20230529-seventy-stash-0446d9ae02e8@wendy>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH v4 6/9] dt-bindings: sc16is7xx: Add property to change
 GPIO function
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 15:16:47 +0100
Conor Dooley <conor.dooley@microchip.com> wrote:

> Hey Hugo,
> 
> On Mon, May 29, 2023 at 10:07:08AM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Some variants in this series of UART controllers have GPIO pins that
> > are shared between GPIO and modem control lines.
> > 
> > The pin mux mode (GPIO or modem control lines) can be set for each
> > ports (channels) supported by the variant.
> > 
> > This adds a property to the device tree to set the GPIO pin mux to
> > modem control lines on selected ports if needed.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Did I not ack this in v2? I didn't notice a reason for dropping it
> in the cover etc. Was it intentionally dropped, or missed?
> 
> Cheers,
> Conor.

Hi Conor,
In v3, I slighly modified the example, and that is why I didn't copy your ack.

Hugo.
