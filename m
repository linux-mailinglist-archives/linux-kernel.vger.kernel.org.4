Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D6860E323
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 16:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiJZOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiJZOSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 10:18:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1641510F898
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:18:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b25so10582117qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 07:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YtRWJZKbMif6QKbJ+qEdydNmgiCQ/4zO/xpn20FjE4=;
        b=zdv4FwBCWn4px/ZLt6urY7kQ5Nzp174y1W9tVH1mW0ock6rV9wZBSXu9ivTdt6zbTL
         WhTDnHDBw6mAYNtI1BmdeflDYALhjHvpVldTdQOpUwhBZIaoGdCzXbY5dpeFGggOUHTk
         gXzffOzZ97i6hXQYzh94pTxhfIp9F/Db6KAkqCdRA2p66dGQ17rJw4netdD4OIdeJw7l
         rOXafc6nTCRjQyLebEIxGq9w5UK9kZFVCmfkC8lz6F0smWx2CvSh5U2Eq3RVRHPk4ceH
         DL7jADWT0VUCCapVJZ7hHRtLV3xSA/Im1YVoB4lPOkXqFBvaDiDq2+moeBa7ACD9uqMA
         cVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YtRWJZKbMif6QKbJ+qEdydNmgiCQ/4zO/xpn20FjE4=;
        b=6Rj6hHtVJ5GhCjC0tdwrRV9OvZKHuT7hK0Jq9HAReCg9NsljCYrO5GYkmrMY/45EPB
         IT1lMM/nP+NmRKTch+hQFWux/cU7foCXG8UrsiA8NLvvQjOEU5YgDSEKJZ8RYbZ6kjr8
         OoBM6yuwH/sm28B2jUiM8Q+BZx5PP5LDS4+lxY7Cf/PSVmlRyn3UiAGXW66qo+9lwkab
         KjV0YUwpz9TInlIf3XyNBWxCV7QJUHcG8+w2zFmUEFFwV990Ze33eh91j9N/m2YCb5Ol
         xqdh6iSlvI4jTxvsRiLO4Rn8euYxmCxtoL6/sEeFu0B1kqKt8lsZFQJz+LxXI1WCEFMg
         2cuQ==
X-Gm-Message-State: ACrzQf1tp4zGdEdGCK4Ec/dey5GgVMyeaFA4iHgZi/OTginX0Kx2Ueym
        c40yDIWiFrVAglz/MeKVfUwe1g==
X-Google-Smtp-Source: AMsMyM6764WLKyAmF+3eAYWy9F1BsXvQY4uwWjp3lRii2rrmauPtCVQKmSB/pWf5AHM85b+gdXjhGA==
X-Received: by 2002:a37:6945:0:b0:6f4:ae0f:648b with SMTP id e66-20020a376945000000b006f4ae0f648bmr11991186qkc.329.1666793901165;
        Wed, 26 Oct 2022 07:18:21 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id b14-20020ac8540e000000b00399ad646794sm3293499qtq.41.2022.10.26.07.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 07:18:20 -0700 (PDT)
Message-ID: <4ddf54db-69c6-69a8-5c73-6c365b9f90b3@linaro.org>
Date:   Wed, 26 Oct 2022 10:18:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 2/2] dt-bindings: rtc: add bindings for max313xx RTCs
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20221026131124.289-1-Ibrahim.Tilki@analog.com>
 <20221026131124.289-3-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221026131124.289-3-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/2022 09:11, Ibrahim Tilki wrote:
> Devicetree binding documentation for Analog Devices MAX313XX RTCs

Drop second "bindings for" from the subject, it's redundant.

> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

