Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C672617C8A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiKCM3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbiKCM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:29:00 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D9BF7A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:28:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 64so1526397pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvgX6ikZPni7jkpkvXbOwi0lz3HvKft3SvDqE9pJ2xU=;
        b=WyrnXRZT3Uw1ORHTuUhT8HNqidfzc/clXoM6HVa5dwhaCAmIj1oPOdCbKnG9YHBil7
         eZ2jqBre98HZk2J35iQkISx7sC1/cOcB5nb+ZNqGNBQDjMdCrbPoB5S+tv6239aE8V1s
         k89s6rvO0CtOC+GQC4xOk04j48iZ59MnDgK+RPP0DV6ANxWkmLwjOlo1pNYkmm+8KTHK
         40UAHkuEOGZU/xlGA6kkT6iz1JPcu4UTjKgCsS0UmCSoqKLNBGa4I4MYSdQZ2UW9pKtn
         rk3dVMHGJOzkCVFSXE0f/Vz1Klf4uCdnz+V5Ejnzclqgb2dT0fgs8ISNUimcD7ZK79Q/
         6nlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvgX6ikZPni7jkpkvXbOwi0lz3HvKft3SvDqE9pJ2xU=;
        b=IouaYsFb4NuB20Dgh3e/k8lEW+DAZOFgZUuIpXJD27x5ism0mm8uxlm5VeY4QtIAs2
         LIi71R2tEBwDXin/bvYkvyz2lV1rYRKVDOq3LAM6rNPmdkRB2140v7Usu2mnokzJpUpb
         7wP4X0rfFRRt8yMITc73VKX2VrMX2+/LR6lWjVbqSC9tKXCXmlcFMoJ1GjoPKCf5p229
         whMkfrJt94pg4QHGzfsY30L99X3GCcCA5szmrVaLNY1m6JEx1sOGP0o8dCgQmerf1Ti6
         KmX15HLCOdpOezfs5fuwmZm/cOsCyjNiLJrSXrrgCVw6idj1tL/E5fC0IyufO9m/my7S
         wheg==
X-Gm-Message-State: ACrzQf27eyaLM4BGxClecX9MVTlR7Nlx6VFf4E3005Vd47C9s6zcv0RW
        36Qpx08jiQvlpP8vBIyBElnk
X-Google-Smtp-Source: AMsMyM7IgbklEQwLyfEerx5Y4/DIC4P9MoC9GwY02mCKjFxupeSyqgi6vMMbfF4T4PW2ljR+mFibkA==
X-Received: by 2002:a63:4f09:0:b0:440:4706:2299 with SMTP id d9-20020a634f09000000b0044047062299mr26472031pgb.115.1667478538121;
        Thu, 03 Nov 2022 05:28:58 -0700 (PDT)
Received: from thinkpad ([59.92.102.81])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b00172fad607b3sm510757plh.207.2022.11.03.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 05:28:57 -0700 (PDT)
Date:   Thu, 3 Nov 2022 17:58:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, quic_cang@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, dmitry.baryshkov@linaro.org,
        ahalaney@redhat.com
Subject: Re: [PATCH v2 06/15] dt-bindings: ufs: Add "max-device-gear"
 property for UFS device
Message-ID: <20221103122850.GD8434@thinkpad>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
 <20221031180217.32512-7-manivannan.sadhasivam@linaro.org>
 <1fe8fd96-7770-0bda-c970-aa38d030ff3b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1fe8fd96-7770-0bda-c970-aa38d030ff3b@linaro.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 03:09:50PM -0400, Krzysztof Kozlowski wrote:
> On 31/10/2022 14:02, Manivannan Sadhasivam wrote:
> > The maximum gear supported by the UFS device can be specified using the
> > "max-device-gear" property. This allows the UFS controller to configure the
> > TX/RX gear before starting communication with the UFS device.
> 
> This is confusing. The UFS PHY provides gear capability, so what is the
> "device" here? The attached memory? How could it report something else
> than phy?
> 

This is the norm with any storage protocol, right? Both host and device
(memory) can support different speeds and the OEM can choose to put any
combinations (even though it might not be very efficient).

For instance,

PHY (G4) -> Device (G3)

From the host perspective we know what the PHY can support but that's not the
same with the device until probing it. And probing requires using a minimum
supported gear. For sure we can use something like G2/G3 and reinit later but
as I learnt, that approach was rejected by the community when submitted
by Qualcomm earlier.

> The last sentence also suggests that you statically encode gear to avoid
> runtime negotiation.
> 

Yes, the OEM should know what the max gear speed they want to run, so getting
this info from DT makes sense.

Thanks,
Mani

> Best regards,
> Krzysztof
> 

-- 
மணிவண்ணன் சதாசிவம்
