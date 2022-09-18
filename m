Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF25BBCE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiIRJnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 05:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIRJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 05:43:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EF1237F2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:43:03 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h3so22209757lja.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=bymflm0cWcyCTcdpDuivzckUWs78vF1VXtEIBmc274U=;
        b=TI0J/rsC/B5GyVft25Qvkb3DYyVwMDmddjhpplWK+hlHUTclerDLmDiCsjcmUzSTjq
         WDZa7usVHWlBmPh+0lAUg6l8VMWF1fib95uSb+FJyS/sq7R66K/2fq0BVLERFkYVs7CM
         Fc5avno0PhJKEaw9xoUMVhNMb+CZF2J6Dr/4nV2OCegSKH8vafgCy18voZtuyq0wTKvc
         YVaV3p0gDQHoEsxP4Z6Z+DPuoE2Cv6wX8WWojV4ni2kNJmSGbBXeXE4x3ZFzQ7FhXrdO
         3TFC0XTKG6pVompPgIugtC8kChWJ+hb16XieXjhEm2qRQBOihMeRohAgq56bHQEABvMv
         Mghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=bymflm0cWcyCTcdpDuivzckUWs78vF1VXtEIBmc274U=;
        b=hLZ8UTS4N5d3T7+ZiOUp83askCZRIBP6IW6j4LB0jILiK2zAb3AciqdA1Uuu4oSwfK
         r3/18L2XZdWGsa8IgJ2LNgy9RtdTulkXlr9eD0RHx88dsOlVacvyqHbatkrVqurG25c1
         gsaOVhCP72vVxoxwyLcSIkolQo9sg83m5aWDjm5X5jyf5tu8BI98MWuq7EQL40zhZCha
         zqiEdJOXpv8n5Y8VdaRTIjzM9a5GvWnT3RX6laJd2StfqG8OYFfuM/MMBRanJGUOGqRb
         3Qw2uCc4B+ciXhxpeGTW9L2FaqiSwkg+3PbH5JKy+WbPn9iFN/KtL6xxD/1UaxXooAA5
         Kvtg==
X-Gm-Message-State: ACrzQf2C+hpT6r08DZ1N22cCBk45B2W02oUmNgG8Z/+Fjw2ce4hlTBXL
        TPFe2OqC+gnXUuuJGseRuXRxfw==
X-Google-Smtp-Source: AMsMyM5oa1+BlsQvoBLSHJ7qg8UbLPA6SYwqWrNJ6NOOwZcdHftell11JoXnHhdlBiSB7vRm2amj0g==
X-Received: by 2002:a2e:9cda:0:b0:26b:e930:6f7d with SMTP id g26-20020a2e9cda000000b0026be9306f7dmr3860677ljj.436.1663494181646;
        Sun, 18 Sep 2022 02:43:01 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v17-20020a056512349100b0049d3614463dsm2805245lfr.77.2022.09.18.02.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 02:43:01 -0700 (PDT)
Message-ID: <46046974-78a5-1aa5-6d39-d6e41645148b@linaro.org>
Date:   Sun, 18 Sep 2022 10:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v1 1/2] dt-bindings: power: Add MT8188 power domains
Content-Language: en-US
To:     "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220916055216.20139-1-Garmin.Chang@mediatek.com>
 <20220916055216.20139-2-Garmin.Chang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916055216.20139-2-Garmin.Chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 06:52, Garmin.Chang wrote:
> Add power domains dt-bindings for MT8188.
> 
> Signed-off-by: Garmin.Chang <Garmin.Chang@mediatek.com>
> Change-Id: I62dff8af2bd74d6148712bfaa1caafc0b49e4b0c

Run chechpatch before sending any patch.


Best regards,
Krzysztof
