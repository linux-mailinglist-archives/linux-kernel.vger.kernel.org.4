Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C2F6C31D2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjCUMiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCUMiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:38:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFE9EC9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:38:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h8so59039699ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 05:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679402288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAHU5kqXRYKOLBxaAoswUkMHVemnT1L6PZ6oDpy10Og=;
        b=MpW1PxAiokgthWrvl0fAhVprwNnKMOzVF5kPm8DWuvwwuYdC/IZu/5/sJlhOcR9MLL
         9k1Ll2OzrGnEPdO12o5Not8Ij7zDVDNULBaQaI3oLJxXf2EEFoAci7QfsNB158/P96JH
         O894ra4J1L+2MIi4pJg2BCEkV1QSvMEX0wdZJXlYbdhn1byEljr/2jAxvgUEwCZa3qy5
         LFA8eWEXe4WrJ5nGq9RiIFQnPHsbPqWR9XHxiUhl+iWqAsUffZvXR1y9z9dLbMBcwSnm
         DSKF0EI8mkgjeaREKfVET7gFLUD4JOU54ASbSsUejmCTAtO058LNyXEntJM07Ao3Upmt
         wa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679402288;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAHU5kqXRYKOLBxaAoswUkMHVemnT1L6PZ6oDpy10Og=;
        b=PYjJGQXgZFq5X/Wj4ueU4JS29QTWPsQDRoFMyp3/h8EGYFAHmvPsZzgk+k+I91Ti75
         Fkmp7VlaZ/OFXtbK7N94wLcGOGw5/Odf8W6cRGjQkCL50+2wWYA5TglOYeyakjaOVW/a
         WN8oJzUD8AXRAmDRXxcrmB+AbMc75dgS5flcIkHFqhi+O2d/6j1cqjDESN9jwWHEzr7i
         V/rxqa9OKwtaWybtjh+9XCt9rD3zmtLnO3Hcr1kYWAV9JIHvxeg+knrLfn4FZQj/7WuH
         Bbj54hurL6+TjswHjrcOVFXoEAK+X+NQImswlq4qhfwR9q1z9+TaVC381CuJLwDE3ScT
         6EGg==
X-Gm-Message-State: AO0yUKXEg9NMXNu1tSCcYrgfP/5cx68YFVAvpSGJBWWmSJ+z1UN9Wh2D
        1/rmjNk7+5mG+PFbWMyCiCFnNw==
X-Google-Smtp-Source: AK7set+vNaEbl3l1Z6hbghc31W3om2GAvq3BZt9/SEGY2N7Ry7e+QAITpS/ixh1bfJlmj1UWuz7y3Q==
X-Received: by 2002:a17:906:7249:b0:895:58be:957 with SMTP id n9-20020a170906724900b0089558be0957mr2691044ejk.2.1679402287907;
        Tue, 21 Mar 2023 05:38:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:2142:d8da:5ae4:d817? ([2a02:810d:15c0:828:2142:d8da:5ae4:d817])
        by smtp.gmail.com with ESMTPSA id v14-20020a1709063bce00b0093344ef3764sm3865240ejf.57.2023.03.21.05.38.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 05:38:07 -0700 (PDT)
Message-ID: <55cfacf6-03e0-b9bc-83f3-3e9f2d7b2d4d@linaro.org>
Date:   Tue, 21 Mar 2023 13:38:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: drm/bridge: Add no-hpd property
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sam@ravnborg.org,
        jani.nikula@intel.com, tzimmermann@suse.de, javierm@redhat.com,
        ville.syrjala@linux.intel.com, r-ravikumar@ti.com,
        lyude@redhat.com, alexander.deucher@amd.com, sjakhade@cadence.com,
        yamonkar@cadence.com, a-bhatia1@ti.com
References: <20230316140823.234263-1-j-choudhary@ti.com>
 <20230316140823.234263-2-j-choudhary@ti.com>
 <dbc43c09-f8ec-f877-598a-adff47d44b0e@linaro.org>
 <79ce5fe8-9fb0-5caa-67a0-87dee7867856@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <79ce5fe8-9fb0-5caa-67a0-87dee7867856@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 13:02, Jayesh Choudhary wrote:
>>
>>> +    type: boolean
>>> +    description:
>>> +      Set if the HPD line on the bridge isn't hooked up to anything or is
>>> +      otherwise unusable.
>>
>> It's the property of the panel, not bridge. Unless you want to say that
>> bridge physically does not have HPD? Does it follow the standard in such
>> case?
> 
> MHDP does have hpd. But the mhdp driver should handle the cases when the

This is about bindings, not driver. Your driver can still handle this as
it wishes.

> hpd pin of bridge is not connected to that of the DP-connector. This is 
> to add support for that. (optional property)

Which is indicated by panel no-hpd, right? Or you mean now that HPD
physically cannot go to panel because it is cut on the bridge side? But
isn't this the same case (from hardware/bindings point, not driver) as
panel would not have HPD?


Best regards,
Krzysztof

