Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E240690833
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 13:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBIMIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 07:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjBIMHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 07:07:54 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC72D6E98C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:59:48 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13so1243762wmr.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 03:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ENx1BlMiFFp2IoPqIDNCRtS0BoPqJfHW4nQVqKYr9o=;
        b=F4BeqKwaARMgjeu76MVzv4QbUzWJlju3wOKLYmwaicSUmQQImF+LmXugMwe+v8PckS
         e8SWMyh5k+8OFwmmHNSy5PmVDK8ffQI4/FC9YC01WgJzqlQnZ4fpqfvT9KtomOyHCSpL
         LKm3iUQNwBisWpGoM/ePatMD1AJRqlTsVvQ8wh+8PctwSIlXTcmJ9dLHYlyX3K9yY8Ev
         sPvB/Dnf6iHVOq8R1ZaHp+/STgGIw2EQ0WEJaBtG2ZsVBWut4MF82t1oyqtOT1FxfRky
         mlQGe7X1XrPwClbiCpEaDuB7OPzvlWKj357btrD/X0IGvNCxLbrPFmMSdDKOmo/Rp2X4
         oMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ENx1BlMiFFp2IoPqIDNCRtS0BoPqJfHW4nQVqKYr9o=;
        b=elwmgS4q6WpKt6sQg5wVnBEmxCgWQmg1uOk8LPSKKLThlHUd1c/mXhHFIy8Fhkp1zM
         zPvqW0h2Z0HKipL1S6FQxE1Lph+seMdKgBDwBCu5kKCwuoFqdfNMCeCjDNrp3RcXyHd+
         LiUhosgpAJ3XDFF/rXa9abXwwOn2WqDd0qzLXlcdRZHhFv8bK1dcKjcXDEalbWbyhUGp
         7mNZEMFEId7lLmb/otA9DYrbCxxt+X4zc9lO12Df3/2gi72nf4ZRpaVlWWSmCTCF1lEZ
         7BLaA7gvGkHmkm2/thqADb6VDmSrvz0Txqi25VGK0tLpbBRke3ZOpt+9SuP24GfGwT/t
         XDVw==
X-Gm-Message-State: AO0yUKWPcjtYH9QIaSIfc7zGlguAzaUtDWGRPAjx4OZUP7Di0KlJSVnp
        rsZZT6GcUXCib2VKhfOxwpRtXA==
X-Google-Smtp-Source: AK7set/93LzZXc2ETQeI1iMfQkCdxX2mN03ZhK1l+5AOtK6IVpqR5uADbh/hURLTNDJn+GsCsPzDmg==
X-Received: by 2002:a05:600c:13ca:b0:3dc:5937:35a2 with SMTP id e10-20020a05600c13ca00b003dc593735a2mr10965053wmg.9.1675943945890;
        Thu, 09 Feb 2023 03:59:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003daf7721bb3sm5264513wms.12.2023.02.09.03.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 03:59:05 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] ARM: dts: exynos: correct max98090 DAI argument in Snow
Date:   Thu,  9 Feb 2023 12:59:02 +0100
Message-Id: <167594393974.789355.9583895741497134321.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208160424.371678-1-krzysztof.kozlowski@linaro.org>
References: <20230208160424.371678-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2023 17:04:24 +0100, Krzysztof Kozlowski wrote:
> The max98090 has only one DAI and does not take argument to DAI
> phandles:
> 
>   exynos5250-snow-rev5.dtb: audio-codec@10: #sound-dai-cells:0:0: 0 was expected
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: correct max98090 DAI argument in Snow
      https://git.kernel.org/krzk/linux/c/301d3dd05525e3a046f6cfa6ee4dea6a3b7111ee

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
