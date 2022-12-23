Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF55165508F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiLWMoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiLWMoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:44:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639E31F4;
        Fri, 23 Dec 2022 04:44:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12610B82033;
        Fri, 23 Dec 2022 12:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1A7C433F0;
        Fri, 23 Dec 2022 12:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671799439;
        bh=TJUCtCPTDqjJVtQZLHwysV6hOBcEFfLQYbyBet6T7JA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVxxyFfiqUQtF6QsGFizjs+OnFurWJ1iyKz6rS9+Wbz9+Zx9M4FJoWAFDcyv5dpzV
         dnrhYqUGNqZPDclOR0jLFZ1JOOd70uiUfffrKF9kwPJoudX30a+asyJe+LpyBoTVel
         PWaqpVMeDKJcdbApQiNZXQ9l5w3is4+hqqIMxHxvxGqbOfKoilS/4mk6k9Uw/tE64P
         bU/f20vrCeJYQix4H7JnAEtncY4TDZlfe2BykrF8Ro1ELaXYh23gJysYthF1TeZ7/l
         52kQYSSLJD2LYPxP8RxJbC6tttxTZkjuyheUPVe3BMgLbCqAL4QcUzIq4b0/I9o14k
         xBPCIwvAyQSHg==
Date:   Fri, 23 Dec 2022 12:43:53 +0000
From:   Lee Jones <lee@kernel.org>
To:     Corentin LABBE <clabbe@baylibre.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: leds: common: add disk write/read
 and usb-host/usb-gadget
Message-ID: <Y6WiicVdyM/zfXvC@google.com>
References: <20221028064141.2171405-1-clabbe@baylibre.com>
 <Y5clqogvKUjk+KN9@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y5clqogvKUjk+KN9@Red>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022, Corentin LABBE wrote:

> Le Fri, Oct 28, 2022 at 06:41:40AM +0000, Corentin Labbe a écrit :
> > The triggers enum misses 3 cases used by gemini DT.
> > usb-host was added via commit 0cfbd328d60f ("usb: Add LED triggers for USB activity")
> > so we add also as valid trigger usb-gadget which was added along in this
> > commit.
> > 
> > disk-read/disk-write were added by commit d1ed7c558612 ("leds: Extends disk trigger for reads and writes")
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> 
> Hello Pavel Machek and Lee Jones
> 
> The two patch are reviewed, could you take them to your tree ?

I do not have access to these patches.  Please [RESEND] them.

-- 
Lee Jones [李琼斯]
