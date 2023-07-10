Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BA74CB81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjGJFEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjGJFES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DD8CE;
        Sun,  9 Jul 2023 22:04:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD31260DE4;
        Mon, 10 Jul 2023 05:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9DBC433C8;
        Mon, 10 Jul 2023 05:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688965457;
        bh=p8YNjR5FTTbYpldel0JyzfCWG3L7Lf5CN238TGr/nxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJTx68/Zxf/bU3IANW7O+cWZUDIolnUEvYVYDSDs3yx+XAgGWvbWn8nQBOCdKOpJK
         rl/AmC5DvIy/PM1OJmYgvWR0datPINSx0nNZZIJcg1g0+GpbPWxR2YHp+MQjgmfgvx
         7FdiMG9tI3o/vz/cf0bdEDfqGo/NodVPiK8qyRuNyPwzJtxDzGVkZRtmxLHE6eM4iX
         skG6awDb1RF/wlU5DkOAfWIPVQVkWTVxPCZ4spZcaMGWVZEavHJabuZe1x/QUnWbgL
         zrroN06K8Bc1/jTNPmc4j36bYxjEEcRB+ibdWQjdBIj7OoE1MkcnNOjLKVnSTZaTZ+
         GFDAc5/7bs0YQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/5] arm64: dts: qcom: enable ethernet on sa8775p-ride
Date:   Sun,  9 Jul 2023 22:07:00 -0700
Message-ID: <168896565968.1376307.18127304044280221873.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230622120142.218055-1-brgl@bgdev.pl>
References: <20230622120142.218055-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 22 Jun 2023 14:01:37 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Bjorn,
> 
> Now that all other bits and pieces are in next, I'm resending the reviewed
> DTS patches for pick up. This enables one of the 1Gb ethernet ports on
> sa8775p-ride.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: qcom: sa8775p: add the SGMII PHY node
      commit: 683ef77158cbb56ede2a524751b150cec340128a
[2/5] arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
      commit: ff499a0fbb2352bff15d75c13afe46decf90d7eb
[3/5] arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
      commit: 5ef26fb8b3ed72cc5beb6461c258127e3a388247
[4/5] arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
      commit: 48c99529998026e21a78f84261d24c0b93c1027e
[5/5] arm64: dts: qcom: sa8775p-ride: enable ethernet0
      commit: 120ab6c06f69b39e54c949542fa85fd49ff51278

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
