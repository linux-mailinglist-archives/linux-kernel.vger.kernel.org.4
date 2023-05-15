Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8245B70227C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbjEODdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjEODdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:33:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DFD1BD7;
        Sun, 14 May 2023 20:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 885BB61E46;
        Mon, 15 May 2023 03:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF83C4339C;
        Mon, 15 May 2023 03:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121366;
        bh=Vc48zhXdXW2DwPisW5JMemJ+aJ34aLl88B7TdtDzoSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ji5bDr5iiqDK9556h8HVRaqWc4++TqzzUz89psbfiNnHp6KzhsRmtWun1pgpBVBuX
         H+yBdSYOGwByL0kuTVC7zx5EiR72csbr/Pviz0aZb+emlSkFgm5g561PgOahuO4T2s
         Atq/oOahmoU5J/QkLRzTUhSd47wbZ8h0ciDZEDXuLg0CCDREVo0vw946bdW2htAOdG
         l0dpHNY3WxeD9E2Lm6AtCQndBBvakr5W88Gcp57j0wKE+vJmmcQIS7lO54WvifjUdT
         9sf5BdI66Bu+g+ucUGHT+3ITkn1qGwJ8QDelaQnE6BJ1cKDzPr0XT97iKYRr6dfjF3
         tnIrbah9XTlcQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Revert "arm64: dts: qcom: sc8280xp: remove superfluous "input-enable""
Date:   Sun, 14 May 2023 20:33:04 -0700
Message-Id: <168412158456.1260758.15280942821090239789.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411170938.1657387-1-krzysztof.kozlowski@linaro.org>
References: <20230411170938.1657387-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 11 Apr 2023 19:09:38 +0200, Krzysztof Kozlowski wrote:
> This reverts commit 87e1f7b1a041a37390bf4fa7913683fb4f8d00d8 because it
> removed input-enable from the LPASS TLMM, where it is still correct
> (both bindings and Linux driver parse it).
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: Revert "arm64: dts: qcom: sc8280xp: remove superfluous "input-enable""
      commit: 2d80b1e649dd74f5226484e244e57990348a9f18

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
