Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0B67AFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 11:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235616AbjAYKj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 05:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235046AbjAYKj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 05:39:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3EE16301
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:39:25 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so932093wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 02:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PCQyXdewltdtbx7rJmvVCiDghesnHqYi1Jd/8j7UFHc=;
        b=FqawqXg+rhOtM79UXKaRsXOKjJ00ET0/G29Yc6C2ZSZ2+UpYwOdB1n4UJyY3IG40YO
         gA88h8M1iWfdCTcJz/WcYKhrRJg+gABKsVfDB2bQ3jIKXo077ieR0eddsalh8MgFrN7y
         0aV7HjieREmyqLkV0VXP1+bC+6l+6wKWzS+YXUIH19FMVpSaSabL2wI58EhSPmtGhiUf
         lEBrvdvhjXdTVdZxxOTGkxzOy1GbrmS0N9m8+JTQdkKIHC2BsodcLrFn5sN/vxXTYgmg
         yn/Q1PMaCPL1DovYer9gR2xxozt6mFWw8NaftlWbahUci3htAx5Oii2McJigqmWROYdF
         Yhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCQyXdewltdtbx7rJmvVCiDghesnHqYi1Jd/8j7UFHc=;
        b=wdLfoCyCrPkMauTGE3uXRYfeTLElytBH+dsPQuiIyZg4dfAJduJ85wn4wHHxyo0Lx/
         iNREWWSgmVxwaFBw370Ng3w4eKuOJIHYdAikGwExJWv20XiWruDFoUw0ZZgcs40U8oS6
         zsEey0lv4crS2OicyIMSfV8qxR92fpUMeNQpFrbSC9+k+VW63sD5mswcsFf7Yj1K8gOP
         OiBdBdUmK1PJ5dAzWDwH2+wn3OBFLLC3Ajwh3w2B9d9RaHqcbOXBVnJcW5J01RsixvhD
         LrkMWi8/o9IzhLRMi5rzz9XyV0GdcxR33UKmpByPt95k/jDSRhtSOkwnfQUD9HeaDZoS
         1Ijw==
X-Gm-Message-State: AFqh2kpKXThBE9R1ko///82aYi5SHKVHx8xWlRMdgXp5oUfnEF+na/Bd
        wMcmJDmJ589gMglBBrP77XXcwQ==
X-Google-Smtp-Source: AMrXdXtsJreryStNy+l+FbhfiUv2iHijwvvCbH7mS4C6rTdRFwcs37mZIQ69LivvO4uDyTpp6NTOpg==
X-Received: by 2002:a05:600c:24ce:b0:3da:18c5:e48b with SMTP id 14-20020a05600c24ce00b003da18c5e48bmr39098305wmu.18.1674643163675;
        Wed, 25 Jan 2023 02:39:23 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003d9780466b0sm1386804wmp.31.2023.01.25.02.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 02:39:23 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Baruch Siach <baruch@tkos.co.il>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: cx92755: align UART node name with bindings
Date:   Wed, 25 Jan 2023 11:39:19 +0100
Message-Id: <167464315348.338477.8230347885994646650.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151527.369285-1-krzysztof.kozlowski@linaro.org>
References: <20230123151527.369285-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:15:27 +0100, Krzysztof Kozlowski wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> 

Applied, thanks!

[1/1] ARM: dts: cx92755: align UART node name with bindings
      https://git.kernel.org/krzk/linux-dt/c/60e6cca8a2610379c1d29cdc8db42c020de28d8d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
