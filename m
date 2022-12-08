Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C75647A09
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiLHXeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiLHXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:33:56 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BF6ACEF
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:33:56 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id z9so1901171ilu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pKD0z1maEkr8LN0VfjE0onCG1Voz2tMlAbquW+aI4PQ=;
        b=iSoc4pbq9Do4IAFoykJi1KZ7vMe8vtdeeGGq5uZtTBdEV1CaLocmDJjg8KfSho38xH
         1FUG5kP/1iOT51Xx8FULwhkyjdC4wCgFiVDjFbUNs0q3d7eAfTXbT+XahCwcZJchaBA4
         sfgOW3bGfdZnzBWHxO6y3ULK2wpIcwrF9V0mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKD0z1maEkr8LN0VfjE0onCG1Voz2tMlAbquW+aI4PQ=;
        b=8LE7n0dNojSpPTFwGCw5rvuTQuhyVUcbmo97C/rkTEcuXI0pZkyZ1iKB47l24GJeLQ
         kt3M4lv7OISTNUsKmiotPY8ZyBUf3C5INdNYS/XYpPMc1mcCWya4mc5VeAgh1SDizGlY
         0PVOVwvA6K8h+oLQzHxymcLxeuKy9ncE0GhJ+KzxzC93RMskuVpgTyExi3JZ5dqknWHq
         ovy7Y1DxNJa1oXcmhE8rTAzy0MQGQAv5hIrvqNBLIDDz7XOWETePB8/0I4NSVY72K6fu
         D0fE8Xc23dBoVxt+I9EFT5QmF8M9SRpTOxdcrNo4qwFhNeTxYe0RgVwOHqKy7NrZOfx+
         eQEg==
X-Gm-Message-State: ANoB5pnpbzngX5N8HFxd5QiYkZ5tly7a21Jm7gho9jH7hTwKgHpupdMN
        C+m11HrQ68mBBLSJt8O844TIgQ==
X-Google-Smtp-Source: AA0mqf5dzgNqV8tMzXnKMA0Xtxo+nx2jWlFnmxrgaHS3Hl7qDg7Di+cWg4Y0Oa6P18edB25yxnAprw==
X-Received: by 2002:a92:4a10:0:b0:302:ab04:915c with SMTP id m16-20020a924a10000000b00302ab04915cmr2025685ilf.24.1670542435623;
        Thu, 08 Dec 2022 15:33:55 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id e33-20020a026d61000000b00363ad31c149sm9096965jaf.110.2022.12.08.15.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:33:55 -0800 (PST)
Date:   Thu, 8 Dec 2022 23:33:54 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-input@vger.kernel.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: dts: qcom: sc7180: Start the trogdor
 eDP/touchscreen regulator on
Message-ID: <Y5J0YqLPtjIJ3Lpc@google.com>
References: <20221208192006.1070898-1-dianders@chromium.org>
 <20221208111910.3.I7050a61ba3a48e44b86053f265265b5e3c0cee31@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208111910.3.I7050a61ba3a48e44b86053f265265b5e3c0cee31@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 11:20:04AM -0800, Douglas Anderson wrote:
> Now that we've added the `off-on-delay-us` for the touchpanel
> regulator, we can see that we're actually hitting that delay at
> bootup. I saw about 200 ms of delay.
> 
> Let's avoid that delay by starting the regulator on. We'll only do
> this for eDP devices for the time being.
> 
> NOTE: we _won't_ do this for homestar. Homestar's panel really likes
> to be power cycled. It's why the Linux driver for this panel has a
> pm_runtime_put_sync_suspend() when the panel is being unprepared but
> the normal panel-edp driver doesn't. It's also why this hardware has a
> separate power rail for eDP vs. touchscreen, unlike all the other
> trogdor boards. We won't start homestar's regulator on. While this
> could mean a slight delay on homestar, it is probably a _correct_
> delay. The bootloader might have left the regulator on (it does so in
> dev and recovery modes), so if we turned the regulator off at probe
> time and we actually hit the delay then we were probably violating T12
> in the panel spec.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
