Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B2B6C8501
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjCXSbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjCXSb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE07DB2;
        Fri, 24 Mar 2023 11:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA2AD62C3A;
        Fri, 24 Mar 2023 18:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE88C433A4;
        Fri, 24 Mar 2023 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682687;
        bh=Ic1B6wQV50JDPwY+CApZcmUliG9wEFrvB2GpvMvl5ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYbopYt1qLkhjKlzqjqRakmsJfzu/fSRbHhQ2x0nfcQ794Vu+nxR7wk+Wb/FuiHtB
         OU1z1eLWKWtzrgF8VDcqSZ3yZmcmF93omiemGLwM1Th+nW/Yso23m2xOEjf/Y/LH/D
         YmD8GTkHITAHDBMzl7bJDaCaZU6K+XNRBuREviOHcOvCctj+uEtDN8DQEZ3mLmx2aC
         EOhZiBS2nXlSiRls61c0X32hBha4yE9Fa8Dm53lvPqC1i77VN4SNdKcgBAIZR0ZqeA
         BYLXjJn0c6SQIPcp67BBlAYOONVAeRzeEGH80sDX6mi3CQ1TwsFByM6y9J8eusxkFN
         2UXsR2so7siWA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: enable alternate touchpad
Date:   Fri, 24 Mar 2023 11:34:27 -0700
Message-Id: <167968287204.2233401.15960719073719503318.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324094744.20448-1-johan+linaro@kernel.org>
References: <20230324094744.20448-1-johan+linaro@kernel.org>
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

On Fri, 24 Mar 2023 10:47:44 +0100, Johan Hovold wrote:
> Enable both touchpad nodes in the devictree and let the HID driver
> determine which one is actually populated (by attempting to read from
> each i2c address).
> 
> Ideally this would not be needed and the boot firmware should instead
> enable only the node for the populated touchpad, but this is unlikely to
> ever be realised for the X13s.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: enable alternate touchpad
      commit: 4367d763698c5c7c2c0e540f0508e48b337c7d8a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
