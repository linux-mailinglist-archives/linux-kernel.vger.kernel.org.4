Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A6F68FEEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBIEbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjBIEb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2ED412F3F;
        Wed,  8 Feb 2023 20:30:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1801B81FF7;
        Thu,  9 Feb 2023 04:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9BDFC4339B;
        Thu,  9 Feb 2023 04:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916482;
        bh=xAxxWdboushZfD1YeIForBDQzKECpGvY48zEQYgQMaU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aAN732DmNQuRyMvjqt0Kl0Ph1whnRiMmzla0hBBlOXL0JSbI5/t9GwrJYcy8Hy3Sb
         rQhpnVOr7Y5I0XZQcYsUc4pvjrwrP01G8YFew6MVrDC/yNDx7Ktrpd3gX4v5hylwhr
         8FjgkcKAUt+l/3h8fuUZTslucYYV1h3g+8rG6jh7EmvgfS9MODkjR/CfekpH5xKcc9
         aziGqnK3FQWrT3nzLYim8Oiec2GynqpZu7eNvRE2OnpFE+RTyyEewJQnv34FgTlrFt
         EICH9+qoOS+d0QDTiN7t3uUsQupfRwNZSh206DYNaTdCslZeU9A5ol1aWzcDI1Jv/p
         CX1ZTIt85XcZQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@linaro.org, agross@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add watchdog node to dtsi
Date:   Wed,  8 Feb 2023 20:22:40 -0800
Message-Id: <167591660365.1230100.7497941182881427076.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119123200.1021735-1-bhupesh.sharma@linaro.org>
References: <20230119123200.1021735-1-bhupesh.sharma@linaro.org>
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

On Thu, 19 Jan 2023 18:02:00 +0530, Bhupesh Sharma wrote:
> Add watchdog node in Qualcomm sm6115 SoC dtsi.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm6115: Add watchdog node to dtsi
      commit: 7b54d92a9c85b1c57b1b977f262b6b0e2497efd2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
