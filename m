Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8596AD613
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjCGERN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjCGERF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:17:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7B57083;
        Mon,  6 Mar 2023 20:17:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF8B8B81609;
        Tue,  7 Mar 2023 04:17:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2991C4339E;
        Tue,  7 Mar 2023 04:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678162622;
        bh=Sn9Fwdys/0HKyOFUbPeNygLcO0x6bn5TArBJ/SpDRl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xm3yZnKCw1/JggZ3iez1UUCvo7862wYavD2hDU7QWbLEtq3ja1iGPVOl/b0LK0Rxg
         ljH2RseoELQgnPFPHfauLiSgwNnCneL7A+xEpr7TG4O4OhYtINtEMTcsV43YDscBsj
         tXPBDnG/dNJu60L2AUj5dmnNrclAphv3BTqbFFCxWJVqscE5+g5yog64wlLSEQzx4K
         wPp6aODRnhaSjpNJJT//n4Wma7HvMTyuMJi2cwddRcvdqFKp/RqM5uaKzX+PA53Uef
         +FthjoaZ+N0S0kZpTqH85cvW1bae/ToCykh3gL0gWNgI1N7dmhDWopK3sKr/pmIUPt
         gnnIuk7NYUomA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/2] pinctrl: qcom: Add support for i2c specific pull feature
Date:   Mon,  6 Mar 2023 20:20:25 -0800
Message-Id: <167816282863.1458033.10775571193377113905.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230209074510.4153294-1-abel.vesa@linaro.org>
References: <20230209074510.4153294-1-abel.vesa@linaro.org>
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

On Thu, 9 Feb 2023 09:45:09 +0200, Abel Vesa wrote:
> Add support for the new i2c_pull property introduced for SM8550 setting
> a I2C specific pull mode on I2C able pins. Add the bit to the SM8550
> specific driver while at it.
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: sm8550: Add bias pull up value to tlmm i2c data clk states
      commit: 4059297ed0a5adf8e5fd0bd734d702a24202c02e

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
