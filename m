Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5617673632
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjASK57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjASK5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:57:52 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219D4E508
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:57:51 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so956058wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMZR01owbHO/yW4TBPtf4cxNL344oUdxNVduW7eGBng=;
        b=qv/2sETlHaT2b412ALShAz7sRSaRxRyGYH2ui+PmwfkEeOg2MXXucIHOzhQLP2k57x
         6n1gT+gnKCdkYIX/GvdIbLhdG8jPuTjQo5yzmmOGWRJ0+5zwqtDfCaEmMl+nVGJd4P6I
         vBCJnISwzT77bbg/WrC4TvstliX9h1Uplr48op2/wFYCKTa67Qn2FlPw5qRIIYAoeedx
         3IUqlj708y4MAdlRBuiRR6L2gonhrY2vTGTqYz1LIpi4Tet11YnkRZiLQ2qXb+E3k/dO
         ptr4IrMJ9ZzoCz7+LbjZ0B0RR2NEVOG0MVDmQd/eID5UhXS04+ekh8AvU75ax3VMZ07L
         Em3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tMZR01owbHO/yW4TBPtf4cxNL344oUdxNVduW7eGBng=;
        b=THtiyiWV1TxxpGtzDjdlzzh+xR4V3YGp2P1jnESMKDw3NFtevtASP3pnJdsOqxduYZ
         OB4QhvFNghJ2R6i9uNpwRIhkG3nz83CTTJSkUlMtQocP34qhIKuYiFJh2CYuxZksfqDw
         vJr0mReRJ/KLlbn/iAlMBOistL6hxn9C3+35Ei4I5OZeVLvjuNmVGhfPGGXsRPwnwQbi
         9j+12a/Wr/36aM3gD+FV9Tw0Aq3AR+UVXhAwndYT6nVgqaQjt+aP9MNtdxqLNUhD4ASn
         +ejNhOFpxO1rzCdK097kVZsE/o50b63zLeW5K8fpKEYqoqHC0qUtdC0j/A4CXcn7wxHT
         +ArA==
X-Gm-Message-State: AFqh2kp4hRhiagEnu7KHzFt+/N+0cbZl+7I4QHxAKIJHaC3FsZE5j+bv
        kjSfboMUI9U9ue7eBsAADt0iTA==
X-Google-Smtp-Source: AMrXdXudIpOd+qWQZe68qqTI9Aial2kdhZzKSiyJFoq5LeI4WbkFtzkyokSjpPUwlOg9Uv1JVtFSXw==
X-Received: by 2002:a05:600c:1c8e:b0:3d9:e5f9:984c with SMTP id k14-20020a05600c1c8e00b003d9e5f9984cmr10187513wms.2.1674125870391;
        Thu, 19 Jan 2023 02:57:50 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c314a00b003db0659c454sm5631083wmo.32.2023.01.19.02.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:57:50 -0800 (PST)
Message-ID: <454e4783-2e42-847d-d03c-60741bb4b8ac@linaro.org>
Date:   Thu, 19 Jan 2023 11:57:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] dt-bindings: arm: aspeed: document Ufispace NCPLite
 BMC
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-3-jordan.chang@ufispace.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119102102.73414-3-jordan.chang@ufispace.com>
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

On 19/01/2023 11:21, Jordan Chang wrote:
> |This e-mail is confidential. If you are not the intended recipient, you
> must not disclose, |

Similar problem. Please drop and resend.

Best regards,
Krzysztof

