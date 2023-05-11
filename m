Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7F96FEF00
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbjEKJhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjEKJhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:37:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4BCE49
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:37:15 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9660af2499dso1235330166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683797834; x=1686389834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TRjdhGheNLs8yioJ0et+AqnEpVQkoA539PlQCzm5lQ=;
        b=pfZeriXXUl23v8ujioeEl7tU7lkqZg4uhs1cDv8ogmQ4nDTwj4f5BrsvbPAmGKE+ke
         uizekmWLlrfLoIYnZXtWu8r4Bk27QGRAOcSQgIefdvzWF1drv5DcN/2bYjyBydovPbWz
         TjkfKwbW/gTpYXSPT+otsiOxypWwGQga3lNVdpeqacOBNqeYH5UbRuhTFWNiQIebwHG0
         lvonbYwuR9dng+4MBA+oIWqCQAuRk65DjpAJvOCJhHZn5+OdBySlrvFSb8sP/GVFmYUU
         z6gh0CMcQZnO3DREanelq2x3pJSKKcQf/yAkbETAtg3Axm7UZNr78vG4FoaLf2W6JCHW
         bHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683797834; x=1686389834;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TRjdhGheNLs8yioJ0et+AqnEpVQkoA539PlQCzm5lQ=;
        b=VRDCpAkWLnDHJ6t7knv1vhTJFhIY1D+U/KgnVc240Qz5zqthv43B/mfF5c5uZxqhfy
         hXarKuChSR/3kdAMiUCk8i8Y0rI2P7VF6gLGqpdd83Qei0RB4zsY4uf9pYkGSp5Qy3DC
         wYMrUeFmsCr3XIFLlxh9yLFJu3OI6+0WtufmO0Cx33PnrNan+XQDhBqjZUsph6D0R/rU
         po/OXNKfUcr6iSsl5Xlu8nAiA5rTQdofmxgDKpH4diRAKrJHQA8zcfqpTmet+YG8+zhg
         hRZfXLrH5yI2IP4FRXzqMqT2pDsCwecSUvOb5ipX29Kgq5Jv9LXjymHcaOSX5HAfJC8u
         SIJg==
X-Gm-Message-State: AC+VfDzO8XT3PPJq7mKcHDjDz/T1/JIhA096A3zjT/uzHLKRflI8spva
        lxSmpFzMawxpHnJF0cUmc7dxBw==
X-Google-Smtp-Source: ACHHUZ4Hx4V319vc6VylXMO0Suff5DbHcFrowjRJuWGQieE5u6uGRJkXgthm4dY8KecLpl8JO8tKQQ==
X-Received: by 2002:a17:907:9308:b0:965:b2c3:9575 with SMTP id bu8-20020a170907930800b00965b2c39575mr16984246ejc.57.1683797833890;
        Thu, 11 May 2023 02:37:13 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b0094e1344ddfdsm3712446ejc.34.2023.05.11.02.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:37:13 -0700 (PDT)
Message-ID: <ca2ed8e9-850a-56c5-e395-72e5861b9c71@linaro.org>
Date:   Thu, 11 May 2023 11:37:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] ASoC: dt-bindings: Add tas2781 amplifier
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Shenghao Ding <13916275206@139.com>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, x1077012@ti.com, peeyush@ti.com,
        navada@ti.com, gentuser@gmail.com, Ryan_Chu@wistron.com,
        Sam_Wu@wistron.com
References: <20230508054512.719-1-13916275206@139.com>
 <ca9d45cf-8a84-4fbc-e1dd-c96eef36fe25@linaro.org>
 <ZFyBzHWo3ORKAskX@finisterre.sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZFyBzHWo3ORKAskX@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 07:49, Mark Brown wrote:
>> Missing minItems, but...
> 
>>> +    items:
>>> +      minimum: 0x38
>>> +      maximum: 0x3f
> 
>> ... So these are fixed? No need to encode them in such case...
> 
> I'm not sure I understand your concern here, there's up to 4 possible
> values from 0x38-0x3f which has more than 4 possible values.

Aren't the addresses going to be incremented by one (up to 8 of devices
in total)?


Best regards,
Krzysztof

