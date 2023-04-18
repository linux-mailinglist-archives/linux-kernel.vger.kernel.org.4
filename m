Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7CA6E694D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjDRQVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjDRQVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:21:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD06B773;
        Tue, 18 Apr 2023 09:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16BB46366C;
        Tue, 18 Apr 2023 16:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299E4C433EF;
        Tue, 18 Apr 2023 16:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681834896;
        bh=0yAsboJRhuuNcS/z/N+pA0vFKY7x/4YDMsb7MJU+SG0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=Y0WbHURiNPne3Tmv/6+qjvK+kRFeR5BkLjL38B7xiVdEUtG6fwvVafx6CNPLDPS06
         t7pePersbWXzMF+lgS61O0K7eLvJncdCYa3pfjUquffFQ5+MgX+2MeWWSeqMC4iKOo
         hE12LvmMLpMvMt7zOTpOOHpE5XMPGnFO2h/8+k9O+OZu5v5RxyogDaPsFjTWZQkWWd
         X/Kyv0T9oJ9ZizmfM5V64htLaNkp8GSRdUNZoQDOppwpn1ovFIcmaucbZXheyF+gAk
         FdZ1lSm1Zbi61vudeBmKQbWlFGFQMPbCBhCvc+XvxGj5STp87EtBkb+0ECUqaSOyFj
         1pQoB/WQVNB9Q==
From:   Mark Brown <broonie@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Rob Herring <robh@kernel.org>
In-Reply-To: <20230418071734.5706-1-krzysztof.kozlowski@linaro.org>
References: <20230418071734.5706-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [RESEND PATCH 1/2] regulator: dt-bindings: qcom,rpmh:
 Correct PM8550 family supplies
Message-Id: <168183489386.88061.8852651683552439984.b4-ty@kernel.org>
Date:   Tue, 18 Apr 2023 17:21:33 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023 09:17:33 +0200, Krzysztof Kozlowski wrote:
> PM8550 is different than PM8550VE/VS, because the latter has much
> smaller amount of supplies (l1-3 and s1-6) and regulators.  The PM8550
> has on the other hand one pin for vdd-l1-l4-l10 supplies.  Correct the
> if:then: clause with their supplies.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[2/2] regulator: dt-bindings: qcom,rpmh: Combine PM6150L and PM8150L if-then
      commit: ed479907ff79007548c3bd1aed387f8cf0a62065

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

