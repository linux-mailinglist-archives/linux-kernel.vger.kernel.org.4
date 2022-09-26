Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AE5EAC26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 18:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiIZQNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 12:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbiIZQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 12:12:40 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5765A88D;
        Mon, 26 Sep 2022 08:00:52 -0700 (PDT)
Received: from g550jk.localnet (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at [IPv6:2a02:8388:6582:fe80::6])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 03FA6C78D3;
        Mon, 26 Sep 2022 15:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1664204451; bh=St+z+1b3Jkc4uxjTl+6dCyco1+LJaG4Oic8mbEtDHtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=MgLWyTd3+i7Bb25vBjk7iiBSj1xnx79m0pAODtcpEDqNdU9zVMls6ZGc7iQPUwKzo
         FOKpvUPm0p7BqC+ggCr+9bqG8EwTS37z26L6BA6xhOq0DmfM1YVlsy2hsuVuDahNCv
         eg/SMfPFSupULi6pi3pzXvwzrRUlY6rXLXApuhns=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: qcom,spmi-pmic: support more types
Date:   Mon, 26 Sep 2022 17:00:50 +0200
Message-ID: <4769828.31r3eYUQgx@g550jk>
In-Reply-To: <3cabc45a-526b-0177-e29a-bbe048e97a7f@linaro.org>
References: <20220925211744.133947-1-luca@z3ntu.xyz> <20220925211744.133947-2-luca@z3ntu.xyz> <3cabc45a-526b-0177-e29a-bbe048e97a7f@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 26. September 2022 10:51:45 CEST Krzysztof Kozlowski wrote:
> On 25/09/2022 23:17, Luca Weiss wrote:
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> >      additionalProperties: true # FIXME qcom,pm8916-wcd-analog-codec
> >      binding not converted yet> 
> > +  "charger@[0-9a-f]+$":
> > +    type: object
> > +    oneOf:
> > +      - $ref: /schemas/power/supply/qcom,pm8941-charger.yaml#
> > +      - $ref: /schemas/power/supply/qcom,pm8941-coincell.yaml#
> > +
> > +  "^dcdc@[0-9a-f]+$":
> > +    type: object
> 
> How about renaming this one to usb-vbus-regulator?

Sounds good to me. I was actually hoping somebody would suggest a better name.

Should I wait a bit to see if anybody else has a better suggestion or send a 
v2 now?

Regards
Luca

> 
> Best regards,
> Krzysztof




