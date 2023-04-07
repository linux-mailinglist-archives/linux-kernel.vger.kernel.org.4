Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF156DB3CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjDGS5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjDGS5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:57:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395D1E058;
        Fri,  7 Apr 2023 11:55:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A43C764BFE;
        Fri,  7 Apr 2023 18:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E3CAC433A7;
        Fri,  7 Apr 2023 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893689;
        bh=nnY1JySVNfwsNMHgDfNwRks8DH82dQ3ZmDN9Q/Kir60=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=erlhf1MjnFAVyFJORGzDg2Gttt9xZEihxj8sIzLAfl+3Rcw7QyXeVeli2lyuyjS8F
         W7ePqMTlnUOqG8sa5pvTv3HB3Fxh91yqi/O2gq4jHprRFksYxgQDEl8LI/1AqICfuJ
         MvFw50ws6vFH85BNKvoEM7kNk8sBPAHcTQOSEIumbc00ttWz116hB6bv7cbwLeFtdR
         7qukMjM6qkZqAl0QVbUjj3Jhkai8aEd54wsOYzK9do10bC2c+WvRawy8hfOkNjo2sS
         tDYwEuWh5Rfy27g4hoZxESAk950LoggxH4STmzQSU21IV9zaboW4dBULSSQUj2rGaU
         Q2SVs8Fo2extQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin drive-strength
Date:   Fri,  7 Apr 2023 11:57:36 -0700
Message-Id: <168089385286.2679377.420207984754249816.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
References: <20230407180710.128815-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 20:07:10 +0200, Krzysztof Kozlowski wrote:
> Fix typo in drive-strength property name.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-lenovo-thinkpad: correct pin drive-strength
      commit: 47ce7e168486de0a581f5903e72ba2cbc68123ec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
