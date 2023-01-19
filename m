Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82D6737BB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjASMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjASMAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:00:10 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E45B6F32E;
        Thu, 19 Jan 2023 04:00:04 -0800 (PST)
Received: from wf0783.dip.tu-dresden.de ([141.76.183.15] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pITaD-0002eu-Qs; Thu, 19 Jan 2023 12:59:53 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Walker Chen <walker.chen@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: power: Add starfive,jh7110-pmu
Date:   Thu, 19 Jan 2023 12:59:52 +0100
Message-ID: <12134372.O9o76ZdvQC@phil>
In-Reply-To: <20230119094447.21939-2-walker.chen@starfivetech.com>
References: <20230119094447.21939-1-walker.chen@starfivetech.com>
 <20230119094447.21939-2-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 19. Januar 2023, 10:44:46 CET schrieb Walker Chen:
> Add bindings for the Power Management Unit on the StarFive JH7110 SoC.
> 
> Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


