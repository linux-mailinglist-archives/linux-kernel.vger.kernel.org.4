Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25BD703451
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242964AbjEOQqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbjEOQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:46:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E21DB;
        Mon, 15 May 2023 09:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08E3362914;
        Mon, 15 May 2023 16:46:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4D8C433D2;
        Mon, 15 May 2023 16:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684169204;
        bh=eL6yi8hMio7duV0WcJ4yRmARZWgFYml5JEHbo9uWn+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogeSGaFFFvjbPGqY4fxX+spkml9Sb//s1UTvN5ItUHwSUxdO19Y5JNiXhApeuaIVv
         6Ah747zLCTDSMzxR5e4DFvTy9Ov3n6OqOlp1/n8d5LK5XLeX/mqqyhd60RXg+ICx/K
         k2wMW9aREKv9ZfJyLnW84qtlqO/jQkDCdmamz0BPpCHkrFq8umU868A11jr3p2HO+i
         6ak7XhVQk1Hp7/IZs6lqyoZjUsYg29t5Q/0WI9HoWZlxdSPVPqeHbNAAUr07AyEwl/
         KTDKsaLAyD75obXfofZ3ZxAG00g+4tetgJSYhIaqN8cNq9gabfmYD4qCmd7osMDNFz
         gf0A+oRXUzmmw==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor@kernel.org>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/2] Add watchdog nodes in StarFive JH7100/JH7110 DTS
Date:   Mon, 15 May 2023 17:46:33 +0100
Message-Id: <20230515-tribesman-sloppily-658f86d776ac@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509151723.84989-1-xingyu.wu@starfivetech.com>
References: <20230509151723.84989-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=610; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=q4UXWBBFSwrCUpZYR2X7bAvP0FrsLTRfFER3VBh/8+A=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDClJic8TON0778U8FM7zuXNtguXjL/w2Yc9frHt/4tObj RN+cDx61lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJCLowMjx1+f/o2YmWU8IM bnd/X3b4XsazbNsawadR99e2h0u51MxmZLjSXnXh4eO8w5VLV6+qiSjkW35BJy612c95ukPdU83 z+9kA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 09 May 2023 23:17:21 +0800, Xingyu Wu wrote:
> and JH7110 SoCs. Patch 1 adds the node in JH7100 dts and Patch 2 adds it
> in JH7110 dts. This patch serises are based on Linux 6.4-rc1.
> 
> Xingyu Wu (2):
>   riscv: dts: starfive: jh7100: Add watchdog node
>   riscv: dts: starfive: jh7110: Add watchdog node
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive: jh7100: Add watchdog node
      https://git.kernel.org/conor/c/435ac3fbfbc6
[2/2] riscv: dts: starfive: jh7110: Add watchdog node
      https://git.kernel.org/conor/c/6361b7de262a

Thanks,
Conor.
