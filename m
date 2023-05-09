Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B856FD093
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjEIVLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEIVLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:11:08 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47862721;
        Tue,  9 May 2023 14:11:06 -0700 (PDT)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8BBBFC7021;
        Tue,  9 May 2023 21:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1683666634; bh=G9P8GwMxO4SBZr0FJcEpePiv5xT0e9d3vve9PbLG8Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZFfUb9SBKGHc5M/ZQAqEuqxT2fF58wYdUFzK8kD86b/CdmObg9QviLsIl3ZFFBo2Q
         ldWAbkw4sES7KBqg/u5glgbHPHy0g0ANNfamaSpgnGGtOtrQ5+9I71NX2S3tOJdy7D
         nXtAL+7TrG79CnNixyNHMWhxmqkC5jPxnYBbmYfM=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] dt-bindings: sram: qcom,ocmem: Add msm8226 support
Date:   Tue, 09 May 2023 23:10:33 +0200
Message-ID: <8118185.EvYhyI6sBW@z3ntu.xyz>
In-Reply-To: <bac82710-da26-7acf-4375-5c5346c01705@linaro.org>
References: <20230506-msm8226-ocmem-v1-0-3e24e2724f01@z3ntu.xyz>
 <2449951.tdWV9SEqCh@z3ntu.xyz>
 <bac82710-da26-7acf-4375-5c5346c01705@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 9. Mai 2023 22:00:03 CEST Konrad Dybcio wrote:
> On 9.05.2023 18:44, Luca Weiss wrote:
> > On Montag, 8. Mai 2023 09:39:22 CEST Konrad Dybcio wrote:
> >> On 7.05.2023 11:12, Luca Weiss wrote:
> >>> Add the compatible for the OCMEM found on msm8226 which compared to
> >>> msm8974 only has a core clock and no iface clock.
> >>> 
> >>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> >>> ---
> >>> 
> >>>  Documentation/devicetree/bindings/sram/qcom,ocmem.yaml | 6 +++++-
> >>>  1 file changed, 5 insertions(+), 1 deletion(-)
> >>> 
> >>> diff --git a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> >>> b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml index
> >>> 4bbf6db0b6bd..515f0d8ec641 100644
> >>> --- a/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> >>> +++ b/Documentation/devicetree/bindings/sram/qcom,ocmem.yaml
> >>> @@ -15,7 +15,9 @@ description: |
> >>> 
> >>>  properties:
> >>>    compatible:
> >>> -    const: qcom,msm8974-ocmem
> >>> +    enum:
> >>> +      - qcom,msm8226-ocmem
> >>> +      - qcom,msm8974-ocmem
> >> 
> >> Any chance you could read the revision field on both and add comments
> >> like:
> >> 
> >> - qcom,msm8974-ocmem # vX.Y
> > 
> > Do you mean the OCMEM_REG_HW_VERSION register?
> 
> Yep
> 
> It's currently not read in the
> 
> > driver so no idea what the value is - without adding some code.
> 
> Would be appreciated!

Appears msm8974 has v1.4.0 and msm8226 has v1.1.0. Will include this in the
next revision.

Regards
Luca

> 
> Konrad
> 
> >>>    reg:
> >>>      items:
> >>> @@ -28,11 +30,13 @@ properties:
> >>>        - const: mem
> >>>    
> >>>    clocks:
> >>> +    minItems: 1
> >>> 
> >>>      items:
> >>>        - description: Core clock
> >>>        - description: Interface clock
> >> 
> >> allOf: if: properties: compatible: 8974 / then: clock(s|-names):
> >> minItems: 2> 
> > Sure, can update
> > 
> >> Konrad
> >> 
> >>>    clock-names:
> >>> +    minItems: 1
> >>> 
> >>>      items:
> >>>        - const: core
> >>>        - const: iface




