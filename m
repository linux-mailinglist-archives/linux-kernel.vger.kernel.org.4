Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC2C6FC772
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbjEINGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjEINGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:06:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19252558D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:06:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-b9a6eec8611so30390421276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683637564; x=1686229564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JCemM+c2qiZ17odPdtzVZ73pLR7n+qmtftHOxm5MbiI=;
        b=V1JbNGdVpXLpZ2KZMseRk9jn2eT8KTHq+DxTgaeU5yR2zZrXPdsBBAdkYZXV3aMhFK
         uE8aWXkrVAVrzJN0C+wkyA3lmkuLGN0jF845PaYeGIhNOteK+c5Cw0dZu1AwgRuxSVhz
         39PuJEsBeya4u6lxYOZFW+fLkZpQGVwjEyJ2lWYQg5Hs46Goo3vAaqFcvpm/LKX/LMHm
         y8tUdpEpn58DJbIUIOUCiF7EKl67HGp6IXZx/asZO83O+MyE8DHwoRrWkMNY6tTBtdo7
         S5Lq0vyh58Lwwol4uUzGc0WV4Z2olKNmfbeYkZ9bNI4MtMwhLSj9eMqCgqwqdmoHemA0
         qIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637564; x=1686229564;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JCemM+c2qiZ17odPdtzVZ73pLR7n+qmtftHOxm5MbiI=;
        b=JOP57fsKe5LOEUMyJ/PZn+UdRlmeYsM9CtWwwwSL6SJWUGa1KlxKhtDrox5DhZtB7g
         tQd2rYOn6g6KzEN095q4Ozzb/gGMILhiVkU7TSa4Q8flfOh1iLDXollysiwde2mU2O1r
         PcQLRpzGD8IcKKmdS8PXj89pol7Rprmef9iqCBO1++PqjG98RMPq0bpl7l+D5VkpCA4k
         qnk8l24VJqM/iSsvGq22clgF9kS4+KTn7kcJrO57FvM8l59d7AZiU8XVc9C4XuOfoEb4
         VyvB4ytJAJGr46Mr2oM93/dX+Vv+WcX3q0F8fqchjwgUcaRSnmJokXLTWoKNb1GmE91F
         hdOg==
X-Gm-Message-State: AC+VfDx0xvF3T0j6BbcECt8L9fpqWSteKpLLW4eh75jzsh+hh1kNLofH
        ugVIl/3wIvEt+TbIRvXQft/fEwHvV7yCqmRxCi50Tw==
X-Google-Smtp-Source: ACHHUZ5Qcc1QJJWsUTSHqWg6N6DB+laxRjd4Y/2fmdyogSaXc1bK6Wa8AkJmG+Z17l3YdO/vGtR5sBB/+6vVHEq0G/s=
X-Received: by 2002:a81:4895:0:b0:54e:ac2b:8a8c with SMTP id
 v143-20020a814895000000b0054eac2b8a8cmr15151059ywa.24.1683637564226; Tue, 09
 May 2023 06:06:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <343182748e12b6a4ac57d336405c50e36fc5520c.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJpp2x2OEB2sg+caKmjkDYJp_NJ9mXo85FxTZr-9zRXHNhw@mail.gmail.com> <10fa20f9-33d9-a8a8-3fca-f5ff320a6574@quicinc.com>
In-Reply-To: <10fa20f9-33d9-a8a8-3fca-f5ff320a6574@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 16:05:53 +0300
Message-ID: <CAA8EJprJfmtFs1dx0uJw0bi1ig2JsCYzH_4BncPop4aO16D2aA@mail.gmail.com>
Subject: Re: [PATCH V6 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 15:21, Souradeep Chowdhury
<quic_schowdhu@quicinc.com> wrote:
>
>
>
> On 5/9/2023 5:05 PM, Dmitry Baryshkov wrote:
> > On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
> > <quic_schowdhu@quicinc.com> wrote:
> >>
> >> All Qualcomm bootloaders log useful timestamp information related
> >> to bootloader stats in the IMEM region. Add the child node within
> >> IMEM for the boot stat region containing register address and
> >> compatible string.
> >
> > I might have a minor vote here. Is there any reason why you have to
> > instantiate the device from DT?
> > It looks like a software interface. Ideally software should not be
> > described in DT (e.g. this can be instantiated from imem
> > driver-to-be).
> > Or we can follow the RPM master-stats approach, where the device is a
> > top-level device, having handle pointers to the sram regions.
>
> This is a dedicated region of IMEM reserved for storing stats related
> information. So it is represented as a child of IMEM, please
> refer to Documentation/devicetree/bindings/sram/sram.yaml which
> follows a similar philosophy. Also since this is a child of IMEM with
> a specific purpose, does it not warrant a dedicated driver?

I do not question a dedicated driver. I was asking about the DT node.
Even the mentioned bindings file describes the SRAM regions inside the
SRAM, rather than a proper device to be instantiated in the SRAM node.
I'd point to the boot_stats discussions (present on the list in the
last several months).

>
> >
> >>
> >> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>   .../devicetree/bindings/sram/qcom,imem.yaml   | 22 +++++++++++++++++++
> >>   1 file changed, 22 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> >> index 0548e8e0d30b..bb884c5c8952 100644
> >> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> >> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> >> @@ -50,6 +50,28 @@ patternProperties:
> >>       $ref: /schemas/remoteproc/qcom,pil-info.yaml#
> >>       description: Peripheral image loader relocation region
> >>
> >> +  "^stats@[0-9a-f]+$":
> >> +    type: object
> >> +    description:
> >> +      Imem region dedicated for storing timestamps related
> >> +      information regarding bootstats.
> >> +
> >> +    additionalProperties: false
> >> +
> >> +    properties:
> >> +      compatible:
> >> +        items:
> >> +          - enum:
> >> +              - qcom,sm8450-bootstats
> >> +          - const: qcom,imem-bootstats
> >> +
> >> +      reg:
> >> +        maxItems: 1
> >> +
> >> +    required:
> >> +      - compatible
> >> +      - reg
> >> +
> >>   required:
> >>     - compatible
> >>     - reg
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
With best wishes
Dmitry
