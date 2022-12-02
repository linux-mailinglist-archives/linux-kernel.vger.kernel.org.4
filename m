Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDC9640196
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbiLBIJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiLBIJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:09:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBE70DF5;
        Fri,  2 Dec 2022 00:09:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2F08B81E5A;
        Fri,  2 Dec 2022 08:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8EFC433C1;
        Fri,  2 Dec 2022 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669968585;
        bh=8+gNM22UEiZvcMiIBcHcTs/pXIXI8H7d72J7cmSl0Ss=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJDdYI8NwoBqhCsnasmkykXxWx8nO6qZQG3935HThM4ivYW3+E6v0tbVkxyDsNC7+
         QhGiXKef/dVDme2c1W+XpbIetzQuY3NkoyEAIoHZVFtKiyZJjATtSSyQJK9VAGZZ/3
         GPmr2mYwlaVfSv5lp8uTHDYG3XGbgYzqt+tjJ2swXFUF3UjuNAKqVsUWPONoPIImxD
         lq1EWYDIODZsjojwGgKs+I5+X04gvFvALU6VmlxUwaaimoNadIkIwSlP1Gf/0cLK60
         iCOOpUslJ9gidbK1U6+ifTA94RxKtr0OWNNFemRqDSMvqiFNzhRa0eCyUMS81zEYa9
         T1wIQDz5MtVsw==
Date:   Fri, 2 Dec 2022 08:09:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Fix maintainer email for a few ROHM ICs
Message-ID: <Y4mywve76roQ6NtO@google.com>
References: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7986d30480df6179a3989fba4cd13817738635c5.1669877740.git.mazziesaccount@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Dec 2022, Matti Vaittinen wrote:

> The email backend used by ROHM keeps labeling patches as spam. This can
> result to missing the patches.
> 
> Switch my mail address from a company mail to a personal one.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> 
> I did this a while ago for my email addresses at the MAINTAINERS. Forgot
> the dt-bindings and doing the conversion for bindings now.
> ---
>  Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml   | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71815-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd71847-pmic.yaml    | 2 +-
>  Documentation/devicetree/bindings/mfd/rohm,bd9576-pmic.yaml     | 2 +-
>  .../devicetree/bindings/power/supply/rohm,bd99954.yaml          | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71815-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71828-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71837-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd71847-regulator.yaml   | 2 +-
>  .../devicetree/bindings/regulator/rohm,bd9576-regulator.yaml    | 2 +-
>  12 files changed, 12 insertions(+), 12 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
