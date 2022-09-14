Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B245B8A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiINO2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiINO2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:28:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C664660F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:28:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc7so35228770ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7FXZIB5r2QHuGv36+dxkQHgOBeT7MiFKwzm4Bz7OlsM=;
        b=gci4cmI8iUvjj6uqnkssrpEgSrL2tuueBA9uAmsi2VlkOSjxh4M7LjM02rs1zZnl3g
         ZElH6j/IoUnh4hSRSUvaqQxcHJgtRbzMI7UDpZJ9xy0dhguyggn95JsArmL/GPl1h4VA
         Jffzk0tCq4EaGThCrSjvL6fZsR1GV/YEKoJbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7FXZIB5r2QHuGv36+dxkQHgOBeT7MiFKwzm4Bz7OlsM=;
        b=ooyhSAr7zegkB0EU59dhKOIFk6FdBy/8w7C0wXZngSC8F2xWcj0tMe8KdhchqUy8vX
         bYj8Cwt8uN9UhxbE4s0tN2u1XjrgEDZx8WLTbSIkGKm6jQVZcob8VWp6eFrh/4Gwp/fN
         nzONpoyI1ywrpxicXUgVzDXk3GY4UBMZxRWyXB4tsjVPSdjqvjYkV6G8+rJByQ27whjz
         GjwG9C21FZr6USzmlv4g8MxwWiplhY4R1hlbHXEks1h19PPVKwev1oOJLuKJGFudNF/A
         ZACRKP9rd5Fwe5xPwo+NuEQiB6/Qjo4DpqCB1e3NdF7n7JkeQDMfSGbIGs3DA3aDApeC
         +zqw==
X-Gm-Message-State: ACgBeo2s8sGe9Q5AVO+r8YmvrbzslbokUhmKLUQLYzGjbYoq4ItLUyLI
        ZItlzM0WJe+8LVW8MDMT/Rx4AGVB6dZvsc5RFpR5Iw==
X-Google-Smtp-Source: AA6agR4IMX4D2vN/g8nezL/LZ5bc5r/c5LjAfvrvD3/AJ05vt1JS6e3muRvPfwHTOSV9LnFbI4XTU0do5zNGU9mlNL0=
X-Received: by 2002:a17:906:9b8a:b0:77d:8add:3074 with SMTP id
 dd10-20020a1709069b8a00b0077d8add3074mr10470334ejc.251.1663165714173; Wed, 14
 Sep 2022 07:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220721083849.1571744-1-judyhsiao@chromium.org>
In-Reply-To: <20220721083849.1571744-1-judyhsiao@chromium.org>
From:   Judy Hsiao <judyhsiao@chromium.org>
Date:   Wed, 14 Sep 2022 22:28:20 +0800
Message-ID: <CAJXt+b_2XR6GEaAysYe=P_HsRjkmn5GeRi9s1RXTS-Od9RqbFA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add dtsi for sc7280 herobrine boards that using
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dependencies of this series were just landed, please help to apply
this series as well.

Thanks!
Best regards,
Judy
