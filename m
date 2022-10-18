Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0E60227D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiJRDV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiJRDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:20:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DFA915CE;
        Mon, 17 Oct 2022 20:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3756B81C6E;
        Tue, 18 Oct 2022 03:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F29C433B5;
        Tue, 18 Oct 2022 03:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062927;
        bh=gmVqkIBnM4f+SlQUPqTQ+cEonSxrk3fmIHCPam3y7ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qWtHSOG7BWu5Ux/2oBy03n0fIf/3IyFEu5oTXPm8uTQyv9mcin+N9iZUSBWblPRh9
         RCSSkvy6cF65LdPSAcqDwubq1RbRWjU4uCIDFG0Z65c5SW9v1vPQP4E8yg6N/keGjX
         otBcG6+YDNNHJXhEMK0Apg+vkMT5c4XeeLj/SdXjJCt2AeaB96n6Y65jOJubSCWsah
         B7HDYrtVBGaj1eT4CoceoFH9TXPrHBSEAa9ETlK37kj6lQoWn0eSGraY6tTz89yfjI
         w39E0XCvJqARBaq542H8j9cDIWzxbuJOyKsuJM12BL2tCO8QVSS8P5j/tGXT5hpCSO
         SJtyxr7noCedw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        yunlong.jia@ecs.corp-partner.google.com
Cc:     henrysun@google.com, devicetree@vger.kernel.org,
        moragues@chromium.org, agross@kernel.org,
        Douglas Anderson <dianders@chromium.org>, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
Date:   Mon, 17 Oct 2022 22:15:21 -0500
Message-Id: <166606235849.3553294.10700447109437637515.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
References: <20220901024827.v3.1.I3aa360986c0e7377ea5e96c116f014ff1ab8c968@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Sep 2022 02:49:57 +0000, Yunlong Jia wrote:
> pazquel360 is an extension project based on pazquel.
> We create 3 sku on pazquel360:
>    sku 20 for LTE with physical SIM _and_ eSIM and WiFi
>    sku 21 for WiFi only
>    sku 22 for LTE with only a physical SIM
>  Both sku20 and sku22 are LTE SKUs.
>  One has the eSIM stuffed and one doesn't.
>  There is a single shared device tree for the two.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Document additional skus for sc7180 pazquel360
      commit: 185d192d0a7b565a24b3f7456a2f84f169ab087a
[2/2] arm64: dts: qcom: Add sc7180-pazquel360
      commit: 2f72a4f54cdb4fd0ebea9a2dea65756d3e676be2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
