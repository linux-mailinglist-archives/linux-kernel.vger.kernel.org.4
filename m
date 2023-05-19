Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32476709E66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 19:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjESRlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 13:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjESRlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 13:41:14 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E06EF4;
        Fri, 19 May 2023 10:41:13 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3940f546923so2583334b6e.2;
        Fri, 19 May 2023 10:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684518073; x=1687110073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zyC8PnfI9XbbL3zj+lnVWVG5hpCaOmXN3AIjDOl28/4=;
        b=obalH9qRMLvilwY6q3sKWeoK0cZLDmYuPqooShs6Bo6GWuY3cw5Ax/+UWHRhtKsWGF
         1+mJasCGgAtSAUtluHAkY7EOcCoAVqFaImwZdd5zsLdz1Vyf9hu4a/tYqcrHk02E0t3k
         dZCxxsydPp2En9kEb3YxoRJ4qQFNH4yE+QYa2KxdlmUqydsdqkfZhIYK0ewUrc1EU3sG
         q/igIXxQTuvsTVn9eJRk8c0Cjs29WvGzWMrspABgVLhnkA5j9KERZt+Svi3YvIfAkhzR
         d7dtMNl1PJTouGcOI8F1Hemn0wMhZWauSv/Q3hgUltfbIbxnP0ajsV7Ri+pGOaLCBHVB
         d57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684518073; x=1687110073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zyC8PnfI9XbbL3zj+lnVWVG5hpCaOmXN3AIjDOl28/4=;
        b=lbUY8HMhs9D/rxdrHEZNko2SLSFW2leagigvz8Ra5KcD3bPJJnyJJnoLrrTLMnzMmO
         22BGdEDEfRwxonAsfaeiVU88C0kD43z+nfo6lekqWs1k0973GRdF8Cc92u98XJiZQ7Mu
         Sa+veDY84FcaHF0wA97Oh+C04pAe/LFhMP6AbLSmI9RRcqZ8w3Nw6EraeJxFz8+ch62B
         lKyxpPorgCUdRqNkIz0WpHLtwxe2H+ZcBNRcvFb+0FaY1V/1NIR1QSc+UK+K2tnLTyMV
         XfAxnbC5jDTpJR0OTe24QULrR07vyBk8utpoHcjeMZ00tPe46JqfkefgEDv2MAaw+Xv/
         K/SA==
X-Gm-Message-State: AC+VfDyqJqseDa2ZXK4PgSzFrnpfjSHeJasnbcN/3d6Ev5wd/FGxT7nb
        V1WQ2DkZOeVPYzvvltuCVCmTkOYI48nlpbGfCpi68lzc
X-Google-Smtp-Source: ACHHUZ4UrVLa0agrHncr8UIMxx3FQcGtiLA3QhZsr8KzI+qP/P4/TkwFJt/+/sZZthwoJmnOS95iwVJZitvckESHRbc=
X-Received: by 2002:a05:6808:8dc:b0:38e:c2a4:3530 with SMTP id
 k28-20020a05680808dc00b0038ec2a43530mr1408267oij.9.1684518072697; Fri, 19 May
 2023 10:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230411224308.440550-1-marijn.suijten@somainline.org> <e6407312-c2fb-e77e-0c9e-abc2a014464a@linaro.org>
In-Reply-To: <e6407312-c2fb-e77e-0c9e-abc2a014464a@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 19 May 2023 10:41:01 -0700
Message-ID: <CAF6AEGsPOb-EzBjRTZC1ik5QB65E4yVhfFei05uS1+CVAJ4weg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Marijn Suijten as drm/msm reviewer
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 3:46=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On 12/04/2023 01:43, Marijn Suijten wrote:
> > As I get more and more active in the drm/msm space, yet sometimes miss
> > out on patches (where I was involved in previous discussions), add
> > myself as reviewer to make this involvement clear.
> >
> > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > ---
> >
> > Note that this is only a slight commitment from my part to look at
> > patches arriving in this area, most notably on the DPU1 driver and only
> > if day-to-day workload allows for it.
>
> I think Marijn does a good job of reviewing incoming patches in the
> mentioned area.
>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Rob Clark <robdclark@gmail.com>

>
> >
> >   MAINTAINERS | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 04d7c816d46a..fd1b717c57d8 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6536,6 +6536,7 @@ M:      Rob Clark <robdclark@gmail.com>
> >   M:  Abhinav Kumar <quic_abhinavk@quicinc.com>
> >   M:  Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >   R:  Sean Paul <sean@poorly.run>
> > +R:   Marijn Suijten <marijn.suijten@somainline.org>
> >   L:  linux-arm-msm@vger.kernel.org
> >   L:  dri-devel@lists.freedesktop.org
> >   L:  freedreno@lists.freedesktop.org
>
> --
> With best wishes
> Dmitry
>
