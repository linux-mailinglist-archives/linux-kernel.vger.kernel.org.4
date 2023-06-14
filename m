Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D3C72FEDB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244611AbjFNMif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjFNMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:38:33 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9858109
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:38:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc40d4145feso545651276.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686746311; x=1689338311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8zduhsrk2hNlBDcs98TrvnIcL1T9WwwykQFrWXmeXjA=;
        b=nFs7ObQ+lyeAJe+Bwt5fP4QiMSbWF+S5GY4uXuflq8aZRrZgm/e5V7VCvFnsRlVnCX
         l8L6C0jt3CevN5xfhq1pLXdKLMjMI0k1i3/5MzHbWDz6RJz8/AnlwdRRt8xpAnFg0z/f
         seZU9QVxpiEv7zBn1fcoGlslnem+mifZk11jJockxaK/DwQjvYA9NQ1ZYrL/YDY/LA0o
         SZ5CwXyn0t+LCpF4oSxrddPqGZ+K970a4OZ/fCgrYKiCMxmkTOxgg/sxdOvi35t7H5KA
         PO8YYn3pFMh23fRglD57VHJIF+NpwSQacJ1dmeJ/vrcFhJpoOrcNwQAX027MxwdgXIej
         txDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686746311; x=1689338311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zduhsrk2hNlBDcs98TrvnIcL1T9WwwykQFrWXmeXjA=;
        b=YFQ3JnuPn9u+HEx53ZCZGmuaiFaWPwyqS4zd5/xKb3X/E1FlYkMky1zRF0DtP+sS6b
         /e6LcMsyLuAsaGQNVcNYh1bwVjMIpRhkXB0VmoFEeFx2/tiYGHWqqUWZlrg0ziDvrpG7
         HIb93qMB9djjhYdFSbyXTF/ej44elbgpHPABylPg1hoJsX75CUjxITmLVazeQIX8jM4J
         Pblih0lUTXf3P9QbE3bzUgyV8xT4yavbKbe53ujp34aB/NI+dLyS781p196dEvRzBHI5
         pUCxTpgLbOLKCHFBhUYhYI+Wvpsphiy0HQ6ZF0EV1OLwjoeh9HqufAFjmtJtFyCqkmu0
         XtKw==
X-Gm-Message-State: AC+VfDwKRpNzDoHOyQV0fMkzNixJiObgywvVKuTutxJ94VFFlibQbse9
        vivCpsYX+FNoA0GMW3i9So3FY6zX40zhZyqhsj2VCQ==
X-Google-Smtp-Source: ACHHUZ7BCyvM3L3VgG2asz4HO2ruBRCL54IiDh7kRyPpTk5n1wrmy0W2qsyyen6X8qoxeies4gwnY4ytljZZ0A5Yy9g=
X-Received: by 2002:a25:ac19:0:b0:bac:2a78:aaa7 with SMTP id
 w25-20020a25ac19000000b00bac2a78aaa7mr1639626ybi.54.1686746311067; Wed, 14
 Jun 2023 05:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <5437756c65c79f9520886bc54321d39c022c8638.1686739018.git.viresh.kumar@linaro.org>
 <af0fd0fd64f33809875335a9cc2761085c3bd66f.1686739018.git.viresh.kumar@linaro.org>
In-Reply-To: <af0fd0fd64f33809875335a9cc2761085c3bd66f.1686739018.git.viresh.kumar@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 14 Jun 2023 14:37:55 +0200
Message-ID: <CAPDyKFpA2+-aCYGfRQa3PokuYLTCKHufxSUXpktap43aoRu4NA@mail.gmail.com>
Subject: Re: [PATCH 2/2] OPP: Simplify the over-designed pstate <-> level dance
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 at 12:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> While adding support for "performance states" in the OPP and genpd core,
> it was decided to set the `pstate` field via genpd's
> pm_genpd_opp_to_performance_state() helper, to allow platforms to set
> `pstate` even if they don't have a corresponding `level` field in the DT
> OPP tables (More details are present in commit 6e41766a6a50 ("PM /
> Domain: Implement of_genpd_opp_to_performance_state()")).
>
> Revisiting that five years later clearly suggests that it was
> over-designed as all current users are eventually using the `level`
> value only.
>
> The previous commit already added necessary checks to make sure pstate
> is only used for genpd tables. Lets now simplify this a little, and use
> `level` directly and remove `pstate` field altogether.
>
> Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Again, thanks for improving this code!

Only a minor thing below and after that, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/opp/core.c    | 8 ++++----
>  drivers/opp/debugfs.c | 2 +-
>  drivers/opp/of.c      | 5 +----
>  drivers/opp/opp.h     | 2 --
>  4 files changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index bfb012f5383c..48ddd72d2c71 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -245,7 +245,7 @@ unsigned int dev_pm_opp_get_required_pstate(struct dev_pm_opp *opp,
>                 return 0;
>         }
>
> -       return opp->required_opps[index]->pstate;
> +       return opp->required_opps[index]->level;
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_required_pstate);
>
> @@ -943,7 +943,7 @@ static int _set_opp_bw(const struct opp_table *opp_table,
>  static int _set_performance_state(struct device *dev, struct device *pd_dev,
>                                   struct dev_pm_opp *opp, int i)
>  {
> -       unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
> +       unsigned int pstate = likely(opp) ? opp->required_opps[i]->level: 0;
>         int ret;
>
>         if (!pd_dev)
> @@ -2728,8 +2728,8 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         mutex_lock(&src_table->lock);
>
>         list_for_each_entry(opp, &src_table->opp_list, node) {
> -               if (opp->pstate == pstate) {
> -                       dest_pstate = opp->required_opps[i]->pstate;
> +               if (opp->level == pstate) {
> +                       dest_pstate = opp->required_opps[i]->level;
>                         goto unlock;
>                 }
>         }
> diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
> index 0cc21e2b42ff..954ea31a2ff3 100644
> --- a/drivers/opp/debugfs.c
> +++ b/drivers/opp/debugfs.c
> @@ -157,7 +157,7 @@ void opp_debug_create_one(struct dev_pm_opp *opp, struct opp_table *opp_table)
>                              &opp->clock_latency_ns);
>
>         if (opp_table->is_genpd)
> -               debugfs_create_u32("performance_state", S_IRUGO, d, &opp->pstate);
> +               debugfs_create_u32("performance_state", S_IRUGO, d, &opp->level);

I think this should be dropped altogether. The "performance_state"
node is just confusing - and we already have a node for "level" a few
lines above.

>
>         opp->of_name = of_node_full_name(opp->np);
>         debugfs_create_str("of_name", S_IRUGO, d, (char **)&opp->of_name);
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e23ce6e78eb6..e6d1155d0990 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -945,9 +945,6 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>         if (ret)
>                 goto free_required_opps;
>
> -       if (opp_table->is_genpd)
> -               new_opp->pstate = pm_genpd_opp_to_performance_state(dev, new_opp);
> -
>         ret = _opp_add(dev, new_opp, opp_table);
>         if (ret) {
>                 /* Don't return error for duplicate OPPs */
> @@ -1400,7 +1397,7 @@ int of_get_required_opp_performance_state(struct device_node *np, int index)
>
>         opp = _find_opp_of_np(opp_table, required_np);
>         if (opp) {
> -               pstate = opp->pstate;
> +               pstate = opp->level;
>                 dev_pm_opp_put(opp);
>         }
>
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 3805b92a6100..8a5ea38f3a3d 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -78,7 +78,6 @@ struct opp_config_data {
>   * @turbo:     true if turbo (boost) OPP
>   * @suspend:   true if suspend OPP
>   * @removed:   flag indicating that OPP's reference is dropped by OPP core.
> - * @pstate: Device's power domain's performance state.
>   * @rates:     Frequencies in hertz
>   * @level:     Performance level
>   * @supplies:  Power supplies voltage/current values
> @@ -101,7 +100,6 @@ struct dev_pm_opp {
>         bool turbo;
>         bool suspend;
>         bool removed;
> -       unsigned int pstate;
>         unsigned long *rates;
>         unsigned int level;
>

Kind regards
Uffe
