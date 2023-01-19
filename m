Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6F767362E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjASK53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjASK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:57:25 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C58A4A1C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:57:23 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so955130wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OyRWVUrW+V1Icmfd27FTvnkFbqcR7oTMbdLllE4jHWM=;
        b=dmcdJ2bvivUVgRaAn6Ds7tFZalEWmo1k+E3i+YLebbDaKQC7IOnh01EgierRuqpcw6
         wZ2P/H19ozpGA6rykc9fS2LB6oLED6uihEh6I5la+yL4l0T4ls76LwxOO0cIwNIgIdAn
         3NUkBz/YKunjqAqDPprJuSfDsNNLu12WrEJqtvxapDvHc06AVeFZcPHYIrVmdCeB2H26
         +2zFDeUXI6NzLut61E/fa6HaJwxBEESTIveMDNZe8s6e5vGzMesVRFnYJG+k5aI5f8q3
         RxMpefZpdpTvFeWhNnxZE7Fv3GwV3EAEklGNFP5bRVtBBWZueVHeaRrvBv6cTVzQuE/y
         HuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyRWVUrW+V1Icmfd27FTvnkFbqcR7oTMbdLllE4jHWM=;
        b=FauIrQqBsZbMs/3u/5jyGXlE1NmKL44xhE1U43V4W3syr2jRa1N5xg3j8rZfxZNB4j
         EvsC4ucf36vZxCigILpjLBqdKt/SoFHTbNxDJ7qyQ2RJBcLfuSkLHXRyifTJkwhodBwr
         W4bAFEoqVnG4UNkf2YiycCReyDbbDlLHc01T7OdggAd7wLCJCCGMPu5REP5H3tIFpmcR
         uYKBbGCsSygoEHAxYy377sXHi34gD9wJRbR0o/A3V8ERtEMyxZT8SEZsali66d3QfwpF
         ilf6j9pr89lN4SNhyC2uZVnM9eFsGGpspchm53O4HtTFrubM74HKyn2RDWWbt2wsqlot
         yCYA==
X-Gm-Message-State: AFqh2kpK+E+/Pr92Y7+Vp145gudomc4HUfjXbjvgVfG9GeGSiiUn/dlS
        sRZZAAnERUPwCe7N29TSA7yhBg==
X-Google-Smtp-Source: AMrXdXtZeeIlW7NQbFCmh+nm6vWUCa6nuFN98gnkd8MSOYNLyamx4kvBvQNEF+0xJEi5WAWJWsF9GQ==
X-Received: by 2002:a05:600c:17c6:b0:3da:f672:b0e7 with SMTP id y6-20020a05600c17c600b003daf672b0e7mr9799355wmo.26.1674125841709;
        Thu, 19 Jan 2023 02:57:21 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c35c100b003db06493ee7sm4779804wmq.47.2023.01.19.02.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:57:21 -0800 (PST)
Message-ID: <bc2329ec-bc3c-51ff-5738-51d2c78fcdc0@linaro.org>
Date:   Thu, 19 Jan 2023 11:57:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi
 Space
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
References: <20230119102102.73414-1-jordan.chang@ufispace.com>
 <20230119102102.73414-2-jordan.chang@ufispace.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230119102102.73414-2-jordan.chang@ufispace.com>
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
> |This e-mail is confidential. |

Sorry, we cannot work with confidential emails. Everything you send to
mailing list is public and must not be confidential.

Best regards,
Krzysztof

