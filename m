Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB565E62B6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIVMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiIVMqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:46:00 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2041CB2777
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:45:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b5so857250pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:from:to:cc:subject:date;
        bh=EUOZb2990E/2sm9nyDml2aFGYKW9boLOMIoTqqkufhU=;
        b=1Bcs1Ny8mbZraxYiQuvMnq/zbwtwWWnCOQVPvj/I/46jXmekqMhqko99SpjSu5QdiH
         qDtYVNR2ZNk39h53rapFnDcnYFZ76S5k9IjhP77Z/A926FXiga6R/i+yzuz/uwMq7U+q
         158wYH7FmsKqdZnAfPcR9wKuFTG1R3WTDSMv8CnX5s0cBDpMEQWONja1/aeaRxVMngbG
         5/PZTCoPStAAc2kI0cJ15KfyVhEZDDWAZbwSaCIgTFrIIprM9upFdYel/xF2bl4uHrfh
         CoQDh04eCu7eXYrD0k0Vr3Cwaeoklvq+lh92xk96wzyyldhrj3cNlmUt4hmtc86UUzin
         0PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:references
         :user-agent:from:x-gm-message-state:from:to:cc:subject:date;
        bh=EUOZb2990E/2sm9nyDml2aFGYKW9boLOMIoTqqkufhU=;
        b=S161NRHSSD2XroWkmPyhH/ILTdhajp4U8omvrQ5BJnbXgO529vUdz7Lxf87Jw4KPog
         PzgS+UBBUphk+0lWNk/hdWtkmJfO6I/zEOEzOE/OSf0gT0NtwGG3tZjg/VwBmNWOYbZB
         I7PLEFXCa2rcxPoTSoP4Iqy8nS0VQvwY8irmT98UsszF+4GutHxcT2mL5t5Ot9POxZsB
         eX2cyqjOFKx5XbZpy9uOyZKJIZw0GC44qtgNxMNKNX6bTF8N+nmtcz7enNxS2GoESzJ/
         oRYsUiWW77NBcbOVtZ7tQgas6boj/WNCOwz/WNSwVWny+wslEyHkawtYB1Or+nzYgobO
         cbtQ==
X-Gm-Message-State: ACrzQf2s7/2s1u4hy+Jo8zVbExv8HLMBQjY9HSUOCl3tmk5QV/dlYD01
        HHWTvlfFZovQNz6gy3Zl6k/zMqAOgEfjgvhdutBWYg==
X-Google-Smtp-Source: AMsMyM4O/N/zVs9zWHo8VZ8pdUXoohAewcmlUdHeafYOGuDWYY8oL47N7HPDeTurxd6fZSfsLroIY0k3HWCl8XmZlms=
X-Received: by 2002:a65:57c2:0:b0:438:ac40:1460 with SMTP id
 q2-20020a6557c2000000b00438ac401460mr2997875pgr.216.1663850745089; Thu, 22
 Sep 2022 05:45:45 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Sep 2022 05:45:44 -0700
From:   Guillaume Ranquet <granquet@baylibre.com>
User-Agent: meli 0.7.2
References: <20220919-v1-0-4844816c9808@baylibre.com> <20220919-v1-1-4844816c9808@baylibre.com>
 <d01e4a03-1d6d-9616-45ca-1c927f2d8237@linaro.org>
In-Reply-To: <d01e4a03-1d6d-9616-45ca-1c927f2d8237@linaro.org>
MIME-Version: 1.0
Date:   Thu, 22 Sep 2022 05:45:43 -0700
Message-ID: <CABnWg9uZ=FrumgUzyUoUiS6T51nZTEf5JZ-1KF0-Ra9Ood5ufA@mail.gmail.com>
Subject: Re: [PATCH v1 01/17] dt-bindings: clk: mediatek: Add MT8195 DPI clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sep 2022 09:11, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>On 19/09/2022 18:55, Guillaume Ranquet wrote:
>> From: Pablo Sun <pablo.sun@mediatek.com>
>>
>> Expand dt-bindings slot for VDOSYS1 of MT8195.
>> This clock is required by the DPI1 hardware
>> and is a downstream of the HDMI pixel clock.
>>
>> Signed-off-by: Pablo Sun <pablo.sun@mediatek.com>
>> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
>
>Looks like broken patch.
>
>Best regards,
>Krzysztof
>

Hi Bo-Chen and Krzysztof,
I've sent the patches using the rather new b4 prep/send commands.

Though it produces valid patches, it's using `git show --format=email`
to produce the patches, which lacks a diffstat.

My understanding is that the diffstat is considered to be comments and thus
are not necessary to produce a valid patch.

I've reported the issue on the tools mailing list [1], I'm looking at providing
a fix.

I'll be extra careful at the patch format for V2.

Sorry for the inconveniance,
Guillaume.

[1] https://lore.kernel.org/tools/CABnWg9uBOGqJMq=yCtn7SoEME=+2u1-ZK9ftb6=_jRhkhL_jiw@mail.gmail.com/T/#u
