Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC0C71050B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233778AbjEYE63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbjEYE5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:57:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18270E5C;
        Wed, 24 May 2023 21:52:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5263B642B0;
        Thu, 25 May 2023 04:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13482C4339E;
        Thu, 25 May 2023 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990292;
        bh=Lsn8tBP8ZSSUA//JnMDVO4vFUtVUaVWq5LZvajlR09I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dLw4PllMOjOmV42B3+6etn2D02BQ8+R1RUNvs7lyBVgg/BtryHWtss2ETVQV4RlOH
         XpTssBPaw4HvJkMY6+YGyp9BYwx5LN+eNuxVSYTnsxjfZrIwEn6istGrPfXEnIfgk7
         /ihz4DlAZhM0FygQ5dLBiRmkeBQq2+42Z347SE+ocZac8gFwMvSc5rQ711F9/Ooq67
         /p9OgiEyQr9Eu+fC451qIPNMNqRdY1lwV6IebknpONh3R+HMLN9F2VDllEewPpuxjo
         PqzkD+31tXxPzWp6Ah4lD8wIZlbrkLNSDhPKt+uant0SyoWf3waTtwpD3mqxuA+PnY
         bpPKW0ttrA5zg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: do not use underscore in node name (again)
Date:   Wed, 24 May 2023 21:54:12 -0700
Message-Id: <168499048183.3998961.10701247228162042579.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410175232.22317-1-krzysztof.kozlowski@linaro.org>
References: <20230410175232.22317-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 19:52:32 +0200, Krzysztof Kozlowski wrote:
> Align RPM requests node with DT schema by using hyphen instead of
> underscore.
> 
> 

Applied, thanks!

[1/1] ARM: dts: qcom: msm8974: do not use underscore in node name (again)
      commit: 311bbc884b2edcf584b67d331be85ce43b27586f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
