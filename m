Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3781B6CC235
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjC1Ogm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjC1Ogj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:36:39 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485F6C671
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:36:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ek18so50617172edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680014161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkUxb1yN1awxacFzY/nANVpb9fbOuHgLElxbE/XrNOY=;
        b=NlviKrSbiJ6rmZgJIY/VL8iDRUl4VMonk0wujvV6GNcBmtzluNhpICT0Ja8dp/Vq5S
         E12AjeI1kEPzOpELfj85huH7m+wcQNlsZUvXLh2BTTSDx69C/CZbREsIyCRacau4esz8
         9JjbHSf9ZeMxxUKW7MMmvK1ZHj+IN0PaUa121RQ1T3xzdXJ3EN58hs2I17dfxln2/qj2
         snkgsiCg3lpu7PXAar871dT+anpr7PKrJANZhDXc8QN1MEambLNUHKzREzOOz9nat2IS
         DaxIhouOXvHf2ylVwaO6joJJQFLbZ4AGllwWd5o6JbDaHMhvpCNa6aJofxgfBT9xTGDt
         aAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680014161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkUxb1yN1awxacFzY/nANVpb9fbOuHgLElxbE/XrNOY=;
        b=LvgN3102hh5ds3lUr7VOnsgFmagiMCo4U+Rqq/p+h4+eZBDqstNd5WD+uz8xFGoHkA
         iL9ZraKNjKravSKTdMkpzwV9rjO9275FYt6kSHGSbfhMRT+vejEnUqKHLqnzM+ZNsg4p
         app1cSXcRhcGBXKGfNOK59lsvFNpfAtFkIEgfOfOVY5CI6+j8TgN1G/frmDG1mM/zqzE
         Z7HUE4GfKn7Af+61rEXmK/ulRAkNKvFMlIDUvXSVvEpDv5aVixLnFZbjsmsohSONqip1
         sbJHRg1oAO0q2qNiJCMSrwBeV8kawpL18FvMiFFlsXJ1ceTP/FM4FtHGSRWMrqW+sw7n
         q6/Q==
X-Gm-Message-State: AAQBX9fVh7if79J+hdSEPVQH03V9vtxxGA5SA2iZmYnfue5MZdaadjFC
        1hkxmlvTuPiP1BHTKciDE0RJaQ==
X-Google-Smtp-Source: AKy350aMxSkeVpVehYPInFnohdXS1ZEfyugD9A3W5oUCVFJdHZugT2owddmW86nqFx5ryQ4w12jsRw==
X-Received: by 2002:a17:906:3449:b0:93b:b8f3:225d with SMTP id d9-20020a170906344900b0093bb8f3225dmr15892263ejb.15.1680014161037;
        Tue, 28 Mar 2023 07:36:01 -0700 (PDT)
Received: from [10.105.135.205] ([88.128.92.162])
        by smtp.gmail.com with ESMTPSA id p25-20020a50cd99000000b004bf76fdfdb3sm15808831edi.26.2023.03.28.07.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 07:36:00 -0700 (PDT)
Message-ID: <ad96f28a-7b2d-a58b-50fb-648063ed0b18@linaro.org>
Date:   Tue, 28 Mar 2023 16:35:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to
 json-schema
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
References: <CGME20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259@epcas5p4.samsung.com>
 <20230328114729.61436-1-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230328114729.61436-1-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
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

On 28/03/2023 13:47, Aakarsh Jain wrote:
> Convert s5p-mfc bindings to DT schema format using json-schema.
> 
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
> changes since v6:

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

