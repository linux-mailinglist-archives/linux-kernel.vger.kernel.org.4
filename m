Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD30C6DE501
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 21:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDKTa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 15:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjDKTa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 15:30:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C083E59;
        Tue, 11 Apr 2023 12:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=99rjBHAIuUBD5vgFLT/ds3Qs4IN8NAW8z3ETOIFESko=; b=XlY4ASrl87TphUHDf/QYvzDnMz
        DcTw2SzToXLCSz7BrHdDOUQnFCgIkjeI2nh4B1ehkaLG2x047HXC/CPV7/9+F/4KDOfqcO4g7gbaR
        mP+KkpTDBMC7tZTLmGU5B6mSBTs8j2SK06KBIe/I9IKEtKIdU3VP9niOCK0aJ/pp22q8Ydc+36RE3
        J5IqkHDHXILk9ZDNr0ZY2XkeKjtFP2BOZkuzQRRJYyEammvpkAtgfoM+Vh4TPeSI/O9t8EjwvJ361
        +UU8zSXelf5mBX1f8baEbOjTcPzch5+GO8CdA71k9kkQu9tGGWlUosFF8l5qyPxGX9jBv3WgLUziZ
        pBm3nyRw==;
Received: from p200300ccff1a24001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1a:2400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pmJhX-0007eE-0B; Tue, 11 Apr 2023 21:30:47 +0200
Date:   Tue, 11 Apr 2023 21:30:44 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: ROHM BD2606MVV LED driver
Message-ID: <20230411213044.4bf6dc89@aktux>
In-Reply-To: <a16a8071-3c67-0f40-d7da-3459f7dc584d@linaro.org>
References: <20230407050803.170773-1-andreas@kemnade.info>
        <20230407050803.170773-2-andreas@kemnade.info>
        <a16a8071-3c67-0f40-d7da-3459f7dc584d@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 17:34:00 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

[...]
> > +        led-controller@66 {
> > +            compatible = "rohm,bd2606mvv";
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            reg = <0x66>;  
> 
> reg is always second property in DTS.
> 
> > +
> > +            led@0 {
> > +                color = <LED_COLOR_ID_RED>;
> > +                function = LED_FUNCTION_POWER;
> > +                reg = <0x0>;  
> 
> Ditto
> 
hmm, reg also second if no compatible first? I see it usually first in
such cases.

Regards,
Andreas
