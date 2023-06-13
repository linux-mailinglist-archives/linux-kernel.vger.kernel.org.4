Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644C072EFBF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjFMXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFMXAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7659B173C;
        Tue, 13 Jun 2023 16:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01227615A4;
        Tue, 13 Jun 2023 23:00:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE38C433C0;
        Tue, 13 Jun 2023 23:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686697253;
        bh=P5vclOWa2rg2WBMe4tVZgM78ogE98HzztyOAfPqFBT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VJ2NeGlWXOW21wZ977gcXk6M+hMVMtbgdDcDJm3j3bw3rthZcoq7El9pRM5hmdgRO
         Uc9uklqtsh4sX/yqkprghiucQfg9eCw3tEluH0g6Ol3RSMmiqhMGZt+sNdBGjpYBs1
         X+t8bM9gq6S3UE8pLrniBZHIo8w0ycaG8CsJ3tQDTNBQ59QI2k8ZVxJeCxBOeOB1QD
         xEy2e+RkdB3hmn2J/kOVS+siowmP770tAMjnh38KZLY6Yq28+Kr5+4w2KDmK2842TS
         nLn8gTRIdFKYOzXpzwawh6wCQHseisMm4anY7fQ5bk/B7p+Lu5X7QgFGe/1qoQMB7n
         irPpTF/IzM9qQ==
Date:   Tue, 13 Jun 2023 16:04:16 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hariharan K <quic_harihk@quicinc.com>
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document MI04.1 board based
 on IPQ5332 family
Message-ID: <20230613230416.flhnzaiuy4imzs2z@ripper>
References: <20230606095732.12884-1-quic_harihk@quicinc.com>
 <20230606095732.12884-2-quic_harihk@quicinc.com>
 <d4970017-86b5-884f-fe67-6fede30469b4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4970017-86b5-884f-fe67-6fede30469b4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 01:28:27PM +0200, Krzysztof Kozlowski wrote:
> On 06/06/2023 11:57, Hariharan K wrote:
> > Document the MI04.1 (Reference Design Platform 446) board based on IPQ5332
> > family of SoCs.
> > 
> > Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > index 8302d1ee280d..165a815337f7 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -93,6 +93,7 @@ description: |
> >          ap-mi01.2
> >          ap-mi01.3
> >          ap-mi01.6
> > +        ap-mi04.1
> 
> I think we need to stop adding them here... This was supposed to be
> limited list for Qualcomm bootloader. Are you sure Qualcomm bootloader
> requires such names with versions?
> 

Hariharan, can you please elaborate on what these numbers mean? Is this
just a version of ap-mi04? Or do we have 5 different reference boards on
IPQ5332, just with "cryptic" names?

Regards,
Bjorn
