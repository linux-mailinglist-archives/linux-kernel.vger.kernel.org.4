Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D842172EF61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbjFMW2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240330AbjFMW1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97951BD3;
        Tue, 13 Jun 2023 15:27:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1EE5D63BA3;
        Tue, 13 Jun 2023 22:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DF8C433C8;
        Tue, 13 Jun 2023 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695249;
        bh=j4hUbMII4yGJoQdHnLq4/WHu40T0DGhs9v46PXPDFwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9n7F/gWprSaxLBaE1ZlVOG7xTgw6nIz46bKNtpa7hvyJjiP0s5XhiPPq+ISzd9pW
         vbI54tx0+XG6r+RV474ZEMD1w4qmLzDLmISsQ6WJag4dcbglDgC6Q3yApX/FYyyk6a
         RCsYAVOoNM9sbJkGXypJVjcUNl5EAmgH8fvI0P/KPjPd89DuBpdEO8cwJblAD2WUpS
         YUHkxCkufQmXjfy5x3OZxOiyA4CN8g/hog1yyS9TFpIdp2TOYwYlVnrgAhZ8KmP8gO
         DPFJNZjw/kfAHAj3vDDg0+BORjuLzpCdKU3fjtz3fcwn1D3emFza7PCqEQ0MCfDXU3
         Jorfw1aBn4SFw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8180x-primus: dispcc is already okay
Date:   Tue, 13 Jun 2023 15:30:25 -0700
Message-Id: <168669542893.1315701.16624254320123903741.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612220420.1884631-1-quic_bjorande@quicinc.com>
References: <20230612220420.1884631-1-quic_bjorande@quicinc.com>
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

On Mon, 12 Jun 2023 15:04:20 -0700, Bjorn Andersson wrote:
> &dispcc status was changed to okay by default in the platform, no need
> to do it again in the board.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8180x-primus: dispcc is already okay
      commit: a277430b3836cdfb994f45cc87d1bd56c4d490aa

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
