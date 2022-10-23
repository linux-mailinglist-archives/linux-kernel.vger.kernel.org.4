Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A31F609273
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 13:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJWLOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 07:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWLOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 07:14:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F6753A5;
        Sun, 23 Oct 2022 04:14:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 076CEB80BFE;
        Sun, 23 Oct 2022 11:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B898C433D6;
        Sun, 23 Oct 2022 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666523651;
        bh=DLMyfkLQCJ2cNhFzfchZELot8uBKjXe99jDV1JeqSV0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D73HcALIYD0/BJDZHJPw6p3DKY+V1dJXBB/1X78Ak48PO8eVONp+IuoqT0HwT671e
         OMzNIWrPBaclgyNun6EXd1xHyl+W2swXkUHynbfuXcsmwmfdO1QkSvwK8aan6psb4E
         6y2ngYlOUW7WgttGxY1TWaLXOTv59XQj0VGIT4/d7Va76fjRKcDK047Wh76EupDbFE
         U08N9umL3l3oRwP90G5TfBf/ubHGevXqJpp93fqT/1gx6tx6R9YSoQel7TnsUujx6Q
         uKxhkPJtM9R0r8wb7SoxZsyR0LOIihTTiBgZ/BPwsyBzEODkdtU747od8Ht9aP9a6a
         ZZCSYpEOqdYWA==
Date:   Sun, 23 Oct 2022 12:14:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mitja Spes <mitja@lxnav.com>, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: pressure: meas,ms5611: add max
 SPI frequency to the example
Message-ID: <20221023121445.204b4de8@jic23-huawei>
In-Reply-To: <b656b2c5-3f2e-a808-b86f-796dd03127b3@linaro.org>
References: <20221021135827.1444793-1-mitja@lxnav.com>
        <20221021135827.1444793-4-mitja@lxnav.com>
        <b656b2c5-3f2e-a808-b86f-796dd03127b3@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2022 10:08:42 -0400
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 21/10/2022 09:58, Mitja Spes wrote:
> > Added max SPI frequency setting to the example. It is now honored by the
> > driver.
> >   
> 
> This could be there regardless of driver support (because it does not
> matter)... anyway:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Having the max frequency specified is certainly a valid addition, so I've
applied this patch to the togreg branch (targetting next merge window).
The other two are fixes so will go in quicker.

Jonathan

> 
> Best regards,
> Krzysztof
> 

