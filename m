Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D644A68FE9C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjBIEZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjBIEZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:25:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D70B728E;
        Wed,  8 Feb 2023 20:24:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A99361880;
        Thu,  9 Feb 2023 04:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A9BC433A1;
        Thu,  9 Feb 2023 04:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916500;
        bh=z6M8gPuBX2Ocf8EclTxwjKW8aTiWUmHLv1hZSQT3iXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQxY8IjdnKXT6FMmuccx8bmMKFf7BxCv8ehHPih5SrGvTfKMWrz4qLBY9fh4/Z+gP
         xGpDsIyQGYSGCu+KWssA58ck2eq74rZHS6ZFGnQ++XmDv0vnJZ3/hLSUkYDoVwf3hM
         WgU2OKvUjaGqUBZW82qGZkypwkup/DWzr0wwApCNDTBKu3v8BdDeUTgwmPENwMxUiD
         346DHe0axAvDsOXwaQ/IPvqpQ8Bv3grDvgtH1vdUppJSGfjSb+GqbuG1ualO8Y3HgZ
         JZ7lJwQJ6bcmnXUrgOfKCKxhPw/oJWn9M3uJN2ocYy7L5IpD+pW+E2vBJ2+rBy/anz
         uTpQ4C3q7UMtQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Abel Vesa <abel.vesa@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8550: fix USB-DP PHY resets
Date:   Wed,  8 Feb 2023 20:22:56 -0800
Message-Id: <167591660366.1230100.8595987413832313805.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230123101607.2413-1-johan+linaro@kernel.org>
References: <20230123101607.2413-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 11:16:07 +0100, Johan Hovold wrote:
> The USB-DP PHY resets have been switched.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8550: fix USB-DP PHY resets
      commit: cd649ac4059bd7221e5a1c1370db749c1c9d82f8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
