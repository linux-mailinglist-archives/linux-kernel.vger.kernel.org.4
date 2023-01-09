Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9E66253C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbjAIMPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237227AbjAIMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:15:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03FDB1A825
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:15:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso3568212wmq.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 04:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sf2TZznzR94HwbxPhrrDg7FkzybRt5Em8Lc/blKdqH8=;
        b=SzEGagKva5XOYlfYjF0turJTD/NqRAWhsxpnDTO8Bw/EzKXMjgL4qlfBv8D1TjmLyt
         IBozLxYW4mOY10zCNAdNj46Ur/AMrhKmQZ9fZe6dOHH6EJxc1seHhu+qVUFWYk3Q9eOS
         swgt02fhDMZYimDxUQ/rkescISOKQoKqMIP9HXwZ6jak84gktnrPCPPHaekZGxTdXiE3
         w9RkSPxRzDdhN7pTTrYe5Uv/etW/xaLclLIybO0+bJHUZqFQFmECqsjUpkC6HgMIW/QM
         SNF2meC7vaBtxQYWtXEYcRrb34LM18X3YSq9BhAYLFXKzrJA2782nSE+oY6j3MHnFMMZ
         YyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf2TZznzR94HwbxPhrrDg7FkzybRt5Em8Lc/blKdqH8=;
        b=fbubz8R/bUuDIXHTWW9KR6LW1XbkrMwpCCj3Ne2f9/U3FpwHqLbgLHRdWTDRSrj6vB
         CLGkMrniNhgWByOFFLd33TW0cX0NIl4jzPTtuj3q9Zm2f2CbymrCjbFAfjUgp/RM5xEN
         QMmu8rgO55CgZ8iEIZH+aEy4+pvRmV4IYhg28bxbfdU9xV1mBhJJPmtRpiZLOHcvFS5J
         5KW++M0V/biCD8WH+rHhgn5OpzEk2pJNPlD3QZjQOlUnEgal7qgMfv8LV1ren2vFfqWZ
         7OVTsq0/bDJ875pYh9o/y8fOznrDyHFwMEgSCgmpRwTfEyjj+cwwjDOpRDj/WJXHMxMz
         JR/w==
X-Gm-Message-State: AFqh2kpQZFXs43CAaTCNzGWZ0dH8SqLsG34c29AvY1jzTYUlu6W4tQhT
        NKxv/U65O+iyknnc70WrTUubCg==
X-Google-Smtp-Source: AMrXdXtmVMaoiczR9d03qwRGWbgZHDTNvXuMvAvIqtS2eVUgL38gXdUkMeGdBX/TO4oTGIKbhnIUkw==
X-Received: by 2002:a05:600c:5022:b0:3c6:e61e:ae8c with SMTP id n34-20020a05600c502200b003c6e61eae8cmr56295366wmr.28.1673266518601;
        Mon, 09 Jan 2023 04:15:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az28-20020a05600c601c00b003cf57329221sm15656813wmb.14.2023.01.09.04.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:15:18 -0800 (PST)
Message-ID: <4b7458ce-18cf-8222-b5c7-349e07dc6b87@linaro.org>
Date:   Mon, 9 Jan 2023 13:15:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: document the Visionox
 VTDR6130 AMOLED DSI Panel bindings
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-0-dd6200f47a76@linaro.org>
 <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-1-dd6200f47a76@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-vtdr6130-panel-v2-1-dd6200f47a76@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 09:49, Neil Armstrong wrote:
> Document the 1080x2400 Visionox VTDR6130 AMOLED DSI Panel bindings.
> 

If there is going to be resend:

Subject: drop last, redundant "bindings".

Best regards,
Krzysztof

