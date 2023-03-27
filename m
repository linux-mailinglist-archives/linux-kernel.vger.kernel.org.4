Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEDD6C9F09
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 11:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232875AbjC0JLc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Mar 2023 05:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbjC0JLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 05:11:31 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC541CA;
        Mon, 27 Mar 2023 02:11:28 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pgisq-0003FS-Jd; Mon, 27 Mar 2023 11:11:20 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Jarrah <kernel@undef.tools>
Cc:     Robert Mader <robert.mader@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Peter Robinson <pbrobinson@gmail.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Ondrej Jirman <megi@xff.cz>, Martijn Braam <martijn@brixit.nl>,
        Kamil =?utf-8?B?VHJ6Y2nFhHNraQ==?= <ayufan@ayufan.eu>,
        Caleb Connolly <kc@postmarketos.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: dts: rk3399-pinephone-pro: Add internal display support
Date:   Mon, 27 Mar 2023 11:11:19 +0200
Message-ID: <8197476.T7Z3S40VBb@diego>
In-Reply-To: <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools>
References: <20230327074136.1459212-1-javierm@redhat.com>
 <e4f82c1e-621e-7e94-497d-8c579264f996@undef.tools>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 27. März 2023, 09:55:15 CEST schrieb Jarrah:
> Hi Javier,
> 
> On 3/27/23 18:41, Javier Martinez Canillas wrote:
> > From: Ondrej Jirman <megi@xff.cz>
> >
> > The phone's display is using a Hannstar LCD panel. Support it by adding a
> > panel DT node and all needed nodes (backlight, MIPI DSI, regulators, etc).
> >
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Co-developed-by: Martijn Braam <martijn@brixit.nl>
> > Co-developed-by: Kamil Trzciński <ayufan@ayufan.eu>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> >
> > Changes in v2:
> > - Drop touchscreen node because used the wrong compatible (Ondrej Jirman).
> 
> 
> Any reason not to include this with the correct compatible string? It's 
> been available since 
> https://lore.kernel.org/all/20220813043821.9981-1-kernel@undef.tools/. 
> Swapping out gt917s for gt1158 in the node from your previous patch 
> should be enough.

Just wondering if I'm blind, Javier's patch doesn't contain any touchscreen
controller (haven't found neither gt9* or gt11* mentioned there), so
I'm inclined to go with the "touchscreen can be added later" thing.


Heiko


