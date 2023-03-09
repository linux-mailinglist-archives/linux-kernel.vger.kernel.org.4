Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF636B1815
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 01:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCIArf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 19:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjCIArc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 19:47:32 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A8893133
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 16:47:29 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id n2so240754lfb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 16:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678322848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=437PpNVjqYKGEQeD2jkEFWkG9hQyYDlo2SOUpM3Tg1U=;
        b=F3lW2eiTo0jdTD7TJ1mbsCaB+9kIEq2jUobqVXPzuAgYuQDNKtvwFbE14NfrNnuIU+
         UgqmjoOp5EUB9vxuHqzPN9zU5bley54CSsAWwdfqq3PN2Q5LiKFFqM2cIPx9CUY7yXoK
         Cx1yWP2CLRLxfkMW/M71FelIZQNeW0f0B1du7jFJW4E+R/cOe2Y01hUY3W5T5RHow3wl
         XfY40CVYq6jddsig0khTFRcCtJ8/+OIt+0sCBPk8n5fMpVbcI8vcwcOStamwpp3sKkfg
         KjCZuzpOIDNY4jCMY6nlLoo/uHPC4Vv1V2C0lK/TPGDRbaMo5WJgGUhyjuHnTrtFhq8T
         kX5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678322848;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=437PpNVjqYKGEQeD2jkEFWkG9hQyYDlo2SOUpM3Tg1U=;
        b=NzNUSz0b3kqNmFhH+XSwK0to11DYzENZ7D+sArjqzd9JFlFqWDhaTlnZFCx21/31s/
         S93QX42KlqeAbWiG4s77KLNxRqy87yN5q96HLO6JSvwQNcy9SMaFu7lqyECkWJB+FwiA
         1JYwWCbJeORpacqGlj2nurWnN4hQj9lJLdnIKFs1CtomHpnDS0OZ3TZ++WzIrHRWGjik
         jodZYzuzfQe2TM2p9jfTpY8Yd3Vj4j+ImkoxFsQpedwsNm8pPAzgHz9frKy0K/27XhPZ
         ui4rmAHwve2f/s3uiiUcPRVtBUZW2gDZJ5DLe/5h0bD92HYTUQmVYTtM9I9oS4/oQGFk
         wZTA==
X-Gm-Message-State: AO0yUKUFauQ+EYLMKyuG3kJUUdno/AhcHTNfzh9bzkC+nyyWcAecg/RC
        zbdNhJ1vc86W8Q+bWxEwJN+hMaFlZjbV8H7nCc0=
X-Google-Smtp-Source: AK7set+dXt6SVKUsiSo4NBV/iwMw8JqLsNhmlgyZB+e3Ka8HL9NdiISrvWYGvn3aNdKGHayY1trHnQ==
X-Received: by 2002:ac2:50c5:0:b0:4dd:a025:d83 with SMTP id h5-20020ac250c5000000b004dda0250d83mr5410775lfm.9.1678322847929;
        Wed, 08 Mar 2023 16:47:27 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id q18-20020ac246f2000000b004db4c79d845sm2323326lfo.184.2023.03.08.16.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 16:47:27 -0800 (PST)
Message-ID: <8f961711-86b9-274f-dcf3-84dfebc853ee@linaro.org>
Date:   Thu, 9 Mar 2023 02:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFT v2 02/14] clk: qcom: smd-rpm: Add .is_enabled hook
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
References: <20230303-topic-rpmcc_sleep-v2-0-ae80a325fe94@linaro.org>
 <20230303-topic-rpmcc_sleep-v2-2-ae80a325fe94@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230303-topic-rpmcc_sleep-v2-2-ae80a325fe94@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 23:35, Konrad Dybcio wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> The RPM clock enabling state can be found with 'enabled' in struct
> clk_smd_rpm.  Add .is_enabled hook so that clk_summary in debugfs can
> show a correct enabling state for RPM clocks.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> [Konrad: rebase]
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/clk/qcom/clk-smd-rpm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

