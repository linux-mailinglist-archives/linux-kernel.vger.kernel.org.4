Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EBA72EF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240930AbjFMW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbjFMW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F471FD5;
        Tue, 13 Jun 2023 15:27:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4557363624;
        Tue, 13 Jun 2023 22:27:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB3AC43397;
        Tue, 13 Jun 2023 22:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695247;
        bh=0I7xurv8Bj2LJd47mP9rsrc9D4xgFqrgQVowLUP65xI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LK3dThaJvVnArVSxd/SU3JIw/dcrmlCMlU1aNTq+5izujmjGn6KW6HI+/DACew3zS
         hwwhpEAVayjlMDowYYj8PuZZNpeaABdsRT8J0Cnpv1oacI3bE2J4fyRmQHX9vMA8+N
         fUZXsa3dwWiIy9rT224x59JWYSi0XC4tCcFIcd1Ufy1EXfgtZOwWlbLfWsaUXMv/59
         blIwjlH4JShzEysj+NuasIXQgjYyQ0muEooP7ihX5iTAeMXZ3B8h0IS4/ETkGiEPNT
         tj5Acg1cRxg0BTbITMOfV1XGz8FkgtIUAPduVrDcRJ7OfJh6jxPY9MvVXA6WYhWOKL
         YhQS+KtqnX8+g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x: Fix adreno smmu compatible
Date:   Tue, 13 Jun 2023 15:30:23 -0700
Message-Id: <168669542893.1315701.7297495942709983113.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612220532.1884860-1-quic_bjorande@quicinc.com>
References: <20230612220532.1884860-1-quic_bjorande@quicinc.com>
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

On Mon, 12 Jun 2023 15:05:32 -0700, Bjorn Andersson wrote:
> The adreno smmu should be compatible with qcom,adreno-smmu as well for
> per-process page tables to work.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x: Fix adreno smmu compatible
      commit: e537d5ef47097360d8df524c748f3df451383dcd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
