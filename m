Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85304729042
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbjFIGmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238460AbjFIGm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:42:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E430326AD;
        Thu,  8 Jun 2023 23:42:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 69D7B653FA;
        Fri,  9 Jun 2023 06:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBBAC433D2;
        Fri,  9 Jun 2023 06:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686292946;
        bh=PVdB+AwZvwn4DeyD5vYz3PbPMHbTTz9cAa9Iw7rONfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjetvuk/Jkcpc4ncQR+rrGptvC9JRXSQ3daCh/I51hYTKaQB72EHS7ivOMpj1hOrq
         /jhb/0cLHy7HqS3Om8FA1dLAAyaMbrDbunxPASs8ShpAMd7e3tntdnGuP7NMW2yf8e
         Nty686vbJFc69vWRFIt+bNBe4vtcBzP6pc/1G7dnMk+hgukKgWKhK2s/P2y8IfzHJV
         eKLmmIHFJxYz532D94zL0u3vtfxzuU6EtaAckIEtwtZwFbzq8Y2lLrXrEUQ8Yt1SYr
         NRzs0VDttaIzOyYQ/3/5hi3233o9iLnW1yfGwBdnwz0MvscqmhjMqxExtVvNYP5X/y
         ErElvCRW7HH/g==
Date:   Fri, 9 Jun 2023 07:42:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, pavel@ucw.cz,
        sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCH v3 3/8] dt-bindings: leds: leds-mt6323: Support WLED
 output
Message-ID: <20230609064220.GF3635807@google.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
 <20230601110813.2373764-4-angelogioacchino.delregno@collabora.com>
 <75d78713-fc8f-24a9-a422-2b4d57c5d488@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75d78713-fc8f-24a9-a422-2b4d57c5d488@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2023, Krzysztof Kozlowski wrote:

> On 01/06/2023 13:08, AngeloGioacchino Del Regno wrote:
> > Some PMICs have a separated WLED string output: add a property
> > `mediatek,is-wled` to indicate which LED string is a WLED.
> > 
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  Documentation/devicetree/bindings/leds/leds-mt6323.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> > index 052dccb8f2ce..904b2222a5fe 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> > +++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
> > @@ -30,6 +30,7 @@ Optional properties for the LED child node:
> >  - label : See Documentation/devicetree/bindings/leds/common.txt
> >  - linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
> >  - default-state: See Documentation/devicetree/bindings/leds/common.txt
> > +- mediatek,is-wled: LED string is connected to WLED output
> 
> Why would it matter to what the output is connected to?

Skipping this one.  Please resolve and resend.

-- 
Lee Jones [李琼斯]
