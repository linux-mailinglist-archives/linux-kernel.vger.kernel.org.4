Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A44636BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 21:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbiKWUw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 15:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237729AbiKWUwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 15:52:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1358D485;
        Wed, 23 Nov 2022 12:51:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79CFDB81D08;
        Wed, 23 Nov 2022 20:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E893C433C1;
        Wed, 23 Nov 2022 20:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669236707;
        bh=99bgODPnO/xYYRlmRJ9g0umnQAfr7ZHkKZHekFyTuec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R1+mtZA50ml+7xLDHry0VO0Sz032R7VbOoyEq9/rQLBbxdD1N6ek/rRLhZIR5OFbQ
         3TYzPZmk6MKNyfOivQy2A+9wxFKcuMX026DslHk+kwK8M7MsHlxOnIDeJy7XByY0C/
         wt8nsn7oR7yjh+grLLgxZbRzG4zCvHODOSGW5TYAvTYjCs2NkLSEx94o8ZKwLhMIyA
         u+vmaIBTBIYBH3Ughii/OYGndNhIr4WstXPL3bF37wpU1Q85HydGcsJOlmFy7sneE8
         eVHCmWAjSRRj1LWs5Q+MramnBMppHj/WEfaxGMpXFFNtHT+fwiUsQQxMugZKQGRF3T
         C3jq8v2h8MVdA==
Date:   Wed, 23 Nov 2022 21:04:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: iio: adc: ad4130: use
 spi-peripheral-props.yaml
Message-ID: <20221123210419.1d4eed01@jic23-huawei>
In-Reply-To: <166863662057.1116418.9768601754353437839.robh@kernel.org>
References: <20221115151955.394030-1-cosmin.tanislav@analog.com>
        <166863662057.1116418.9768601754353437839.robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 16 Nov 2022 16:10:21 -0600
Rob Herring <robh@kernel.org> wrote:

> On Tue, 15 Nov 2022 17:19:55 +0200, Cosmin Tanislav wrote:
> > Reference the "spi-peripheral-props.yaml" schema to allow using
> > all SPI device properties.
> > 
> > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >   
> 
> Acked-by: Rob Herring <robh@kernel.org>


Applied
