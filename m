Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9865F8C3F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJIQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJIQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:16:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B285D2B265;
        Sun,  9 Oct 2022 09:15:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45661B80D6F;
        Sun,  9 Oct 2022 16:15:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D6F9C433C1;
        Sun,  9 Oct 2022 16:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665332146;
        bh=4cm2c0fOvu9nkij3uX1+ze9n1lMXyfLq2WBLGR1H5wo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EcJLppsNNuahtyuUcfoXT+8pjXqwSxL/2UEBG+kfkXIEv0S6/CphyUb5XUmPvA7DX
         PpLNJoBzaRlyAJ73xUnsC7b3WTKIiSNJkBwLyl3d/tQb/5sqVVqPJ93ScoHEbTpvVw
         opgdc6R7zX79avXxV5t0OIY5+UgZI5TA36WGvVN5PrfW19cgzU0dJoNcZzDbXkVKXx
         OaWaQUlXr/I9bM1TygJqg3TiHuHwsOS/R2rgYAPsBv+lGmNRRFW/n2/vC4S7Zk9ESC
         9ifG1cSJ1OKWmjHPFGmG//Hg0/4VjwDM+2jtjvuEVa//6FUwEZnNpCwjT8zFfrBzLX
         mfoVnbCInvnQg==
Date:   Sun, 9 Oct 2022 17:16:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, linux-kernel@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: iio: addac: adi,ad74413r: use
 spi-peripheral-props.yaml
Message-ID: <20221009171605.12017856@jic23-huawei>
In-Reply-To: <166497632690.3268685.6335632613671776795.robh@kernel.org>
References: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
        <166497632690.3268685.6335632613671776795.robh@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022 08:25:27 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, 04 Oct 2022 13:56:35 +0200, Krzysztof Kozlowski wrote:
> > Reference the spi-peripheral-props.yaml schema to allow using all
> > properties typical for SPI-connected devices, even these which device
> > bindings author did not tried yet.
> > 
> > While changing additionalProperties->unevaluatedProperties, put it in
> > typical place, just before example DTS.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/iio/addac/adi,ad74413r.yaml        | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>

Series applied,.

Kryzsztof, thanks for your continuing work to clean this stuff up.
One small request for future similar series. Please add a cover
letter with a very minimal intro. If nothing else it gives me an
obviously place to reply to in order to say I applied them all!

Also works for anyone who wants to give series wide tags.

Thanks,

Jonathan
