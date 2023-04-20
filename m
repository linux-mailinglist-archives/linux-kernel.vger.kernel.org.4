Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1A86E9007
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbjDTKWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbjDTKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:21:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B959C1FF2;
        Thu, 20 Apr 2023 03:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54E526170E;
        Thu, 20 Apr 2023 10:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10731C4339C;
        Thu, 20 Apr 2023 10:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681986073;
        bh=Oke/vxaYCsaXG/i/ejtj16MkigByqTQMltM4m9SpS3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Myszrib75Rcrq6eBvq0D4zzaVZOUsiMTOqnI67K8Vgz9GRMTsVLTU0hdgzzOSUSDK
         p0pyBJlD8t4WZXg8kC6O6JRUDeF6Gh+IEB3gQmz7kCmJmXemIwp1KmwTLycUkgMV1W
         HsavNSoVSh7pZ+mZFYxUK62lSEd6H3XQs6Ds4FxmIBIRXF0z0iK9IX26smE8xTWqrB
         dbcj3nBDFPIyXF5a+UoOvPmdAM6J93MYvaX9rNAepN595ZJbM5jAQQFVeB9GCU9ZHq
         8zf5s0U2ySpiKVc+EiV8rlCTcTy6rkID7MnIPBBJfdj8+KdGJ9gZjYnMKf+ljF0wDm
         f75A4wGaytUng==
Date:   Thu, 20 Apr 2023 11:21:06 +0100
From:   Lee Jones <lee@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: mfd: qcom,spmi-pmic: Use generic ADC
 node name in examples
Message-ID: <20230420102106.GG9904@google.com>
References: <20230410202917.247666-1-marijn.suijten@somainline.org>
 <20230410202917.247666-5-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230410202917.247666-5-marijn.suijten@somainline.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023, Marijn Suijten wrote:

> Update the examples to reflect a future requirement for the generic
> `channel` node name on ADC channel nodes, while conveying the board name
> of the channel in a label instead.
> 
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
