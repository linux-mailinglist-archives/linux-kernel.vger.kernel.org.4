Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC46569BB1D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 18:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBRRAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 12:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBRRAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 12:00:43 -0500
X-Greylist: delayed 594 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 18 Feb 2023 09:00:40 PST
Received: from www.linux-watchdog.org (www.linux-watchdog.org [185.87.125.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8949217155;
        Sat, 18 Feb 2023 09:00:40 -0800 (PST)
Received: by www.linux-watchdog.org (Postfix, from userid 500)
        id 00136409E9; Sat, 18 Feb 2023 16:00:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 www.linux-watchdog.org 00136409E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-watchdog.org;
        s=odk20180602; t=1676732406;
        bh=mmrzvLbJt44h+Sq+aFCdJK1Dkf8hdq69aQcSosm2/hw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SMI46vBIMOYhEAux/gfW3FNlGhqhgsf8pQXggsAGD9CyO48K+gmfh3SVeFB3Q5POU
         tHaEnWEqB3p2hxaeD9r8BcnTt/7zT4WeWje89J5P+NbKj6MeLdlkdBQ+RZUM7giV2q
         fASL9HQCNXkTbB9xfyqoXM6jvRYbcBllwvDlii9Y=
Date:   Sat, 18 Feb 2023 16:00:05 +0100
From:   Wim Van Sebroeck <wim@linux-watchdog.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        patches@linaro.org, Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: Add MSM8994 watchdog timer
Message-ID: <20230218150005.GA30362@www.linux-watchdog.org>
References: <20221117105845.13644-1-konrad.dybcio@linaro.org>
 <20221117105845.13644-2-konrad.dybcio@linaro.org>
 <07defd1c-2cbd-f25b-d1f4-824023d27135@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07defd1c-2cbd-f25b-d1f4-824023d27135@linaro.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

> On 17.11.2022 11:58, Konrad Dybcio wrote:
> > Document the MSM8994 watchdog timer which is already used in DT.
> > 
> > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> Looks like this never got applied?

Patience is a beautiful virtue.
Since Guenter reviewed it and since it is in Guenter's tree, I picked it up.

> Konrad
> >  Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> > index d8ac0be36e6c..a1f17c9e02db 100644
> > --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> > @@ -17,6 +17,7 @@ properties:
> >      oneOf:
> >        - items:
> >            - enum:
> > +              - qcom,apss-wdt-msm8994
> >                - qcom,apss-wdt-qcs404
> >                - qcom,apss-wdt-sc7180
> >                - qcom,apss-wdt-sc7280

Kind regards,
Wim.

