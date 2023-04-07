Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767D76DB3D0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjDGS6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233778AbjDGS5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0486E06D;
        Fri,  7 Apr 2023 11:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4B2B64986;
        Fri,  7 Apr 2023 18:54:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 918BFC4339C;
        Fri,  7 Apr 2023 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893688;
        bh=YaXMx6M9gbJoPB9xkYm44wUlP1e09yl/zgAnYfJoyYI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AF6scGSNpPklK6d5bZhNN/Kad29zHcpxRfkgcB8pH2IW9BLLfAopGLYNLw+JPvCBG
         DzeSjZI2Gzt1ECiIgerpjyL6zuMVlLmxqdrRh6tWFs0WTKKQQJvDsO8TusvmRnws0A
         HZ7XPEzTvpA4HijpK/+2To9xGA/Muq0OvsEQWL7JMI03NsbZ1Cn3cx2g6d5d+JnMUc
         8yF2o4Pykh9bQKz/52bv8iILjj/pjnd4xHS0XRzk3a9cHIbs/sbtKutXdWrtpKvtkz
         UOCfyz+OGy0qjXxnSWWD51221EaDRC4qNirdQOiuqUj+FfB763quYE6GjqwP8s1H92
         8XtdnLLlZ/BmA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-crd: correct pin drive-strength
Date:   Fri,  7 Apr 2023 11:57:35 -0700
Message-Id: <168089385286.2679377.1066171024604979575.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407181541.139349-1-krzysztof.kozlowski@linaro.org>
References: <20230407181541.139349-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 7 Apr 2023 20:15:41 +0200, Krzysztof Kozlowski wrote:
> Fix typo in drive-strength property name.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-crd: correct pin drive-strength
      commit: 536ba6c48d8e1a47d688326dfbd04ab37a6eb8dc

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
