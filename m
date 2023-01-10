Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178D4665023
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjAJX66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjAJX6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:58:55 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9D728D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:58:53 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id ay40so9953907wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bKXPGoAIuzXo646DraHzR8EvZYxmmNg33tXtmMV4roY=;
        b=XrbdSBFcavLgRfuhWevFUq0/gpN9e1x45pdELe+4WH+os00ZTrF3yOFWtgWagIkPvW
         9Sg5Qq6ikQ8K/N3jvbBrQUt/FWytNHSkswBMWSPJcvyexISdZapinVZxlVmpGMQoFuiJ
         kkcn7gDn8UZ3RhKG3+WUxodJBveGp5v7yQovKRszznMhVaCpDfyn6j+aPxRvTFhlT+CH
         qwD+B4SCAwWbKktGfAeKBMsS3gPvYL96hh+jNrHtNR0LPk5L+PQHce+Zxb4nwEvXSNxO
         te0LF0KSptfBuf+wUUxIHCnwlOyE+TZIUguxeB6k5ZHfkIG6JmdeQFVCSnWVXFBFS+pL
         dDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bKXPGoAIuzXo646DraHzR8EvZYxmmNg33tXtmMV4roY=;
        b=QgiXHL7jRqpHZDTZUmX/7p82PnH5hzAwohQgbrIDK/OWdhsQmNTEwLjZSvSi9oMifV
         gUXsHpHTJ5gfpkio6IPYMUiPz5wzzZqGMq8dOyTaFy6dpkI4QwJ91vOZkb5nihCZB1GS
         GjjgCtuTcvrcuSRh6K6QEkfdYrukVxXCFmQJ5yFa29NS09EtWPoQrwCmBOgfqGaj8k9W
         Sj/qKIvGaOTjXegqfWRpeVT4Cx/lnYXoKbYO6fi2DVc4rsufB1ZkKbVXnUCRgt49A0y8
         xNbge9kyn2ankQ36Ns/bT6d1qWlt2xRAQ41nmPAUwR5H/ZzsJIhDEcc+1vYQop+g6RgJ
         xbDg==
X-Gm-Message-State: AFqh2ko/JoO+3okaDFY0DeC0p8np3/d4u7DxW9tlq/28DBoTPKMAH+//
        WOGi6TexJrAjlby7Y6BbLTKBqw==
X-Google-Smtp-Source: AMrXdXvRrBMNJUmwB1EuC9zwh3AKFe0kafxlPk19cU9lvU9Q62WOXly811pndz/AJDpSmxhFJJFwxQ==
X-Received: by 2002:a05:600c:3b90:b0:3d1:f0f1:ceb4 with SMTP id n16-20020a05600c3b9000b003d1f0f1ceb4mr50554961wms.19.1673395132430;
        Tue, 10 Jan 2023 15:58:52 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c458a00b003d35acb0fd7sm22560051wmo.34.2023.01.10.15.58.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 15:58:52 -0800 (PST)
Message-ID: <7e13e50a-57e1-3899-78fb-efb882faef5b@linaro.org>
Date:   Tue, 10 Jan 2023 23:58:51 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 04/10] interconnect: qcom: rpm: Add support for
 specifying channel num
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110132202.956619-1-konrad.dybcio@linaro.org>
 <20230110132202.956619-5-konrad.dybcio@linaro.org>
 <4a30931b-ef94-df2f-2e89-1028bf9510ce@linaro.org>
 <bdff84b5-0531-909e-43ed-5cc1eda64f17@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <bdff84b5-0531-909e-43ed-5cc1eda64f17@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 23:55, Konrad Dybcio wrote:
> I use this field in the upcoming MSM8998 and SM6375 drivers,
> which both require some part of this series to be merged.

That's fine so.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
