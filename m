Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA8B706008
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 08:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjEQG2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 02:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjEQG2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 02:28:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7143586
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:28:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30796c0cbcaso316701f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684304896; x=1686896896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiAzzOsgenMkTRU7FnuCPRQM8PRLaof8x5kRxXJv4fg=;
        b=HB6oQDtg9HIZ90EJAUPuJI+ELvU9YsbWcwFhybf5rnqCCmdWp4wmGMpC0W4i6sMsPX
         5QCs1+RAcyeotoOa101VThh4Z0jXfDEpVS2VFuBI86avB+nmga2TaTjDdgNlOYR0Th2t
         QNQ5BpfADs3Xl8ijJTsTijziAl2M6QMOeMotXpzrKVIp+dcwtloAB/PEDxIC/vbQt3CD
         yDO1sD+zPjL8+0Y7ERIkOcm5PGfnLTT0xXYvrcGkoS4L6s3D3A2RD5chNTfngOBKiYht
         CqDs/ndbwo6CaH+t++B0lVNtQ7TlwrbWcICVNS0DjsiX0+ScDK3L3mKd430FCNK7sPYk
         BM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684304896; x=1686896896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WiAzzOsgenMkTRU7FnuCPRQM8PRLaof8x5kRxXJv4fg=;
        b=J7kWFdsOnH6lS5TgWCrodIl+/EsHXHgapjMsPOmxXuWujLixren42o7JgL6kfT+LA9
         gfcmzm4kUCx1iLGqcVtqu0c8+dswXlhs37AeZr9Yu82xY09KbM4vQWKzP+5C2SQ+Klp7
         pTSwwZF7utS4xdKWz5sXaaPYuCpIgRFF29b+3jHhkuZgvKiMcY6/QKk0O00r2B5TnwQY
         s6gEjEvuEWLlq+xsj3Q/P8gA2XtL0B+aAmxVmGBGgUn+xgJBgZiEwwoUPH/XdY5C/CxP
         L1sPYw1G1YAtdvHBJZd5ghMIpqcqqzBI3Fpg5j3cAVBRRHnifzTB8IkJ3q6Cx4mM6CnM
         SXKQ==
X-Gm-Message-State: AC+VfDyW6n8uVMcLeXFKr1Y4QcBLQHPtx+VY7gQmNArPwpZeWN/EAvZd
        GnGemEmZh5Dh2Ea803Tls+GO3QTybSafvO1oLYMsKw==
X-Google-Smtp-Source: ACHHUZ5zuJ5CUrWf4TfT3tPR1snFuP6lOoBzvts5MJhBsNH47mYmt3D/o5G1TwnTliGLWhqtUtaM7L1R230cSxuQMyU=
X-Received: by 2002:adf:dd0f:0:b0:2fb:283a:1757 with SMTP id
 a15-20020adfdd0f000000b002fb283a1757mr27614579wrm.26.1684304895655; Tue, 16
 May 2023 23:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230516213308.2432018-1-bhupesh.sharma@linaro.org>
 <20230516213308.2432018-2-bhupesh.sharma@linaro.org> <20230517053838.GF4868@thinkpad>
In-Reply-To: <20230517053838.GF4868@thinkpad>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Wed, 17 May 2023 11:58:04 +0530
Message-ID: <CAH=2Ntwvr0TV+W6-Bm8hwUn1XALAqNHndkJ_fDx0EAMai1OL1g@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] usb: misc: eud: Fix eud sysfs path (use 'qcom_eud')
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 11:08, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Wed, May 17, 2023 at 03:03:04AM +0530, Bhupesh Sharma wrote:
> > The eud sysfs enablement path is currently mentioned in the
> > Documentation as:
> >   /sys/bus/platform/drivers/eud/.../enable
> >
> > Instead it should be:
> >   /sys/bus/platform/drivers/qcom_eud/.../enable
> >
> > Fix the same.
> >
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
>
> I believe the path has changed during one of the EUD patch iterations. In=
 that
> case, the documentation is wrong from day one. So this patch should have =
the
> relevant Fixes tag.
>
> With that,
>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Ok, I will add a Fixes tag.

Thanks,
Bhupesh

> > ---
> >  Documentation/ABI/testing/sysfs-driver-eud | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-eud b/Documentation=
/ABI/testing/sysfs-driver-eud
> > index 83f3872182a4..2bab0db2d2f0 100644
> > --- a/Documentation/ABI/testing/sysfs-driver-eud
> > +++ b/Documentation/ABI/testing/sysfs-driver-eud
> > @@ -1,4 +1,4 @@
> > -What:                /sys/bus/platform/drivers/eud/.../enable
> > +What:                /sys/bus/platform/drivers/qcom_eud/.../enable
> >  Date:           February 2022
> >  Contact:        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> >  Description:
> > --
> > 2.38.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
