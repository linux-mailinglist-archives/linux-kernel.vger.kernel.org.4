Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 895DA6CF9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 05:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjC3Dvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 23:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjC3Dvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 23:51:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894774EFC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:51:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d13so16095136pjh.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 20:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680148311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4e9QyhcBsAQeSGpoYgMIf5LsrO1sB7K1qNfkG2NcBE=;
        b=IGlK+xAx2+0Yo/GwhQoVnpdG7PEmhwII1RKRSM+GOod/c9lLkaPb6XcM5TKoWxk0z7
         mSWqiPkChriRIgax0x6qEs5jQ70FlVyEitlkwg9XRKImNomzVXU6+ULPtfkyH5WNT3m5
         Iq1Tm1idufhE/EMzdd1yUnBmm7PRZ42kdRxAqsYsqPvlpW314mWYnkjru2ld3TAYIQlq
         nGGaJo6GoyuqyeESgf4SNVmIgoQpCSUJCPlntSL99grtrcaqKM/Xxukzy2b4qQugf1P4
         44q43Le8uo+fwG9/Cwk8FcNvbQvrDaK895vkWL7y6XzyGVjJoImyzy4w4pjkb8bQJcDa
         FXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680148311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4e9QyhcBsAQeSGpoYgMIf5LsrO1sB7K1qNfkG2NcBE=;
        b=PjwsfaV3OcE3RWTbG3MLGiGNuPmS7NRkJIOyUKTwY1h8USlcioDqMT6RM/RI3e2YLS
         XW0hqux3afvJq3N0NqUET5UsL/icrYGxXE3Oagz8wL4bTbhJ6bfFRnw2iLnwPZH+VqcX
         oMkOnhi21ytmkIrkaGIChZwolTglCc7V10QJl8paXJ0HX/pDg3zhpBPOKXcrltyUj2Bc
         rTluVcNnX60Srf9DnSQYkHzz/cnbqS017NIjryVosWigwJ0HqkPS1PzAeF7MPQdBj3Xo
         Z/OkhQle6+1QpU4OBT464KNbfGXGRV66GKaHmllx0Ob1aYNUgRcmykvPNtSBgRffG7pZ
         4BiA==
X-Gm-Message-State: AAQBX9dG4mQrZ5ct0Yt8wgESKBEhlIWyJirYg+v/bbMJ7BuNP6ysFCv0
        UcBIY/ZQjJHtxIYcqtXj5I3ySQ==
X-Google-Smtp-Source: AKy350Y2dh1VU9r3ACKQ4ZdXYifXV0CkfmucICJZvfWMZ7ipucNyg7ut3lHP/KU0xY8PtNRF+CaEiA==
X-Received: by 2002:a17:90b:4b4e:b0:23f:7e2e:fe13 with SMTP id mi14-20020a17090b4b4e00b0023f7e2efe13mr24105018pjb.0.1680148310985;
        Wed, 29 Mar 2023 20:51:50 -0700 (PDT)
Received: from localhost ([122.172.85.168])
        by smtp.gmail.com with ESMTPSA id iz4-20020a170902ef8400b0019f9fd5c24asm23670525plb.207.2023.03.29.20.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 20:51:50 -0700 (PDT)
Date:   Thu, 30 Mar 2023 09:21:48 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: Add SM7225 to cpufreq-dt-platdev blocklist
Message-ID: <20230330035148.7twrszrlmog2rdzt@vireshk-i7>
References: <20230324-sm7225-cpufreq-v1-1-7c2e9a4ab7e3@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324-sm7225-cpufreq-v1-1-7c2e9a4ab7e3@fairphone.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-03-23, 15:06, Luca Weiss wrote:
> The Qualcomm SM7225 platform uses the qcom-cpufreq-hw driver, so add
> it to the cpufreq-dt-platdev driver's blocklist.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 5ac6b9e5270e..452181434735 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -152,6 +152,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sm6115", },
>  	{ .compatible = "qcom,sm6350", },
>  	{ .compatible = "qcom,sm6375", },
> +	{ .compatible = "qcom,sm7225", },
>  	{ .compatible = "qcom,sm8150", },
>  	{ .compatible = "qcom,sm8250", },
>  	{ .compatible = "qcom,sm8350", },
> 

Applied. Thanks.

-- 
viresh
