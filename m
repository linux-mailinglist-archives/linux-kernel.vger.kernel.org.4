Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9FA606142
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiJTNOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiJTNOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:14:35 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C561FF93
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:14:01 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so11366086otp.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u0+uDTLiSxgXk5TNHxXL03uQzfakDOtS8Qg9Ra2ST6U=;
        b=bIHISWEu+A1kb4nsc5ajKrDMtLpPAo/s4FYHDz95KD8eeK1s4R8ES/qAXqx05A8Xwh
         PhGN3980e9ybQtn8YsabSGIkUnaePSfiMS09+WT4rxBGMtjDH29j0mKT3/aIie156yN9
         Wc3htvRPUI97m3x5HhiSZrJA4Ch2aBqUY/BVO27eKUWSTqkyxiMKvbn/JjXHCPaFxtWc
         Hv3ntlc8EKRbb2Yn8ULdtpdlHU9ZmF08DOSZbBr02QH+k42U6cfu9G3cyZk/p1qbIWD8
         1272n1itRVgwXnayL1g9XPJw0L+Prv0GaoCcZRR5vjLssAyeDQrgmBbtlp7TNvGNmhJX
         9seA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0+uDTLiSxgXk5TNHxXL03uQzfakDOtS8Qg9Ra2ST6U=;
        b=HMTyWEY/Tae44DKI7C2OypZW7+WsdL5DyCG2ZLrYrfYMPjL6NDZd3cXDewy/UPzGt3
         1ATCcYDex/RGu8cYFe/kpEVvKpg4iNnYcXpR6qbGXAZK/rAhdGDD1/MY1Ukv/LlCxWEM
         hekAhuhF6Ih2E0o286AvRS+Z6HYEiCPqfhBtZ5PKGvd5WbIAgR3cPq3zJHq2tjlw+tCu
         PnHfshIsvfs40bfKLKil9r9E/H+F7CgHIkXT0wbYTB+z6xEmc2eLQU/G00Ztl41girg8
         aSUn4Lb35mtmpoIbmEK0HKDJ1PI+VQpHx8S2EY8SqquQaw2dthTMxzKgemJvTZZloffK
         gyLw==
X-Gm-Message-State: ACrzQf34AezcqsNObdThVAOWxHN2NBkpnw2K6zj2rDkFNDpGwfYV8s6l
        B4hMIxtjPrtVThVI8rLg7U1rBxtOPkTm4FgTtTA=
X-Google-Smtp-Source: AMsMyM6842vpHVdqDrFoBPGHYpKmR0VIvXOGeO6/O+xzMcfkIdqXt3vuft4DKch3kwVV7F4YQ6X47YLJQXnAzVLuCHU=
X-Received: by 2002:a9d:6645:0:b0:661:b778:41b8 with SMTP id
 q5-20020a9d6645000000b00661b77841b8mr6967997otm.233.1666271510132; Thu, 20
 Oct 2022 06:11:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221019063115.3757510-1-ruanjinjie@huawei.com> <faaae681-65b7-0cc5-d413-b8995978d2c5@amd.com>
In-Reply-To: <faaae681-65b7-0cc5-d413-b8995978d2c5@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 20 Oct 2022 09:11:38 -0400
Message-ID: <CADnq5_MX4irT51Th6OaQNONohxO85wyf5g5YLX73jOxTyJVetw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: make dcn32_mmhubbub_funcs static
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     ruanjinjie <ruanjinjie@huawei.com>, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, jiapeng.chong@linux.alibaba.com,
        aurabindo.pillai@amd.com, isabbasso@riseup.net,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Oct 19, 2022 at 9:27 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
>
>
> On 2022-10-19 02:31, ruanjinjie wrote:
> > The symbol is not used outside of the file, so mark it static.
> >
> > Fixes the following warning:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_mmhubbub.c:214:28:
> > warning: symbol 'dcn32_mmhubbub_funcs' was
> > not declared. Should it be static?
> >
> > Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >  drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
> > index 41b0baf8e183..c3b089ba511a 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mmhubbub.c
> > @@ -211,7 +211,7 @@ static void mmhubbub32_config_mcif_arb(struct mcif_wb *mcif_wb,
> >       REG_UPDATE(MCIF_WB_ARBITRATION_CONTROL, MCIF_WB_CLIENT_ARBITRATION_SLICE,  params->arbitration_slice);
> >  }
> >
> > -const struct mcif_wb_funcs dcn32_mmhubbub_funcs = {
> > +static const struct mcif_wb_funcs dcn32_mmhubbub_funcs = {
> >       .warmup_mcif            = mmhubbub32_warmup_mcif,
> >       .enable_mcif            = mmhubbub2_enable_mcif,
> >       .disable_mcif           = mmhubbub2_disable_mcif,
>
