Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA296E4FB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 19:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbjDQRyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 13:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjDQRyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 13:54:09 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2AB777
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:53:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so15756331fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 10:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681754036; x=1684346036;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgoyYDnW3bIE1+yljhW7/iBAMT7lsN3TyOEFvRbUH10=;
        b=EJhrnqAo5r1bSmWzs7C07USLvkz5hS1EbVKEnKfoPs3eGs3QCR/xm+xC45Cbf7BlXA
         oOGy2Ov4MvSlzg40qKckOxufkPEdiqJ5CLAK+Xuqp2u27F6k+rhUEv8/G/oL806P9nC0
         wtRZge/oe+vtD2Hr7mSZ0XAaMqEiuIjk2jAwRM0tVeqpHMQa6e+kWancUuVAfuiKI84G
         8zSJNPQCLoEPiMeC/bbhx4no98Yap6+ue/hKXEEcqw0xrooTR1YVi3BkdwO/wzLR+UkU
         GUd1npSMgjtg0amkn4Pg9Nwgw7mXazyhkh7DV3u076j+2pmQnJpz06fRy1NtAi++yPlD
         2khQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681754036; x=1684346036;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgoyYDnW3bIE1+yljhW7/iBAMT7lsN3TyOEFvRbUH10=;
        b=e9/G9kKOnqk/maRHQ+FrC+SZ4XJUBYQ3cZZxkCHqGz7gttp7e5l64gnp/PFh9bnWQh
         JQxPFoK/nmeMTasvzAdlclqb6v8mt3QpKGxoPW+QWJOWs+E7oA3pnG5t+ADrhIZZauKa
         OZsFgEnMkMMDZZogQ+DkipwD/N3+H4Mt5wmRkDBiLWWNuFwPt4s6tChKBOyR9/QOBtd/
         8H8sqeKLoouBA9bAeJTI4/EHBsg5MP1EyGobFt4Bmqf9gy2uX06p/VdPPjrKpvRUCYdO
         +XDrYOZhut6L5bnw8VCkLMla50gEYPMVWta2Nk1dbyWe0+izXISA1LPTowBkNt+22lfJ
         BkHA==
X-Gm-Message-State: AAQBX9eeh3eHpxf13ZyNKpEiVKHgAlfMKu5GuXzWtoOEFbgdEeZi/5dQ
        2lChIwmwou9UTPqeAaDR+7GXeQ==
X-Google-Smtp-Source: AKy350amMPvVgPAUL6SocxjvTtoFWiqo+FzjMRcTObRsUMzfYWHUYIqXjvSnMBPwgoa4p0rcfGfMbQ==
X-Received: by 2002:a19:7507:0:b0:4ec:85f6:5bf3 with SMTP id y7-20020a197507000000b004ec85f65bf3mr1962145lfe.21.1681754035984;
        Mon, 17 Apr 2023 10:53:55 -0700 (PDT)
Received: from [192.168.1.101] (abyk99.neoplus.adsl.tpnet.pl. [83.9.30.99])
        by smtp.gmail.com with ESMTPSA id 7-20020ac25687000000b004edc2a023ffsm688536lfr.36.2023.04.17.10.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 10:53:55 -0700 (PDT)
Message-ID: <42ed2929-93db-6270-a994-b43eb59c3869@linaro.org>
Date:   Mon, 17 Apr 2023 19:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] clk: qcom: gcc-ipq6018: drop redundant F define
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230417174408.23722-1-ansuelsmth@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230417174408.23722-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17.04.2023 19:44, Christian Marangi wrote:
> The same exact F frequency table entry is defined in clk-rcg.h
> Drop the redundant define to cleanup code.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/clk/qcom/gcc-ipq6018.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq6018.c b/drivers/clk/qcom/gcc-ipq6018.c
> index 3f9c2f61a5d9..350ead66914c 100644
> --- a/drivers/clk/qcom/gcc-ipq6018.c
> +++ b/drivers/clk/qcom/gcc-ipq6018.c
> @@ -26,8 +26,6 @@
>  #include "clk-regmap-mux.h"
>  #include "reset.h"
>  
> -#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
> -
>  enum {
>  	P_XO,
>  	P_BIAS_PLL,
