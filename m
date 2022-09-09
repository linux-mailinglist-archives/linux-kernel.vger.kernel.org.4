Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C55B2FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiIIHRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiIIHRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:17:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E05C1656;
        Fri,  9 Sep 2022 00:17:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 279F7B8236F;
        Fri,  9 Sep 2022 07:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DC3C433D6;
        Fri,  9 Sep 2022 07:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662707830;
        bh=9rxJTma0ot1qdkR2G84RM1MLt5higm4graPSXvFpHBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pW4YOICrjyL4a95bVaxi4pPFyyoN+KiOMx8XWpmEGAGWhbnIafXItqvyFfS2Cexzx
         j7V+TuJTlCMlCGShlDhIq6xgRW+AlAes9N4lcSdmd6QcWE93dTrCuzNaFE996A4bvH
         UXrevKHQ7ffHGPb0t8xGOUsfnNCZkj0CpPsEjq8T9f84v3+DWQab+DSMGCMsnx1uCJ
         D+tPc5Ur0aTPwGtrnilyc+uA/atnW/sLztigvzWCcdrklpvCx1UcT1xCpfXb4y1HxT
         IgZOocoEq05O6mMtlO34DxyCJGDd3Jui86zrO82wr+ZcSDlwqepeeSlBxLvcOqPQwj
         f4nqRqoKgiNcA==
Date:   Fri, 9 Sep 2022 08:17:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH v2 02/17] dt-bindings: mfd: qcom,tcsr: add QCS404
Message-ID: <YxrocczzA/p0kg+1@google.com>
References: <20220817145901.865977-1-krzysztof.kozlowski@linaro.org>
 <20220817145901.865977-3-krzysztof.kozlowski@linaro.org>
 <YxmetuNRIgDhutKv@google.com>
 <9abc956f-17c7-60c9-4672-d62fe581f516@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9abc956f-17c7-60c9-4672-d62fe581f516@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2022, Krzysztof Kozlowski wrote:

> On 08/09/2022 09:50, Lee Jones wrote:
> > On Wed, 17 Aug 2022, Krzysztof Kozlowski wrote:
> > 
> >> Document new QCS404 TCSR compatible.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
> >>  1 file changed, 1 insertion(+)
> > 
> > Merge conflict.  Please rebase.
> 
> I will rebase. Can you check if you pushed your tree? I see updates 3
> weeks ago here:
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/

This week's updates now pushed.

-- 
Lee Jones [李琼斯]
