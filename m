Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A816759DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjATQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjATQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:26:02 -0500
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADF975731;
        Fri, 20 Jan 2023 08:25:59 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id kt14so15313803ejc.3;
        Fri, 20 Jan 2023 08:25:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=23gZa1/a3V23pC8XL6MRmU2/xwtQsgJPUTgG2v8KibA=;
        b=Uz1Tii+PvQG0IScjnH5G17GkFuygL16/U/EIGuRA79GkoHUvpHwoHvlEqsFWQ+mmkf
         0at1LFscW6NQulKm21rfuiTFiergUzAZy/dK6lU7qeV/ceVkj5xY2UBg1zD1qkrFamWU
         1ybdCbLSj+eNh1qVCVlAgr5fKCRk1LoPzFkfOUsTd9juKB7q5cQnmGBphpRSuV2nnJeV
         0fLWCfEz8GsRFnUA957TKuKd14WeuA2cWVKKj+82/JGomTxDl+XEJG5DmlYCU+A+aKT7
         QCxin12AgA5qNfWAMuSuqLlZtv+o9ebe6KWZMg3VUmQ4hcV7Je5oAYdZMguygi6R9R9g
         7kiw==
X-Gm-Message-State: AFqh2kqlfrBHKnx2S70Wf2sHBlan1E5pPZnRULimi3f/XVHJrrowJBKd
        RShIhBtQGWDEPHixQWWQBpM2b0uYA2+FFaQbzpmAacwE
X-Google-Smtp-Source: AMrXdXt2Z91xwDps2pjwJwGVsru8N4HEf3/Q/dO4rivGKSa1QTfR+xcTtwK/CEQ0WViamsa2bxz1dFv00RaDha0uETs=
X-Received: by 2002:a17:907:8b88:b0:872:dae4:1ef7 with SMTP id
 tb8-20020a1709078b8800b00872dae41ef7mr1329357ejc.84.1674231958341; Fri, 20
 Jan 2023 08:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20230104143602.23792-1-rui.zhang@intel.com>
In-Reply-To: <20230104143602.23792-1-rui.zhang@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 17:25:47 +0100
Message-ID: <CAJZ5v0jMNQOwQe3meKq6XAp3hnrxDFNQpW2kgrRDZ7nkoq-pJQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powercap: intel_rapl: add support for METEORLAKE
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 3:29 PM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Add METEORLAKE to the list of supported processor models in the Intel
> RAPL power capping driver.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/powercap/intel_rapl_common.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
> index 26d00b1853b4..ca6ff27b4384 100644
> --- a/drivers/powercap/intel_rapl_common.c
> +++ b/drivers/powercap/intel_rapl_common.c
> @@ -1113,6 +1113,8 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,          &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,        &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_S,        &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE,          &rapl_defaults_core),
> +       X86_MATCH_INTEL_FAM6_MODEL(METEORLAKE_L,        &rapl_defaults_core),
>         X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,    &rapl_defaults_spr_server),
>         X86_MATCH_INTEL_FAM6_MODEL(LAKEFIELD,           &rapl_defaults_core),
>
> --

Applied as 6.3 material along with the [2/2], thanks!
