Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B5F6D7305
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjDEEGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236785AbjDEEGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C043A9D;
        Tue,  4 Apr 2023 21:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 220D063AFA;
        Wed,  5 Apr 2023 04:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB4BC4339E;
        Wed,  5 Apr 2023 04:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680667581;
        bh=H8dPNKHUfXWNsgfgFGe3++TjF49fwSPY6O2P4N87Jh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpctuHp1Rc58B3MfeiynXVEbTlW/IKZbDurfBdKeRzO++Kt84393TyDGtfQtFUBZQ
         ghz8CBlS/9dtDzlv7K7P5nL7PeWIJGJxTrI59AISFKJJeHcyYZgjMVCcVeApjva7MH
         QdlcvJWlnGPpKaIOzVO6jGlFeTw1qGEencTIOZgbiZCtr31MUDZhaSa6L4p8oyo+/4
         vqA7ZjYlqevwLxoSF3Y/awlr8wHu8l7b6q6xl9YiWcPP62IedFhab45pvKKOiWTimo
         wLWbMBx1GvcjpkBhPSVyHm9zOPiw71f7eBRJ6eMuv6UO7VcOTNgL0cr8MwyH3gf6H1
         NMejFeWOUIEqQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and registers
Date:   Tue,  4 Apr 2023 21:08:53 -0700
Message-Id: <168066774419.443656.10936856241477839410.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327122948.4323-1-johan+linaro@kernel.org>
References: <20230327122948.4323-1-johan+linaro@kernel.org>
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

On Mon, 27 Mar 2023 14:29:48 +0200, Johan Hovold wrote:
> The pmk8280 PMIC PON peripheral is gen3 and uses two sets of registers;
> hlos and pbs.
> 
> This specifically fixes the following error message during boot when the
> pbs registers are not defined:
> 
> 	PON_PBS address missing, can't read HW debounce time
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and registers
      commit: ad8cd35c58ca3ec5e93f52a0124899627b98efb2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
