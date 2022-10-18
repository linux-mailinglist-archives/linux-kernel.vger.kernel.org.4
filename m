Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1ED8603509
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiJRVhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJRVha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:37:30 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1EC7CE3E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:37:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id g16so5742937qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 14:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/sgBmX5hq4Hl0naA+BS4En8+zhwQfH6/hn1rzrP6U=;
        b=ivYhcIJ1qdVqtKJrZX2qoPG+j04czSqmpcGyAjNeME0eBp0CyiuUer7IslYv5h2APF
         97Q5oNs35Syx3lRSKjkOt/pZZUmAK5TYiJBrvo+KuJJxxAYWYyhJuMI+NxBQVghc1nZ+
         JbQGhSvSXDOoqKXPy1KdK1JyK1qQQjMaRvkf9wYbb6fuInBr40aLAi5fJfkhB5W2WkDj
         9Ygh53XUEDdB2hKXuCseUJmEQExbjh3J1tH9oGXmXiQ64meKbLDPUNQJhMTGOkY9fCHt
         BsKid1wig2VobcVXOWMxNdpsHJYslBYlILC1Zh/jstounlu/zDEXxfZ8LgG1lT9piB0E
         EgsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh/sgBmX5hq4Hl0naA+BS4En8+zhwQfH6/hn1rzrP6U=;
        b=SkfOgKaBV9GjtDTWFvSni9Ele2T3RU51aFlutdTcaHsSIaAZw4X7kYsdgxzPA3JMQZ
         RUF/zSKKd7KFsZmcA2eknL13TrQkqf3iYffyUcMFEwLA/yprOWOT6LxNj8L7L9SEFLGk
         42r/sYDDZ8X2fc62uzOAY23oYl2oSUjAhof7l5OGsyNrO7tlX63ATxiQ66sm9Ymqoi7W
         x0F7cK03XPht8+xe6/kZVDC1J7y1j6EtN5+g2LmTQOIER1geDb0hLbdALX0KQsExXu2j
         TU0/JrAYqJAvwW0PtB4vsxVGPccvvWtmIHkWN6Wb7vvYp31I1v8j1nnNekDd5zHjTM3F
         BZKA==
X-Gm-Message-State: ACrzQf0mA8tqd8H9oXr3I93315rvabkFRN2/eInCz6Ivxres6EF9Xfto
        /hDrAheiJgQZ+SKIb0oAdG1Hj9UZoAjByA==
X-Google-Smtp-Source: AMsMyM6enZ6m0flY7LkSIdX6E6c0Y1Bk8wEPlnDZf3TRloHt4FjIeQWMJm7zFHoCwgzL97Uc8qQb3A==
X-Received: by 2002:ac8:5a82:0:b0:39c:cbe1:e177 with SMTP id c2-20020ac85a82000000b0039ccbe1e177mr3997401qtc.393.1666129048528;
        Tue, 18 Oct 2022 14:37:28 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id h7-20020a05620a284700b006ecb9dfdd15sm3240384qkp.92.2022.10.18.14.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 14:37:27 -0700 (PDT)
Message-ID: <2dcc0ee2-5fc2-8fe3-9eb1-2c57007286f3@linaro.org>
Date:   Tue, 18 Oct 2022 17:37:26 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/4 v5] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
To:     Julius Werner <jwerner@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, Jian-Jia Su <jjsu@google.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
 <166610580692.30968.11562735981650899285.b4-ty@linaro.org>
 <56ce7440-b60b-4688-c7ac-d0435f79eb97@linaro.org>
 <CAODwPW_p2=u=YP75BW_RYG2wNgu8sjthYabEC3H4MgHG7ae4sw@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW_p2=u=YP75BW_RYG2wNgu8sjthYabEC3H4MgHG7ae4sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 17:36, Julius Werner wrote:
>>> [1/4] dt-bindings: memory: Factor out common properties of LPDDR bindings
>>>       https://git.kernel.org/krzk/linux-mem-ctrl/c/087cf0c5a19c638dd3b26fe7034274b38bc8db6b
>>> [2/4] dt-bindings: memory: Add numeric LPDDR compatible string variant
>>>       https://git.kernel.org/krzk/linux-mem-ctrl/c/f4deb90635ec8a7dd5d5e4e931ab539edc9a9c90
>>
>> Run checkpatch before sending patches to the mailing list... This was a
>> v5 so I expected it ti be clean.
> 
> Apologies, I ran checkpatch originally but forgot to run it again
> after the incremental updates. Looks like there's a typo in the commit
> message, but I see you fixed it in the version you picked up, thanks
> for taking care of that. So I assume you don't need me to send a v6
> update, right?

No need for v6.

Best regards,
Krzysztof

