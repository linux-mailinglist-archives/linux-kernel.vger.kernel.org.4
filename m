Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF92270FED8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbjEXT5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjEXT5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:57:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80927BB;
        Wed, 24 May 2023 12:57:14 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f50020e0f8so1570395e9.0;
        Wed, 24 May 2023 12:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684958233; x=1687550233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLol2IdG4tTK63mTrrC65nNHk/pVjGyfhzUsaldNnBk=;
        b=G7ncb83k6LQKm4TA6W8AROPkYABYE7pgkllGjDlcuXQeoPCNzJvNzluBC/7PZTka6x
         FvoR0vRJr47+DoT+5n15N7HjVS22tot5bIU+CyJnmdc0nR1kQmHNkyM9TbtDI1bjpvcx
         XQ6j0VGm009DsNiv5h/PK3nUHWmuUxc/Y6b1q+lc8wz83Ke0QCrDrkxob77PhjPSBccY
         iQNYutqk9RtaTilv2/i+6Uo0gsKVVyckZa1otPPUAzJJTQ4APj5RaOEEtC9Mv2diO1nc
         KgE/j8F9KJHiAX8venSRAtZsDeFdPdDNY0EhEl2aqZxy1h4dtWgm1sbGSI/lYvIZO0hE
         hJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684958233; x=1687550233;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yLol2IdG4tTK63mTrrC65nNHk/pVjGyfhzUsaldNnBk=;
        b=ewQChUXuOYvJXNduiM4Htm0tqjfSksCvkUCZeVTb2a9Dw6biPi9nlNSodT99QlJIBR
         XJAdETYh/YneJr/qaw+MYqjVAzWdhHhtRDZQFWkS2ThzrJ0oiCpMmKyV1ZxltQBIUvQj
         5AgYehq09Q6BPsCvlMR7DH8zyGKiYnQm3bEAyENzN1+xvaivi+Vp5G+CpIJ3GKBVFEbT
         6hzAy7pVSkX8NlHyCGWeYQkGEFIpMwl13lqYyBx7H0YWxAj8BlGATKd9Ok1sN+PdgQ3d
         qk9LCy6+zwhkdeWr4Yt+fjhTOvGw+kgIfsnkybBksFLDMEE0S+THfu3Lpx7grww8LWUg
         +Mnw==
X-Gm-Message-State: AC+VfDyNkBY0+RBqJxZlfRz6z5ruw147x7QBv2+XjK2ka3zdh2zMXquO
        sMv7ZExmo0S+QyQduVxK+81PR5oVCh0=
X-Google-Smtp-Source: ACHHUZ5MoIZWNi8KTk2LS8ssuAMv1c03F7t1QKhwYBJ1OG8luCaLVb0GQRdQm8SsweRE14dNgL1MOw==
X-Received: by 2002:a05:600c:3ac3:b0:3f6:335:d8f0 with SMTP id d3-20020a05600c3ac300b003f60335d8f0mr272776wms.13.1684958232656;
        Wed, 24 May 2023 12:57:12 -0700 (PDT)
Received: from Ansuel-xps. (93-34-93-173.ip49.fastwebnet.it. [93.34.93.173])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c228a00b003f42461ac75sm3341565wmf.12.2023.05.24.12.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 12:57:12 -0700 (PDT)
Message-ID: <646e6c18.050a0220.12e7c.6043@mx.google.com>
X-Google-Original-Message-ID: <ZG5sFzJwU1wW5V34@Ansuel-xps.>
Date:   Wed, 24 May 2023 21:57:11 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Trilok Soni <quic_tsoni@quicinc.com>,
        Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 2/4] soc: qcom: smem: introduce qcom_smem_get_msm_id()
References: <20230524162329.819770-1-robimarko@gmail.com>
 <20230524162329.819770-2-robimarko@gmail.com>
 <47c0faf0-f855-d3c4-6825-e51a1a1a7c83@quicinc.com>
 <d9406953-6452-2394-ab3f-4ce1d8986fce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9406953-6452-2394-ab3f-4ce1d8986fce@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:27:03PM +0200, Konrad Dybcio wrote:
> 
> 
> On 24.05.2023 20:16, Trilok Soni wrote:
> > On 5/24/2023 9:23 AM, Robert Marko wrote:
> >> Introduce a helper to return the SoC SMEM ID, which is used to identify the
> >> exact SoC model as there may be differences in the same SoC family.
> >>
> >> Currently, cpufreq-nvmem does this completely in the driver and there has
> >> been more interest expresed for other drivers to use this information so
> >> lets expose a common helper to prevent redoing it in individual drivers
> >> since this field is present on every SMEM table version.
> >>
> >> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >> ---
> >>   drivers/soc/qcom/smem.c       | 19 +++++++++++++++++++
> >>   include/linux/soc/qcom/smem.h |  2 ++
> >>   2 files changed, 21 insertions(+)
> >>
> >> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> >> index 6be7ea93c78c..0d6ba9bce8cb 100644
> >> --- a/drivers/soc/qcom/smem.c
> >> +++ b/drivers/soc/qcom/smem.c
> >> @@ -14,6 +14,7 @@
> >>   #include <linux/sizes.h>
> >>   #include <linux/slab.h>
> >>   #include <linux/soc/qcom/smem.h>
> >> +#include <linux/soc/qcom/socinfo.h>
> >>     /*
> >>    * The Qualcomm shared memory system is a allocate only heap structure that
> >> @@ -772,6 +773,24 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
> >>   }
> >>   EXPORT_SYMBOL(qcom_smem_virt_to_phys);
> >>   +/**
> >> + * qcom_smem_get_msm_id() - return the SoC ID
> >> + *
> >> + * Look up SoC ID from HW/SW build ID and return it.
> >> + */
> >> +int qcom_smem_get_msm_id(void)
> On top of Trilok's point, this should return le32, or at least unsigned int.
> 

Mhhh why unsigned? We would lose error and qcom_smem_get can return all
sort of errors. Also I think le32 is problematic as we are converting
the value with __le32_to_cpu.

> >> +{
> >> +    size_t len;
> >> +    struct socinfo *info;
> >> +
> >> +    info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
> >> +    if (IS_ERR(info))
> >> +        return PTR_ERR(info);
> >> +
> >> +    return __le32_to_cpu(info->id);
> >> +}
> >> +EXPORT_SYMBOL(qcom_smem_get_msm_id);
> > 
> > EXPORT_SYMBOL_GPL please?
> > 
> > Please change it for other symbols in the driver as well w/ separate patch.
> > 
> > ---Trilok Soni
> > 
> > 

-- 
	Ansuel
