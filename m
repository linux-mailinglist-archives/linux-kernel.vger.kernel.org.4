Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B076396AF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiKZOwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKZOwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:52:43 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B5E6476;
        Sat, 26 Nov 2022 06:52:39 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkxjnptf9d2bpn7gcmbty-3.rev.dnainternet.fi [IPv6:2001:14ba:44ce:b640:9d1d:82c5:eca2:5060])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id D1B8D1B00118;
        Sat, 26 Nov 2022 16:52:36 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1669474357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eam9jeoBQiN3SrHfi7a8ZxUvYPGxuG4vei6/xRQJZTk=;
        b=Egy/Snw4aLdAGA/cCwbZNNip7ODsR8iCctJ50MCaareaH3dPf1aSBXEF3bzAfc1BAXmVNF
        G1i0mtTfW7pLiiJO+hIUffnLWQy0h3mu6kUuxnno8iAodg/Wn/8H8Y1OzL900eAdMbFPHe
        FIrKDacfUZLEMGCSFuP8qkqkIE+EwlrTbHy4Fvq72UvLpvxDIwrNoCmT0pDIzmfS5ufQo7
        A/wbiQhz5Hh1oqq1Z7DKaIzaRQ0+9FE2Gy6BGjB0k5SVdCtpnlrV0yXxrTOfnti3nQaIrZ
        K1qG12NM1AFbRSRCMe5wZdhN7ickITOir4ncO6Xhrr0Ga5YBju89Alow78C1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1669474357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Eam9jeoBQiN3SrHfi7a8ZxUvYPGxuG4vei6/xRQJZTk=;
        b=Z7C92FfMLbI+WqUKeGrkVpDL9CWvjI5PdRFmE8I1rsCyd82FT8ARGbZycHOG4kYFHCEihp
        vG1DlBHa9yHbvhIXTif5CL7vmjjoGFrsm2s1HzoZKBN4z3H6kAf6OGAmulTgQ/lspcOXp0
        /vZJV7OYPMsyKkHuRYv1CMTk4WnJSibnJV2TXKgskd1+T8U4PV5x6XRrtf03ULsDBu/oLz
        5wYjCUaDHs55MzjsgHxMUJrIAyQOjvRUnZk+H5txoV87QpCyfx2AxGbZgvDqgXE/LXaMuR
        +d3GwjG6k9Mui3lS994/ioIn4OYdVfKfVE/Vb2hYmyqAJ/7ugH7OxTzV5dH94w==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1669474357; a=rsa-sha256;
        cv=none;
        b=rT58Ant0zIwQO/3RsO+vdoxkzSlWHolhtspR2FEqRFgpam7G3jZvYqawuy1o8TlMFepMrs
        b06XFwe+Nb/OYTZHQPNuziUTJAdXvgq3GGdFmQCMBxslS+4COhEq+pX90y9ZwQCE742rGq
        N5KDRjfHoDFJemRlkwgGhCxnlBEygWg7EF0z7okRAJMzdu6TPFvZ5/jYXvmYCP/tib2bIC
        C1ED5dEIyMBnMYrrcxClktu1/FBWOg1pdB3cxOafvIWiNRhWSi62KmQx48EY7gNKQINIIE
        RIAS7d7UoMlVeC5RWPmXEoudrKWFaP/r7ecXx22BWFZagBNV1uwCSAAw03Jlmg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 81A78634C92;
        Sat, 26 Nov 2022 16:52:36 +0200 (EET)
Date:   Sat, 26 Nov 2022 16:52:36 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     shravan kumar <shravanmicrochip@gmail.com>
Cc:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: imx334: modify link frequency in
 examples
Message-ID: <Y4IoNGaPNzQ+fa7A@valkosipuli.retiisi.eu>
References: <20221125050807.1857479-1-shravan.chippa@microchip.com>
 <20221125050807.1857479-2-shravan.chippa@microchip.com>
 <Y4DlZWqlVf6zYZTo@valkosipuli.retiisi.eu>
 <CAOPdzVa7Fb3Nwfs8ZzTLGJkJ6KMbqAs3KB6p-fu2jKVO0qNv4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOPdzVa7Fb3Nwfs8ZzTLGJkJ6KMbqAs3KB6p-fu2jKVO0qNv4w@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 04:21:57PM +0530, shravan kumar wrote:
> On Fri, Nov 25, 2022 at 9:27 PM Sakari Ailus <sakari.ailus@iki.fi> wrote:
> >
> > Hi Shravan,
> >
> > On Fri, Nov 25, 2022 at 10:38:02AM +0530, shravan kumar wrote:
> > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > >
> > > -imx334 sensor is configured to 1782Mbps/lane for 3840x2160@60.
> > > -But in device tree bindings exapmple we are passing 891Mbps/lane
> > > so modified to 1782Mbps
> > >
> > > Signed-off-by: Shravan Chippa <shravan.chippa@microchip.com>
> > > ---
> > >  Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> > > index f5055b9db693..ea3c93f97d65 100644
> > > --- a/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> > > +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx334.yaml
> > > @@ -82,7 +82,7 @@ examples:
> > >                  imx334: endpoint {
> > >                      remote-endpoint = <&cam>;
> > >                      data-lanes = <1 2 3 4>;
> > > -                    link-frequencies = /bits/ 64 <891000000>;
> > > +                    link-frequencies = /bits/ 64 <1782000000>;
> >
> > My understanding is that the original frequency is correct --- 594 MHz
> > pixel clock, 12 bpp, four lanes (and DDR).
> 
> As per my understanding, other than these three parameters there is
> one more link frequency (communication frequency from imx334 sensor to
> MIPI CSI2 controller).
> thanks,

Feel free to add additional frequencies later on. But this patch appears to
be just wrong.

-- 
Sakari Ailus
