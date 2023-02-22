Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE3169F9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 18:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbjBVRU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 12:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjBVRUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 12:20:25 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2086A3D089
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:20:23 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j3so4292632wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 09:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVi4Wirs0e/17ik8W0xDMJgrb4uTDy85Bz2aeRFW/hc=;
        b=t75YkVIC2DZjLqm9BpjhIGF8T9pmK/zO0NA0dYuyop58C7cPNrnCC0FyYOXOj38dR4
         Th1+F1PcXaovr40hbRCTNMZXgb6SZHs0SKfE+WGhbkOiwD8CMMf+LYuIP5yBAIp+nihs
         XsexyVV09n71It80X/oIhW80NlZhzrUf+3I9+M0+VJi3dIamLEAGrYoBoBK0ARJrNT45
         3rC5/616tDu2lDREreG864MnBJSy7UdbbrqsF33Ql/DEghZV5sKqAG0YC3SbGYGvhzMo
         V3u/c72J4z0MCIp5JeZmqGg9q/TIeYK13KgpasnMfYpPT3v7CB5bqfr+AwO1vKQENfs3
         rk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVi4Wirs0e/17ik8W0xDMJgrb4uTDy85Bz2aeRFW/hc=;
        b=l00ncrT1vh7LLngQYAW2LViUZul65nmohhIlqUczygoHCk+xxyAl9212WXXK8H3n98
         ypf82w7SAXxVWSaqz5PkkUzagPKRyWwtHLEs5Yq8FwS3p4COMB81Z0ebpRWdgepGIB7Z
         DRaDI4/QzRpSdkG+cjrJGyqkKvwSplQ73hSzOlJoe0SWYpluR/DBYChSRur7ewsXmgqK
         fVunowd+3RxYXuFA4fTOcKnB5y3NsYf2IBXIadA2kDqDKj+qhiCTEM5Ck5GxWVozBeGT
         b+mdO1YxKaQ0P1+f4aS0LSbEPlYUpN33Z+xEQ4RUbKs6s2rQZAon3FR6Nl6amQZtqV3p
         0Ufw==
X-Gm-Message-State: AO0yUKX0qza3x6A9l/LC8VvyK+bjgSDJhVuro6RekD+t7W1EnEm3tiMf
        h+c8bKpdXirwYwDWGXKqYVlmXw==
X-Google-Smtp-Source: AK7set8TllcV+8dKebiEcH0GOIDcwlJbsApHyh128agZkDk70uRojafplxAcp46qxWfAbzvdAyVeFg==
X-Received: by 2002:a05:600c:331b:b0:3dc:4318:d00d with SMTP id q27-20020a05600c331b00b003dc4318d00dmr6624700wmp.11.1677086421630;
        Wed, 22 Feb 2023 09:20:21 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id ja14-20020a05600c556e00b003dfefe115b9sm6010747wmb.0.2023.02.22.09.20.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 09:20:21 -0800 (PST)
Message-ID: <b42af293-3dd0-008e-819f-676d79ff96d0@linaro.org>
Date:   Wed, 22 Feb 2023 17:20:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v6 3/5] arm64: dts: qcom: Add msm8939-pm8916.dtsi include
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org,
        stephan@gerhold.net
References: <20230222120411.55197-1-bryan.odonoghue@linaro.org>
 <20230222120411.55197-4-bryan.odonoghue@linaro.org>
 <39e69f3c-5b81-d04f-c89c-a8173622493a@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <39e69f3c-5b81-d04f-c89c-a8173622493a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 17:18, Konrad Dybcio wrote:
> Reviewed-by: Konrad Dybcio<konrad.dybcio@linaro.org>
> 
> Konrad

Oops sorry I think you already gave an RB and I forgot to add it.

---
bod
