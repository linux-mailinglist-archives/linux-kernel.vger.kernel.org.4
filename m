Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14CF7246A3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238072AbjFFOqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238861AbjFFOpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:45:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EEB199F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:44:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977d0ee1736so417020366b.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686062603; x=1688654603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DIlTHwqKf8fPlLoHMVIGGWaQ8exTlPIjxSSytyTFW+k=;
        b=l8q2z06xu2crICmLcCl4xTYML23aq8seNXR7OWdQPkIvS9BXcilF+V7+sCLQEIXv+o
         Y/a0eDP2PY0PrWS2TGq9kAWYSjajLRQAtmbWQExKaSIlv9I9BSm6kTKtKc/x1/0ZCSkU
         Il/NomYkgqjoaThTEQpYztiLg3IMCvHeRMLzWfCtwlm2FC6++7rrfy+Hr3hmbNIo9TW4
         t5HugA/4Lzf4/LhhqNKRF+dmLT8ozZ3//TD3ltxW7qqkyddxC7/eHBb4gnWogj/u3Yph
         BqHUF8ZgR/YmH3Cr+X3a5u+33YM1WeWwRkjj1T+LgI0aeLYHmvQ5OBc32SJ4U1rrP7MI
         B69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062603; x=1688654603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DIlTHwqKf8fPlLoHMVIGGWaQ8exTlPIjxSSytyTFW+k=;
        b=Q7TsD8CANi2N9OmHIJ1bxsxjH6d85Nh8isbxRD2hPHtvxkGWXoS8lfCuuhIKkRr0MM
         NIdrTgWuhE4YfTrVRlXgmpTSh/RCPOnseK1ZFj+WYLxqTgnhXRqkAHLKTVaqbe0g4w5o
         EOcPD4QlA8WBT85w1Tb4AcD4xv0d6TcbBZ0J2Z9qflCRiZtONHhLaIuJ0ANqX9LO1NBT
         HwWBVLFpMA1hM+5y/clabDx1L3VFzDo1qG91ASlU4YE1HHJh0OmB1CZ+idHYnD21S6XT
         TXkwzwQzpNlYEAXZ40gB21djCsTr//RLwIax5j5667xVlwtjYQbVIEiuxyjhwmiSbKk6
         DKyg==
X-Gm-Message-State: AC+VfDy4eZKrWSUeAja+hdq0RukdORICeFpvdHQffQFRuJYPOcEo+dOI
        3aVO0VKyDCVzmntRH3vvI+Tic588abd3/cahYb0hvQ==
X-Google-Smtp-Source: ACHHUZ5Lgn4F1Hvld3oRgiKguBmLKnwbIruenb4AT6gfG5zweY5WjxmnBMWT7asU9/KFdnr+CTLmhw==
X-Received: by 2002:a17:907:a0c8:b0:96a:861:a2ac with SMTP id hw8-20020a170907a0c800b0096a0861a2acmr3030862ejc.0.1686062603560;
        Tue, 06 Jun 2023 07:43:23 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id y18-20020a1709060a9200b00977cfa6ff46sm3391586ejf.103.2023.06.06.07.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:43:23 -0700 (PDT)
Message-ID: <cac57af0-aa0f-0a60-3376-234e1da7f4eb@linaro.org>
Date:   Tue, 6 Jun 2023 16:43:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 2/3] dt-bindings: display: panel: add fannal,c3004
Content-Language: en-US
To:     Paulo Pavacic <pavacic.p@gmail.com>, neil.armstrong@linaro.org,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230606140757.818705-1-pavacic.p@gmail.com>
 <20230606140757.818705-3-pavacic.p@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230606140757.818705-3-pavacic.p@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 16:07, Paulo Pavacic wrote:
> Added fannal to vendor-prefixes and dt bindings for Fannal C3004.
> Fannal C3004 is a 480x800 MIPI DSI Panel which requires
> DCS initialization sequences with certain delays between certain
> commands.
> 
> Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> ---
> v4 changelog:
>   - add spaces between properties

???

I pointed out last incorrect versioning. This is v3, not v4. Or is it v4?

What about my tag?

What about my comment?

Best regards,
Krzysztof

