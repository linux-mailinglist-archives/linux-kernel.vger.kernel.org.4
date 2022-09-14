Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5235B88BA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiINM6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiINM6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:58:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EC957550
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:58:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id y3so34567260ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=I2ClKCNA8nGw26qPRTutewiZz4gnHlgIxTVYr8EB/C0=;
        b=toGFeiHDO8nOmyDJ1wpO0V7ZxZRs6uSdjlH//F9V9YMX7UxpvoX96BgI0QLrU0uz7u
         DSGgi3SwyD68LMh+N8EoWlMgJE/2xe0ravvzCfVuhRcA56J/4GnbV6Qo/pfQF5N0QWEq
         xNXq6LPxKznKPR93qvZ4ygosriyMbUEPq/N8Qukd7DZVJWFrCEJoueK6KFkAkNu05my0
         Z2kziPW3dVHZwEU+FusOHHL6ueoqSdi1sf0A2nU3fIO9fdpoiX0Wnk1ntMDbeTARS1jT
         Oz6mZMJmoFT6WhG2o0IzclRVbmSXCb3QRuwk+MIQtx6Sx9h3CEuHvUqNcHQ4NQCqJtoR
         6SCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=I2ClKCNA8nGw26qPRTutewiZz4gnHlgIxTVYr8EB/C0=;
        b=wIRZQHKtZbi5MCFV3Com7RCrcc9gDJKWxaSx355vyJb4p/0ctSDF+ZyxbRmc+ULwC/
         0J4EitZqma4WsRl5nayx8dsKAZJoBM1zR6zM0hvf9cQv/Rfj3vwfYLceyRRah+SEkLeE
         /boRdNIQoD3MFL7gKEwnw1HWH+nkHJtHHQU1IgXdAmRsjlZv4TQQKsmRy/wS6/ml8czQ
         DJCKVELoKXK6AQ/wUCTJV+/p9RQgjPWkw6QCMu+DnKZ86y/nftdNt0EbdwQWyN55HNZC
         CbHIAXVVNf8GKr21/LMdBO4nBwr8wsUnEvUmSoY7aEjk3Idqcfx+Xo818UpAMIV3LH0Y
         Brsg==
X-Gm-Message-State: ACgBeo2FLkWQ9GqQDy+V9vr+VhjEbhxyPDeaEp/6mQw3L4e8c4mgdpuK
        sMZVwuauARBxe8dpb1ocF44slsZifaukMq0Iyti2hg==
X-Google-Smtp-Source: AA6agR4YH/5boV9AGgO4NnyoVhAFZR0/ol+MHAeJc+Q4I3I9dqqwYbVPCQRWIK+Y1MtGnJw4qmEqHqHoa+kp1CDq9DY=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr25658550ejc.440.1663160279893; Wed, 14
 Sep 2022 05:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220913164104.203957-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20220913164104.203957-1-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 14:57:48 +0200
Message-ID: <CACRpkdaY7NuCY7_847uKFP3_L1ny-PsOeWrh4J==enc8ecpzyA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: exynos: correct s5k6a3 reset polarity on
 Midas family
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 6:41 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> According to s5k6a3 driver code, the reset line for the chip appears to
> be active low. This also matches the typical polarity of reset lines in
> general. Let's fix it up as having correct polarity in DTS is important
> when the driver will be switched over to gpiod API.
>
> Fixes: b4fec64758ab ("ARM: dts: Add camera device nodes for Exynos4412 TRATS2 board")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Excellent catch!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
