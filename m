Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC46BC10E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjCOXce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbjCOXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E14F77E19;
        Wed, 15 Mar 2023 16:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689DC61EAB;
        Wed, 15 Mar 2023 23:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0E6C433A4;
        Wed, 15 Mar 2023 23:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923136;
        bh=TNUDe5tDBfb5XrsZzqQsmMn7uFLbYPz9x0b4oR5fy+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDaYEQak0kLt/7yxYEIb1FEA6w6/MjLUUA2N4mcQR2UFvwsSUVcp657FFNDj9XCQt
         YOVnYOBuU6zXpZ261aC/1ELBGTmkYuyYO014ai58uApzo7c7PcvXZ3tUjIt99CxAZl
         a6cvSXzdt3zhWgrRbWU4+LScAsBPQhiu7DrPabOStjMULucHVaInzjLdfuV3eVWem5
         kJrg4sv9Ua1xM0YK4ExgRQhNOac/bhw873CQVNefsNDQv1FVZQbcgqU1VMRaToS0Rq
         9qgPoBioD1HYOzbjgl9u7Ezc0BQbjwH7w3vS/oygR6/6QNKgi/XioZuK79ZVQa6f1J
         TnduOq1slowng==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm: qcom: sa8775p: add socinfo support
Date:   Wed, 15 Mar 2023 16:34:46 -0700
Message-Id: <167892332564.4030021.16091580585019672531.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230209095753.447347-1-brgl@bgdev.pl>
References: <20230209095753.447347-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 10:57:50 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This series adds support for qcom-socinfo for SA8775P SoCs.
> 
> v1 -> v2:
> - fix ordering of socinfo defines
> - fix the commit subject line for patch 2/3
> - collect the Ack from Krzysztof
> 
> [...]

Applied, thanks!

[1/3] soc: qcom: smem: update max processor count
      commit: b302c64a3c0a005f39155e9aef5e99ad8a9abbb7
[2/3] dt-bindings: arm: qcom: add the SoC ID for SA8775P
      commit: 26a4bf805c6cd88847dd045f6b29d8a20f02d8df
[3/3] soc: qcom: socinfo: add support for SA8775P
      commit: 7fa9c5fc1a753ac593904ebe9c4e8628a4240096

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
