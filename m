Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5B874EC91
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjGKLZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGKLZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB96E7E;
        Tue, 11 Jul 2023 04:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4DA6147F;
        Tue, 11 Jul 2023 11:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72ED6C433CC;
        Tue, 11 Jul 2023 11:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689074740;
        bh=ukUjCeCdruXdkiTh7KIF8MyySLBbuQHe+rPdQaoxZJU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=boJsxhUixxmLnT7F5Q4u//Lh5Xwjgp2OMmp6SpFQH9y2pmO0FF36ai6geFE8vFM9m
         EbP3hWTRWiZ2F7a4HOIzC+9d4gQ1OMi+YODKPb+nPA6rRqGFEMrr14RYZH8nRDH25+
         hJYDxwPMvOHowM+hoUZJwONVC2QOpfVQT4oiHPzFch2muFek67IUbGyRUU3BB8zBA0
         ZU9ik4q8wvDZrX2jH9CxYasAoQosSGSwVEitAmFHwz/dRJW0vUliOlw0PAx5KqbPd1
         yaTOFFrRWzYWke90zp5FI6ngKsnzV03a65skVHO5oW9BnoFQePGJA9Sm1s8r55h1gR
         03xdWRsyWnb1Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Conor Dooley <conor@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Roger Quadros <rogerq@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>
In-Reply-To: <20230629075115.11934-1-minda.chen@starfivetech.com>
References: <20230629075115.11934-1-minda.chen@starfivetech.com>
Subject: Re: (subset) [PATCH v8 0/5] Add JH7110 USB PHY driver support
Message-Id: <168907473599.198426.16779806941255747951.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 16:55:35 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Jun 2023 15:51:10 +0800, Minda Chen wrote:
> This patchset adds USB and PCIe PHY for the StarFive JH7110 SoC.
> The patch has been tested on the VisionFive 2 board.
> 
> This patchset is base on v6.4-rc6
> 
> patch 1 is usb phy dt-binding document.
> patch 2 is Pcie PHY dt-binding document.
> patch 3 is USB 2.0 PHY driver.
> patch 4 is PCIe PHY driver.
> patch 5 is PCIe PHY dts
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: phy: Add StarFive JH7110 USB PHY
      commit: 6172141bf8ce6ec8f0b5d33533bf5a5646880e3c
[2/5] dt-bindings: phy: Add StarFive JH7110 PCIe PHY
      commit: 2b236fd4912141074a1cf34a7b3ef724d5bc8d8d
[3/5] phy: starfive: Add JH7110 USB 2.0 PHY driver
      commit: 7ac349186842972ee2b17413a0eee34231324eb1
[4/5] phy: starfive: Add JH7110 PCIE 2.0 PHY driver
      commit: 26cea0e28057d4ee440af4157f13a5312e3918b7

Best regards,
-- 
~Vinod


