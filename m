Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C586CF114
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 19:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2Ra6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Ra4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:30:56 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E31F49FA;
        Wed, 29 Mar 2023 10:30:55 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id l7-20020a4abe07000000b0053e1205c84bso2189032oop.9;
        Wed, 29 Mar 2023 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680111054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2IPudqLQnBF6M0Cb+sHJqpiyOjjt5yWTuSQtgO57oM=;
        b=Q8+YeanEpf/SrDNg8nrGpxL7PTrLvQEfhSFAYYcuKvNSKqKuqGWknevyESHXx0I5Z/
         GMYJZY7b7Hug1vmkBmhqrFJe1N3TqVTi+7ReyDwouTGpW8X0Oi/abMeHBBLvNdHamwM5
         f8nKWOzxYcb4rvHJY91frT56FbwjrPAsdTJr/qkjlaLUoLD+bu8yN5rM2bm5Aao3ceJE
         iEAiGYsJ9e6i+O8NIHv+FzGB5U9TgTB3N3hUmRfhn0GLUtQ28aUKr5CoKv4H4/Lt6zJ2
         ZK4uXM4edeOazX08ps4D+8nSbotnxdQgEiQ1DjIJWCpKVF+dIDkRvH5rgSFufM1WHs2k
         GtTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111054;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t2IPudqLQnBF6M0Cb+sHJqpiyOjjt5yWTuSQtgO57oM=;
        b=bEgY9AbgP8I0dIZiQ22bKE2kCrgZUNINv46qGDHf111fP02EOoxZQKDGI40CfYcyGz
         fwMnDEBzHDjcnOAO/CTk35VH8L92G0FwhAcdUe3d7uSMA7ylNFm058AySourXpoHgSL8
         TKiPxyEVgC40iLgDxO+Vy4V0Z4PJQ/atg2EmW7TXUIB2aujVf3pFTAl8YR09O4iEbUet
         JLFpWw4Yo6uoqeZfKP2Bvow1BOZOQpECv6g7q7jYd+CkaaaYZS4k1kBgWbjjqoiaIkBj
         UYt9U/Lmy/xhU91OCeWIIu5wKX+HRe6g/Ec2fIguOkbmHmEscGJhqMSVcLbKRv+SARtI
         REFw==
X-Gm-Message-State: AO0yUKULUdyyOjUpLLM1fm/14Q8lPpPaQhsmxo+bMSXKyZc2vTNtfr0t
        XAa0Fa9yAsR5lMIxRIi6Neiiaz6ySwxqd0jDvAc=
X-Google-Smtp-Source: AK7set/PYDGb/qktpF5+p6KZzT9FAS8IXhgUr0yK9clidh9mIEJ0n7X2fd4eNmJxGIBD6hMIGDshYwZ32Q4NpJTf6vU=
X-Received: by 2002:a4a:d0d4:0:b0:53b:57cf:d23c with SMTP id
 u20-20020a4ad0d4000000b0053b57cfd23cmr7236916oor.1.1680111054642; Wed, 29 Mar
 2023 10:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230329140445.2180662-1-konrad.dybcio@linaro.org>
 <ZCRNFitcrAeH27Pn@hovoldconsulting.com> <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
In-Reply-To: <83986fa9-c9eb-ae5a-b239-584092f2cea5@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 29 Mar 2023 10:30:43 -0700
Message-ID: <CAF6AEGsYimELcEAs8hdkYqdMzteMwzhPFavvmEUiEFsO01RrrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: adreno_gpu: Use suspend() instead of
 idle() on load error
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        andersson@kernel.org, agross@kernel.org,
        marijn.suijten@somainline.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Johan Hovold <johan+linaro@kernel.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nathan Chancellor <nathan@kernel.org>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 8:48=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linaro=
.org> wrote:
>
>
>
> On 29.03.2023 16:37, Johan Hovold wrote:
> > On Wed, Mar 29, 2023 at 04:04:44PM +0200, Konrad Dybcio wrote:
> >> If we fail to initialize the GPU for whatever reason (say we don't
> >> embed the GPU firmware files in the initrd), the error path involves
> >> pm_runtime_put_sync() which then calls idle() instead of suspend().
> >>
> >> This is suboptimal, as it means that we're not going through the
> >> clean shutdown sequence. With at least A619_holi, this makes the GPU
> >> not wake up until it goes through at least one more start-fail-stop
> >> cycle. Fix that by using pm_runtime_put_sync_suspend to force a clean
> >> shutdown.
> >
> > This does not sound right. If pm_runtime_put_sync() fails to suspend th=
e
> > device when the usage count drops to zero, then you have a bug somewher=
e
> > else.
> I was surprised to see that it was not called as well, but I wasn't able
> to track it down before..
>
> >
> > Also since commit 2c087a336676 ("drm/msm/adreno: Load the firmware
> > before bringing up the hardware") the firmware is loaded before even
> > hitting these paths so the above description does not sound right in
> > that respect either (or is missing some details).
> ..but I did some more digging and I found that the precise "firmware"
> that fails is the ZAP blob, which is not checked like SQE in the
> commit you mentioned!
>
> Now I don't think that we can easily check for it as-is since
> zap_shader_load_mdt() does the entire find-load-authenticate
> dance which is required with secure assets, but it's obviously
> possible to rip out the find-load part of that and go on from
> there.
>
> Do you think that would be a better solution?

Hmm, to hit this it sounds like you'd need all the fw _except_ the zap
in the initrd?

BR,
-R

> Konrad
>
> >
> >> Test cases:
> >> 1. firmware baked into kernel
> >> 2. error loading fw in initrd -> load from rootfs at DE start
> >>
> >> Both succeed on A619_holi (SM6375) and A630 (SDM845).
> >>
> >> Fixes: 0d997f95b70f ("drm/msm/adreno: fix runtime PM imbalance at gpu =
load")
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >>  drivers/gpu/drm/msm/adreno/adreno_device.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/=
drm/msm/adreno/adreno_device.c
> >> index f61896629be6..59f3302e8167 100644
> >> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> >> @@ -477,7 +477,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device =
*dev)
> >>      return gpu;
> >>
> >>  err_put_rpm:
> >> -    pm_runtime_put_sync(&pdev->dev);
> >> +    pm_runtime_put_sync_suspend(&pdev->dev);
> >>  err_disable_rpm:
> >>      pm_runtime_disable(&pdev->dev);
> >
> > Johan
