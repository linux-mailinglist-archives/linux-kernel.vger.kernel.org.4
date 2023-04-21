Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009CE6EAEFE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbjDUQ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjDUQ04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:26:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21134869B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:26:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-507bdc5ca2aso3210715a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682094413; x=1684686413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIEVML4IO5anh889+aalXEgSW3X6EwyG+xKSv5s4BBU=;
        b=vNf7B7OMSpTvkt/QhbB/PsdtgWBg1pW9dMi93H7w5lWvBEWhimVzdKHM56ubv9YdOi
         MhSrry6TwNkGNklCPZ61WR+7zLhsd1Cp/go24HmMDtFzKEaH0KV3bPz+YzXwGXo3NdFa
         AZqalVa8nxwpxvHRp77seyGRegReWeSrY7c+XCBK741gPSfK13cdMNmKo65eIZSU4jCj
         irpenpQa2kKEPFolx2roZEow6EovgxA3f+ypHKWdATTLEmonSrskN/EDE0xdJ3gSoUol
         QfjO3WbZ6W1HG4z7biEvEPaZ4rGDWbPI3rvS2yfP9tiTxb3SYT5RsEk1ClZTElkIxVu2
         ikHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682094413; x=1684686413;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vIEVML4IO5anh889+aalXEgSW3X6EwyG+xKSv5s4BBU=;
        b=Ummi/jiMonj5QwKqWs2g9TWGB4tvMmAqAd+VyR+kdm0Tm9D7RhTv7jCC2u3E0TcPvL
         mQ6s+vIi9+ogxZouWUV44EczKZqGtEWqcbhHCdduFOFpGULznNVEqgOPg3l7k9PX8Kci
         U8tq2rzF82jX6zS1ckITj2+V+9srjWW2W8+t464g6Dd91XmgClcrXHY204c0LSNTjheo
         xQDwMtnfea/sOHN3eS+EHqvrUHrGTRLHiQsF6OdWSqi4MW7v2T6cbVDhzrZVCb1IufCT
         Mg1Wv0P0nXk4ZzYsEc4OwYA3nPv4kKduESiLvfzV5FhoIVGqec+SL9MRwoRwGuXbHD2+
         ZmKA==
X-Gm-Message-State: AAQBX9cAeLHGfjP5l04WzvWWkZmZsNbJzhTlbLCVxoebDv81+vd1YxvA
        aARMMzVB+h5NGNdz5PvPmMP/oQ==
X-Google-Smtp-Source: AKy350ZlepiYHICnCvkKxXgRvs5qFi+tujr0SqeW/avud6pnNBIJ6AakgyIPJCcworE7G0FK8U1oBA==
X-Received: by 2002:a17:906:194d:b0:94e:c938:1987 with SMTP id b13-20020a170906194d00b0094ec9381987mr2928538eje.7.1682094413624;
        Fri, 21 Apr 2023 09:26:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:687d:8c5:41cb:9883? ([2a02:810d:15c0:828:687d:8c5:41cb:9883])
        by smtp.gmail.com with ESMTPSA id gn5-20020a1709070d0500b0094f29a53129sm2190915ejc.205.2023.04.21.09.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 09:26:53 -0700 (PDT)
Message-ID: <fb93e95f-181f-917d-9216-a81dec1a2959@linaro.org>
Date:   Fri, 21 Apr 2023 18:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v2 1/2] dt-bindings: display: simple: add support
 for InnoLux G070ACE-L01
To:     Doug Anderson <dianders@chromium.org>, richard.leitner@linux.dev
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Richard Leitner <richard.leitner@skidata.com>
References: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com>
 <20230201-innolux-g070ace-v2-1-2371e251dd40@skidata.com>
 <CAD=FV=XJCtqep+92h3gLfs4o2TwvL4MORjc9ydTSpZiZ0dsR0w@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=XJCtqep+92h3gLfs4o2TwvL4MORjc9ydTSpZiZ0dsR0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 18:15, Doug Anderson wrote:
> Hi,
> 
> On Mon, Mar 13, 2023 at 12:51 AM <richard.leitner@linux.dev> wrote:
>>
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> Add Innolux G070ACE-L01 7" WVGA (800x480) TFT LCD panel compatible
>> string.
>>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> 
> nit: as I understand it, ordering of tags is usually supposed to be
> chronological. You signed off on this patch before Krzysztof acked it,
> so the SoB should be above. I'll fix that when applying.

Some people agree with this... but b4 disagrees, so I would say the
tools should implement the right process and right decisions. We should
not be correcting the tools' output, unless the tools are not correct -
then fix the tools.



Best regards,
Krzysztof

