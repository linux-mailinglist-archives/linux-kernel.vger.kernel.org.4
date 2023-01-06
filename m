Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA46B6600F1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjAFNGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:06:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233371AbjAFNGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:06:00 -0500
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0985F46
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=gDg2C8wzCWaYAwH+05zvmIArdZV2pjBbAAKytWPoFLQ=;
        b=v1AUk9HWxQCQGwwUrqJr1Ns0WhZoUyTSko2yd+GsncJz68rxo+iuXP1S2ac1EVSME619PvUzwkc43
         wxpYoFm7mA0+S5auap/cT7i+X+20u9g2mFNAtrktK/Og5lLMZZ+yVA4tx2kHhZW1D2nf8Bdp0WGYWA
         4EtjFMwLgoP3qegn+cMkEBtQJ5C4/TRX2ZCg0ge3DwXJ7wq76kboKmoMjZzIop6/e0sQu6+neiT+gC
         tC/JKXF75ulNcNAVp57/yqTN4rNfkk+md7humRcxqpaxQX2tWTXl5111486m76TFUQefL7ye5C6TKw
         0IjtIHkMyVOxAX0ZIE6P9Zi30tY5n3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=gDg2C8wzCWaYAwH+05zvmIArdZV2pjBbAAKytWPoFLQ=;
        b=qlJdktE2ogNOGWFPtTpqNOqpY1orCMfAN31moczxtBwCYX+lx8uDvs646Yr7lUVAqCTicvdlJb2FM
         RzuRq07Dg==
X-HalOne-ID: b3eccd90-8dc2-11ed-a4d7-87783a957ad9
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id b3eccd90-8dc2-11ed-a4d7-87783a957ad9;
        Fri, 06 Jan 2023 13:04:52 +0000 (UTC)
Date:   Fri, 6 Jan 2023 14:04:51 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: display: panel: document the Visionox
 VTDR6130 AMOLED DSI Panel bindings
Message-ID: <Y7gcc1tjge3wHOf7@ravnborg.org>
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-0-9b746b858378@linaro.org>
 <20230103-topic-sm8550-upstream-vtdr6130-panel-v1-1-9b746b858378@linaro.org>
 <Y7RsnBkgnWbF3uMj@ravnborg.org>
 <877fc236-5f86-3853-0877-33df32689d8c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877fc236-5f86-3853-0877-33df32689d8c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

> > > +properties:
> > > +  compatible:
> > > +    const: visionox,vtdr6130
> > > +
> > > +  vddio-supply: true
> > > +  vci-supply: true
> > > +  vdd-supply: true
> > These 3 looks wrong to me, as the above are not documented in panel-common.
> > But maybe I miss something and this is OK?
> 
> It should be OK, the XXXX-supply properties are standard properties
Thanks for the explanation - patch is then:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
