Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57206377A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiKXL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKXL1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:27:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FAB62D8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:27:31 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id c1so2103180lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g/RcUCBSrTzcNlLdWw7otlBZrxfGPBbiRBBDWc0XP4A=;
        b=HbCrXU+SzUJguUIe4zXMLiPiGN8Oa9EjS1Wu35u/YBnJoq5/8xUuNLz2b3USLgdr+2
         fskMhE4MJ5Ruiu3AdZOwN6d8Byd1ObVR5Rlhj0nwTcgG8u3GntM0xJd3R7pzRoRqqb2H
         9bttEo22Xwo5MJnldX0IRdQdv89MyyXoeCVvrlNBAhvYphYA1EqOXMQlmGmqs5NZAJqu
         e4kIOQQFuQPDzfgxyKRcvc+gWwu5aJ85pec7iG/JWtLwPcF08OuND1ggAaemojQmVVxJ
         cvB9J2HFyOoinRUqGRvrmhqpfStr3Xm/fui8TxtpCJgusJpG8VN3Jx/y5Fhm02Uc9fJG
         O5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/RcUCBSrTzcNlLdWw7otlBZrxfGPBbiRBBDWc0XP4A=;
        b=NMtkEtHLxt5rguD/LnOWja2qNdg0ySFrtlwsHU9obnfQ2wVsEWobKIsOXz9l2AOYK1
         hYf4kFmNFIpiUrua99HZoKx/sv+Ia4h2DsD7XSN4LLwzHVFkR/gpPOupITNbBfXd6LU4
         uq8eBoyB6R49XIt49IEvH2eaUStm6gimbo9lwlDsbWm734Cmee6Aje6zXJmxINQiwIOh
         SYwS+qubbTVnNwj6G9EdzsxVLgcxiijPUJEVNDWKbiLAtMo9D05XtyZq9kWpNumDIBOx
         I+5pLtxV5TJLcsTZ7vNMlkfwr6Aofzn1WzotFAC7EMti35d8a6494WkgjfL5PS9/8TpJ
         dtaw==
X-Gm-Message-State: ANoB5pkS4di4+ZIyQ0oESZVNLERfX49lpvabMlr8an1fpZJBhxjq8nFW
        KmzVGFu1FDEpigaKAIgAwuM+nw==
X-Google-Smtp-Source: AA0mqf6XG2yxSA16v4PWoQHaCgxxnQd1h0fWdr0Q6o7i6UnADvTLM9Oqi2ogidxtB+hSXcoYiodb9w==
X-Received: by 2002:a05:6512:3416:b0:498:f589:c1b3 with SMTP id i22-20020a056512341600b00498f589c1b3mr5473600lfr.406.1669289250094;
        Thu, 24 Nov 2022 03:27:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05651c0b9900b0027708462fe5sm77157ljb.120.2022.11.24.03.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 03:27:29 -0800 (PST)
Message-ID: <b54cd0a4-7ee8-e8c0-ceda-18b29588d535@linaro.org>
Date:   Thu, 24 Nov 2022 12:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: qcom: Add zombie
Content-Language: en-US
To:     =?UTF-8?B?5qWK5a6X57+w?= <ecs.taipeikernel@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bob Moragues <moragues@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, Harvey <hunge@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Gavin.Lee@ecs.com.tw,
        Darren.Chen@ecs.com.tw, Abner.Yen@ecs.com.tw, Vicy.Lee@ecs.com.tw,
        Jason.Huang@ecs.com.tw
References: <20221124115712.v4.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
 <CAPao8GK93KMrtaXw7mNWOCE60zk=uCENLfBXhNRVxJXEnnaGFg@mail.gmail.com>
 <f58866c8-0164-2e59-4ff3-f9a4f9334e49@linaro.org>
 <CAPao8GKbdK79Z7w91x0T6JW9v6VFoeYSaXGGAuzB_=ukR9g0_w@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPao8GKbdK79Z7w91x0T6JW9v6VFoeYSaXGGAuzB_=ukR9g0_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/11/2022 12:20, 楊宗翰 wrote:
> Hi Krzysztof, Matthias,
> 
> How to use "get_maintainers.pl"?
> 
> I find this script in path "<MyCodebase>/kernel/v5.15/script", and output

This looks like v5.15 kernel which is heavily outdated. Please never
work on such kernels when interacting with upstream. The rule is you
work on either last mainline kernel (v6.1-rc6), maintainers for-next
branch (you should know who is the maintainer of subsystem you submit
to, get_maintainers.pl gives this information) or on moderately recent
linux-next. For bigger patchsets there might be exceptions for these
rules, but it's not the case here.

Best regards,
Krzysztof

