Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7EA651056
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiLSQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiLSQZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:25:50 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA1DC5;
        Mon, 19 Dec 2022 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DMgnjXuEz37SAQZwzhYvECTxcksb+stH/eD5YxCDg08=; b=jwExuptXdOIFXQ6Fl3g+htcwTO
        sFpyrI0Jah5mQt4ROJ+Ls2kdKqnNRDKvWO0BMv0xjQJjZBdUaTYzbZLc6T03J0Ll8c7cDW5oE7beV
        a1Fppy4cmneYSrlPKyWMqffOpTR5et+bCzs78Ko4hMlj7aFBTtarUnNsmsBkvniE6WkA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48606 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p7IxS-0001V0-Ic; Mon, 19 Dec 2022 11:25:42 -0500
Date:   Mon, 19 Dec 2022 11:25:42 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20221219112542.fb30929b8b91255dcba5a289@hugovil.com>
In-Reply-To: <CAH+2xPAWo=nycQMLrjye8i3a3textJdyYJcWRG3Jq-tbN0a9RA@mail.gmail.com>
References: <20221215150214.1109074-1-hugo@hugovil.com>
        <20221215150214.1109074-15-hugo@hugovil.com>
        <CAH+2xPAWo=nycQMLrjye8i3a3textJdyYJcWRG3Jq-tbN0a9RA@mail.gmail.com>
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
Subject: Re: [PATCH v3 14/14] dt-bindings: rtc: pcf2127: add PCF2131
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Dec 2022 10:14:10 +0100
Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> Den tor. 15. dec. 2022 kl. 16.19 skrev Hugo Villeneuve <hugo@hugovil.com>:
> >
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >
> > Add support for new NXP RTC PCF2131.
> >
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > index cde7b1675ead..a8f8c23da4d8 100644
> > --- a/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf2127.yaml
> > @@ -14,7 +14,9 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    const: nxp,pcf2127
> > +    enum:
> > +      - nxp,pcf2127
> > +      - nxp,pcf2131
> 
> The enum is incomplete as pcf2127_of_match struct also contains:
> nxp,pcf2129
> ncp,pca2129
> 
> /Bruno

Hi,
if I understand correctly, this means that the pca2129 and pcf2129 entries are already missing and should be added in a fix or a patch outside the scope of my new driver...

Hugo.


> >    reg:
> >      maxItems: 1
> > --
> > 2.30.2
> >
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
