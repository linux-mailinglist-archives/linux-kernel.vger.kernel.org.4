Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132DA6CB747
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjC1Gg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjC1Gg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:36:56 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A0FC7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:36:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r11so45317676edd.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679985413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rg7ln0vtWUz2rX09aiXxcm/NmjbrwQwhmjlO2+xf65c=;
        b=bJFuoeYvos6lpzBKhbZ13koLXy0NZysEjyNZje4vCdC0hEor+K56w5X94AhomyWBPK
         +arik7s1GIUOE4i3bp1dViZXfhYiDWje5wDy+VguF6ZE4b6165vuScAkj9h3qnYy50uo
         +e71NUyCldyEvdC6VjA2F+HGlimCffcz4hiCpLRJMXwHIkuZM2tmuPRNuXiO4zleFvhN
         kGg4okFvG6lc4W/timUsjP3mJxDN5pwaqqC0LyshnJHCMvuMXvMk5RzW1lrcsArnX9kw
         4EBXz+ExSJDKrEx10Q1rYaDxrVpXcbRtamA466QBSihz1LtVDDuue1qLjHIRcNKxav84
         7ysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg7ln0vtWUz2rX09aiXxcm/NmjbrwQwhmjlO2+xf65c=;
        b=2VLiXCw1mHKkFVN7Q0QmPhoJS2XU4wi7CqvK28BA1JNFO/xIpwu81qfqoKRJx2ZuMo
         Cf/QXooBiAmN+m0csVNlg3R33bVwuQ9QohfH1P/rPYKjJlL9ZLBi9oOe0fHLLPAK9Cda
         ZJQm0PE4mwXLhiZ6dYbgUR/wkGrXwRX/pHs5YUaxi6w2moc54eNQje1QvlFtNq13xqAa
         nUhyIupiD6a8NCtu1zPiiFi+Rxr2BpoIyOXZI7rtGJCk1McCQt4FefK0bmbY5oSNytwf
         COUOggZao/7uaNHVrfJ+x0XmATDrAvkvaFkA+ewnXBeUnyZX1Hrk+yKOjsVuiRBslp6m
         gOLw==
X-Gm-Message-State: AAQBX9eGoS2sguVm6/p4nAXmVdvfuObloMzUuywcqQ9obUGcPggesIYP
        16QFuCnokLbRvY6xh72l7jXbzg==
X-Google-Smtp-Source: AKy350YR4kjr4yCk8UnUPhlJWSjLT1aUW1CZ0zwUJkBhu0R6dQMskjbM2t0Zl3BjeL+CDVqDOR++FA==
X-Received: by 2002:a17:906:d78f:b0:932:40f4:5c49 with SMTP id pj15-20020a170906d78f00b0093240f45c49mr15253200ejb.67.1679985413260;
        Mon, 27 Mar 2023 23:36:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id r5-20020a1709064d0500b00923f05b2931sm14868672eju.118.2023.03.27.23.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:36:52 -0700 (PDT)
Message-ID: <1838b760-c911-cb0a-184e-150df2f86c3b@linaro.org>
Date:   Tue, 28 Mar 2023 08:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: firmware: arm,scmi: Support mailboxes
 unidirectional channels
Content-Language: en-US
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, sudeep.holla@arm.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        nicola.mazzucato@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230327140342.222168-1-cristian.marussi@arm.com>
 <20230327140342.222168-2-cristian.marussi@arm.com>
 <dd8d1503-e2bf-7032-4d0a-16d9a5b2aa51@linaro.org>
 <ZCG154hlWbLMAzIi@e120937-lin>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCG154hlWbLMAzIi@e120937-lin>
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

On 27/03/2023 17:27, Cristian Marussi wrote:
>>> +  - |
>>> +    firmware {
>>> +        scmi {
>>> +            compatible = "arm,scmi";
>>> +            mboxes = <&mhu_U_tx 0 0>, <&mhu_U_rx 0 0>;
>>> +            shmem = <&cpu_scp_lpri0>;
>>> +
>>> +            #address-cells = <1>;
>>> +            #size-cells = <0>;
>>
>> I don't think adding one more example with difference in only one piece
>> is needed here.
>>
> 
> Mmm, I thought was sensible to add this example, given that a mailbox
> transport configuration for a mailbox exposing unidrectional channels is
> quite different from the usual bidirectional channel config already
> present in the pre-existent example.
> 
> I'll add mbox-names into this example and see if I can change your
> mind...or I can then finally drop it.

And what exactly this one more example changes? Does not validate
different parts of the binding if only one property differs...

Best regards,
Krzysztof

