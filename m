Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC9168E079
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbjBGSr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjBGSrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:47:52 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ACE241E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 10:47:36 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id b9so12302ilh.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 10:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hh1+psgQjuaoleUt0Gfjzl6xxwSk1nOZXISdOJBYhZo=;
        b=O7Uql6UeoJwdzn+dt4TAvMk8iH4jBm5N2loXY9CB226GBn0RtTECMbXjXJ60XsdQxe
         61YUI+7efXufASEAZrNbadz8aGg6nSGQWlsY0/HAPISK7mvJnCmD9dEuiwS0KwmJNxzF
         56mJBBvnPFWilfM4C/G4e5RWJLWhx3wgvtLkg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hh1+psgQjuaoleUt0Gfjzl6xxwSk1nOZXISdOJBYhZo=;
        b=rnnFAiX0YaIrUFsbivbAXO/lzLL6efveNqjMbQU2ZMw/FBcUGJ4nL3l3bYZzKo47vH
         LN4c7Rdceqrq14kc54iPhk8Z2I8Pn93lNXTJ05xaoDEGSzZ8KpdcbaI6M/Y6H0/Th4QK
         0RD0MlkCeG249Ibs6edJieUfXKV1Hcpi9Z8Hk02Xp6fQCVOm1/BXdd+2xZyXMJEwTub3
         bLousVaKPhNxIkgLl321ujJm7A3BODo5qz9AZ8JJWHqWON6rarcK0tK9MhgEdU5MV/FY
         5dV9ShEoV+vHH3nRWY7HWR27xfOrw+wEnOD/2Hu9hLzPfvhjkkgVJdgAT/R7mVeJve8p
         4rWA==
X-Gm-Message-State: AO0yUKUxsn7cUAXpV0q4D5kAJN1sPxlSBySv0iJAjFRWTu+5X9dZ3PPF
        GvsGp3ZKPxxtxrxKuWk3teFbZn3i+acgHH/h
X-Google-Smtp-Source: AK7set+50Q8ImTBYrWghW1Qs2pOZ11pGyr3Fu5kYn4klXUQILP7Y+Jx3pulSXi5JSEPRwJXz9Jgkrg==
X-Received: by 2002:a05:6e02:1b06:b0:313:dffd:6268 with SMTP id i6-20020a056e021b0600b00313dffd6268mr4304294ilv.30.1675795656275;
        Tue, 07 Feb 2023 10:47:36 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id u18-20020a02c052000000b00346a98b0a76sm286698jam.77.2023.02.07.10.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 10:47:35 -0800 (PST)
Date:   Tue, 7 Feb 2023 18:47:35 +0000
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
Subject: Re: [PATCH 7/7] arm64: dts: qcom: sc7280: Hook up the touchscreen IO
 rail on evoker
Message-ID: <Y+KcxxWzm0PFksm+@google.com>
References: <20230207024816.525938-1-dianders@chromium.org>
 <20230206184744.7.I2d960ed7f2445db0cf3d227fde985fbd740f3c4d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230206184744.7.I2d960ed7f2445db0cf3d227fde985fbd740f3c4d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 06:48:16PM -0800, Douglas Anderson wrote:
> On older revisions of evoker, the touchscreen was either
> non-functional or needed special hardware magic to get it talking
> properly. It's been decided that the proper way going forward is to
> use L3C to power some buffers on the QCard and then configure the
> touchscreens for 1.8V. Let's do that.
> 
> Note that this is safe to do even on older revs even if it might not
> make the touchscreen work there (because they didn't have a properly
> stuffed QCard). As talked about in the patch ("arm64: dts: qcom:
> sc7280: On QCard, regulator L3C should be 1.8V") the L3C regulator
> didn't go anywhere at all on older revs.
> 
> This patch relies on the patch ("HID: i2c-hid: goodix: Add
> mainboard-vddio-supply") in order to function properly. Without that
> patch this one won't do any harm but it won't actually accomplish its
> goal.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
