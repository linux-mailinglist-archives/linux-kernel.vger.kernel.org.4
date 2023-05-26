Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB9712D72
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242643AbjEZT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242775AbjEZT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:28:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6343D9;
        Fri, 26 May 2023 12:28:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6e72a1464so8298805e9.1;
        Fri, 26 May 2023 12:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685129292; x=1687721292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8NMc/veCKzb+fUJONXklbAaF4wpMddgEx503WmdKbO4=;
        b=MAquTvPOwAOleji5PY+c/03peBIcaDfLLbsklFvH+sVormIUAYHhcmvG/ydk6jzgm+
         6r0oHmMSVcJm2VQSz/tlgmNNcnMn6ejJHdAVzFaZD1FbBwZC/09Q465i9xjxCtEQhV1J
         8GPuQooPhaS/qmgPSCdLaEpGn2X2sgfbJ5uSUPvcp2xZqv4dmFx5GjuwV8QkMVHXghp2
         0/4bhisp1Yg4gqWZg9QNploMamgif5V2XZkNmz3mRr2y6+jMkKpSkwMCWUKNp1n+JWsi
         1SPNOfN9PrbyG7vr/pIRA9kJeMnaUL+qfg19f+p/0UDxvPMuTYyJsC8hIOo/M5BAGU0E
         08Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685129292; x=1687721292;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NMc/veCKzb+fUJONXklbAaF4wpMddgEx503WmdKbO4=;
        b=Qhhd4szJjoN7FguJT4byTwbgZzDTwWkUiJa+xfACHZdhdjlz7wCMtfzWbBj8visBL3
         yv2lKiH1KKEi7EBD93Htt3Jpt60JYyBG7bXNEQWNOJ5fpz/g+IofIEuFo0/vZhlw2p5D
         aSr3ws1SbDshlgrYKnJLUBkOeYGBMR0p0ewr+aeVLO4fnlyPcTV/HC6FaWotmhSLsWBG
         V9MZFA9U5f0W5c+D5tE1RV0dRZhcNaq8LyDC6IeVYJBbtf8c+nSggDwIQSR05KEXSRnQ
         IwCCfxDWEuzNXmrKkITx7Ojvn2CERsUTcsFZSK195Cys5BtduFMXcoCDc9VzJtIOvP18
         YnEQ==
X-Gm-Message-State: AC+VfDzcJrOW+EdKJv77s/tQdytkfowOaZ3q4cfXeCu6gJgjJWdQG4YR
        VYxh79xfyPoUNeIKb1l+dyAaxC1jMmY=
X-Google-Smtp-Source: ACHHUZ7RgJzSyZQFT6x8v9v5O8cebN1xidwyGJhx9R7eh5EXcTrnyhKp8UDVE76cnTe84wBHdZOfow==
X-Received: by 2002:a05:600c:2219:b0:3f6:2ee:698e with SMTP id z25-20020a05600c221900b003f602ee698emr2370974wml.7.1685129292033;
        Fri, 26 May 2023 12:28:12 -0700 (PDT)
Received: from standask-GA-A55M-S2HP ([188.123.113.247])
        by smtp.gmail.com with ESMTPSA id x6-20020a5d6506000000b0030639a86f9dsm5905683wru.51.2023.05.26.12.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 12:28:11 -0700 (PDT)
Date:   Fri, 26 May 2023 21:28:10 +0200
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] ARM: dts: bcm-mobile: DT cleanup
Message-ID: <cover.1685127525.git.stano.jakubek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up some parts of Broadcom Kona platform's DT files.

No functional change intended.

Stanislav Jakubek (6):
  ARM: dts: bcm-mobile: change "" includes to <> where applicable
  ARM: dts: bcm21664/23550: use CCU compatibles directly
  ARM: dts: bcm-mobile: move status properties to the end of nodes
  ARM: dts: bcm11351/21664: add UART, I2C node labels
  ARM: dts: bcm21664-garnet: use node labels
  ARM: dts: bcm28155-ap: use node labels

 arch/arm/boot/dts/bcm11351.dtsi       |  27 +++----
 arch/arm/boot/dts/bcm21664-garnet.dts |  46 +++++------
 arch/arm/boot/dts/bcm21664.dtsi       |  31 ++++----
 arch/arm/boot/dts/bcm23550.dtsi       |  19 +++--
 arch/arm/boot/dts/bcm28155-ap.dts     | 110 +++++++++++++-------------
 5 files changed, 115 insertions(+), 118 deletions(-)

-- 
2.25.1

