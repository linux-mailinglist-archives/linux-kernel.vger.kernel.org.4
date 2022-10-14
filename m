Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3838E5FEFD0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJNOIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJNOIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:08:06 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC4AF1AA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:08:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 10so4894533pli.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 07:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J3Kos8T/8gwRDfo86qMux7ZTf9esBn0HKCg2CDGaa3Y=;
        b=mJiZQUrco6KLnU+2EJD+nCu7NKBLssniMVs2YfsuEY76vJkBH+lk0YwAD9TqHAMI5y
         nze3wLUlWR1oxd0+D+jWnfLNX3K8xFDCIzXLcmQwr1qCngzZrBfrwiduM/hMafC4ZKXC
         0DH5Ick8ddO+uo3Fl/9Plol2uvdXmC+oqd9coWU4dFKRig17PqicrAE89B01lq8868sd
         QiiDQYfqYEFtcXAPBX6TBXyNFNjoB/mkt7Yp7aYE00t8ZmlitRL90WHBvHwjlmiCnoqh
         JMEe5GoABiyylWA6UCXxMLfDGgTdX3MEEWTeIYiorjas7Gv/Jhm/oB0OsClGrAFNC+8M
         iMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J3Kos8T/8gwRDfo86qMux7ZTf9esBn0HKCg2CDGaa3Y=;
        b=RIs9OWNq5Fi3jhXrqeAN2B1U2bzWwpFwwEfhrKOloo+9CmtcjeyRGsUUkKT+xq7JKM
         GVJWyjWNX7j5tS2S8FPkCBKAMZB40CvJTBAkk9K5SUnNQ+YrIRcwUbtfdGfvfAUBn0yt
         jWmyQPt2TT4+6TMnRpw5tgklb6urmIXSR8KnzvIbegEZz5CGbIn0f14/5KjLXWKZQaRE
         bbZO8r7hR8WT9QRX6nuRusXyZeN8PKmUIzoIozeZxF+zdb27m0p4UI5L7m3t/OkxwpuI
         Zq2WgLaAIuprNzD1zVhRIUkkKWBCjPqpBV75DUQPTJbaWv0m3VAWCT2ZsLgNp3d4ujdb
         Xrcw==
X-Gm-Message-State: ACrzQf3unee6PdWAulBZSL+/jOC44rmhTv7VDtp6RnzAc1UlXshg8D+x
        mwk00Msd4Eug6+WyFGTbqsXTbsCiyhouvXaeecz70Q==
X-Google-Smtp-Source: AMsMyM6d5Oxs9VoOobMUSza3K6oIWHJjbDIWXohADgynWSebUrWsBkpRd8G1ySo0x/sB0MMpCRMIwyJOKogTY7PyI2k=
X-Received: by 2002:a17:90a:7b8c:b0:20b:1f3b:f6fd with SMTP id
 z12-20020a17090a7b8c00b0020b1f3bf6fdmr5987167pjc.202.1665756482734; Fri, 14
 Oct 2022 07:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20221013210017.3751025-1-ptf@google.com>
In-Reply-To: <20221013210017.3751025-1-ptf@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Oct 2022 16:07:25 +0200
Message-ID: <CAPDyKFoWy883VqnA8Qmk8OvP2FAQKALys41yDab+YQhs29Y63A@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci-core: Disable ES for ASUS BIOS on
 Jasper Lake
To:     Patrick Thompson <ptf@google.com>
Cc:     Linux MMC Development <linux-mmc@vger.kernel.org>,
        Sangwhan Moon <sxm@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 at 23:00, Patrick Thompson <ptf@google.com> wrote:
>
> Enhanced Strobe (ES) does not work correctly on the ASUS 1100 series of
> devices. Jasper Lake eMMCs (pci_id 8086:4dc4) are supposed to support
> ES. There are also two system families under the series, thus this is
> being scoped to the ASUS BIOS.
>
> The failing ES prevents the installer from writing to disk. Falling back
> to HS400 without ES fixes the issue.
>
> Signed-off-by: Patrick Thompson <ptf@google.com>
>
> Fixes: 315e3bd7ac19 ("mmc: sdhci-pci: Add support for Intel JSL")

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


>
> ---
>
> Changes in v3:
> * Remove redundant MMC_CAP2_HS400 selection
>
> Changes in v2:
> * Only disable ES instead of CQE in its entirety.
> * Target Jasper Lake (JSL)
> * Target ASUS BIOS instead of specific system family
>
>  drivers/mmc/host/sdhci-pci-core.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 169b84761041..34ea1acbb3cc 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -914,6 +914,12 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot *slot)
>                 dmi_match(DMI_SYS_VENDOR, "IRBIS"));
>  }
>
> +static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
> +{
> +       return slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_JSL_EMMC &&
> +                       dmi_match(DMI_BIOS_VENDOR, "ASUSTeK COMPUTER INC.");
> +}
> +
>  static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         int ret = byt_emmc_probe_slot(slot);
> @@ -922,9 +928,11 @@ static int glk_emmc_probe_slot(struct sdhci_pci_slot *slot)
>                 slot->host->mmc->caps2 |= MMC_CAP2_CQE;
>
>         if (slot->chip->pdev->device != PCI_DEVICE_ID_INTEL_GLK_EMMC) {
> -               slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> -               slot->host->mmc_host_ops.hs400_enhanced_strobe =
> -                                               intel_hs400_enhanced_strobe;
> +               if (!jsl_broken_hs400es(slot)) {
> +                       slot->host->mmc->caps2 |= MMC_CAP2_HS400_ES;
> +                       slot->host->mmc_host_ops.hs400_enhanced_strobe =
> +                                                       intel_hs400_enhanced_strobe;
> +               }
>                 slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>         }
>
> --
> 2.38.0.413.g74048e4d9e-goog
>
