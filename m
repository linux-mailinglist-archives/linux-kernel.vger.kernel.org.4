Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DF46BC0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjCOXcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCOXcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C35923A6C;
        Wed, 15 Mar 2023 16:32:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FC5C61EAA;
        Wed, 15 Mar 2023 23:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA8AC433D2;
        Wed, 15 Mar 2023 23:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923128;
        bh=FEmtlcIqqS89abT0ssoEBTavV/1rty8NOhTw/nMtYX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgz6l6/MxdMd4DqHkEWJBJMf7ada+yO0vtLuy22PcKklMd82Ka6ixwwEGqJX1gugR
         nE21JSPVDDpAXp9CWsJkRBngGVIbfuNzm8ucDtDVOAWvsAOBvqzT+i7Hu9qLJ9hQIA
         mtLPc8bWd86yo1gmX0OGw8MAWeWfvSzDrk2dSbLG8h7GEhTYeaY/H1LC8NSurFm3vJ
         fCWYyq9MZbEXBh/+DZhKrctiiuEai4kUwBval2xzyzTUrz3OsEXNs/Gwqg8NCWksof
         InRGbzzv0o0lqT8VQytv22imatSjsJ6wjx72ZB2xnULWiAyz5RywrGesIX/Q1mAPME
         jUpq4mHf1yphw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        vkoul@kernel.org, Rob Herring <robh@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: (subset) [PATCH v5 0/7] sm8550: Add support for eUSB2 repeater
Date:   Wed, 15 Mar 2023 16:34:38 -0700
Message-Id: <167892332564.4030021.4228411970991027965.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230208190200.2966723-1-abel.vesa@linaro.org>
References: <20230208190200.2966723-1-abel.vesa@linaro.org>
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

On Wed, 8 Feb 2023 21:01:53 +0200, Abel Vesa wrote:
> This patchset adds support for the eUSB2 repeater found in pmic PM8550B,
> used along with SM8550. Since there is no dedicated generic framework
> for eUSB2 repeaters, the most appropriate subsystem to model it is the
> generic phy. This patchset also adds support for such repeater to the
> eUSB2 PHY found in SM8550. Basically, the eUSB2 PHY will have its own
> "phy" which is actually a repeater.
> 
> [...]

Applied, thanks!

[6/7] arm64: dts: qcom: pm8550b: Add eUSB2 repeater node
      commit: fdaa922585f4474c88fbfaa129f8114f38200660
[7/7] arm64: dts: qcom: sm8550-mtp: Add eUSB2 repeater node
      commit: 749078e38e1ee28357e8fdcd4eac382a465bd1e7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
