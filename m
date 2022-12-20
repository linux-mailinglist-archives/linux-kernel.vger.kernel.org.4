Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0810D65229C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiLTObp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiLTOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:30:58 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A51900A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:30:36 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id n63so6423773iod.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mn7sVzPcgdMtzLOq4vuJ+0xkJax5BCUfAE5eepAbBEo=;
        b=QPsipMOOopx2GONZiUQtWxQg/Jg0tRDThFJPijUtEr4SKnq687xxGOvxAq50y4p6fw
         kYAdW9HPSo8sXoII6vFLCejSKzMu3p2zdw2zvaaunVRFFed3LuJ78FYkbOvyDVfNdhJl
         ZFXLzx2Iv19k0oJhsJBdkePZTaZbStb3ZdLhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mn7sVzPcgdMtzLOq4vuJ+0xkJax5BCUfAE5eepAbBEo=;
        b=6ZDpXe7MxgF3FrGFmKvRekj0X/fmCUjyFmxGgIm2z8XWLzbdOWxOxRh2YOlSUJRaOs
         9G/wS7v+7FG8pvYPivJcB50NAfPiCqbVAyMxmOOjUlsp8ERw13V3+YD4A9RurpVWXfqQ
         zwZJKGHVXlVvcAEiu6o+ILhOSCqKrd6/cr4jHp1lG8FVdru8+1gAkeKuOvO8BGX/dABs
         pX8DVj9U8Rh80goRthRO3ZGqnxppBWkFk60k4VSnnWZNGuLgx1lsq48vp8/gkL9i1dqs
         lnzeIDg62OFEu4hkGdHaPacg9rD3nS5n2TWUi2dFae9wgwIBlNB5n/IXBwMwnaYQyx6N
         ElPQ==
X-Gm-Message-State: AFqh2koHIgudw7dlPWgvAkioEBAsynPL/MYy+CjS3FuIDoyFFiB6TyUO
        O1cYqfR1StkrAhIwWRNVeTAhGQ==
X-Google-Smtp-Source: AMrXdXv2B6wK1zfP9XrFvBptCHTpM0mZkQfZ/aItYDrw0Ir5H/V/D68iIgSfOoE5jNU+NceAhCGuSA==
X-Received: by 2002:a6b:7a46:0:b0:6e0:139e:a241 with SMTP id k6-20020a6b7a46000000b006e0139ea241mr9047514iop.12.1671546635633;
        Tue, 20 Dec 2022 06:30:35 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id l18-20020a0566022dd200b006e2d21ab686sm5396449iow.38.2022.12.20.06.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 06:30:35 -0800 (PST)
Date:   Tue, 20 Dec 2022 14:30:34 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Document the sc7280 CRD
 Pro boards
Message-ID: <Y6HHCrl0q5BhrHOY@google.com>
References: <20221216112918.1243-1-quic_rjendra@quicinc.com>
 <Y5x+WEwTtpoV0gaR@google.com>
 <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd23e295-fea0-1b0a-752c-3cce26b57346@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 10:30:32AM +0530, Rajendra Nayak wrote:
> 
> On 12/16/2022 7:49 PM, Matthias Kaehlcke wrote:
> > On Fri, Dec 16, 2022 at 04:59:17PM +0530, Rajendra Nayak wrote:
> > > Add compatibles for the Pro SKU of the sc7280 CRD boards
> > > which come with a Pro variant of the qcard.
> > > The Pro qcard variant has smps9 from pm8350c ganged up with
> > > smps7 and smps8.
> > > 
> > > Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > v4 changes:
> > > Added the zoglin-sku1536 compatible along with hoglin-sku1536.
> > > Zoglin is same as the Hoglin variant, with the SPI Flash reduced
> > > from 64MB to 8MB
> > > 
> > >   Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > index 1b5ac6b02bc5..07771d4c91bd 100644
> > > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > > @@ -558,6 +558,12 @@ properties:
> > >             - const: google,hoglin
> > >             - const: qcom,sc7280
> > > +      - description: Qualcomm Technologies, Inc. sc7280 CRD Pro platform (newest rev)
> > > +        items:
> > > +          - const: google,zoglin-sku1536
> > > +          - const: google,hoglin-sku1536
> > 
> > Is there actually such a thing as a 'hoglin-sku1536', i.e. the Pro qcard
> > with 64MB of SPI flash, or do they all have 8MB of flash?
> 
> The SPI flash is on the CRD mother-board and not on the qcards, so if you replace
> the qcards on the CRDs with 64MB flash you would need the hoglin-sku1536 to
> boot on those.

With such a configuration how does the bootloader know it should pass the kernel
the device tree for 'hoglin-sku1536' (pro) and not the non-pro variant? IIUC the
device tree is selected based on pin strappings on the mother-board, not the
qcard.
