Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06E869F7D8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjBVPbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjBVPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:31:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AFE38B5F;
        Wed, 22 Feb 2023 07:31:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F174612AE;
        Wed, 22 Feb 2023 15:31:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF2DC433D2;
        Wed, 22 Feb 2023 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677079887;
        bh=doelYmFDQDxHNtr+FTNIxkvka7FWJLdjaS1gCzFGYBs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUxIYoj8r2U0i28PdCQMRXsLH4xye0tr4oLS6ZhVNYSMznm5Wcu28IuIjZD0R5kQ8
         Pi7QvgWaS/gKJp6KjuSIxQZ/TX1XdRqBwPCFD2n/CjMQji2fleu2SXfh8aDaPbVOky
         qmYTRbKDqreiFEK4HQL1Gk0EMGbl/i49VRXgB9I0I2aWvm5yeRroYbwIueZ+Fn1MsM
         +I6CPEkyt5Q+7Xf2N+0Etb0W5LFhJnIEkwWMwt7UW55FpObB4FUTzAs1RXAiDVCdGy
         jENx0NzadeIn77KR81Ck4ErPWZVhQmnm7BkLBuxjGPdsxOZSUd4jPkXY1ogc9amT5x
         Q5XE8nL9T7bKw==
Date:   Wed, 22 Feb 2023 15:31:22 +0000
From:   Lee Jones <lee@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mfd: qcom,tcsr: Add compatible for sm8450
Message-ID: <Y/Y1SlIgo4SEJYop@google.com>
References: <1675336284-548-1-git-send-email-quic_mojha@quicinc.com>
 <c8c1ae71-a85f-18cb-780d-fd2e055f8e26@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8c1ae71-a85f-18cb-780d-fd2e055f8e26@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023, Mukesh Ojha wrote:

> friendly reminder.

Top posting and contentless pings are seldom received well.

If you think your submission has been dropped (it hasn't), please submit
a [RESEND].  In this case, I'm just a little behind due to a planned
vacation, a work trip and being generally overloaded.

Please be patient, I'll get to you shortly.

> -Mukesh
> On 2/2/2023 4:41 PM, Mukesh Ojha wrote:
> > Document the qcom,sm8450-tcsr compatible.
> > 
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> > Change in v4:
> >    - added Acked-by.
> > 
> > Change in v3:
> >    - Align with new format mentioned at
> >      Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > 
> > Change in v2:
> >    - Considering here it as v2 as this patch came out from comment
> >      made on its v1 https://lore.kernel.org/lkml/c5dc8042-717b-22eb-79f6-d18ab10d6685@linaro.org/
> > 
> > 
> >   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > index adcae6c..4290062 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > @@ -26,6 +26,7 @@ properties:
> >             - qcom,sdm630-tcsr
> >             - qcom,sdm845-tcsr
> >             - qcom,sm8150-tcsr
> > +          - qcom,sm8450-tcsr
> >             - qcom,tcsr-apq8064
> >             - qcom,tcsr-apq8084
> >             - qcom,tcsr-ipq6018

-- 
Lee Jones [李琼斯]
