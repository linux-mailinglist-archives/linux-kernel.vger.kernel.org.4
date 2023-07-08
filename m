Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58AB74BD30
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 12:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGHKCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 06:02:15 -0400
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0571BB
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=XAkZ6X4l+X6cWosMXu6LD/f+EfKx2L/IOaqJiF43ZK8=;
        b=NSacb9lnGAUoKO1zq8ebBzmGagQUKthQZTsu0AFWKC3b30z7MSTYiMIghp0MXY0tzifesw1E7Uzfb
         kMqcW3hI9Pf7vXlE9bUaV08+ZjqaxO+mYtWCjQeEg2Dcf+h3jt/mYGBZ7E3nrAJJuRuzvRrqisFVeo
         r+6YL01rFpH/lsqGZY59NyjFkgdCIhvOhzMLuSoDYYiGtLKNB8Z9b0/PvAUoSehTnsMsDYs/BGnTn1
         x9SKnRom59VvWtG0Im3ck6RXa8fHdxDyes6OYJMFYDovsLNTDYBiS0d7q+yysaqBsn8xP1RGI27UTq
         7HCYnzp/gASugSkT2CJ34GmHzHqGhyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=XAkZ6X4l+X6cWosMXu6LD/f+EfKx2L/IOaqJiF43ZK8=;
        b=Dr1OI8BOGQz0I3Hc8Um998MHZ8KTcdhoW8kR02keYfqJU6Y5+yNuGHg2Wf4T+B5G6jlZgwqSGcaIA
         jfr+YdMCQ==
X-HalOne-ID: 5b568de5-1d76-11ee-8230-592bb1efe9dc
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id 5b568de5-1d76-11ee-8230-592bb1efe9dc;
        Sat, 08 Jul 2023 10:01:09 +0000 (UTC)
Date:   Sat, 8 Jul 2023 12:01:07 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 0/3] Galaxy S2 (i9100) panel updates v2
Message-ID: <20230708100107.GA443750@ravnborg.org>
References: <20230708084027.18352-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230708084027.18352-1-paul@crapouillou.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul.

On Sat, Jul 08, 2023 at 10:40:24AM +0200, Paul Cercueil wrote:
> Hi,
> 
> Follow-up on my patchset that fixes the display of the Samsung Galaxy S2
> when running PostmarketOS.
> 
> The first two patches update the LD9040 panel driver so that it looks
> much better, and supports setting the backlight.
> 
> The third patch fixes the size of the panel in the Device Tree. The
> previous values were completely bogus and caused Phosh (PmOS' UI) to
> display tiny icons and text as it thought the DPI was much lower.
> 
> Changes since V1:
> [1/3]: Remove spurious new line
> [2/3]: Remove .get_brightness() callback, use bl_get_data() and
>        backlight_get_brightness()
> 
> Cheers,
> -Paul
> 
> Paul Cercueil (3):
>   drm/panel: ld9040: Use better magic values
>   drm/panel: ld9040: Register a backlight device
>   ARM: dts: exynos/i9100: Fix LCD screen's physical size

The series looks good.

The first two patches are:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

The third patch are:
Acked-by: Sam Ravnborg <sam@ravnborg.org>

(I was not sure if I could/should stamp it r-b, so decided for the a-b).

	Sam

