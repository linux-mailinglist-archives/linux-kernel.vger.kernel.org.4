Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FED709E63
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjESRkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjESRkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E2F9;
        Fri, 19 May 2023 10:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 313F6617CA;
        Fri, 19 May 2023 17:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EDEC433D2;
        Fri, 19 May 2023 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684518020;
        bh=UDkPTriVgF63ln4ZyrbQRph9MfKBLUZJt2i1hBGxbgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Aqw8D6mpeQT4w0fcGePat4H8HZzBKIKWOeUIA8alAX2uA2qSAZBBelFH1hPRBkWB5
         zCW7JnxXImPHDm1iFUam6V5xw63zRqh9PdXExsNYp081ytq/Tt16x0WpfMUCNOteX6
         qBiUUORVTc5/nF6UChgQRNfB4VpikiTTxgof71VDpl6VjA3G0czOdDFRwvarH4XDND
         pQlyZ9tx184IAxdcTRxFt2ul+EkdzLzzf+bYtdqnSAAjuEFWZA9OBQNYtxCjAw9P6N
         D/Jgh9+OqviTJDwRB8ZudGMqBlFs6qx3Y0Pf4hWfzrXd6bpUg3KMCJ9IskzeXqQHQo
         q94fvn1FHRRcQ==
Date:   Fri, 19 May 2023 23:10:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stanley Chang <stanley_chang@realtek.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB
 2.0/3.0 PHY
Message-ID: <ZGe0f4OfaXzweSp3@matsya>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
 <20230519045825.28369-2-stanley_chang@realtek.com>
 <0d165c7efbb71a65803abddc364e1c5252b8b939.camel@crapouillou.net>
 <0ee8a26205a041cab9a787ec29201a9f@realtek.com>
 <f7edea0c-dbfe-4c16-8134-0656411a837d@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7edea0c-dbfe-4c16-8134-0656411a837d@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-23, 13:01, Arnd Bergmann wrote:
> On Fri, May 19, 2023, at 12:58, Stanley Chang[昌育德] wrote:
> >> 
> >> I'm pretty sure that drivers/usb/phy/ is deprecated now...
> >> 
> >> New drivers should be written for the generic PHY subsystem in
> >> drivers/phy/.
> 
> Indeed, I missed that in my review.
> 
> > Thanks for your reminder.
> > Will drivers/usb/phy be removed?
> > Is it not allowed to add new drivers?
> >
> > In our application, driver/phy is not suitable.
> > We need to notify the phy driver when the USB hub port status changes.
> > However, generic PHY drivers are designed for various device's PHY.
> > And it seems inappropriate to add this function. So we choose to use 
> > driver/usb/phy. 
> 
> If you run into something that works in the old usbphy layer
> but can't be done in drivers/phy, I think the better solution
> would be to change the drivers/phy/ code to add this.

The is correct, phy interfaces can be improved upon and have been added
upon as and when we have users.

FWIW there are already usb phy drivers in Generic phy susbystem, so you
need to really justify why you need a new interface?

-- 
~Vinod
