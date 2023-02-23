Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0716A1020
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjBWTJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjBWTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:09:26 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7F842BEF;
        Thu, 23 Feb 2023 11:09:21 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id ee7so30849263edb.2;
        Thu, 23 Feb 2023 11:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C17xM/OrSwMCDTbrQggit6Zj2i6Kinsr0xmtLdobdYY=;
        b=rhsPC1rYpQ/PGQYzRCKIzz9qU41E4U3ldw3pIm4MTYCwp4U3i0heM/oeUAFBXo8Qa5
         ryA9Hvb8mujM7ke3GC2sph2O4q4aDGKOTx8cEMVRCEpFXvcG4pZ9G9WCE5HNrpJWl6jG
         t+o7PUn4YtRr5iKBi14ulolk8fBt1UVUCQN4Wrtovj0xhogE/e65TTXSQFoD6D24oIgd
         eovCv8ipr8gPnxQQ69dBaNTcg25Cg5yuyIevupkO/j8VG2ezo2hsfReXzw+ATFtK5Lnm
         TXP4dy8UtG5Ywe31vInHVIRscFSsRPsyw8CcMCy/YkJTwoXFVKUwVTD8G7uHZtt56kOk
         T1wg==
X-Gm-Message-State: AO0yUKXIqtqqhk6IvxpA1PqzNSSu/wah7LGBCeOwiMXLu/Bv0UH8V6dJ
        NbQUN+Eu7/uSRm5tZ6a3DFmwl1mW+4B2NdMCLd/a+ezg
X-Google-Smtp-Source: AK7set/J7qV2pEsaNAj6rR0b5VHNI9oxECmK+6VxcHO1FjWtPf7TDABVUpNgCIDW75gQT7wt2//Mu/u22ABp6FiiSHY=
X-Received: by 2002:a50:bb02:0:b0:4ab:4933:225b with SMTP id
 y2-20020a50bb02000000b004ab4933225bmr5959181ede.6.1677179359178; Thu, 23 Feb
 2023 11:09:19 -0800 (PST)
MIME-Version: 1.0
References: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
In-Reply-To: <20230215123249.4473-1-sumeet.r.pawnikar@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Feb 2023 20:09:08 +0100
Message-ID: <CAJZ5v0jKBWMrUagqS+qUNDKKmQTNPN1GAN2XcPfC8zLACAnc2g@mail.gmail.com>
Subject: Re: [PATCH] powercap: RAPL: Add Power Limit4 support for Meteor Lake SoC
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     rafael@kernel.org, srinivas.pandruvada@linux.intel.com,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 1:46 PM Sumeet Pawnikar
<sumeet.r.pawnikar@intel.com> wrote:
>
> Add Meteor Lake SoC to the list of processor models for which
> Power Limit4 is supported by the Intel RAPL driver.
>
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  drivers/powercap/intel_rapl_msr.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
> index bc6adda58883..a27673706c3d 100644
> --- a/drivers/powercap/intel_rapl_msr.c
> +++ b/drivers/powercap/intel_rapl_msr.c
> @@ -143,6 +143,8 @@ static const struct x86_cpu_id pl4_support_ids[] = {
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_ALDERLAKE_N, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE, X86_FEATURE_ANY },
>         { X86_VENDOR_INTEL, 6, INTEL_FAM6_RAPTORLAKE_P, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE, X86_FEATURE_ANY },
> +       { X86_VENDOR_INTEL, 6, INTEL_FAM6_METEORLAKE_L, X86_FEATURE_ANY },
>         {}
>  };
>
> --

Applied as 6.3-rc material, thanks!
