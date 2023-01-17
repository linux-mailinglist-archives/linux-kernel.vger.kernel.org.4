Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A3766DBCB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbjAQLFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236115AbjAQLE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:04:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD0E33472
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:04:41 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so7816495wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 03:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PYYRp3TP6ImotUrXlS8Xdarms6MM9WuvjTiVVuoLJS8=;
        b=D397FEuZXPynYX5R+hmZ27qabcuTLhDT7Z+tX+soWV3ge2fUhPPE3hH54JouG8LsES
         zPk37JmdXCaI1mlRsg3IJF/QfJ20hsUtabhuRwLL1EjtvJLN5cVXZS6qL84I71QyYsVC
         LymN2dB6ksOjSNtpPq2b7UqIrpdxPOTQ7LXh09AzI0MClB5s4goGQ3gvLBKKAzVMIBVe
         OaPZXITca/Ni1EMXCMApgEBUZ8CJgZZXdGxknuA7g+SAsjkE4Ttjfat5P0hwpRhvwRQi
         79YF+GL/QMdZTAk+XaAGRJBL/+W4UwTrsrrLj60dDoypdx5iwPx8zpH936ZNUR5HKwZ/
         jw8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYYRp3TP6ImotUrXlS8Xdarms6MM9WuvjTiVVuoLJS8=;
        b=VnE3YUYtz3qL6SidPLV1+8z5Uysc1k5juBmPGGMyIOOmQ3RNqGXQ5x6nd7uUruY7hb
         CVvkgEhHTI/wngaRmx49sV+d97GCOYy95bsBggwZPVWOICa2uKr5uEmLHIZBKcTzePOP
         ohrF84qqySehRZ1E3F3Vrhwz0efien/MTiiM8xX22rU5ffsXaciiGgPVU6DXz9bTJptB
         abZQLhGmCs1SMg2fYtkPxIfwi7vJ6mR6i3KEfmXFY0poGQcsiq9MacJd3qOC8lAMLg/l
         nqPstbZVJqrk5HcBlY2/MUyw/NMKKnKEpnM/YxnP5C/Gvi6KuLVQkVpRXJ2GRqVdaYPc
         AnyA==
X-Gm-Message-State: AFqh2kp6gSXYisfhnUT7sHCLEVKbODiWgbCIYYJetAdNPieex1Zou2bl
        J+6jFUvbdmYI3MI8fzb9NJ23RA==
X-Google-Smtp-Source: AMrXdXus8jo6c5JtL5ZHF6ReqHEvnPdgsfBUMz4+B5f2FSmzjwtrqhSufZtaYbTjFlqkRn55YVoaRg==
X-Received: by 2002:a05:600c:2046:b0:3d2:3ae8:886a with SMTP id p6-20020a05600c204600b003d23ae8886amr11297070wmg.17.1673953479661;
        Tue, 17 Jan 2023 03:04:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c3b0200b003dafadd2f77sm7070819wms.1.2023.01.17.03.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 03:04:39 -0800 (PST)
Message-ID: <c8b7b5c4-4c7f-dd40-b372-5d2689abbdac@linaro.org>
Date:   Tue, 17 Jan 2023 12:04:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/8] dt-bindings: interconnect: Exclude all non msm8939
 from snoc-mm
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, djakov@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        benl@squareup.com, shawn.guo@linaro.org, fabien.parent@linaro.org,
        leo.yan@linaro.org, dmitry.baryshkov@linaro.org
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-4-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230117024846.1367794-4-bryan.odonoghue@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 03:48, Bryan O'Donoghue wrote:
> New properties should be defined before the allOf. Move the
> patternProperties definition to before the additionalProperties: false in
> this file.
> 
> Exclude all non msm8939 compats from containing a matching
> patternProperties.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

