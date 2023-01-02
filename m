Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95BD65B2FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236063AbjABN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 08:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjABN6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 08:58:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50ECBD6A;
        Mon,  2 Jan 2023 05:58:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3EEAB80D3D;
        Mon,  2 Jan 2023 13:58:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB838C433EF;
        Mon,  2 Jan 2023 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672667888;
        bh=JIYbF5LXM59r0MW5XyyTv1fzDEtrT9phK9DtFS9rHPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CvbTqQFJYz3KyOeequ7tIHBiktauX4rr8jCsJcWnwXQC/V1oLCQIN80IqiY7SxxWc
         Ru5+9joAKHoJkWslTr6NH//0Nv6LVCa68kicbWXA3fq6YSw0GsF4nxfqGvGx7bVLBw
         IJ79K8yO2cUrtqta+v1/NNY1NvnpZvJX6JMrVSdGdUnWQZ0pudYPGpFa0poQ2t7rky
         sgEBfYL2FXovBaNkVpvoklCWxEpAi9fRK2DSGpzxQPikudbsmmhUhyLzpzppBClR3i
         pNZ2NIYcNFsR91ivAHyMwm1TQLdILEuNXkuz03eutp90N70j4pmrgpVjbtQavyhvWp
         4Q//MzrmvFs8w==
Date:   Mon, 2 Jan 2023 07:58:05 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 2/2] pinctrl: qcom: Add SM8550 pinctrl driver
Message-ID: <20230102135805.vw6bv236soxj5lbs@builder.lan>
References: <20221230194459.2370924-1-abel.vesa@linaro.org>
 <20221230194459.2370924-3-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221230194459.2370924-3-abel.vesa@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 09:44:59PM +0200, Abel Vesa wrote:
> Add pinctrl driver for TLMM block found in SM8550 SoC.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
