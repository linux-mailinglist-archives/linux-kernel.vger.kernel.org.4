Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 429EF68E2BF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBGVUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjBGVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:19:58 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD0817175;
        Tue,  7 Feb 2023 13:19:57 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id 70-20020a9d084c000000b0068bccf754f1so4650008oty.7;
        Tue, 07 Feb 2023 13:19:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z47pTYQ+/5OctvC8ddoYwu8QG4IsEwXm/DVEAF/PVtM=;
        b=SoyK9tJb5xYN3u/LN3HwBLhozTCRChlbn5319JwIwTUi55OTl0NIyBESxnHHWUfzDy
         QPd1fKY6PqK1wVSSo8pWsrEB/OoZqgEF2fc8iCZJfxDLNaY4BNVJqNvclXO2A2WE9QAI
         i0ECL8gX11a++cqDEWcegiz0LOESfj6ueWnK/SaUZFSwKWm03KfLmkhQCLrUvmXplKTT
         VFE3zBb/vTzxzrcHMZEUdlzSGYX1NXRZOksINSN40sjSvdNSO97gxIKLGimEnqcSv/Bt
         +dJyaLqL8wXg3qvXc+jNCxkmc7arTNR0WPml8/zQbZBuQkmOk/InS4o46dmOYAQgRaDw
         hFuw==
X-Gm-Message-State: AO0yUKWr84srnArgXSiDpQb7Z2aZaEEouuElxY8DY8glx5C6v/aNL3He
        zDpGm+ooMq/PCa4FM4au9in+qENHNw==
X-Google-Smtp-Source: AK7set/diBRHF4lI5GQLqN0GdFX+iy7l2cjOo76iYc6ZAnC18tkVaZyWtWStK7hjiJcpjbgQkX/zug==
X-Received: by 2002:a9d:177:0:b0:68d:a785:5f5f with SMTP id 110-20020a9d0177000000b0068da7855f5fmr2872911otu.2.1675804796999;
        Tue, 07 Feb 2023 13:19:56 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a24-20020a9d4718000000b0068d3f341dd9sm7019996otf.62.2023.02.07.13.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:19:56 -0800 (PST)
Received: (nullmailer pid 4171931 invoked by uid 1000);
        Tue, 07 Feb 2023 21:19:55 -0000
Date:   Tue, 7 Feb 2023 15:19:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 5/7] dt-bindings: HID: i2c-hid: goodix: Add
 mainboard-vddio-supply
Message-ID: <167580479546.4171868.14123127361187653098.robh@kernel.org>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.5.Ia77a96c6c5564f9cc25e6220b5a9171d5c2639e8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206184744.5.Ia77a96c6c5564f9cc25e6220b5a9171d5c2639e8@changeid>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 06 Feb 2023 18:48:14 -0800, Douglas Anderson wrote:
> The goodix i2c-hid bindings currently support two models of
> touchscreen: GT7375P and GT7986U. The datasheets of both touchscreens
> show the following things:
> * The mainboard that the touchscreen is connected to is only expected
>   to supply one voltage to the touchscreen: 3.3V.
> * The touchscreen, depending on stuffing options, can accept IO to the
>   touchscreen as either 3.3V or 1.8V. Presumably this means that the
>   touchscreen has its own way internally to make or deal with 1.8V
>   signals when it's configured for 1.8V IO.
> 
> NOTE: you've got to look very carefully at the datasheet for the
> touchscreen to see that the above bullets are true. Specifically, the
> datasheet shows a signal called VDDIO and one might think that this is
> where a mainboard would provide VDDIO to the touchscreen. Upon closer
> inspection, however, a footnote can be found that says "When VDDIO is
> left floating, the logic level is 1.8V [...]; when VDDIO is connected
> to AVDD, the logic level is AVDD.". Thus the VDDIO pin on the
> touchscreen IC is actually a selector and not a pin whre the mainboard
> would pass a reference voltage.
> 
> The fact that the touchscreen isn't supplied 1.8V by the mainboard
> means that when I originally submitted bindings for these touchscreens
> I only listed the 3.3V rail in the bindings. It can be noted that the
> original bindings and driver were added for sc7180-trogdor boards and
> these boards all use 3.3V IO via a level shifter on the mainboard.
> 
> It turns out that with sc7280-herobrine-evoker, we've got a bit of a
> strange monkey on our hands. Due to some very interesting but
> (unfortunately) set-in-stone hardware design, we are doing 1.8V IO to
> the touchscreen but we _also_ have some extra buffers on the mainboard
> that need to be powered up to make the IO lines work. After much
> pondering about this, it seems like the best way to handle this is to
> add an optional "mainboard-vddio" rail to the bindings that is used to
> power up the buffers. Specifically, the fact that the touchscreen
> datasheet documents that its IOs can be at a different voltage level
> than its main power rail means that there truly are two voltage rails
> associated with the touchscreen, even if we don't actually provide the
> IO rail to it. Thus it doesn't feel absurd for the DT node on the host
> to have a 1.8V rail to power up anything related to its 1.8V logic.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/input/goodix,gt7375p.yaml          | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

