Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B37617B32
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 12:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKCK7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 06:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKCK7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 06:59:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EB7109B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 03:59:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y13so1243506pfp.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tl6gvrKJpq1c2SMRIQkixJ9RHyBaATDZDYadUE36ADo=;
        b=bGNCz6BI/X3dSE94R0ba6QyEEWxSsYixsiRVc3eqYT+xOJrJYnFPcQEuOt5Xcx7/C+
         mXoyvj4knRHD2V8e2AhNKO2ehdnVWW5DGzf0i7GLopJLbJCzB1IOa4LxKlE03jL31aeP
         lGYxws+DjOh22jTEPQ1PPK7ijJbVvZDFRuR+IbRcPPfawZ/duXNrnhtdNbPKvaos5Qmh
         wQi/gL+CWGshJzmVyNXzucywYJE5kYvkx1+pPAlfVcHHLbDLMBZyyoIx7ygkZNIYkdet
         w6fnn1JgkShaj3tpsQZ/7Pje2xXci6FBs1QMXDnlHvJFRON8KWk4jFt2OTNdAkO1eGRW
         AqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl6gvrKJpq1c2SMRIQkixJ9RHyBaATDZDYadUE36ADo=;
        b=Xo/zQ4uOaxl3xZ0N53rnHrqyzCvoa97qV0gfBysWaYgZvJzKcmf3H8zQVez0WA8axr
         RjAg6hHQgZrNbccTxZPmA/lWNs1/D7INQEnjeHkCX9v3vl3qBOV12pIZ4iWg8kkX1Pjj
         fLjG13Vc2MJ5+373DAtiyKq4EJb88IMItzZR1tmfeT6imFI2j2S8HhZZYPPwvPa3x5aU
         zarsoUjk/NZbzu3cvpkAHAKkJ3+x3zXBf+3Cy4dfNKIVUqpOBLlSgvEiLiIDnywlJcWS
         uc/kGtRDB2HmTTICpOvNrb97RXCCZvVBGUz9QcBe9qG+70U0quNzca47HwhYQXHjiA60
         Ypfg==
X-Gm-Message-State: ACrzQf17/M6UzA0hmvqlzdikoOTHZ+sAvtLKwzgeGJ/x7ioU8iE634mS
        bgaaG35V0U4AiOy3qmhxTva8USfpC9N0+CWn5dPKmg==
X-Google-Smtp-Source: AMsMyM5mH9Kbc/UTomJNMiJt8u9MMUAkTK5EumQHhGigQ8uemLyjJRlEChWmswJsa5eXfWYYXRrGMuDgD1V0RHHk1iM=
X-Received: by 2002:a63:9049:0:b0:46f:59b9:1645 with SMTP id
 a70-20020a639049000000b0046f59b91645mr25122160pge.541.1667473189454; Thu, 03
 Nov 2022 03:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
In-Reply-To: <20221103043852.24718-1-pshete@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Nov 2022 11:59:12 +0100
Message-ID: <CAPDyKFrT46SXxiHw5=q8HwK5PMJCsp+iE8Wm4CsEqfBf6EWicA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
To:     joro@8bytes.org, robin.murphy@arm.com, will@kernel.org
Cc:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, anrao@nvidia.com, smangipudi@nvidia.com,
        kyarlagadda@nvidia.com, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Nov 2022 at 05:39, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> In order to fully make use of the !IOMMU_API stub functions, make the
> struct iommu_fwspec always available so that users of the stubs can keep
> using the structure's internals without causing compile failures.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Joerg, Will, Robin - may I have an ack from some of you for $subject
patch, so I can funnel it via my mmc tree for v6.2?

Kind regards
Uffe

> ---
>  include/linux/iommu.h | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ea30f00dc145..afa829bc4356 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,25 @@ enum iommu_dev_features {
>
>  #define IOMMU_PASID_INVALID    (-1U)
>
> +/**
> + * struct iommu_fwspec - per-device IOMMU instance data
> + * @ops: ops for this device's IOMMU
> + * @iommu_fwnode: firmware handle for this device's IOMMU
> + * @flags: IOMMU_FWSPEC_* flags
> + * @num_ids: number of associated device IDs
> + * @ids: IDs which this device may present to the IOMMU
> + */
> +struct iommu_fwspec {
> +       const struct iommu_ops  *ops;
> +       struct fwnode_handle    *iommu_fwnode;
> +       u32                     flags;
> +       unsigned int            num_ids;
> +       u32                     ids[];
> +};
> +
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> +
>  #ifdef CONFIG_IOMMU_API
>
>  /**
> @@ -600,25 +619,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
>  /* FSL-MC device grouping function */
>  struct iommu_group *fsl_mc_device_group(struct device *dev);
>
> -/**
> - * struct iommu_fwspec - per-device IOMMU instance data
> - * @ops: ops for this device's IOMMU
> - * @iommu_fwnode: firmware handle for this device's IOMMU
> - * @flags: IOMMU_FWSPEC_* flags
> - * @num_ids: number of associated device IDs
> - * @ids: IDs which this device may present to the IOMMU
> - */
> -struct iommu_fwspec {
> -       const struct iommu_ops  *ops;
> -       struct fwnode_handle    *iommu_fwnode;
> -       u32                     flags;
> -       unsigned int            num_ids;
> -       u32                     ids[];
> -};
> -
> -/* ATS is supported */
> -#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> -
>  /**
>   * struct iommu_sva - handle to a device-mm bond
>   */
> @@ -682,7 +682,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>
>  struct iommu_ops {};
>  struct iommu_group {};
> -struct iommu_fwspec {};
>  struct iommu_device {};
>  struct iommu_fault_param {};
>  struct iommu_iotlb_gather {};
> --
> 2.17.1
>
