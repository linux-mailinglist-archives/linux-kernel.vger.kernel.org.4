Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037556CF613
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjC2WCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjC2WCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:02:00 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D05240CB
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:01:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id c29so22110964lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680127317;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ggSQSBjcGG50mVsu73/uneoIs8bSkzv42Ltqcyc8S0=;
        b=RoY2mUim9wzp5/rgd1xcAMsFeiFU1OrUMYbM4J48chba/ykhJgS16Q6BNOmOlZp6jy
         rimtoJxrEbRMcRh6E+tKV/cirH8to8mokBPyG5Rb7Y0k9QEvS4K29SCtuHbXUeW8R5iw
         SqKlMg+YJ/2gNX7dQwVXNgVBKr/JPA8LkDAQl1N858piv5OZ+YqPyC4lDxKd2N9oQci/
         2eNLHP2ZoIyohoO+h0coF3bPX6ODplWFXa6ZhOGJHGrPj1jE6SvCmAl/xtECSrQWBMjU
         X4sdiwO3eMe6ivrOUW7EMIuWfaPwPXsGOggX/MM4fjIh+2SLqkQexeiBC7lwmMlBIS/h
         8VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680127317;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ggSQSBjcGG50mVsu73/uneoIs8bSkzv42Ltqcyc8S0=;
        b=3NAFHBTbzTCTNBzRh92QUc+azf3UXwMrshjdOH/Q0A2yZn77F6Yc1Kf5Yxto2o0GBt
         IYGl7TU/0liSPYk/2dOQW2uN7cmqVhoD+FvCj0Y1vWUUZkpBVZYLtKVeQ9BD5vUZg2It
         TSv6IZt0BLP378TCRiCG1BZb5q5Be2TxGX70u3eZG1hcWc1tctwpdzzYrrcFpbLFODxx
         +wh3+gIiiWbYuZHHtSugJB66jVKh3WoeLBc8Hvore3UBimrwnNgclwMPZ8Pced1lnsYV
         JeiB18GOH9Gia+vH9GpVO6srHgjx3ol9KYSRMZ6uqr/574I6ER/Vz4lRar8lJ30rRh6E
         LoGg==
X-Gm-Message-State: AAQBX9cai9UPiqx3rNoJkRPVH3sbYOrkLqepTABqki2JnCJ3XJaXVE3S
        2f9+oJf60+sjLuVrRLeQ5C4XYg==
X-Google-Smtp-Source: AKy350Zwrhm/hOnQlkbJTq37blhpcyLIGGoVDJOIO047VcNvzg4hrmdacIF51fel4zJSTPUpb2U90A==
X-Received: by 2002:a19:c502:0:b0:4e9:85e5:23ff with SMTP id w2-20020a19c502000000b004e985e523ffmr6928472lfe.40.1680127316641;
        Wed, 29 Mar 2023 15:01:56 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id n11-20020a19550b000000b004eaf41933a4sm3413618lfe.59.2023.03.29.15.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 15:01:56 -0700 (PDT)
Message-ID: <718f89ed-c9f7-57ce-a50b-300915c3660c@linaro.org>
Date:   Thu, 30 Mar 2023 01:01:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 4/6] clk: qcom: clk-rcg2: don't re-search config on
 rcg2_set_rate
Content-Language: en-GB
To:     Stephen Boyd <sboyd@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117135459.16868-1-ansuelsmth@gmail.com>
 <20230117135459.16868-5-ansuelsmth@gmail.com>
 <9fe53d8ae42e381f28715aaf8d2b7ae7.sboyd@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <9fe53d8ae42e381f28715aaf8d2b7ae7.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 22:52, Stephen Boyd wrote:
> Quoting Christian Marangi (2023-01-17 05:54:57)
>> Currently the rcg2 driver search the rate to apply 2 times.
>> - In _freq_tbl_determine_rate for the determine_rate function used by
>>    core clk to understand the best rate to set with set_rate
>> - In rcg2_set_rate where the suggested rate is not trusted and searched
>>    another time using a CEIL or FLOOR policy.
>>
>> This is fundamentally wrong as we are ignoring what core clock is
>> deciding and just setting whatever clock configuration we want for the
>> suggested clock. The problem is in the fact that the correct clock
>> should have already be searched and selected with the determine_rate
>> function and set_rate should just apply whatever clock was provided.
> 
> It sounds like you're assuming the rate coming into the set_rate clk_op
> is rounded? Don't make that assumption. The set_rate clk_op should round
> the rate again. The parent rate could have changed.

My fault, I suggested this some time ago on the basis that... "CCF 
switching the parent rate during the clk_set_rate() call. Then the 
second lookup might end up selecting different parent/mnd configuration."

-- 
With best wishes
Dmitry

