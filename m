Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBE46490B7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 21:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLJUyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 15:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiLJUyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 15:54:00 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F60165A9
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:53:59 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3704852322fso96010007b3.8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 12:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mhrAb+yQ8r5Pj6JbLxX6H679hMkP8WxpYQ53O58DWDA=;
        b=RbF+zsbkFenK5oP6pcpKvnk2q8et0ziZuupBucQguQu4GEqvyuCPTcXn5uANp7pTCZ
         ZVUkGih6xULK3gVfvZAvg6xIq+visBaDzsQP6Nxt0IO9340ODMtzdcNxI0FV5IwBzN9G
         u7WpoKfaM5hgUmT0PqGdJtXV5umTsNasJsVkUhIkDc2H7CXncszicY+FqnH9q05xl290
         eIHq9KAEMsW/xtaPZC1TQSIK2bpGH3/Qu9IToLO7UW4FdfX+cBk1qZU6GercHqSv/X5u
         +7DW8P4iB08wemfc0Bkyq++1a30UlOqLYZMCYVaZlyBWK+PF8mpwW06XUyv6y7bZprxH
         GQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhrAb+yQ8r5Pj6JbLxX6H679hMkP8WxpYQ53O58DWDA=;
        b=xfzGmNc+CF+HUvJGuwamtA6MrXZfgFTDCEzpbRZ0pfjaj6/z5b6a0TrtuLwyMAlOQZ
         fhHfK3AfovH7bkHVpeWm/I7IwjTKejd/HOlGd3t/C10ChwYi1FUZGCYa5e1KxvRzdDc3
         cj6VLFk736uY8cJ5xB8l9NufSKUQcYPSGR83TXxUMClLFjuZrDHMKROXIWPJZYVFAdOD
         72rbeXaeRqBQcv1el6/y4+mRv/9ufbPIul6IvpY76bXLRRqDmre2wtWpsoneD6TJ5ILj
         xayfnSxJMAgUPI2XtNA8ckXhZIEm8GfCPRAJoKp8GKfAClWwViqz61LWTKqiKBaAlui+
         0VqA==
X-Gm-Message-State: ANoB5pkglQxqAn/tuB5Rr70E94zYbfGY9lNktaydE36So2vxrRuT+X4o
        wmnH99dh2lVR6GqVNPWGvZJyVvut4AHht+bLzrqDRA==
X-Google-Smtp-Source: AA0mqf6Euj77tZGpcvvSY4sr3yOGyX27MYYokI5ryaiVO9AZutI69pj2NuNT2S9i+T+aEe+S9Uo4ft9kiJCYkcye4dU=
X-Received: by 2002:a81:6704:0:b0:3d2:61bc:e6a with SMTP id
 b4-20020a816704000000b003d261bc0e6amr40897805ywc.132.1670705638304; Sat, 10
 Dec 2022 12:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20221210200353.418391-1-konrad.dybcio@linaro.org> <20221210200353.418391-6-konrad.dybcio@linaro.org>
In-Reply-To: <20221210200353.418391-6-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 10 Dec 2022 23:53:47 +0300
Message-ID: <CAA8EJppQu=f5aXn3F_xAxZ6h+YgGYfCe6M8J77S_LLWH7NkE4g@mail.gmail.com>
Subject: Re: [PATCH 5/5] arm64: dts: qcom: msm8996: Add additional A2NoC clocks
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 at 23:04, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On eMMC devices, the UFS clocks aren't started in the bootloader (or well,
> at least it should not be, as that would just leak power..), which results
> in platform reboots when trying to access the unclocked UFS hardware,
> which unfortunately happens on each and every boot, as interconnect calls
> sync_state and goes over each and every path.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry
