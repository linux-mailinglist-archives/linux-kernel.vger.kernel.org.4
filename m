Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE356635845
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237202AbiKWJwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiKWJv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:51:26 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6D3A2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:48:42 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id r18so16290656pgr.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1GEU2cRgjlLvYsLY0fZ4A4QbwfIO6NbgQTnOI4zDrLE=;
        b=SUtTrkQx6wur4zOzrqLMn/8cHKy9h+yPv+sWOb9nHEWuhuNfU+3ZwvrZL5PsWR1jHD
         LviK45EH3sfIL/zNpqcb/E6rCbosrPbax1qUFcHZlLG1ntBzgPSp2MPSwLc7kaRE8AKP
         9rUbuliMwnHZOeY7pNQQsu/XKgljhiGE9+2tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GEU2cRgjlLvYsLY0fZ4A4QbwfIO6NbgQTnOI4zDrLE=;
        b=ExMm6IB87TxmxzJL7ZdBRbiOJYLmJaZafSI7Hl/qCF6liwpJF/r36MRM2KGP53cakm
         R+BMmL6nd8UHayhWSk/SdclyjP5Y7yY0G3N9AALFGuaYo/uCgIeoIDMOBNtpbBEfgR4Z
         bmYG59Q5Nye5r3hsdoB2IwMgJ18glmgctF0c/4IJzJ9+7O3yvbYFuZ2HJsFKZaIQNV+T
         RrXNqXUau1kRE3hjUVqznYR7NxSCbAUCgoiE5RneWBWMe5wBajGiH3hIywFBbr+IPwNp
         MZOIKgiqlup086HMPJADpZJe5MyE9/w7AM35kJ+fFIeIbXm7F46s8ymZQFMtXSG10/or
         IPwg==
X-Gm-Message-State: ANoB5pnEH1cFze7GwHxRR2QNwgcYbDssHziTTozNG5/t2PrO6irlYPWZ
        ZsCHpMa/JOcGcYRvxxX0etd0ig==
X-Google-Smtp-Source: AA0mqf4GuAbzU14kwO1xYECCrssU/mE1WSrgrNjxoxPUn/mwN7pQwtnAZM0fOT4hAo3W0rDYKw9bjg==
X-Received: by 2002:a63:f00e:0:b0:477:5e25:6d4c with SMTP id k14-20020a63f00e000000b004775e256d4cmr7962597pgh.159.1669196922014;
        Wed, 23 Nov 2022 01:48:42 -0800 (PST)
Received: from localhost.localdomain ([183.83.141.79])
        by smtp.gmail.com with ESMTPSA id k16-20020a170902c41000b001869f2120a4sm6524670plk.94.2022.11.23.01.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:48:41 -0800 (PST)
From:   Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amarula@amarulasolutions.com, Da Xue <da.xue@libretech.co>,
        dsx724 <da@lessconfused.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Manoj Sai <abbaraju.manojsai@amarulasolutions.com>
Subject: [PATCH 0/1] Increase spi-max-frequency of nor flash for roc-rk3399-pc
Date:   Wed, 23 Nov 2022 15:18:26 +0530
Message-Id: <20221123094827.250657-1-abbaraju.manojsai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change spi-max-frequency of nor flash from 10Mhz to 30Mhz for roc-rk3399-pc

Manoj Sai (1):
  arm64: dts: rockchip: increase spi-max-frequency of nor flash for
    roc-rk3399-pc

 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.25.1

