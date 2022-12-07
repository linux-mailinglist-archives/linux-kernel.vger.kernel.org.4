Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC9C36459F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 13:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiLGMiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 07:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLGMi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 07:38:28 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B1745EDC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 04:38:12 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d3so16892770plr.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 04:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZndbdLLkEgHDKboB3d1cn4QD4Wg2k0brH1CxNqU4OcQ=;
        b=cghZdQlCdDcPw+mYqe1g/MXJ6etr9ARIyt/vjlco2GVQQ9/QHNapSbUAMmJ7sZwS81
         //N1u7Mwkhw+q3y4ax4RK+echFY9sOagZwNWfqz5VHFUmL/KzmNn5V+gASVqOJB0CiZl
         3Hw454NM1jlutmtyQ1u3yMBSDeGRy+FpMo99Shue2AjEYHOwXA4DwZbnmaHtuAn/aWXy
         Vx9RRE/MeNzrDF8GcE+TI459thip53eLlZNvaETWwrvpoY0sLdRQqh8VXm2PhJpB23gk
         fNFQRHPu3Rd4EA7lALHFAmgn+H0DIV72az93XSvz4WVlaCbtALtc4wAJBp6/h3ITb/Db
         TTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZndbdLLkEgHDKboB3d1cn4QD4Wg2k0brH1CxNqU4OcQ=;
        b=OU1ZOyV7n0xOMw0Z0lDzl14av55Olz/BhWdrvawzPq5ZVx5g07MdLdC5wlw2t8gm+9
         gXnobmlxPxwwRcEDlwZ/t051QHDm/fMzcaKGdHAhLBQ546rrTFCpXxWx7aqOZtvtln6G
         l3m5+jEm8zDpb6BHDlnB0rzGBgPuv3KJaDmrt6V1Lo9ETdxtS+2YfoSaESqevWYuylPI
         PlnqLUqQu6hrTo2+cNQrGk/1rdEcYsVzOoU99tphJwi0l19z70CCZIY+DjK5j+DROlyF
         cmA6MKLB7aFvj+7HBjrNaSi1D1jB/b7GTpwH2NATvIAa97/8dS9a6RAswPYnyRO5mn9O
         VP+w==
X-Gm-Message-State: ANoB5pmU4cw1GdELEqkjVpa5BXF5V+wdvlyGTfv4MrKRcZ1pGYb3slth
        edi83+RCpBjQff+HToWNxFPLNLTm1iM627DeUIikSw==
X-Google-Smtp-Source: AA0mqf5bCbCVsLPoFunymX5SQn8AFRqopXvc4v7G31VU4+GH5wg3JcCgLxtEIYkqaJ3mfuDn80lgtIBia0VMaUH6ygg=
X-Received: by 2002:a17:90a:ae0f:b0:20d:b124:33b1 with SMTP id
 t15-20020a17090aae0f00b0020db12433b1mr97405139pjq.202.1670416692492; Wed, 07
 Dec 2022 04:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20221202212119.43214-1-kdasu.kdev@gmail.com>
In-Reply-To: <20221202212119.43214-1-kdasu.kdev@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Dec 2022 13:37:36 +0100
Message-ID: <CAPDyKFpze71CBVoHzGWu++JWBYDgNPUmiAjDg5jm7ABMQZg+Pg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update maintainer for SDHCI Broadcom BRCMSTB driver
To:     Kamal Dasu <kdasu.kdev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022 at 22:22, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>
> Taking over as upstream maintainer for Broadcom SDHCI
> driver from Al Cooper.

Looks like we are keeping Al listed as maintainer too (I am totally
fine by that), but perhaps we should make that clearer in the commit
message?

>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Nevertheless, thanks for helping out! So, applied for next, thanks!

Kind regards
Uffe


> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1daadaa4d48b..90beddcf84b0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18497,6 +18497,7 @@ K:      \bsecure_computing
>  K:     \bTIF_SECCOMP\b
>
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) Broadcom BRCMSTB DRIVER
> +M:     Kamal Dasu <kdasu.kdev@gmail.com>
>  M:     Al Cooper <alcooperx@gmail.com>
>  R:     Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>  L:     linux-mmc@vger.kernel.org
> --
> 2.17.1
>
