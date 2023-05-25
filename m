Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8876C710449
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbjEYEvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbjEYEvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19F3C5;
        Wed, 24 May 2023 21:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54F1A64210;
        Thu, 25 May 2023 04:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6EFCC4339B;
        Thu, 25 May 2023 04:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990261;
        bh=61dA08YcWQ2Zr8gjtWTfdh2kgWGFOXGSFfJSI0MLtu8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruq3yniJtqJF8sxdhgEWwx8xr8Uvl+pVjPsPdl51hRrf9VhqRCYyd8/M/5qs+gBAi
         XJ2Yk9eRXFIBfz5O0PJs+vWO3fwsXsozPgKPZShrheoIN3G2QeA7uDMveZsB7HTU4E
         FcEH0mEnaO+xPuEGzIsls6LLJDazE0UJqi/CaRoLB9AHBlDDyxzwZ49p9LiW+IOrbG
         ohSXDNZ3QAIVCGQiqDfgJZK+hY7eLHGLl9eFWNHfQVL7W/eXvQQC2Z1KIxRZ5VATyq
         8nHHA3gmuvwqPzGuYhR+50QE+eQfAKHbWZ0lYxGf5X0KoQrBFawWrQRA2fZ9CVEPkX
         nXKfBwTjwuI4w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        agross@kernel.org, bhupesh.linux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org
Subject: Re: (subset) [PATCH v2 0/2] Qualcomm EUD: Some cleanups
Date:   Wed, 24 May 2023 21:53:41 -0700
Message-Id: <168499048182.3998961.9143202984086549422.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230502093959.1258889-1-bhupesh.sharma@linaro.org>
References: <20230502093959.1258889-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 15:09:57 +0530, Bhupesh Sharma wrote:
> Changes since v1:
> ----------------
> - v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20230104091922.3959602-2-bhupesh.sharma@linaro.org/
> - Changed the commit log for [PATCH 2/2] as per Rob's observation.
> 
> This patchset targets some cleanups for the EUD dt nodes present
> in sc7280.dtsi and also adds a missing space in the compatible string
> in the example used in eud dt-binding document.
> 
> [...]

Applied, thanks!

[2/2] dt-bindings: soc: qcom: eud: Fix compatible string in the example
      commit: 6ade5ce20c466298c04b10fe66091b9055aa9988

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
