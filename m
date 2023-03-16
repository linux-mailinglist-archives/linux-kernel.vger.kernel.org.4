Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EB86BC476
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCPDSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjCPDSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:18:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC81A227BD;
        Wed, 15 Mar 2023 20:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F4D7B81FB5;
        Thu, 16 Mar 2023 03:17:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EB7C433EF;
        Thu, 16 Mar 2023 03:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936677;
        bh=r8bi8T9JqW69l43H5Xq4H0aADjitOt9a8QMkuP/OUK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNVtj/TjWPD6O95H6T0HmgPefZ+riF4Fk055zWJAFDGHGAaeHpPnq0m+EcYuSPyhB
         mJ+f+E/JcLyK+QznSZZYOWM60ZylRClhNwqd5bWVM2BBuReV8X5eVMmh0CqovygD/h
         7Eo+7pQ+lASaDF7TFhZpxlbbSzYWbVl298aOFVvAqBxHtKqvZC7YSKktDrgNgXWHg2
         zfXTnuR75ETst5U7x4kFE7PPuM9Ca0Ql+uDgx34LPQ3mx1CKqg+y3Yk9bHHsCsVtSR
         cMLZHSq75i1tf7mM0XHRBTTriK7mvmfMqei8mQ/8gCAJMdxxmL37C5DxVdwO3N0Yl3
         wFm5sJmDMwtZg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     p.zabel@pengutronix.de, will@kernel.org, mturquette@baylibre.com,
        marcel.ziswiler@toradex.com, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        agross@kernel.org, linus.walleij@linaro.org,
        krzysztof.kozlowski+dt@linaro.org,
        Devi Priya <quic_devipriy@quicinc.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, dmitry.baryshkov@linaro.org,
        broonie@kernel.org, konrad.dybcio@linaro.org,
        linux-clk@vger.kernel.org, nfraprado@collabora.com, arnd@arndb.de,
        catalin.marinas@arm.com, shawnguo@kernel.org
Cc:     quic_arajkuma@quicinc.com, quic_sjaganat@quicinc.com,
        quic_poovendh@quicinc.com, quic_gokulsri@quicinc.com,
        quic_anusha@quicinc.com, quic_srichara@quicinc.com,
        quic_kathirav@quicinc.com
Subject: Re: (subset) [PATCH V8 0/7] Add minimal boot support for IPQ9574
Date:   Wed, 15 Mar 2023 20:21:00 -0700
Message-Id: <167893686409.303819.11238056331180309772.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230214163116.9924-1-quic_devipriy@quicinc.com>
References: <20230214163116.9924-1-quic_devipriy@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023 22:01:09 +0530, Devi Priya wrote:
> The IPQ9574 is Qualcomm's 802.11ax SoC for Routers,
> Gateways and Access Points
> 
> This series adds minimal board boot support for ipq9574-al02-c7 board
> 
> V7 can be found at:
> https://lore.kernel.org/linux-arm-kernel/20230206103337.21000-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[5/7] dt-bindings: arm: qcom: Add ipq9574 compatible
      commit: 64d5c8a46890010e7cf5a72c0616d1141f84494f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
