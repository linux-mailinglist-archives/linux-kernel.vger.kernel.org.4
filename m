Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB462658F95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 18:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbiL2RXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 12:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbiL2RXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 12:23:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF4914007;
        Thu, 29 Dec 2022 09:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9F36185D;
        Thu, 29 Dec 2022 17:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FC2C433F2;
        Thu, 29 Dec 2022 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672334625;
        bh=gOUOkR2zo8y+S8Joa+T9Olru8LKRhBzMfjUbTckw5Fk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsEwq5bk0cqVsqxGZ0jBh9y1F9fO7ILZrxtYac5VvWc1c4P8592YQ3//LjCsh/IYG
         qaTx196RprgKc1w2HeHRPkYduZeWsGhNxEJ2uPP1zLrZyD7qga5HYq9pFThC1nwDpg
         d0BQY/66ShnRK9f/2WWll5GTfRGsWhO1YWPaYrV/yVtiCK1k0yp2cGXTjfUa2TDwhq
         Hn8uml52oRulXoz6cgjo8Q/x9ZLa25Ec1wMg+20U9+BpPIOoKkKCpt4z/Ma/jEsWLp
         R6mgiHQiGfxiwsYDgqcbuNNV08Oh3fI6jhFiueYQdIB3646dJ010ssNVHXxDk8O7KW
         VyMLi8QoKkFkA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, elder@linaro.org,
        konrad.dybcio@linaro.org
Cc:     mka@chromium.org, quic_sibis@quicinc.com, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, dianders@chromium.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: qcom: sc7280: only enable IPA for boards with a modem
Date:   Thu, 29 Dec 2022 11:23:24 -0600
Message-Id: <167233461763.1099840.13987684672071387995.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221224002126.1518552-1-elder@linaro.org>
References: <20221224002126.1518552-1-elder@linaro.org>
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

On Fri, 23 Dec 2022 18:21:26 -0600, Alex Elder wrote:
> IPA is only needed on a platform if it includes a modem, and not all
> SC7280 SoC variants do.  The file "sc7280-herobrine-lte-sku.dtsi" is
> used to encapsulate definitions related to Chrome OS SC7280 devices
> where a modem is present, and that's the proper place for the IPA
> node to be enabled.
> 
> Currently IPA is enabled in "sc7280-idp.dtsi", which is included by
> DTS files for Qualcomm reference platforms (all of which include the
> modem).  That also includes "sc7280-herobrine-lte-sku.dtsi", so
> enabling IPA there would make it unnecessary for "sc7280-idp.dtsi"
> to enable it.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: only enable IPA for boards with a modem
      commit: 9472edb3e7ea08ada9d19a9cfc1bee7de6edee75

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
