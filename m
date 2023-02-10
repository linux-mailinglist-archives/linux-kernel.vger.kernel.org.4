Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEA36923C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjBJQzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbjBJQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A907F795E8;
        Fri, 10 Feb 2023 08:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D1913CE2822;
        Fri, 10 Feb 2023 16:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53495C433A4;
        Fri, 10 Feb 2023 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048123;
        bh=HX82XpHSvbyc94VvPhaVw4a9J1mYgtjVAL5Q4yKGinw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EhkVPPtKsr7agUSyd/GyH/Tsj3yy9634Ay+1faVJgy0cDiD3zdrhcfaiwhpyi74q7
         AnT2jcsyhnEHZLy3FkQt1IBO2icc2bg4XiEH5HbItg4JLmGEjHzj7IQQsEZOCk/rTk
         98h78ddszhlDxzJpcMuZ9rBns+N8vbL/1dSKsna0jiNgecymQ9vgV43/nLHT/sZFTv
         o7vGHegpuJMhJlXN7nN+bgGPVXvxDHNsgP+vRiRvi45v+Cu1zanJHVxGp24MBU6wGB
         KbntjVv9Jks529aY0Rrr57I35BWqjuzxQDLE1B0BO9mtnEGTOFlEJgXrv1K0enR00a
         bV+FyDyfx7KrQ==
Date:   Fri, 10 Feb 2023 22:25:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] phy: qcom: qmp-combo: add SM8350 & SM8450 support
 for combo USB3/DP PHY
Message-ID: <Y+Z29g3owbIoZOEf@matsya>
References: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-0-ed849ae6b849@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206-topic-sm8350-upstream-usb-dp-combo-phy-v1-0-ed849ae6b849@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-02-23, 10:58, Neil Armstrong wrote:
> Document compatibles and add missing tables to support the USB3/DP PHY
> on the SM8350/SM8450 SoCs.

Applied, thanks

-- 
~Vinod
