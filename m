Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACF0714F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjE2Rtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2Rtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:49:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC226C7;
        Mon, 29 May 2023 10:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57E2A6157D;
        Mon, 29 May 2023 17:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5210C433D2;
        Mon, 29 May 2023 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685382578;
        bh=w6IvOvi08pEaUqTJh5LkFUiOSX8C9pAinrnPh+Qkx/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M35iP0f1ZNqSw9RuP/Qwdpofhhr4ANuwhjhUGCsPjDVavvPGY9TcevIa01mX3Fb0Q
         xRvsBSGd96SbsEdBeVcO0v0mxC2NmuNPwkGyZD6b7ggZW29T99f8ug2Vj6gs2zbs1u
         Ll/D7mGtpgthzi8Kgh2mz0H9Sj4ofamaeNB9w9Td9IbTn87S2eyWSL1s4shEynUpWK
         SO+CrEPcZ8BcfMB+LOwJq2B2s9HEBAjRlNX9ozKs+cdhQTMsf5/cKoBNCtfqY49JeN
         yF9NW3gZt7sTlCz12aaVnvPhfvd9MxP2UeW2feYrneEygPrNf2CCFbSNmwOSUHGWYx
         umiEbMCmWhHtA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-phy@lists.infradead.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, dmitry.baryshkov@linaro.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bhupesh.linux@gmail.com,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v11 0/4] Enable USB SS qmp phy for Qualcomm SM6115 SoC
Date:   Mon, 29 May 2023 10:53:22 -0700
Message-Id: <168538280003.437034.14219843180641577263.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
References: <20230516150511.2346357-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 20:35:07 +0530, Bhupesh Sharma wrote:
> Changes since v10:
> -----------------
> - v10 can be seen here: https://lore.kernel.org/lkml/20230502053534.1240553-4-bhupesh.sharma@linaro.org/
> - Rebased on phy/next, as Vinod was seeing rebasing issues with v9 while
>   applying.
> 
> Changes since v9:
> -----------------
> - v9 can be seen here: https://lore.kernel.org/linux-arm-msm/20230501192432.1220727-1-bhupesh.sharma@linaro.org/
> - Addressed review comments from Dmitry on v9, regarding register size
>   and pcs_misc offset handling. Also collected his R-Bs.
> 
> [...]

Applied, thanks!

[3/4] arm64: dts: qcom: sm6115: Add USB SS qmp phy node
      commit: 9dd5f6dba72928e1f16b259fb1c984f80bfa4120
[4/4] arm64: dts: qcom: qrb4210-rb2: Enable USB node
      commit: eaa53a85748d58c4398c5c9acaa8d01d92adbb67

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
