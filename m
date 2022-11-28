Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74F63B13E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 19:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbiK1SZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 13:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbiK1SZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 13:25:21 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A732E3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:17:14 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s196so10672671pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 10:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/lZONqS0oTvFRKGgFckYXWS1x3eo8FLZ0ipr+H+hpfI=;
        b=DSRkylWdHzgDfR5RKIZDKx0KgFOBTkM8u5OSWee6ohj2oOkRyAIQX+ksbUqO3oLUsF
         KklkAvEPlIX/xj52cuXLVx8PbxTCPopDAGmwv2+DxA1owzmyetznekBKZ/OFddjA0Rpq
         p4M8olKwonZp5WQaXc33SDWndgnU6dnKCA/UwXnkaHoBDp4pA59ZMoQMkuv2Cv9LXPgm
         06xrDvzfcvf4FxSml+nrdUIgGIw5XKCH8n6py+ht54wGkXTsE+OVmfF8jlO+V5+uXAx5
         cybik47D/4xxfg51dJoAME8PpseNv+ipT4T0QFQL0MAM4KLeUU82SxjlnmFd6mbTSVsA
         EBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/lZONqS0oTvFRKGgFckYXWS1x3eo8FLZ0ipr+H+hpfI=;
        b=ZuYlFV4QuSRJdeac4AnGwsL9YtAcPzM2KJq01GPC9IoiFBJmL8iOrk4lvCFcYlgQHO
         K3kJgK/KOsa0VNTCw089MXfUBcyahrxVVegUTQqgfv/GnxOWrnfazRYGNZN0UaA1Asts
         LpIDewKHs/AvJWTxyUW2PIqFmtGEnac9dGNE6WGUECuj4nt/4FD5iyQhAZr1ou2mnOmX
         33mORROSpiouMzlvLdRlu2LFX/KX6+rz8X9ExngJ9RqIVT0qCvao7OuwacmUOhrkCU+X
         gB41oSbW+5fS+qhFEWJFlNyT+ImSoMZksH7IQvs8rE7oh1FHYS/6XZGv2M8HPo/b4Q3P
         sKtA==
X-Gm-Message-State: ANoB5pluhajqnyDm+88ts9oEuQxFwlgktwt2SqAr+OdudcX6+cZ1wx2g
        OCdtUmoPwJ1jY4nXk09e3XIB
X-Google-Smtp-Source: AA0mqf6AKO2iT+R96zZccRIgRent1ybVJM2Qw0ZR+SFwiQ+1G3NTMorlvZprmT0fXBB8WZWwYelI6A==
X-Received: by 2002:a62:1d4c:0:b0:574:c3ab:86bb with SMTP id d73-20020a621d4c000000b00574c3ab86bbmr16654230pfd.15.1669659434205;
        Mon, 28 Nov 2022 10:17:14 -0800 (PST)
Received: from thinkpad ([117.207.29.115])
        by smtp.gmail.com with ESMTPSA id c80-20020a624e53000000b00561dcfa700asm8376897pfb.107.2022.11.28.10.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 10:17:13 -0800 (PST)
Date:   Mon, 28 Nov 2022 23:47:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     bjorn.andersson@linaro.org, mchehab@kernel.org,
        james.morse@arm.com, rric@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_saipraka@quicinc.com
Subject: Re: [PATCH v4 1/2] EDAC/qcom: Get rid of hardcoded register offsets
Message-ID: <20221128181705.GP62721@thinkpad>
References: <20221116143352.289303-1-manivannan.sadhasivam@linaro.org>
 <20221116143352.289303-2-manivannan.sadhasivam@linaro.org>
 <Y4SmtfSzLbYea+f0@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y4SmtfSzLbYea+f0@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:16:53PM +0100, Borislav Petkov wrote:
> On Wed, Nov 16, 2022 at 08:03:51PM +0530, Manivannan Sadhasivam wrote:
> > The LLCC EDAC register offsets varies between each SoC. Hardcoding the
> > register offsets won't work and will often result in crash due to
> > accessing the wrong locations.
> > 
> > Hence, get the register offsets from the LLCC driver matching the
> > individual SoCs.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/edac/qcom_edac.c           | 116 ++++++++++++++---------------
> >  include/linux/soc/qcom/llcc-qcom.h |   6 --
> >  2 files changed, 58 insertions(+), 64 deletions(-)
> 
> It looks to me like this patch needs to go to stable?
> 

Well, yes but that would imply both LLCC and EDAC patches going together.
Splitting them will break the build, which is worse.

So I delibrately avoided CCing stable list. I'll ping them once both patches
are in mainline.

> Also, the Fixes tag should probably be:
> 
> Fixes: 27450653f1db ("drivers: edac: Add EDAC driver support for QCOM SoCs")
> 
> Yes, no?
> 

No. The actual breakage happened with, a6e9d7ef252c ("soc: qcom: llcc: Add
configuration data for SM8450 SoC"). I didn't add the fixes tag because, the
stable team might backport this patch automatically. And since the tag is not
present in the LLCC patch, it will break the build.

> Also, please explain to me how you've tested this patch if it doesn't
> even build?!
> 
> ERROR: modpost: "__devm_regmap_init_mmio_clk" [drivers/soc/qcom/llcc-qcom.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
> make: *** [Makefile:1944: modpost] Error 2
> 
> I guess because CONFIG_QCOM_LLCC is =y in your config while I have
> CONFIG_QCOM_LLCC=m.
> 
> And I reported the same build error to you the last time. Did you not
> see it?
> 
> For the next version, you'd need to fix all possible Kconfig build
> errors before sending.
> 

Sorry, it is because I only tried building for ARM64 architecture. The error
you are seeing is for x86-64 and I could now reproduce it as well.

Will submit the next iteration including a fix for that.

Thanks,
Mani

> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

-- 
மணிவண்ணன் சதாசிவம்
