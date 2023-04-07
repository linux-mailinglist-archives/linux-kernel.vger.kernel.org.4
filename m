Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C6E6DB3C6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjDGS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDGS51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F978D30E;
        Fri,  7 Apr 2023 11:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B67764753;
        Fri,  7 Apr 2023 18:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C072CC433EF;
        Fri,  7 Apr 2023 18:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680893686;
        bh=wPrLGK1mrTZriNzn2DsauwFwUooVa5vI985iVF2sO0k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ZY70rN12F1/V/gczy3ivaTrU39pV0oAohk3TOpauN+B0XYYoSnjg5WC5RZcBhA3WP
         kcei+ZKcpKiQJOoNko5Ee4jozI6wyZ+lPxGVRpX90ovy2ULWiXzqKOnfFPQc7IHC9P
         F/kyntBjm4yGHQp/AV30bBglZoqMBMNzrDtiKpojwObZTibBWQsCy6j/NK8h3Zpgw6
         hE9dFlBBW2hjuNsU8sgcI4GwyVcsbT1vDnNFf0WHo+502jP/cvSvrrG0uaxapU0p6d
         foFirphAOFF32j7jJn3A7LL/Fhz3vH7nyXyTuv81SeHG4sgrfNJxPWeu+C1OeE8bmx
         3TBX/b5mXzSNA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8150: remove superfluous "input-enable"
Date:   Fri,  7 Apr 2023 11:57:33 -0700
Message-Id: <168089385287.2679377.8176092418700554250.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407180655.128771-1-krzysztof.kozlowski@linaro.org>
References: <20230407180655.128771-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Apr 2023 20:06:54 +0200, Krzysztof Kozlowski wrote:
> Pin configuration property "input-enable" was used with the intention to
> disable the output, but this is done by default by Linux drivers.  Since
> patch ("dt-bindings: pinctrl: qcom: tlmm should use output-disable, not
> input-enable") the property is not accepted anymore.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8150: remove superfluous "input-enable"
      commit: 087fc87e1882a44637a48cc537b49df9bec91780
[2/2] arm64: dts: qcom: sm8350: remove superfluous "input-enable"
      commit: a72768eecb9d98ed5b5f75f5be02a365b5541456

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
