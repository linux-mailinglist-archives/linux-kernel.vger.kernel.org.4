Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22C5B4D92
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbiIKKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiIKKnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:43:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B2124F25;
        Sun, 11 Sep 2022 03:43:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 338A160F5B;
        Sun, 11 Sep 2022 10:43:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12552C433C1;
        Sun, 11 Sep 2022 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662893000;
        bh=PjYKWdYjaPdBW/P/cLo/GJ4JnDdQ7f/WU/itetP6KcQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RGh2Ea8llpAPmmwT/lSY02a/Meez31o2dyCWGXMvc+OrWebnJIofDsMg0OCXlAwpp
         XKs/+IzsKrtbI5yAKslSuLlroi3rTqrezEijQyku1QnsFRiCixG72ja9AuCB4XJhex
         srm+l+jmd97y8ZKoydzhfTyiEgr6o4FX6U+ahEtYVhOBg35qcxq/Ypzpm+K/kixn2a
         nFIITf5i6Z4xVMpnrkqqYL0lSU+MTlUXSEbxjouZCw+4+5hRvHOVw4FmV8Lz+L/9bb
         8uWVXX6Oi3x1XGcf9vvOse5aIXmqQi+fkKsKLAUuhrslv3AgU2Eg4eiXahzEQbAP5m
         dXjpJ6sTMbFBw==
Date:   Sun, 11 Sep 2022 11:09:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Martyn Welch <martyn.welch@collabora.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>, kernel@collabora.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: st,st-sensors add LPS22DF.
Message-ID: <20220911110917.2d98548c@jic23-huawei>
In-Reply-To: <9593bff8-2738-8196-6e08-32551eabef58@linaro.org>
References: <20220909161611.780720-1-martyn.welch@collabora.co.uk>
        <9593bff8-2738-8196-6e08-32551eabef58@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2022 18:22:40 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 09/09/2022 18:16, Martyn Welch wrote:
> > Add support for the ST LPS22DF, an I2C/SPI pressure sensor.
> > 
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> > ---
> >  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 2 ++  
> 
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Series looks good to me.  It won't make my first pull request for this
cycle (as I've already tagged that - though not sent pull as travelling
to Dublin) so there will be time for other feedback before I push this out
as togreg.

Once I have a stable connection. Will push this out as testing for 0-day
to see if we missed anything.

Thanks,

Jonathan

> 
> 
> Best regards,
> Krzysztof

