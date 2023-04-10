Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223B06DC4B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 10:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjDJIyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 04:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDJIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 04:54:44 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB19199F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:54:43 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id a23so1768029qtj.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 01:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681116883; x=1683708883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT9rBwpWcKUZaczaZowSPWVC47IVSqFCideHtvU7i10=;
        b=IvRn+Lnp4IdK6EhrO4n9VCNPHVdPVJn1DEQYkDk4YIAxchSkW22JHUU/gruhHeyO9f
         mlWENwayKK/3dB28QoUbPYavMgxHSI0JkuZt92WKRr0Go0waK2Sv7qCdwE53TI3+ucfk
         qSypYrgDHjWDSy1X+7CntURJUtDUu02wtA5ZkMZELcT/olax56KfgwbkXwKZfi2/gqSk
         gxxAnURAP4ElwHqvPTEUHRzTzYg8Oql+NY3silNeWgY7GqUugkytORdYzb78QSLPV5Ds
         5ETw8VA8hRsIBYxYT6JqRuaB02E4B4P4A6R1fa8gbjpPJp+CYjs5++1f7oGYiroSpTfY
         d2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681116883; x=1683708883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZT9rBwpWcKUZaczaZowSPWVC47IVSqFCideHtvU7i10=;
        b=P0oN1sWlQIDRq4dIqSNT+EAVj6D2qK8uGuYuzQeRJWHILNiMhwI1ujqYPLR3TA1a7j
         4eNZ/oZ6hOtyBAJidUZ5gQ5uu4k05DQrD1jz4UNJm5cadOCuFxXkPIk96mrdIG24nkPw
         7mqMhdk4qfiygONINttdo1TY8q3IM8ro7LPEk3TNUtIIulXZ0aPcwKQFC6WwIVI6cgvb
         0z9Q48Kuguu7dYpMSLJLj0sLHdDrhbDX9o8olalHnn+R1p8lHVOZ+VQZUQpJPyPm9qGE
         XPT/brZL16yKdhE2zYnDDYX1iwAaD8VzjboHC42ZXYEi0Rdcy+vk/AeqcPsZYJd63H7I
         dyEA==
X-Gm-Message-State: AAQBX9czevjIhi5f6hWW/ig1q2WlIKRMSzGSM7sD8G04WIf6kBFueg4u
        kSpQSkH5PXZCogSsHVtohYNaqZ4VRXy0+KKsWzKnVQ==
X-Google-Smtp-Source: AKy350a6zf69mJUwm6/ebH4HDxTFB64uA/PslNVHrgNo+KNQpsde8kx1jr0COHlIjeMa5yNPWjTKStfYOWTyu535LFU=
X-Received: by 2002:a05:622a:283:b0:3e4:de7a:d532 with SMTP id
 z3-20020a05622a028300b003e4de7ad532mr3689327qtw.13.1681116883059; Mon, 10 Apr
 2023 01:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org> <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org> <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
 <CAMi1Hd2UNxXHUVWO-=sWh=-bVnrqE3UdLguFOq+62SfvUiEs0A@mail.gmail.com> <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
In-Reply-To: <b2307e91-3373-539a-ecfb-e2542b9f83db@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Mon, 10 Apr 2023 14:24:07 +0530
Message-ID: <CAMi1Hd2xfH-=htvHFQRktdgtDwiXKKvFo+9hook4HCJCPY6ydA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
To:     "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 at 16:33, Bryan O'Donoghue
<bryan.odonoghue@linaro.org> wrote:
>
> On 09/02/2023 09:05, Amit Pundir wrote:
> > Hi, So what is the verdict on this patch?
> >
> > I submitted this fix to make sure UFS don't map and crash on it, which
> > I have seen happening occassionaly on db845c and Caleb reported
> > similar issues on his sdm845 device iirc. I should have probably put
> > that in my commit message as well.
> >
> > Regards,
> > Amit Pundir
>
> So the memory _is_ being used by ... continuous splash on an Android
> image, i.e. your Android ? limited to Android - image continues on with
> the splash but other blocks erroneously reuse the memory then, UFS as an
> example ?

Hi Bryan,

Yes UFS (reported only on v5.10) tries to map this reserved memory and
system crash and reboot. Plan is to backport this patch to v5.10.y.

Regards,
Amit Pundir

>
> ---
> bod
