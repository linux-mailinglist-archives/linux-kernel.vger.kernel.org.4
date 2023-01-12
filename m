Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9520668445
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbjALUu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:50:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjALUty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:49:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A408859D3D;
        Thu, 12 Jan 2023 12:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DDF2B81FAF;
        Thu, 12 Jan 2023 20:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB1C433D2;
        Thu, 12 Jan 2023 20:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673554786;
        bh=pYVPEWz52mQGIdPq/+TQa2RMsC8oqbfKajVUb1wSmYk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h/5iAelPBdt7CwSabtsLKTmhZfybFkn3RdYW8aF7UjaAPWEFtAvdYZNDn0dNA2dpU
         5cKsVlODFviQpb8QAlSbOgvi4FM+1ip7mHDEeBd+mF+CaOSmhBmGfpaC/5RUqJMyzT
         xOvzW+UFmoEIp7h7TwQxU0mo2WkS1D20FxhzBcJA06scRdLqXvvhat30S//IQsXQ9y
         rnEDcgcZ5Vnlf/k2dC92ZzZY+Ar8GIPB44bu56HmhQ9X4Md2LuD7NbmDNgHrL85SrF
         B1zFPs0aFRCpUifKVi+3HMmeFPfiA7MySmUa/TMsC1wJmCu5PC4NMmHauyzDQ2ICFi
         MSkRoq4PdAXJA==
Received: by mail-vs1-f41.google.com with SMTP id 186so14945914vsz.13;
        Thu, 12 Jan 2023 12:19:46 -0800 (PST)
X-Gm-Message-State: AFqh2kogOK11zgNq+oGTlbJsok1huDGmK084X+YV26w632DX4Dd0IR63
        wO+Lz9vXgb7Tf5wu7nmSJkTIkjm9kHBvGSUG/Q==
X-Google-Smtp-Source: AMrXdXvK8sBcTracywKQtauoGjyEmrc99wysitQrJ3h7LGjdCX42CXjGmUS7hQKYwr67TrzO326kbBG4qwwfXRNHHX4=
X-Received: by 2002:a05:6102:3b03:b0:3d0:b955:e0af with SMTP id
 x3-20020a0561023b0300b003d0b955e0afmr2332081vsu.26.1673554785707; Thu, 12 Jan
 2023 12:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20230111114337.24782-1-quic_sibis@quicinc.com>
 <20230111114337.24782-4-quic_sibis@quicinc.com> <20230112201731.GA4038840-robh@kernel.org>
In-Reply-To: <20230112201731.GA4038840-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Jan 2023 14:19:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq++hB0s-VmAKWdDbp79UY+-ryAfBnmzMB4_iS++GGEeHQ@mail.gmail.com>
Message-ID: <CAL_Jsq++hB0s-VmAKWdDbp79UY+-ryAfBnmzMB4_iS++GGEeHQ@mail.gmail.com>
Subject: Re: [PATCH V3 03/10] dt-bindings: remoteproc: qcom,sc7180-mss-pil:
 Update memory-region
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        manivannan.sadhasivam@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        amit.pundir@linaro.org, regressions@leemhuis.info,
        sumit.semwal@linaro.org, will@kernel.org, catalin.marinas@arm.com,
        robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 2:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jan 11, 2023 at 05:13:30PM +0530, Sibi Sankar wrote:
> > The dynamic memory region used for metadata authentication would still
> > be a part of the kernel mapping and any access to this region by the
> > application processor after assigning it to the remote Q6 will result
> > in a XPU violation. This is fixed by using a no-map carveout instead.
> > Update the bindings to reflect the addition of the new modem metadata
> > carveout on SC7180 SoC.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >
> > v3:
> >  * remove double space [Krzysztof]
> >  * Pickup R-b
> >
> > v2:
> >  * Pad commit message to explain bindings break [Krzysztof]
> >  * Split dt/bindings per SoC  [Krzysztof]
> >
> >  .../devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml    | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> > index e4a7da8020f4..b1402bef0ebe 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
> > @@ -95,6 +95,7 @@ properties:
> >      items:
> >        - description: MBA reserved region
> >        - description: modem reserved region
> > +      - description: metadata reserved region
>
> Based on dtbs_check, looks like you need 'minItems: 2'.

NM, I see those are all sc7180.

Acked-by: Rob Herring <robh@kernel.org>
