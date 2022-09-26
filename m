Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437625E9A9A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiIZHl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiIZHlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:41:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEDE25C6B;
        Mon, 26 Sep 2022 00:41:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F2E4B80943;
        Mon, 26 Sep 2022 07:41:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BDB3C433C1;
        Mon, 26 Sep 2022 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178111;
        bh=72jn43lvORCqa4NuDs4M2sZqItx2R8kjrMkI6/Q0z3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qDkKjxqNcoAJgzVi7YgBsJVjV/mRz/Ff7vR1JF97CEw+n9Xqfhq7ZOuj04hyQWA8t
         5i8vy2mllndpHeFEpJBKRaeZD4chDBSbM38XmZ4+MkHDe0X4BR5/nyJHVE0TtAGf/c
         O9kzjD+GWcl2GTTAIWOClhnw9MFj89beiApfDvbfqoOsjuaEKT00tY2XB7DxyolPvs
         EYZ5ARiYN+7z8RAgiuSwFbVqMzFkqEC1RfKvvwY0Xyv/XfXSmhvULAtdlQm6bw+UVh
         PR+WOJCDBFgIHmo5M6D1ukV+FXZ3rtPedZJTGtzVkLPCNq+W1YFMNY9ZqE+2T62YJ6
         4AOKL4JWDDZGQ==
Date:   Mon, 26 Sep 2022 08:41:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bindings: Update maintainer's email address
Message-ID: <YzFXtNcHB6o0fHT+@google.com>
References: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
 <78859fd2-330f-1687-7fa3-f0831402778c@gmail.com>
 <430b8a98-d76e-521b-81a2-a302679ecce5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <430b8a98-d76e-521b-81a2-a302679ecce5@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022, Chanwoo Choi wrote:

> On 22. 9. 26. 04:03, Chanwoo Choi wrote:
> > On 22. 9. 24. 09:36, Guru Das Srinagesh wrote:
> >> Update Guru Das Srinagesh's email address.
> >>
> >> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> >> ---
> >>  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
> >>  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> >> index 6a9c96f..480e4fb 100644
> >> --- a/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> >> +++ b/Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml
> >> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>  title: Qualcomm Technologies, Inc. PM8941 USB ID Extcon device
> >>  
> >>  maintainers:
> >> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> >> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
> >>  
> >>  description: |
> >>    Some Qualcomm PMICs have a "misc" module that can be used to detect when
> >> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> >> index ec3138c..1f3ac59 100644
> >> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> >> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> >> @@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >>  title: Qualcomm Technologies, Inc. PM8008 PMIC bindings
> >>  
> >>  maintainers:
> >> -  - Guru Das Srinagesh <gurus@codeaurora.org>
> >> +  - Guru Das Srinagesh <quic_gurus@quicinc.com>
> >>  
> >>  description: |
> >>    Qualcomm Technologies, Inc. PM8008 is a dedicated camera PMIC that integrates
> > 
> > 
> > As Krzysztof comment, I changed the patch title and then applied it. Thanks.
> > - dt-bindings: Update Guru Das Srinagesh's email address
> > 
> 
> I'm sorry for that. It should be also confirmed from MFD maintainer.
> I withdraw the applying.
> 
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com> 

It's fine, go ahead.

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
