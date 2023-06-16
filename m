Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216E87337AE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjFPRys convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Jun 2023 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjFPRyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 13:54:45 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E71E5D;
        Fri, 16 Jun 2023 10:54:43 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31125a0a7daso137096f8f.1;
        Fri, 16 Jun 2023 10:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686938082; x=1689530082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhkAUTROFaUUjEikGXHSVm/YcnJD9DlZT+Y4hJhL+z0=;
        b=bXO2KpTppHAXQY9E+7yWBxxyz9Fc1LH7zjxiyMHG8VHxkpHstwod4OIKuGmP7CfIaf
         m0ZitTkeWmgEoilFBECNYBj85eXn2n0CpZOfjl4W6y4vR47/4SnTz7Qs8wMQyFY6/+65
         r0cUpbUvxsOmYR3L4N23UqNizmLAWkmRX07e964QikSK6n6yjVizzddXuv6GFoYm81fk
         K/vrOD9qOw3KK1ZkfMPUIIe/QS0fencltimJwUZF8BfpvMr9RgqM2u8rE4Fmq/4bNDXE
         Csb7bUTlIwLNoeFy+gK64euVG82o+oj5f3uC68sMCiqCwzfVBVadMud4ep1lrUW39Ona
         qRhw==
X-Gm-Message-State: AC+VfDz7EA8DhNrWEPMmOXBPnxLUBvFTri+c7rqyfN1AvKNe3JbS66co
        6tMV9j43cDQEjtmwsZqr93+CRSPDPD1P3fcju18s09GD
X-Google-Smtp-Source: ACHHUZ4GozFfjQAmS8xt49p7A3EIRv01rkC6sJDZtVGaVOtCaOHFoLidDYrSkZ6JkgutziWs+L3bB26lPLKrX1fH/cs=
X-Received: by 2002:a5d:5259:0:b0:2f8:15d8:e627 with SMTP id
 k25-20020a5d5259000000b002f815d8e627mr1801898wrc.7.1686938082205; Fri, 16 Jun
 2023 10:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230616174723.148532-1-wyes.karny@amd.com>
In-Reply-To: <20230616174723.148532-1-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 16 Jun 2023 19:54:30 +0200
Message-ID: <CAJZ5v0j+sdo+_3W1xkgSUTshGhTSzjgZpYK=gApUc9f4+dr5Jg@mail.gmail.com>
Subject: Re: [PATCH] amd-pstate: Make amd-pstate epp driver name hyphenated
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, ray.huang@amd.com, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gautham.shenoy@amd.com, Mario.Limonciello@amd.com,
        Perry.Yuan@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 7:47 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> mode driver consistent with that rename "amd_pstate_epp" to
> "amd-pstate-epp".
>
> Cc: stable@vger.kernel.org
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Acked-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ddd346a239e0..a5764946434c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1356,7 +1356,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>         .online         = amd_pstate_epp_cpu_online,
>         .suspend        = amd_pstate_epp_suspend,
>         .resume         = amd_pstate_epp_resume,
> -       .name           = "amd_pstate_epp",
> +       .name           = "amd-pstate-epp",
>         .attr           = amd_pstate_epp_attr,
>  };
>
> --

I've already applied the one you sent previously.
