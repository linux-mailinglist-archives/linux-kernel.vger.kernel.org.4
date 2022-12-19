Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03336515B3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiLSWwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLSWwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:52:14 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF18C12751;
        Mon, 19 Dec 2022 14:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JRg59L2B2o7LPqsIhNE5/qUBSTJMHitDdGjfKldqZ5A=; b=O79gbuU5PS3MJJeY5WDrkWzBUa
        aXu6o4Vzlg+qWylyN1751QwAjy2WHaE4OLIyxZ3zaX3Wt/A8KARKsD9FnfyWYs/NT+ZYPGImeEHVw
        cpybr10HJs0P2X7e8qZcqjlFUyYRMt3SQ0NwuKZY9W+OLdp3Xn9Kuqy+eMEsMyOy1h/U=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48622 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p7OzN-00065k-Qx; Mon, 19 Dec 2022 17:52:06 -0500
Date:   Mon, 19 Dec 2022 17:52:05 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        bruno.thomsen@gmail.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20221219175205.2989b6bf86941ec4774dab37@hugovil.com>
In-Reply-To: <20221219220335.GA2400372-robh@kernel.org>
References: <20221219194241.3817250-1-hugo@hugovil.com>
        <20221219220335.GA2400372-robh@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH] dt-bindings: rtc: pcf2127: add missing pcf/pca2129
 entries
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 16:03:35 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Dec 19, 2022 at 02:42:40PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > The pcf2127_of_match structure in drivers/rtc/rtc-pcf2127.c also
> > contains:
> >     nxp,pcf2129
> >     ncp,pca2129
> > 
> > Add these missing entries.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > index cde7b1675ead..00dbae7e23c2 100644
> > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > @@ -14,7 +14,10 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: nxp,pcf2127
> > +    enum:
> > +      - nxp,pcf2127
> > +      - nxp,pcf2129
> > +      - ncp,pca2129
> 
> Check Documentation/devicetree/bindings/rtc/trivial-rtc.yaml.
> 
> Maybe they aren't trivial after all and should be removed? Or 
> nxp,pcf2127 is also trivial?

Hi Rob,
the pcf2127, and also the pca/pcf2129, can use the "reset-source" property. Are they still considered "trivial" devices then?

Hugo.


> P.S. 'make dt_compatible_check' will check in the kernel for 
> undocumented (by a schema) compatibles.
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
