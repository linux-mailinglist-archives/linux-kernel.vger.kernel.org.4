Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64B170F477
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 12:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjEXKpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 06:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjEXKpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 06:45:05 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4682297
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:45:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1ae74ab3089so852285ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684925104; x=1687517104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VtRzF/V811hHQRykzcLAvSFnaLT71WU5kRzUX+bgWt4=;
        b=gK22slI4F9VxzMYBSv1MOTCo5S+N/Ky2iaqDfM9pZ0jfk4Fc0rVfCQGAT6vXONAEq5
         A0RyBZYpqWqqP3sx3o4fA6AG1wqodNX7n5+i3YJLDwaY9tAxMy/Fhd4LsYPzllUHRw38
         i8k4+pn0AymobT5Z4+KOqbsUhaL7xF9pKvWPKbhz1iSMxA4oOSnRpL86Pqc58N6voRW2
         PT+dfYD3Ra/Nhb8zYGshciIVccgFmJJvMwMPNSSn/wG7K5nOKfaaQZsaM+U/oXDIen0M
         CJFgjcMQKlFbcS4RJH1AuyV4eR43K4CHpDHfMis5UuilrC4zF4/L+HJz7UGdUndPr8Sm
         KF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684925104; x=1687517104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtRzF/V811hHQRykzcLAvSFnaLT71WU5kRzUX+bgWt4=;
        b=OgTfV+r6FWr+xhup/hMrJ5BRwnRt0Ot1Jh9efBscHE+20CvJCLl3XY/ipHPUP9zgYc
         ShYciNOeDFLqQCoriLDkhJI0uT2JAuVoT6NrCTw94p7MoiQQid5ICCLbrDLXD5R6SvZ8
         JcBh4osbayRcIyGIgnVFmZ/tTxeCnI3y2eanvY870lKOOrMkmf9fY734R5vwiMbWe2z6
         //aXVbQ40x3uCyUnhPho6ew0S/utgpP5GMm+77z3Nk3YsFMAp93DrUl9l35DBYczfxSo
         JmqENJTyvMnMvfdJDIBBGK/AhDNpQHuFE0YD+2CCVHvyOxbCZt7bJBBZKiX+wHoii+WK
         ismA==
X-Gm-Message-State: AC+VfDy1dKigQsKmPRA6q9Yu7SHpGIpcm95ep+Sv2iDHz4wYzeANQmsa
        mMvrK6LN2uu/ywBhqDjg1RMzLA==
X-Google-Smtp-Source: ACHHUZ7yp/3qCuXXyzRjDvlc5CIdAlNssZWI56gB0O/qKx4HHLXmX4FoNbKuolTI1ecTUxOvnQBNhg==
X-Received: by 2002:a17:902:ced0:b0:1af:babd:7b57 with SMTP id d16-20020a170902ced000b001afbabd7b57mr9292713plg.25.1684925103784;
        Wed, 24 May 2023 03:45:03 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id o18-20020a170902d4d200b001ac7ab3e97csm8407519plg.260.2023.05.24.03.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 03:45:03 -0700 (PDT)
Date:   Wed, 24 May 2023 16:15:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Zhipeng Wang <zhipeng.wang_1@nxp.com>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: dt-platdev: Add MODULE_LICENSE
Message-ID: <20230524104501.uhgs6geb5dtk3wnt@vireshk-i7>
References: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524153417.2738448-1-zhipeng.wang_1@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-23, 15:34, Zhipeng Wang wrote:
> Add MODULE_LICENSE to support building as module.
> 
> Signed-off-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 338cf6cc6596..54529aa16d53 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -214,3 +214,4 @@ static int __init cpufreq_dt_platdev_init(void)
>  			       sizeof(struct cpufreq_dt_platform_data)));
>  }
>  core_initcall(cpufreq_dt_platdev_init);
> +MODULE_LICENSE("GPL");

Any specific reason why you need this as a module ? Just curious.

-- 
viresh
