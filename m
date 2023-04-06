Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459A56D9EED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239602AbjDFRgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjDFRgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:36:16 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7DBA255
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:35:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50463de91a4so431708a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680802554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7i2QvlEeq0f8Kho6kUdltNVYvBrgLW2E9JiTuEKxfZs=;
        b=MKm4AOGTLwGlueANVENIn0nR2wtg7L+v1hQStFlZ73HNy3pdp8EZJ3l0VpdlgHjFU4
         tUy7NC3EO+4uoLwrQBuLq37mvrVwSE14kXEyQpq2HNX5VfC+AZyhPJCquSaBE77Z8jQr
         9VskwtzCdp+XyI6o/Wco77i9zoUiHchTZ44SiYssvAPzD5/n7gtNG0c8k07l2dEPno1d
         29c7g807nT7aHKuXoEpkJvjDg00A6bIyzvEQoQ2wbC6FmBCemLnkw1yVjtMX2nl++akl
         lZQ/QuUV0dzrVy5lOUNcfJaHyzQER+JC2qeZia2f5mG6bl42UVIdeZ9K1Pm66FAEhwbn
         zC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680802554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7i2QvlEeq0f8Kho6kUdltNVYvBrgLW2E9JiTuEKxfZs=;
        b=0D6XSVdM6gN5mJ1eXazmW6WAbKyu2ksclo2ZI17twBr2cs3mFGVOg7puMTnHy+IBek
         osMHsKtw1/XoULnVYpkHqanZVVQjwzPmGtVaL+fnGFBQBp6L3dEeywtn+rUofr7DVd8r
         n9kfqYE9WEZukE79oYg7VHapci35C5aWk8wV/aDXNlYSTVxmde1+KkkboEWt8/wD/u/R
         aNcVRNHltIjtePTkrd+kZmerijzRbiHvOtFjAbV6MMIlcMoQ0PhYHrPuC3hhOucJbVoS
         XqN+lHgVbRd/sUy1oSaWvaDcRdo9SNL22vmrC13RqI+n2m2UOiVdovefAvvnzl9zdavl
         hmQg==
X-Gm-Message-State: AAQBX9diBosEY5DfgE/04r3BrkFAF8RYgD2n4UP/LSeTUK6MEKTZNuMr
        u3pqe7Nckbt2dYb2y+l8ajuRNp2Qghj/i2kHSHc=
X-Google-Smtp-Source: AKy350a/aaAm6K8iM1M3qFFIDK/O2RjN3j1Iys5Fs7jThyWFk+KSAKIAAhYPpj/eddvmy0nrVdohkQ==
X-Received: by 2002:a05:6402:1857:b0:502:24a4:b0ad with SMTP id v23-20020a056402185700b0050224a4b0admr306047edy.4.1680802554378;
        Thu, 06 Apr 2023 10:35:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id v30-20020a50a45e000000b004bc15a440f1sm983935edb.78.2023.04.06.10.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:35:54 -0700 (PDT)
Message-ID: <7c1d4762-469f-0bf9-3482-ff99bc5840b0@linaro.org>
Date:   Thu, 6 Apr 2023 19:35:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8580: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230405205025.6448-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405205025.6448-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 22:50, Saalim Quadri wrote:
> Convert the WM8580 and WM8581 audio CODEC bindings to DT schema
> 
> Signed-off-by: Saalim Quadri <danascape@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

