Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF32647A32
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 00:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiLHXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiLHXin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 18:38:43 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B022AC6D8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 15:37:13 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id z9so1903879ilu.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 15:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XB9uJ+lkRW+tWnK3/uWjQyTrX44g4B5OMTJxdQGorGQ=;
        b=ej1d3i78+fxsuwG+t+/ZsOtCWLxOw1VQ6hBnCjrixMih/PFvYFobeC3lvFX7h4vxXf
         s6iazg1FbHEFq7Oe2x1Y12vH2x7eTvUa7I2GQ7rEGm7cF44W3a1lz9cC81t0VEC6qwzY
         qxHYrg1M+Bv6c7g1fzq+RKijllHpux2RYDrdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XB9uJ+lkRW+tWnK3/uWjQyTrX44g4B5OMTJxdQGorGQ=;
        b=w7N94a1C7dUYh4r8Fb7uuId2m2AZjtam9gHfK/mVzSDRdZbD1hFCUdqmG0GviuND7U
         kzcwdz12i7+IlBLvoNGCabMcUBZzCew40lPqqF2j4z+knDPWIKnhpU8NJ1U35/Ch8Lpy
         L+1u+IdKBSXSEj1dV/b7BwHxj6DwYWf/+SJ+2W8PP2mPI1ms1eJY+n1asql+TzDdBMM+
         AyBynDp9VWXycAXpNv680QbP2VgsYtEhUv8zaecFi09F4yRi9hodUnMkts82G5MDudYj
         ChScmJ/xdF+kpyBoGWjwJt1qTryRXf2vYAtsY3aU6wXvnThO3gZ5t93OUAF3yT0GeGri
         tqrA==
X-Gm-Message-State: ANoB5plximS+4c76U2PHOM+GNr0QugSXXzM5Uj+CEaBDdfk+mkfJ4d10
        GSyQt40ce0Yk0fU96kDhVoQk1w==
X-Google-Smtp-Source: AA0mqf4YOtBRIbMzEvISzpxe835AwFTH9p2fLkeELjKV9KbhJF4qMNDQy7LrDD9CD5e/f6b6JxHkjg==
X-Received: by 2002:a05:6e02:806:b0:303:608d:b34d with SMTP id u6-20020a056e02080600b00303608db34dmr2175715ilm.18.1670542603516;
        Thu, 08 Dec 2022 15:36:43 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id s5-20020a92cb05000000b002f4d91546fbsm1199390ilo.6.2022.12.08.15.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 15:36:42 -0800 (PST)
Date:   Thu, 8 Dec 2022 23:36:42 +0000
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
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sc7180: Add pazquel360 touschreen
Message-ID: <Y5J1CrQ/suo3okdr@google.com>
References: <20221208192006.1070898-1-dianders@chromium.org>
 <20221208111910.4.Id132522bda31fd97684cb076a44a0907cd28097d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221208111910.4.Id132522bda31fd97684cb076a44a0907cd28097d@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 11:20:05AM -0800, Douglas Anderson wrote:
> The touchscreen was supposed to have been added when pazquel360 first
> was added upstream but was missed. Add it now.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
