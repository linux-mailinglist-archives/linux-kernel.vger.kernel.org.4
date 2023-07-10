Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5787274CBC5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjGJFGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjGJFFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:05:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4593110F8;
        Sun,  9 Jul 2023 22:04:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2644B60DFD;
        Mon, 10 Jul 2023 05:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610CBC433C8;
        Mon, 10 Jul 2023 05:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965486;
        bh=G7XQfovG/kEX18bpAsTJZUi6N1LzfLghRYhTWLHDyFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3JBri7SIyhkq9FbkL3knxkeocgwImAbqbVENOahXxQL6RmZzIYnQ8aUNSEf2V4ZC
         evbOz8qd/yTViJOqVIT+ydOL+gsHdw5Ikm1vHDrnhwr+By8RVzkUyG+KPTbJ32Itvp
         fwBBizjjCqnOPo4W8Gw6CObRaAGIHOweObD09j9/dIuq9HbonTQkVvK/4E0NaUhxB4
         ZEdZTjdwgiuCprH3ZvNVtS5R2QPirPl5LhRGCaLrwJl0wzHFAH1hYxYOcZN6zdYfW4
         RbreC3+593HEUSiCYcmgNrpD/Vzvbc1b7b9Gok95cdLl2uV/n3dUO2G/0pQEox7dKU
         b1ut12UFeo1mA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: (subset) [PATCH v2 0/7] SM6350 GPU
Date:   Sun,  9 Jul 2023 22:07:26 -0700
Message-ID: <168896565950.1376307.2219780335769154828.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
References: <20230315-topic-lagoon_gpu-v2-0-afcdfb18bb13@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jun 2023 13:35:31 +0200, Konrad Dybcio wrote:
> Add all the required nodes for SM6350's A619 and fix up its GPUCC
> bindings.
> 
> This has been ready for like 1.5y now, time to finally merge it as
> the display part will take some more time (due to the HW catalog rework).
> 
> Depends on (bindings, admittedly I could have organized it better):
> https://lore.kernel.org/linux-arm-msm/20230314-topic-nvmem_compats-v1-0-508100c17603@linaro.org/#t
> 
> [...]

Applied, thanks!

[3/7] arm64: dts: qcom: sm6350: Add GPUCC node
      commit: 75a511b1e5ff6ffadb9b51d85beee8c7bcc29ba9
[4/7] arm64: dts: qcom: sm6350: Add QFPROM node
      commit: 5b1e5d9a21ec2ad0654ce192371ed81b12088c6f
[5/7] arm64: dts: qcom: sm6350: Add GPU nodes
      commit: bd9b767502806faccbac6f2c8db09d0ea6ca6e3e
[6/7] arm64: dts: qcom: sm6350: Fix ZAP region
      commit: 44bcded2be4fe9b9d0b6e48075c9947b75c0af63
[7/7] arm64: dts: qcom: sm6350: Add DPU1 nodes
      commit: 26c71d31f8be3493006140961acf6be204004fdb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
