Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9836C851C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 19:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCXSbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 14:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjCXSbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 14:31:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD86168B3;
        Fri, 24 Mar 2023 11:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1709FCE263D;
        Fri, 24 Mar 2023 18:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B690DC433A7;
        Fri, 24 Mar 2023 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679682691;
        bh=dTpWa0RnPkTRBd+52SgXg/KPgO6VcmO+Yz/ilIyORYE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tSLbNT6ljI/LrlHfb5Rc1t50O0r4U9IdznGj7kvE3ek8yFUyrfZUYDnn9KI1+fzDL
         lDwrzdzW/T+C5i3DtiPvmruaN3ZlxGySxzLT18cmBXIv37X/3LSWaqVTwSt5pQ2zEr
         9ZeuwR+IVgt0YbyYEdQ1a5Sz1TzjEtPKc1vGFOaAPEm5OXIZW08MINjoclnB8VZfpn
         Hv3W/qMguEbMBntEARQOpDgpDrKLt5vAha1i+ueKMcLRv1ZdbIPeuADujWY0EGmmgK
         Fekrl3UshKJfwFk+z9pOm/UZj6G4NjDom/Ivznt4MQdJLCoqT4HZ8LU+daDXbSmfxy
         nG+Z1M7B1ueNg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [RESEND PATCH 0/4] arm64: dts: qcom: Use proper WSA881x shutdown GPIO polarity
Date:   Fri, 24 Mar 2023 11:34:31 -0700
Message-Id: <167968287204.2233401.1169001774289095121.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322193051.826167-1-krzysztof.kozlowski@linaro.org>
References: <20230322193051.826167-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 22 Mar 2023 20:30:47 +0100, Krzysztof Kozlowski wrote:
> Resending after all dependencies got merged.  The DTS changes are not
> compatible with kernel older than v6.3-rc1 (where the driver changes were
> merged).
> 
> Description
> ===========
> The WSA881x shutdown GPIO is active low (SD_N), but Linux driver assumed
> DTS always comes with active high.  Since Linux driver were updated to
> handle proper flag, correct the DTS.
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sdm850-lenovo-yoga-c630: Use proper WSA881x shutdown GPIO polarity
      commit: a246c20c45a0a2bf5e865a4c3a76822b79b38c80
[2/4] arm64: dts: qcom: sdm850-samsung-w737: Use proper WSA881x shutdown GPIO polarity
      commit: 5b91fab8eae27d1436eacde60107bab9987bbd9d
[3/4] arm64: dts: qcom: sm8250-mtp: Use proper WSA881x shutdown GPIO polarity
      commit: 4ded91530544afdbac350f609e6597076f569e52
[4/4] arm64: dts: qcom: qrb5165-rb5: Use proper WSA881x shutdown GPIO polarity
      commit: 41841f120345be87a12a4096ebcc2d2959c484ef

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
