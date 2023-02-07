Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3861368DFAE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjBGSP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjBGSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:15:55 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36DB3C284
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:15:47 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id s10so2025704iln.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DIIm1+g/ieDfo2JsHwQzMqN/Ba3IscAwZj3f1TonJb0=;
        b=YzCZLNWtJxObUdTX43IEeAFhxBrw637FwOvoP4gEurknqZjz6o5VpokiV/MTyWNLbP
         qCNtBGl3Jozt8D7kQ/xCEybXV9BqImb43BlMUe61UGveju1/z0e0AxNPCRkO7KPE8IWC
         I1nLIMh1Owx5XBtLeo7dxRgAUjdcuOBXSUVZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIIm1+g/ieDfo2JsHwQzMqN/Ba3IscAwZj3f1TonJb0=;
        b=hNwWDLpuRq/g4JPCO1eKBf7yxgVs6vJlMjl8H9X+HoYBr9UTOhQliaJQWnUdgVYeaW
         kDUQaR6NhQBGvcwXcqC42n2mRvzDvWCSMMTYvXgeHRhuigSVa3BxvgJRPxfylIvZIFYe
         D8KLaroYIroRW5n04HmibDyO3MAup4DqGckzKU1HGKdNVlnqU8cGLZ4jFHaKVS2khvwg
         2NsIBTCA9PZGA4gbC7YMLABwTyDK4ihrmwhmgM3f7goK9bHp2tAOvpJxp+cbfDJs/I6+
         1vnkKfxZaj2DGcv/rCwy6Vb9my6SehCjjDiUytGj5RQhdM85QFxBd1s/pX9cvj84tghI
         PpiA==
X-Gm-Message-State: AO0yUKWHv/5ZSI0kx12LuHYMUe0tJltZeS9oXnxIKv1p6u9rGIh+W0Sp
        UUDxW+jkzc6cTjHjzRCnMf5LDCBMATCX9PCT
X-Google-Smtp-Source: AK7set+XchsPuKJ4lojMcTAhqn6IGV7VTuP7cvQpcmx2RAPuCQYg5u1XZjTeis8OAIqLVlb+52kw+g==
X-Received: by 2002:a05:6e02:12ed:b0:313:ea54:e22 with SMTP id l13-20020a056e0212ed00b00313ea540e22mr2066121iln.23.1675793746897;
        Tue, 07 Feb 2023 10:15:46 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id d70-20020a0285cc000000b003a69bd12c6dsm4534819jai.58.2023.02.07.10.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:15:46 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:15:46 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        devicetree@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] arm64: dts: qcom: sc7280: Add 3ms ramp to
 herobrine's pp3300_left_in_mlb
Message-ID: <Y+KVUgRecTSPvdUs@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.2.I13814cefc5ab3e0a39ebd09f052e3fd25d4e8f1d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206184744.2.I13814cefc5ab3e0a39ebd09f052e3fd25d4e8f1d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:11PM -0800, Douglas Anderson wrote:
> The "pp3300_left_in_mlb" rail on herobrine eventually connects up to
> "vreg_edp_3p3" on the qcard. On several herobrine designs this rail
> has been measured to need more than 1ms to turn on.
> 
> While technically a herobrine derivative (defined as anyone including
> the "herobrine.dtsi") could change the board to make the rail rise
> faster or slower, the fact that two boards (evoker and villager) both
> measured it as taking more than 1ms implies that it's probably going
> to be the norm. Thus, let's add a "regulator-enable-ramp-delay"
> straight into the herobrine.dtsi to handle this. If a particular
> derivative board needs a faster or slower one then they can override
> it, though that feels unlikely.
> 
> While we measured something a bit over 1ms, we'll choose 3ms to give
> us a tiny bit of margin. This isn't a rail that turns off and on all
> the time anyway and 3ms is nothing compared to the total amount of
> time to power on a panel.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
