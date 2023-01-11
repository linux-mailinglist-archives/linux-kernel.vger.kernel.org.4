Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D0C666416
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbjAKTtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjAKTta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:49:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A7AE7D;
        Wed, 11 Jan 2023 11:49:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37326B81C86;
        Wed, 11 Jan 2023 19:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C481C433A0;
        Wed, 11 Jan 2023 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466551;
        bh=91K86jMR74XFjlOTWYqVQEk6SBUHrOrxeBqlSPDcs0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oexwSTKMzxJm/Pdjs5X1PJbI17TrC9WZlJSjVB4JHAV3meuJXkNwdqM/TQImVylcV
         mEz6RZDtfNT5p2yTtNGRmp1Kb8bHXz8qmvzOHywI7FFz9Uh/BqeYOj13BNO4UPba4i
         33aiau89AMkfGnoLZT5pFoODJDvIzSShF0nf727EIOmj2XpfhdKk/gPJyAJ4BGNm02
         9k5dMrwhmehQ/Pgsj6SiWBmZgw2OYPP0pV9qx6gYp7avSw+/y4S8JMGKvVmTfCeJpy
         xe3SYAzF6FENaJA6EY101/AOIfhKhz0GaLzYAOUgbkOBZXdxjWfBOJV3y0bDuGJRME
         OY3pwyW24Eryw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, agross@kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable eDP display
Date:   Wed, 11 Jan 2023 13:49:01 -0600
Message-Id: <167346654436.2315924.16376410859709572076.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230111133128.31813-1-johan+linaro@kernel.org>
References: <20230111133128.31813-1-johan+linaro@kernel.org>
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

On Wed, 11 Jan 2023 14:31:28 +0100, Johan Hovold wrote:
> Enable the eDP display on MDSS0 DP3, including backlight control.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: enable eDP display
      commit: f48c70b111b4faaf57dc65055df86f95487ccb88

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
