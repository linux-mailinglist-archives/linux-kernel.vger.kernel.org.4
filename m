Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9054474CDB8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGJGz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGJGzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:55:25 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9E2128
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 23:55:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-991f956fb5aso471117266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 23:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688972119; x=1691564119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/m4t2+e9zxuZutsFcMtyJGQN8UX3/qZu1zrLzPNGmw=;
        b=BMZaXtEXt+jC1vsdg1/+M2Xtbf+lxbJFnLmB0rtJudq4LAeQ/Rqwo3YYCL1ymQ273h
         0/NclEiXfEaSpxde78US1huPytGuu2oEYk+HAGx0+nmk+UrlU4zK3hf4qnU4/SuymnN4
         nf7YsmivzWqca5qfo2Bfa9xq1oyO0TLo4JWwJPO00DjwjR/8TbqAjWWpCvfZHnUMJwY5
         eReJtgF+FvYafmm75MrJx1kglAu7fSyn/3R+hPb6E+KVP4Z7bYXdL+Ppb4ZMC3XDayHV
         S+wxEG0RngBSEsVeHeaGlhq2bofa9/wLwXgmAW/p4KWMUABDBiBizWXwvpgsdLrZ0R3p
         f2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688972119; x=1691564119;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/m4t2+e9zxuZutsFcMtyJGQN8UX3/qZu1zrLzPNGmw=;
        b=lHLrhnFl74YGaPWiRv/r3V1hWacKeFRhpW2Bdl2B9zrFlxOPAXLACz/CWxyzL4gpw/
         3mOV8bZYBaIj1VS/IliSvyMIoI6CR9kuqH+Cf4o7ucrrQGA5gu8Spf4FLvm6/gBwrRh4
         dUIGAqEJg8nfvYeRO9am1ZndoFkq8vZ1nYH80QEA6837QCuOOO2JVCmRy7zAkm4xfg3A
         ZzyqiFjwkgZVwW0PLraVfFzu8yJFk1gxVS48aQtDGfda/AusThSsZP9Uf/0ugiyN3rHf
         BXkdWv1FtY/eh8jVb7pROhOpZizuyE8wrAKyN1j0RByZMbwYmg/3qTKdYIkGrliEJhJo
         7+bQ==
X-Gm-Message-State: ABy/qLbEklp2yBA5kRCle5rvbD7Ae96d9NEYQkUXkFBvB8JmZSN0DjLj
        JazljSJhRRqDURIyMzSgZeWbcw==
X-Google-Smtp-Source: APBJJlHsayh9CciqsWP5vHnn+AZWmcayDyr7rOvGCFnuq8+1b2H+VPUFj7lskEGP99/UUzTqweqgTw==
X-Received: by 2002:a17:906:779b:b0:992:47d7:35d7 with SMTP id s27-20020a170906779b00b0099247d735d7mr11505851ejm.14.1688972119467;
        Sun, 09 Jul 2023 23:55:19 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id s26-20020a170906355a00b00992b2c5598csm5693855eja.128.2023.07.09.23.55.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 23:55:18 -0700 (PDT)
Message-ID: <224afbe7-f0d5-ced2-a300-9e05789f08e8@linaro.org>
Date:   Mon, 10 Jul 2023 08:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] Add compatible support for RT5733
Content-Language: en-US
To:     ChiYuan Huang <cy_huang@richtek.com>, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1688048996-25606-1-git-send-email-cy_huang@richtek.com>
 <20230710014725.GA12147@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710014725.GA12147@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 03:47, ChiYuan Huang wrote:
> On Thu, Jun 29, 2023 at 10:29:54PM +0800, cy_huang@richtek.com wrote:
> Hi,
>> From: ChiYuan Huang <cy_huang@richtek.com>
>>
>> This series is to add the compatible support for rt5733 based on rt5739.
>>
> Sorry, not intend to ping, just want to check the current review status.
> 
> Any comment about this patch series?

You sent it during merge window, so what do you expect? What should
happen during the merge window?

Best regards,
Krzysztof

