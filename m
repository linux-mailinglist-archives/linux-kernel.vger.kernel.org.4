Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB836C4E46
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjCVOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCVOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B6D64B27;
        Wed, 22 Mar 2023 07:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4466CE1DC9;
        Wed, 22 Mar 2023 14:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148AAC4339B;
        Wed, 22 Mar 2023 14:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496148;
        bh=xEyKZaa1+RXFhK2lv1wKEyVPh8wrA5Ghs6WICLxgLV0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OY3q2++VOzzMH6fqxfOsljPG6l24QjRnR+9K8/S82zW08s/JAhM3aPbJFXU6uV2hf
         huK2Nk6a0PSFE4cj9j4GWXhti50cSa7zHrpesi3mr1vgsRo14y7lo1VPWhv2WfIisS
         I55nklUs0bqiWu2aaPCzQqV51sOKJbPeAeMlmx0a78N9dr/e0yxaUomftRNFMeQUq6
         +RJrPlS1bgd58ehFfVCuJP1YchvK01AylBSENvV+g2D70hg1yvUYj6g42lvCtEZ5JK
         WuLtpI+tFKABHJGB338MHO4ELGsRP6sFZfC+Xukep/2qxMm1mUb+ecWVV2NCC6PP3s
         5t7r362NXxv+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: (subset) [PATCH v5 00/12] soc: qcom: add UCSI function to PMIC GLINK
Date:   Wed, 22 Mar 2023 07:45:20 -0700
Message-Id: <167949631651.1081726.4846765935793443746.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 14:21:40 +0100, Neil Armstrong wrote:
> The PMIC GLINK interface offers an UCSI endpoint for newer
> SoCs, the UCSI exchange is necessary to configure the USB-C
> port USB role and altmode on the SM8450 HDK and SM8550 MTP
> boards.
> Since the DT description is the same, support for SM8350 HDK
> is also added.
> 
> [...]

Applied, thanks!

[12/12] arm64: defconfig: add PMIC GLINK modules
        commit: 4ffd0b0019560a52b46b9ebd8127be3fdc157f16

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
