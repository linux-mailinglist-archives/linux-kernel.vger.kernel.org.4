Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2555674BC2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjATFHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjATFHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:07:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389FC11670;
        Thu, 19 Jan 2023 20:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AB73B824EA;
        Thu, 19 Jan 2023 14:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9054C433F0;
        Thu, 19 Jan 2023 14:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674139613;
        bh=8PPB8scc3olT1ongmk7iJw77gF+ApH656+MNhvKjje4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FRdWdR1j6paKQ33JtH5J3ycMsqP5L9H9Q//PSj5vFI/jlS/CML9TiRzo7P1p+lV6N
         1sqm6E8VJfCFRsSXksPU+f3Sl1MUhfH91Xgf+sSQhPxFdN0HU6xmBnA7TlItJvh+sK
         D3+xfcwfoW6tAr2wJhx8WVwc7fr00ZiRIBQIuXo9G0GV1NRXslbCqNCJSIpQ7eYT+c
         v2/BgmohVALK2d3vWdV5fPrfzGItu2+wbo31uRPw2ju2/gaS1nhNqPjsDZbeB3h8Cj
         WOp3t03u93qWkZZa795XJSW4gF+Bc6mjpFc0BmLWqaXciZpDsLrmthXjBM388lfD0K
         yNL5gloXflq9g==
Date:   Thu, 19 Jan 2023 14:46:46 +0000
From:   Lee Jones <lee@kernel.org>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: leds: add worldsemi,ws2812b
Message-ID: <Y8lX1sls3p2KyInE@google.com>
References: <20221212045558.69602-3-gch981213@gmail.com>
 <c592dd31-5e9a-c2a2-1c70-46b7cffa9c5d@linaro.org>
 <Y6XjHNCLXY9s1IOF@duo.ucw.cz>
 <9d2c05f6-af5a-2d79-02ea-85c49e244957@linaro.org>
 <Y7xGUiWBKIAm9YFA@google.com>
 <1905de3e-438e-b729-7c1c-b154998c5eb6@linaro.org>
 <Y708DfB41c/ZivRw@google.com>
 <CAJsYDVJC15cePQ65BR=dxKY8ADoRepbiiFqXTNQzh_6RTAeMYA@mail.gmail.com>
 <Y8FxM/qW3IL2y4YY@google.com>
 <CAJsYDVK2Q22me0LtvuHk5WJ6n18jfFBBNVeis2k4KbwEMoDiEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJsYDVK2Q22me0LtvuHk5WJ6n18jfFBBNVeis2k4KbwEMoDiEw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023, Chuanhong Guo wrote:

> Hi!
> 
> On Fri, Jan 13, 2023 at 10:57 PM Lee Jones <lee@kernel.org> wrote:
> > [...]
> > So the description is for 'this device' rather than any re-use.
> >
> > And the handling of this property is only contained in your driver?
> >
> > In which case, my understanding is that you should use a prefix.
> 
> (Just out of curiosity. I don't want this property now.)
> 
> My understanding is that a vendor prefix means this property
> is for devices by this vendor. However color-index is for supporting
> clones, which are chips not made by this vendor. Does a vendor
> prefix really apply in this case?

No idea.  Sounds like a grey area.

-- 
Lee Jones [李琼斯]
