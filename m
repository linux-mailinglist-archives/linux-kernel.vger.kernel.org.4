Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE468FF3B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjBIEeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjBIEdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:33:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5ED49417;
        Wed,  8 Feb 2023 20:32:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 20DB2B81FF6;
        Thu,  9 Feb 2023 04:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A1AC4339B;
        Thu,  9 Feb 2023 04:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916490;
        bh=SvcwKUXdCMnor5NSesw7eh+plus6fbp60MtHNrj9pVY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxNyAsF0ymkHP3d+Wybi3emvOdOViul8vBJUA57n5J8dMX7WlNzznbh8maWIgcxJ1
         LpIibFWk0xOOQ4I0nR+y6AcKorAnozWCznBkNOHVilCvIx0uP2+bMrJ7pQfAwCZISu
         Df/H2VnnMFIiaHOaeRS0VjasFneQDutucHqF6safjtfU2pqGcwO4zrS8WhWdIw0t6T
         PR7/awYX9lbxy0U6zILp24g4I3GhZufV7E1mDQKNWCVsdiqMwwqJuYWQTFKsHlAebh
         VgqJ3L9IJVnzZJd/SEr8+aXuK0tj6lr51pB0KU+UYlKgSJLlIZ91+/g5ryr9JviLTW
         PWtV86l0Abp+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, mka@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Power herobrine's 3.3 eDP/TS rail more properly
Date:   Wed,  8 Feb 2023 20:22:47 -0800
Message-Id: <167591660372.1230100.15246080713327572008.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207163550.1.I5ff72b7746d5fca8f10ea61351bde4150ed1a7f8@changeid>
References: <20230207163550.1.I5ff72b7746d5fca8f10ea61351bde4150ed1a7f8@changeid>
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

On Tue, 7 Feb 2023 16:36:10 -0800, Douglas Anderson wrote:
> This is the equivalent of commit f5b4811e8758 ("arm64: dts: qcom:
> sc7180: Add trogdor eDP/touchscreen regulator off-on-time") and commit
> 23ff866987de ("arm64: dts: qcom: sc7180: Start the trogdor
> eDP/touchscreen regulator on"), but for herobrine instead of trogdor.
> 
> The motivations for herobrine are the same as for trogdor.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc7280: Power herobrine's 3.3 eDP/TS rail more properly
      commit: f069ede81ef438d99e76112d8738c4dc3d1766f9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
