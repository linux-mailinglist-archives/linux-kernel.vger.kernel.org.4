Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29164706A1C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjEQNnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 09:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjEQNnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 09:43:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A220C269A;
        Wed, 17 May 2023 06:43:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C5F64403;
        Wed, 17 May 2023 13:43:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20858C433EF;
        Wed, 17 May 2023 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684330980;
        bh=kJ4IaHDWaTOfQsuK204QfW/lAjzQ5F4JSArmUW3wBsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aROdYL4Xz4Cyr270m0N14Li9g8Zfm6Ua+YuOyoV0oSO54/u3VROi7CB9dm48qxH/Y
         XhdqWNsSrdb2lcallndCg77UbzraQvpSYenW0rK0AWVyyuBZUYhsP7vuVgQwszE1KA
         EL8Dc56FamCYynQ13kLT2aivSH6SPxS1Atw0dpboVu9VxGcjCU1EveZmWutOUglRj+
         qMERrYsVNcxsEANvjlC0GfUG36BVDftloGptoT/1jAVCezgsDmhCCJ4L2uyksAlPDF
         CWFQIPDMYfvTuMFnyoC/zDma7EnzVcJj9ZMndnSnSL93TdUq58h+QUZU3lQlTSp002
         e3tS0zimjyJyw==
Date:   Wed, 17 May 2023 14:42:54 +0100
From:   Lee Jones <lee@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        ob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v6] dt-bindings: mfd: qcom,spmi-pmic: Add pattern
 property for phy
Message-ID: <20230517134254.GA9658@google.com>
References: <20230510082725.3612903-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510082725.3612903-1-abel.vesa@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023, Abel Vesa wrote:

> The phy pattern property will be used for providing eUSB2 repeater
> functionality. This will be modelled as a Qualcomm PHY driver.
> 
> Acked-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> 
> The v5 (resend) is here:
> https://lore.kernel.org/all/20230320150617.1824465-1-abel.vesa@linaro.org/
> 
> All other patches have been merged already. This is the only one left.
> 
> Changes since v5:
>  * rebased on top of -next
>  * added Krzysztof's R-b tag
>  * added Lee's A-b tag
> 
> Changes since v4:
>  * none
> 
> Changes since v3:
>  * made this the second patch rather than the first in the series
> 
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
