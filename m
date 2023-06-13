Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6961372F0A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbjFMXsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjFMXrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84DB2D52;
        Tue, 13 Jun 2023 16:46:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DCB163C89;
        Tue, 13 Jun 2023 23:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406CCC433C8;
        Tue, 13 Jun 2023 23:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686699949;
        bh=z+m2w7UiSSaJX/OwF3qDeUFbm6UG/urVuxrQGCfidRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LO+V93ICx1HwMwWHEBH/0j7Ux1MkZXoOm2+800vsCbav/XKQvETwEfX7YhnrfOe7W
         qN6tQFZYj3tTkRQdHXkEpAk9TvJtB6g9PBX3nlxikIXhMJE0tdosPyLGckQTMDuMua
         iQR3FByH1msDH91hfRxWp63DKqAcD+dzWjJ+LYEBc00sWHI1tUVkU3H+sh4v0N0x1o
         04SBHZVRg777diNwZx6bBov7RJ1Cl6iOo8vr57CxFHtpY8iFuJtZsax+03SYBbWO8j
         5RteReqO6IvhaaHkMMJzCCKtOGCSVoEgGoRkc9+WvStU5Azu8SH10sRnoQqHvbgDmw
         lRq9ZFF45OJIw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: (subset) [PATCH 0/6] Enable MSM8226 TSENS support
Date:   Tue, 13 Jun 2023 16:48:52 -0700
Message-Id: <168670013503.1400697.16167294323493822570.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
References: <20230507201225.89694-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Sun, 7 May 2023 23:12:18 +0300, Matti Lehtimäki wrote:
> Add support for tsens in MSM8226. Add qfprom compatible for MSM8226.
> Add device tree nodes for qfprom, tsens and thermal zones for MSM8226.
> 
> Matti Lehtimäki (6):
>   dt-bindings: nvmem: qfprom: Add compatible for MSM8226
>   dt-bindings: thermal: tsens: Add compatible for MSM8226
>   thermal/drivers/qcom/tsens-v0_1: Add support for MSM8226
>   ARM: dts: msm8226: Add qfprom node
>   ARM: dts: msm8226: Add tsens node and related nvmem cells
>   ARM: dts: msm8226: Add thermal zones node
> 
> [...]

Applied, thanks!

[4/6] ARM: dts: msm8226: Add qfprom node
      commit: 16a9fa7ab27b69be3a34b97ff8c7b034fcc73b88
[5/6] ARM: dts: msm8226: Add tsens node and related nvmem cells
      commit: 0f8861c9fc7cc9af6d6f65d6657aa9cf2531b29c
[6/6] ARM: dts: msm8226: Add thermal zones node
      commit: 8d4236f62f3acbc6a0def79106c13fe7344d8238

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
