Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD72710F06
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbjEYPEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjEYPD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:03:58 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD9D1A7;
        Thu, 25 May 2023 08:03:51 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae852a5330so11074985ad.3;
        Thu, 25 May 2023 08:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685027031; x=1687619031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFWDgwLoLIGdtDuv/GGTEuXOiKPPnGPJBvZ2eBVspSw=;
        b=mDMIy3b5d/VuwXd29pY+JC0GZzsBcOW94M5BLk0jMXH+qdgo2vUJayasFqBrmjIQ8i
         jU1LNPGBo7clGkGDjR+qrAKVG9bu278q5LoREfarBaU5tg2RNjGJGDC0xxlLhUlpnZhl
         w3rCWTqbVWEmx0a643+iM5wacTOUq69iqhVU4yk05Ffd0x+OcqdLap910vQDPguZRNcm
         YSvAva5aazzpyN5M33/IbGo5Uyd2IjTNzhUhuRMNT5q6QUH1LXVpyjxPja11RiprZ6s2
         A9UVmRXjodU6j88THzdbDOmoS1o7h4LM9tqu887w54Q+A3UEx9bXN2XV203gGm9DEG7y
         f7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685027031; x=1687619031;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFWDgwLoLIGdtDuv/GGTEuXOiKPPnGPJBvZ2eBVspSw=;
        b=brAg8LIMD/fd64i1WyrkxVnFhKhb9i6hDaKwi2t4xbCHhUKgfHeyRDysSoECPyDlId
         7CRDlqHW1WUGGVPVroEfk/zwwxoANHpRXIZ2BBkBE5q2toJ3USRGUHHf0DgERHJ/72jQ
         iVgPRUao/eg+SleM8mm4vffZYKY005kzdKo3eCiR3mSbBsWWx0Tu7h1oWzQ5R5nh4KSM
         v/FJRmVUkMfw5cezfd+ISOHCW7B6nopdMMnwQxegqWLXxxWBAwtucceAXqeSfsfuN+V9
         ATaPg6a9U2+NIKaYX7phAHo0q6bLxDLlhw/8Av9aMlCXMJ/TJ8Ngu9uDSESyVzhQI/Zy
         D9Rg==
X-Gm-Message-State: AC+VfDzT863vbUF/GT1qcabwj8zcX+cEyohgPw+lRZiBUpJQgfiiO2Rc
        bl0Z4LIzBWiZmJ5r73D+y16SLX9e7cP+A5+eZBI=
X-Google-Smtp-Source: ACHHUZ5fxV2IcGhqcic1inla7T2BqbywbneYM+KTZcTMjMWKoJ1UC2CMWbRHbwE8e+jTK1UXDw3mdfqpzpOts8zKdPc=
X-Received: by 2002:a17:903:230a:b0:1af:9c18:a160 with SMTP id
 d10-20020a170903230a00b001af9c18a160mr2363679plh.17.1685027030801; Thu, 25
 May 2023 08:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230525120956.3095317-1-robimarko@gmail.com> <20230525120956.3095317-3-robimarko@gmail.com>
 <c4a50acd-2c0a-7c18-95d8-e9145fa1ff24@quicinc.com>
In-Reply-To: <c4a50acd-2c0a-7c18-95d8-e9145fa1ff24@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 25 May 2023 17:03:39 +0200
Message-ID: <CAOX2RU72PFrdJoJfCGB-Q=V781WD6jEJomjkBeY9jsVPG6MOPQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] soc: qcom: smem: introduce qcom_smem_get_msm_id()
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 at 14:59, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
>
> On 5/25/2023 5:39 PM, Robert Marko wrote:
> > Introduce a helper to return the SoC SMEM ID, which is used to identify the
> > exact SoC model as there may be differences in the same SoC family.
> >
> > Currently, cpufreq-nvmem does this completely in the driver and there has
> > been more interest expresed for other drivers to use this information so
> > lets expose a common helper to prevent redoing it in individual drivers
> > since this field is present on every SMEM table version.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v3:
> > * Change export to EXPORT_SYMBOL_GPL
> > * Use an argument for returning SoC ID
> > * Update kerneldoc
> > ---
> >   drivers/soc/qcom/smem.c       | 24 ++++++++++++++++++++++++
> >   include/linux/soc/qcom/smem.h |  2 ++
> >   2 files changed, 26 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> > index bc98520c4969..185ed0da11a1 100644
> > --- a/drivers/soc/qcom/smem.c
> > +++ b/drivers/soc/qcom/smem.c
> > @@ -14,6 +14,7 @@
> >   #include <linux/sizes.h>
> >   #include <linux/slab.h>
> >   #include <linux/soc/qcom/smem.h>
> > +#include <linux/soc/qcom/socinfo.h>
> >
> >   /*
> >    * The Qualcomm shared memory system is a allocate only heap structure that
> > @@ -772,6 +773,29 @@ phys_addr_t qcom_smem_virt_to_phys(void *p)
> >   }
> >   EXPORT_SYMBOL_GPL(qcom_smem_virt_to_phys);
> >
> > +/**
> > + * qcom_smem_get_msm_id() - return the SoC ID
> > + * @id:      On success, we return the SoC ID here.
> > + *
> > + * Look up SoC ID from HW/SW build ID and return it.
> > + *
> > + * Return: 0 on success, negative errno on failure.
> > + */
> > +int qcom_smem_get_msm_id(u32 *id)
>
>
> I think, MSM  is not the only platform which will leverage this API.
> qcom_smem_get_soc_id() / qcom_smem_get_cpu_id() would make more sense
> than qcom_smem_get_msm_id() ?

I agree, qcom_smem_get_soc_id() sounds better to me as its not just MSM parts.
>
>
> > +{
> > +     size_t len;
> > +     struct socinfo *info;
> > +
> > +     info = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_HW_SW_BUILD_ID, &len);
>
>
> len is unused after this, can we just pass NULL? Did a quick check on
> the code, if we pass the address, size of the item will be updated, else no.

Yes, indeed passing NULL works here for the simple case this helper is handling.
Will address in v4.

Regards,
Robert
>
>
> > +     if (IS_ERR(info))
> > +             return PTR_ERR(info);
> > +
> > +     *id = info->id;
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(qcom_smem_get_msm_id);
> > +
> >   static int qcom_smem_get_sbl_version(struct qcom_smem *smem)
> >   {
> >       struct smem_header *header;
> > diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
> > index 86e1b358688a..cb204ad6373c 100644
> > --- a/include/linux/soc/qcom/smem.h
> > +++ b/include/linux/soc/qcom/smem.h
> > @@ -11,4 +11,6 @@ int qcom_smem_get_free_space(unsigned host);
> >
> >   phys_addr_t qcom_smem_virt_to_phys(void *p);
> >
> > +int qcom_smem_get_msm_id(u32 *id);
> > +
> >   #endif
