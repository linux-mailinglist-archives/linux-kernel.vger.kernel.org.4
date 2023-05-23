Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C6770E5AB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbjEWTgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWTg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:36:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427591BD;
        Tue, 23 May 2023 12:36:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB330635E2;
        Tue, 23 May 2023 19:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3D8C433EF;
        Tue, 23 May 2023 19:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870574;
        bh=byeLrJ5QqBdhPYvwjWOCFyw8OwXSqWI7cTainSrSzzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XRmZe1CebK6G/YM94sfP6ZEx0RrLtpoJDVQbXGqzfqmp0VuTCpC/A2qZ9EsMVHV6O
         E6/ZRIehMResdpQJ/N3EqagIfTbhYWMMjpUC/K9/osWozVV0+p77od5eZdWT0vguJY
         ql9bOlBP5LCegnzrY5ixsojXdT/1jRH+PqdgNhCokR1bwO+Ok/tcFeiCo9gu2HwA0o
         rVUrPzco7lRYaiY7v9lCRZkOExg7lAKhrhzLp8xBYjiCvxKCXk9gdG0aUn7U+pug1E
         ZsyrP+CPF7vFgOBVE7KsnuvdOOhd3LmvkFHG6qkWwXSIbKNWrgjV/veFUXnuyPBS63
         0kcKNBmHzoMqA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, konrad.dybcio@linaro.org,
        devicetree@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: QRB4210-RB2 board: Enable more peripherals
Date:   Tue, 23 May 2023 12:40:03 -0700
Message-Id: <168487080174.3522253.4844936486806688277.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516075908.2323372-1-bhupesh.sharma@linaro.org>
References: <20230516075908.2323372-1-bhupesh.sharma@linaro.org>
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

On Tue, 16 May 2023 13:29:05 +0530, Bhupesh Sharma wrote:
> Changes since v3:
> -----------------
> - v3 can be seen here: https://lore.kernel.org/lkml/20230505075354.1634547-1-bhupesh.sharma@linaro.org/
> - Use explicit qrb4210 .mbn files instead of qrb4210-rb2 .mbn ones.
> - Collected R-Bs from Dmitry.
> 
> Changes since v2:
> -----------------
> - v2 can be seen here: https://lore.kernel.org/linux-arm-msm/20230501105832.1185477-1-bhupesh.sharma@linaro.org/
> - Use explicit qrb4210-rb2 .mbn files instead of sm6115 .mdt ones.
> - Collected Acks and R-Bs from Konrad and Krzysztof.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: qrb4210-rb2: Add SD pinctrl states
      commit: 10254fb73fdadec81e47a776e149863a13030291
[2/3] arm64: dts: qcom: qrb4210-rb2: Fix CD gpio for SDHC2
      commit: 14e6c47b628788a8c8634bc59b2dd50d68a74de3
[3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and cDSP remoteproc nodes
      commit: 50931b44dc751784cdc5721bf30a79093c2c9fe9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
