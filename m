Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2D64A7EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiLLTH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiLLTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:07:20 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF5710556
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:07:17 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id 1so1071605lfz.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MagF9N2zlNHkIFdIICMF8ydb3FmPAw5l1vKmdx/oxs8=;
        b=RM1NdGVqPvDhO3+tbgyu8RhEyq3+++MY0ECRt6eXG1T9AJEQJTMaX8taEJ4Guln6C5
         BD97DcWMgvQm0ZRNQ/XpfwyhiO8YRwd0Y8cat8KbhT7A2R2GW9g+LtXfiscvu6bDpXU0
         +ihJFQHQnoQcurpcnjy+Cruqim/2OzXW4fbTM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MagF9N2zlNHkIFdIICMF8ydb3FmPAw5l1vKmdx/oxs8=;
        b=jb+gyngSeIHQ0d5umM5L2Wh5vpwOu9PvwxpU1fqMzLj3Ll6TgWcVPm9Pi4XwW81D2B
         PPbPJu1mraqB+4UhKm5epWx8CXsk3tXGJIJhO6hwdxNRxfUW/aBvFA9ZMQlHi2oTjUt2
         0CGUkd4uZRZITZCp3ytHKNCQD2bz5MPQZjG8O3foEUzSJV64/3SP6FPleQ3cf4sU97wF
         YqtfGkHRgaW3FR5uNng1FyxgfmEPoprNz895ZQPpg3atw5+Ve6ojQWneZn6+9/eWzNZj
         n/vgNxGtdRlxvkKIFc75qrijUChQKiI6qdUuQC/DV66P75atWqJo/fRkd9TU9nkF0wqv
         qVzQ==
X-Gm-Message-State: ANoB5pk0qWH/xPGwJZQMrHoy6dittt2FmYjNCqOwhaLluQGAf8iWv6Aa
        9avCpCxAkcHdWOYNprWwB62NoTJ6Bqn20JubdZbJuw==
X-Google-Smtp-Source: AA0mqf6Bm6pUVI5zaf2HuGlLhZbzYEVmcaQItyRuLQgFOl1/nMIGhtP7rr5gboLezz0VWd/ps55ctW7DQEO1oVJYAm0=
X-Received: by 2002:a05:6512:33d1:b0:4b5:1c86:9267 with SMTP id
 d17-20020a05651233d100b004b51c869267mr18965216lfg.297.1670872036091; Mon, 12
 Dec 2022 11:07:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Dec 2022 14:07:15 -0500
MIME-Version: 1.0
In-Reply-To: <20221212133303.39610-3-krzysztof.kozlowski@linaro.org>
References: <20221212133303.39610-1-krzysztof.kozlowski@linaro.org> <20221212133303.39610-3-krzysztof.kozlowski@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 12 Dec 2022 14:07:15 -0500
Message-ID: <CAE-0n50b-AaOo2MFyMyvgKhBhpMpL3fxzqLvJaPq=Hg1fdu2Mw@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: correct SPMI bus address cells
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-12-12 05:33:01)
> The SPMI bus uses two address cells and zero size cells (secoond reg
> entry - SPMI_USID - is not the size):
>
>   spmi@c440000: #address-cells:0:0: 2 was expected
>
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
