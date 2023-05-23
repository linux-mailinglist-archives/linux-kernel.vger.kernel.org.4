Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E6370D20C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjEWDAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjEWC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 22:59:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCF6CD;
        Mon, 22 May 2023 19:59:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3209262E66;
        Tue, 23 May 2023 02:59:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB14FC4339E;
        Tue, 23 May 2023 02:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684810773;
        bh=lu+zoOvPb5u8/tfXKugozBgooQNzp9iQcQ8p6olPMnw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q2RMO+saCW5qcIqFJKL+ZYwIMWWYgKYLjVirzN+lAUSJsbm2EExbcudOx0AZXFnPc
         Wg2racsAwcbBHfRV+NQp8Y3VmgqdeAUBp8zzTW8CACjFNsdDtV27Df6HhvvgOCg0S1
         YdnEaFc4PTY7x5twnBQNPlKMd3Z6KRZPBeKBp7NTDj9O1LOwT6DhIq1CtcPEMm1GRK
         L9NGpUzdyg2FwBW6PWUujpNyRv6kTDSPb2L1vgsLc+Ccnv+/jxX3aJAPMm58HUGuBL
         4JEnXbUZXAdTsHR2/XK350IvXMyYIwlMJAUQZqzSM1nqZehueErqhaJgbxZWC/awiu
         GgmxZhssOIUSQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/3] ARM: dts: qcom: apq8026: remove superfluous "input-enable"
Date:   Mon, 22 May 2023 20:03:21 -0700
Message-Id: <168481094821.1229550.1596652705535212352.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
References: <20230410181005.25853-1-krzysztof.kozlowski@linaro.org>
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

On Mon, 10 Apr 2023 20:10:03 +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
> input-enable") the property is not accepted anymore.
> 
> 

Applied, thanks!

[1/3] ARM: dts: qcom: apq8026: remove superfluous "input-enable"
      commit: 18f341061262a7a63bc8b5c9ef94a342ac2673a2
[2/3] ARM: dts: qcom: mdm9615: remove superfluous "input-enable"
      commit: da50416fb1fa7502a52ad38c0e9ff196d9f56ac9
[3/3] ARM: dts: qcom: msm8974: remove superfluous "input-enable"
      commit: 033553c04b02b450261f60d5f1b0e5948cd197bb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
