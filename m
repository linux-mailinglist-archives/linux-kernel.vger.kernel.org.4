Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9D06168DD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKBQaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiKBQ35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:29:57 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A813F45;
        Wed,  2 Nov 2022 09:26:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id d3so25780240ljl.1;
        Wed, 02 Nov 2022 09:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i9lzFBitnyAp6ipWpwtICbzA7hqqgUYQcinpTzvMvYI=;
        b=pE3B01zFCVw+bIUAPWnhHJVI4HcUniogBqFng7orjWDucp24hEY7aCrqjDuO6GV6hM
         YSu5meS5CRBEILfG0g6tdvKOR9x44wyXJAXK/wQ0VHKqUkLclJeEZX8tEklUhNyRClvC
         tkaWHlt2A5zuihz51DFhN6Jwlrtrkglb8YvMFNw9Q2LyLwSUpkLRmkO9Yd4vIFLeercb
         pHdVDYN32QXUIfuydzeuJ2zCpen7H8ise2cmH1/CEXU3af7Bky29LQAha/r4RpKRXz3C
         TL/nArGGa58sBE/P2nuzY7qUCjG/V+HRkVZZyoIXbguWohQuZnynAiIQ6cwVMrsjaUf1
         V7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9lzFBitnyAp6ipWpwtICbzA7hqqgUYQcinpTzvMvYI=;
        b=2cXJJIJJAPwg7xtSu8LtuiKB7bzHq6uXX9oS00+SbWOwu1I/tSWPAeWqGMrEiTujBE
         WtLHLPdiMNYoqOk36PLa1aQ5wZwvIFuS7WUDHynjUguuIgSjF/RNJVRsCKmWAKRGnR7F
         jGDf5UIL7e7sRkgM/Ba6gENp1wfSqiaoFSI504OEEVkiDV2oZpiI5dtQOpc6NONPDM9J
         iLysI2//tSxdl5KJi4U6r7oLaocsYoBK2qtZx/lArgNee31jJXdxWOE7LSkD7s0gTLbK
         r5/TZ5Vn4/IvtaPVM8D2B3HoMEp/ZPIgBqJQLUZZQWrY4TZ3tFYjoVUwp8oAnKwoptdK
         Owuw==
X-Gm-Message-State: ACrzQf1wPOMlGV4UNIy/6Ofpma0z7IIZbG2t/SvKCvTNyRi7259RchHa
        q8HKywrwcCPwGbMCJZ7BxMbEv5bIRBc77bcG8y8=
X-Google-Smtp-Source: AMsMyM6IbNesFItHd+WCfCAtu+r/QS5DLwm2t+DZtQmi2xg5qQZv8LtFV2vCfxx4R8Q8SmpZvAFp2FCTROx9tNrxDFk=
X-Received: by 2002:a05:651c:33c:b0:277:e2b:de4a with SMTP id
 b28-20020a05651c033c00b002770e2bde4amr9519495ljp.55.1667406362096; Wed, 02
 Nov 2022 09:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221102141513.49289-1-fnkl.kernel@gmail.com> <20221102141513.49289-3-fnkl.kernel@gmail.com>
 <OS0PR01MB59227A9E7B8A471E4D6B665786399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMT+MTT1ptFymwDdOe=OXYzKfOPHdQbAfpx_9LBYn+C9NFhddg@mail.gmail.com> <OS0PR01MB592217539BCA46FD8F523C2386399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592217539BCA46FD8F523C2386399@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Sasha Finkelstein <fnkl.kernel@gmail.com>
Date:   Wed, 2 Nov 2022 19:25:50 +0300
Message-ID: <CAMT+MTQLJZsDSOtcQqV8e_j0XKfjNm+dVjeo7ocMjcYOPLAPvA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] pwm: Add Apple PWM controller
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "sven@svenpeter.dev" <sven@svenpeter.dev>,
        "alyssa@rosenzweig.io" <alyssa@rosenzweig.io>,
        "asahi@lists.linux.dev" <asahi@lists.linux.dev>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 at 19:02, Biju Das <biju.das.jz@bp.renesas.com> wrote:

> I just asked, because you are unnecessarily turning on the clock or increasing the usage
> Count, even if it is not used by anyone during probe.

It is used to get the clock rate so it can be used to convert between
seconds and pwm ticks, and the pwm uses that clock, so it is kept
enabled while the pwm is active.
