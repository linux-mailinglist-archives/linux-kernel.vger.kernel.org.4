Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3D67D4A3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjAZSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjAZSuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:50:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CE4126D3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:50:38 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1779906wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/whTD282K6WecPGYHs6gXgw7rwbNpkwpfrS4Ud3OEM=;
        b=KQhZ3EBb7Ll1P2eOPpRQovChfAHLXhEBnBsa2cH4KAhXmTUQFp2fdXv6HJ8HvJTNEj
         gO278RWGJruX+GK6CigrXiriSjJwx4wy2w6/9sP3aIXc20BUB15DFCmMTIoXILdYpoB9
         SnDvQB3A+6sc/nnPWGuU5MqgqCagWNofmN1NvOe5BFb/MZx3mGSwIDZv+WBSifnglctG
         Is7nYK/qauYvWssFU418bAyqMO7qFl/czEU3PZJM5IcZnE6nIRWrhHY+NQYsm/0XJb69
         rO8f5L/96GSsdQAegc7mYDwBvul19Sha0v8r+Lpy98WZu4v3/T1bNlG2pGYiAKfRR10W
         CsPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/whTD282K6WecPGYHs6gXgw7rwbNpkwpfrS4Ud3OEM=;
        b=X4zpUAjpwfDhRo4rnSsu2rwDCZvOTV/zsYXJcamQF1qjUkCm3U4EpFjBrO0vzsZq1G
         zenf6uBSJVsJz1muBu6y6A+DOcmBuj4V6jVL3pk7MK9DMRQvtwPqBtp90u27JRZeiKJf
         dG1utV7QjgvJh0nxGH8SODDi24bL/MB7skGXGV0PmdrupRtFz2A+QJVPKXsnXlwKTH6M
         xGGntUqk7srfo4gCXfIMkVGdjhKdinh4uHs3LTV9hgbsZJaSnS0pkhqf54JHD2/CBKqg
         1WjKtAwoE7NrmWhZz/7wYdqWSemeWimACWAQdox+udNcOzn+t4e11LNWe60kFPorFtmn
         SoAQ==
X-Gm-Message-State: AFqh2kpoFF5NGvYLmtYDH2QBg+bD9a85//+C9i7hKLaQYvMibnSJrq/J
        J760UtzQf+X26+4wTtWAfbON1A==
X-Google-Smtp-Source: AMrXdXv3PKUpNXo2uUsfIjSLP4FdvSGa04WQE2S+MRjCR54k63+fjCwjur4D7WpHQ3oE8IQQ69WHaA==
X-Received: by 2002:a05:600c:1c86:b0:3da:fa75:ce58 with SMTP id k6-20020a05600c1c8600b003dafa75ce58mr39807792wms.21.1674759036713;
        Thu, 26 Jan 2023 10:50:36 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r25-20020adfa159000000b00297dcfdc90fsm2049532wrr.24.2023.01.26.10.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 10:50:36 -0800 (PST)
Date:   Thu, 26 Jan 2023 20:50:34 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: llcc: Fix slice configuration values for
 SC8280XP
Message-ID: <Y9LLehs4PSvHE6qf@linaro.org>
References: <20230126171636.2319496-1-abel.vesa@linaro.org>
 <09bf9907-27b9-146f-4a94-dcab51350d5a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09bf9907-27b9-146f-4a94-dcab51350d5a@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-26 18:25:52, Konrad Dybcio wrote:
> 
> 
> On 26.01.2023 18:16, Abel Vesa wrote:
> > The new values have been taken from downstream kernel.
> > 
> > Fixes: ec69dfbdc426 ("soc: qcom: llcc: Add sc8180x and sc8280xp configurations")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/soc/qcom/llcc-qcom.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> > index 23ce2f78c4ed..5702354fb946 100644
> > --- a/drivers/soc/qcom/llcc-qcom.c
> > +++ b/drivers/soc/qcom/llcc-qcom.c
> > @@ -183,17 +183,17 @@ static const struct llcc_slice_config sc8280xp_data[] = {
> >  	{ LLCC_AUDIO,    6,  1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 0 },
> >  	{ LLCC_CMPT,     10, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 0, 0 },
> >  	{ LLCC_GPUHTW,   11, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> > -	{ LLCC_GPU,      12, 4096, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 1 },
> > +	{ LLCC_GPU,      12, 4608, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 1 },
> priority (the arg right after 4608) should be 0 per downstream

Actually according to Sai's review [1], I need to revert this part.

> 
> 
> >  	{ LLCC_MMUHWT,   13, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> >  	{ LLCC_DISP,     16, 6144, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> >  	{ LLCC_AUDHW,    22, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> >  	{ LLCC_DRE,      26, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> >  	{ LLCC_CVP,      28, 512,  3, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> >  	{ LLCC_APTCM,    30, 1024, 3, 1, 0x0,   0x1, 1, 0, 0, 1, 0, 0 },
> > -	{ LLCC_WRCACHE,  31, 1024, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> > -	{ LLCC_CVPFW,    32, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> > -	{ LLCC_CPUSS1,   33, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> > -	{ LLCC_CPUHWT,   36, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },
> > +	{ LLCC_WRCACHE,  31, 512, 1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },

Same goes for this line above.

> > +	{ LLCC_CVPFW,    17, 512,  1, 0, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> > +	{ LLCC_CPUSS1,   3, 2048, 1, 1, 0xfff, 0x0, 0, 0, 0, 1, 0, 0 },
> > +	{ LLCC_CPUHWT,   5, 512,  1, 1, 0xfff, 0x0, 0, 0, 0, 0, 1, 0 },

As for these 3 slice_ids, I need to doable check.

> CMPT1 (id 34) is still missing.

And Sai also says that CAMEXP0 (the upstream name of CMPT1) needs to be
dropped.

> 
> With that:
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Konrad
> >  };
> >  
> >  static const struct llcc_slice_config sdm845_data[] =  {

[1] https://lore.kernel.org/lkml/8a627cc0-8f9b-0bda-c9b5-6d51a788948a@quicinc.com/
