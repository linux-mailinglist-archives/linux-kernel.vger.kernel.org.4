Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9FC73D7DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 08:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFZGlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 02:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjFZGlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 02:41:00 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54E4E53
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:40:59 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b539d2f969so18935475ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 23:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687761659; x=1690353659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wCvhmw6kQ3uIEC+j3cMfVpnKpQgeWiOzs7p2WmB390U=;
        b=MSytMtpeRgD+BJOYnum8eNk1TX39UQBuzR7uywCe7S/gGv+jsYI7h/lsQuArTIHyKb
         iLTeLhFe4q0O3A0AL7eF5LbgfAYtGJBevux3hxssmb2oTsiUtF+jbs/lVC8+CcVOL63R
         mzQkmgd72MsM+MD6YI0lhia8ZZYEQyJzjPDKznm+qOQ3ZpRzv281V3WiE20tzUNawxWy
         mg0+UMxSywChp1cai8Es9IyTr6R1XZU1Z5cz0RdTOitqCXbDihVUBBADgi/PxSMwWRPj
         /2TuyBHP5LrIl4LAO/Bd9pBu9jMOqsLirvxPQtCwg8BwVy3zfZMspNbBH8Lp/8ZWXOOp
         MI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687761659; x=1690353659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCvhmw6kQ3uIEC+j3cMfVpnKpQgeWiOzs7p2WmB390U=;
        b=Eq3o6Nua+GDwf3QNiU27oviboUtVzXKhLZ9UxSS3eIEFRLAlXfh/zQ13LjQ4d1MJvT
         WYXtkOhQRCL6tRj/IYu7ocQ4GPaMU6WgV5UNrZvVg2sKMSBrl1NwnFOdw2tV+b5u/l+b
         ibaftWI/FC9n7eFHiYcGbQ654eN+KvNTonchyvgeGcVuz7mdPS9RcV0IPxziY97+ULVi
         3vfa/EUwq2HkNFvt7xaKPN+MbAQzhIBu2nd5cIHY1lfsW10JwYsIR47gUPUAOwEXbzI3
         lEuvvmbStKI8rpXFphrPTPTslBGcuK2fgSQCGuNaOCoee10nb5gMsHgs9bG3wDUUBPTl
         Jvqg==
X-Gm-Message-State: AC+VfDzcuykNC1uvvTxbR7aCYso8OUiH+sNgzMHG5WTOI+xAzCE9WR4H
        HrMZ6xRokjqB1IpYRyoO44BbXTvZg99tjX5jS2w=
X-Google-Smtp-Source: ACHHUZ4aHnLLTVQX/qVAaEokz/PHrm2f1vkr165KYamNRKv51JFJ/AfpRWQFAHqPrsXlrD8ZQa96zQ==
X-Received: by 2002:a17:902:e751:b0:1b0:3ab6:5140 with SMTP id p17-20020a170902e75100b001b03ab65140mr8635258plf.4.1687761659122;
        Sun, 25 Jun 2023 23:40:59 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001b02162c86bsm3408776plg.80.2023.06.25.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 23:40:58 -0700 (PDT)
Date:   Mon, 26 Jun 2023 12:10:56 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        sboyd@kernel.org, nm@ti.com, vireshk@kernel.org
Subject: Re: [PATCH] OPP: Use dev_err_probe() when failing to get icc_path
Message-ID: <20230626064056.46xavabpyarxqhz3@vireshk-i7>
References: <20230623155338.943655-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623155338.943655-1-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-06-23, 10:53, Andrew Halaney wrote:
> This, in tandem with dynamic debug, can print useful information about
> -EPROBE_DEFFER like below, and keeps similar behavior for other errors:
> 
>     [   16.561072] cpu cpu0: error -EPROBE_DEFER: dev_pm_opp_of_find_icc_paths: Unable to get path0
>     [   16.575777] platform 18591000.cpufreq: deferred probe pending
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/opp/of.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e6d1155d0990..1f0923cc1cd9 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -513,11 +513,7 @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
>  	for (i = 0; i < num_paths; i++) {
>  		paths[i] = of_icc_get_by_index(dev, i);
>  		if (IS_ERR(paths[i])) {
> -			ret = PTR_ERR(paths[i]);
> -			if (ret != -EPROBE_DEFER) {
> -				dev_err(dev, "%s: Unable to get path%d: %d\n",
> -					__func__, i, ret);
> -			}
> +			ret = dev_err_probe(dev, ret, "%s: Unable to get path%d\n", __func__, i);
>  			goto err;
>  		}
>  	}

Applied. Thanks.

-- 
viresh
