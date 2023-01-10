Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0D966413C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjAJNIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbjAJNIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:08:01 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD1C58D2B;
        Tue, 10 Jan 2023 05:08:00 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d15so13097909pls.6;
        Tue, 10 Jan 2023 05:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FQjxjJ8qZ3hM4//p+uSuH9Q7xJZ04eDZ+d9MlCyJuSU=;
        b=LgUr5bj4jUS1UqenSM2ILfG6zsJOH+F0qMWYC9g1pA4QVDDuzeFyXrYB2vO1LD5xE7
         pYVnDsyrPR5tyllBDIsqV+EWJDPt3ZQEbIscHV9MdzEWp5isSbTDjbnYoHLgOQhbq4Ez
         DKpoozCOYQLsOTuC0ux/9SuRDmD2FU2852FhJk+YJN7ZE2vLmx4Jt1xsCx6ij5gAw31S
         VJ8V5TbK7f04FmgOJONJnLJFjbqiN3lhtnwojTD46EZleXo43lRHqrZQIpHhSFC4WgWK
         cb/eAE8v7Ry0vTEVLzPQ+x/xjs1AtuV97wQGFHTGUiZHawdxmx/pLBk322EIYPQs7Ikc
         ZDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQjxjJ8qZ3hM4//p+uSuH9Q7xJZ04eDZ+d9MlCyJuSU=;
        b=YvVZB+Qq+wKqyyF746wymntJW+qpOiqd7ZPPkcqw4QY9gSTac2jantVAbKF4iRXaI9
         bEG5tOhdGwOcg2XuqcP2fVQdOuPixpEYznP8bjp4Lwdhd0C0VM+mG45oGd0Y8GVYJg2t
         OgJYHK4Ynka06PCDWY5UREBWhsK0ItphudqoNePIx1KbZcu5KjLWrKBs63txPdXvulJE
         BD/XuWAJc7ERzOI7VOw/id/muUouFaavzaVWkkC6awmIwAVcyz6UbJnwqqs2ewN9SXRe
         Q0KQ9H5/TI1C7AGPsrJD+m02T8q7KOJQM71F0CWfEkheIU+4c2vyJMnSp22dcTpgcpOz
         xlzw==
X-Gm-Message-State: AFqh2krjs7xzDBcL8BDM4wC1PNtkB8fu9Paa++iR5FEOT3eEXPwUSmb5
        xu5T+T+dnYu+jqEc7HJGESI=
X-Google-Smtp-Source: AMrXdXsA7MqFTjg4QFI8+s01CITBAHUQyaihohIza1jiYEYtuLrF/4EZs97vGb6wqfSVmguVodE8bw==
X-Received: by 2002:a17:903:31d5:b0:191:4539:d2c1 with SMTP id v21-20020a17090331d500b001914539d2c1mr67586353ple.47.1673356079207;
        Tue, 10 Jan 2023 05:07:59 -0800 (PST)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b00178aaf6247bsm8097869plk.21.2023.01.10.05.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 05:07:58 -0800 (PST)
Message-ID: <49e7326a-2813-db52-9833-dbd5092cb971@gmail.com>
Date:   Tue, 10 Jan 2023 22:07:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH rcu 12/27] drivers/devfreq: Remove "select SRCU"
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-12-paulmck@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230105003813.1770367-12-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 1. 5. 09:37, Paul E. McKenney wrote:
> Now that the SRCU Kconfig option is unconditionally selected, there is
> no longer any point in selecting it.  Therefore, remove the "select SRCU"
> Kconfig statements.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> Cc: <linux-pm@vger.kernel.org>
> ---
>  drivers/devfreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> index 9754d8b316211..3c4862a752b5a 100644
> --- a/drivers/devfreq/Kconfig
> +++ b/drivers/devfreq/Kconfig
> @@ -1,7 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  menuconfig PM_DEVFREQ
>  	bool "Generic Dynamic Voltage and Frequency Scaling (DVFS) support"
> -	select SRCU
>  	select PM_OPP
>  	help
>  	  A device may have a list of frequencies and voltages available.

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

