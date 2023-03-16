Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE26BC45D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjCPDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCPDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DE78DCC1;
        Wed, 15 Mar 2023 20:17:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 881CD61EF7;
        Thu, 16 Mar 2023 03:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2A3C433D2;
        Thu, 16 Mar 2023 03:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936668;
        bh=QySpbD5EqGiz/4gwPyeC6DpOLd0Z9FJwDrHk/S8HLqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f7PPx9wR+wGxTPnl5TVc201/TW/lXJXklxuKYqGO765VA98+P6ZB8w/QsBCI241hT
         9AmUzezc5pgJF7j86QEUBqaMD2eW7mA101Efvp2zC8QLJCa5kPjO0UO9Ul2clcKXvn
         3SOYzCW6AgQ3ga8ehczWFaosYvY6VFMdFWchl5HRMt0ukc22xcKNkrVIw/S9NHdhGN
         goZr/MfVgQ1LIFC2XCIJp94v8AEO3jZfDVYGT7T2Yy06fDDp+dctpMDbL9UhtVx9iE
         eciMube4WCwFsNGeX+JnyMRYOsKWmOM6sV+3jdoBpDvqul2A5XgJqpdA5sCgj1c2O5
         QqbOS2J3hqosw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        swboyd@chromium.org
Subject: Re: [PATCH v2 0/4] arm64: dts: qcom: sc7180: Delete a few unused trogdor dts files
Date:   Wed, 15 Mar 2023 20:20:52 -0700
Message-Id: <167893686410.303819.14030526545585715318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230302211108.2129598-1-dianders@chromium.org>
References: <20230302211108.2129598-1-dianders@chromium.org>
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

On Thu, 2 Mar 2023 13:11:03 -0800, Douglas Anderson wrote:
> In general on ChromeOS we try hard not to throw away perfectly good
> hardware, even if it has a few quirks. Many people keep early versions
> of boards around indefinitely and keep using them for testing /
> development if the feature they're working on doesn't need the latest
> and greatest. This is the reason why there are so many sc7180-trogdor
> device tree files.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sc7180: Delete wormdingler-rev0
      commit: 62d882e62fe91ebdf4acbb8444bb3cf78a958aef
[2/4] arm64: dts: qcom: sc7180: Delete kingoftown-rev0
      commit: 5fe8b1c88d7b3a227d96f277cd0d36a76aff0273
[3/4] arm64: dts: qcom: sc7180: Delete lazor-rev0
      commit: c0d1296512102a216f9ce10238a9f79c0ac22ccf
[4/4] arm64: dts: qcom: sc7180: Delete mrbland
      commit: b82c362b4d27f439f9ba753e74e0e7a364263f3a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
