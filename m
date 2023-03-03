Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27656A94B1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCCKBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCCKBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:01:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680505B5F5;
        Fri,  3 Mar 2023 02:01:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF580617AE;
        Fri,  3 Mar 2023 10:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF00FC433D2;
        Fri,  3 Mar 2023 10:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677837692;
        bh=F8qMc/kfGDmlmCTH8pqJK45nXvS2wbqeBWFFGTQThoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jQ/U8KTre7xLotXJWUmmjhXV32NdKPNjMDxLgtAIsdAo1YJ2GH3LigDvGn5Qaav8c
         jWtTU4uQ6WsqyXzicVjAH1MT4Eo/BSNbxt4yjay/T67pWuBQa677TdtvG6yTPCO1yH
         iWgPoLFE5FvCqtXqPw03mrGELvzcx4rKEiwEPnmgtQmYt0EAnGovbTjE4bV5+c7FBB
         n77pvh0tQlfSJxHB4UxHB4n0GQ+NRKDQiWeJWK4TTxLAgClTUaxOFYxJv2Cv6320jm
         ZehtWWM88kO1uoNaZyYS6eQjQRfSH64kxE80eLwtyILoZzoBXX+icurWVQpMEsSRMV
         4o0XZ6MP5GCLw==
Date:   Fri, 3 Mar 2023 10:01:26 +0000
From:   Lee Jones <lee@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mfd: qcom,spmi-pmic: Allow RRADC as adc@
 subnode
Message-ID: <20230303100126.GL2303077@google.com>
References: <20230213201337.2089970-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230213201337.2089970-1-konrad.dybcio@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2023, Konrad Dybcio wrote:

> This was omitted when adding the RRADC bindings.
> 
> Fixes: 7ea58c951ab3 ("dt-bindings: iio: adc: document qcom-spmi-rradc")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

-- 
Lee Jones [李琼斯]
