Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 791136CD4A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjC2Icw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjC2Icv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:32:51 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84438269E;
        Wed, 29 Mar 2023 01:32:50 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o2so14238846plg.4;
        Wed, 29 Mar 2023 01:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680078770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4d+dtycLWqp0weLwXRWpI8ZrJvnJZhAPdrOE5mljqQ=;
        b=Wpnsul2QEgA7ExdcZ8IljuJzHdvrVZoaBkKniQMz4wROWKSOi5OwSY6kbdqkR04778
         ukPTw9Hccif979qBxKCtHEmWgVXL7cHKw3u/WxwzhELIrWecx4s0EJOrcHZT7g6V5MB6
         II71lnNtQtfbbvGLHERGkMdLGHDJveB1IW/2hTKTbg9iXuwuE920zJ/Kvkj5DYcwND2J
         ERyPA2hQPpiVn1SdXgDFbVxYPdX7JEpTRnTjnHCu9luRC5g1QU5RDw+qWSxRvZFKIo0z
         VvGCqRJyuotoSkT7PkuGdh/Lozpm/CL2pJ0Ha0T9Sq+J4yPeY1E52+kysSrbRbFbOQuJ
         7uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680078770;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4d+dtycLWqp0weLwXRWpI8ZrJvnJZhAPdrOE5mljqQ=;
        b=2lHFjlj/iaPBj33KdgJg4/nucrD+Ec8Ti/Ah3i8JzYT7Vc0i4zatXaAm8R19xLUnFV
         GqaqVk85Kkl2FOf4vUSy3ylspI+rF32srR7jyy/0AUpWRxXnr4eKbgnxoYuJksXyKunP
         mPrszwSlhokBsojroMpCUUkp+Lvn4tODsZbB6BInD1/yNyj5XgWaKuMVLzvy+p+SplgD
         PpMARIjCjnc5EZpg2JQWqBc0UtHiK67temWwkW948GKbIgFVMoXNlYaK5nzozo2fltVj
         wj+reSXfARO81nWEm+MBfVD5+ikaeH9UqAMNYlr5BrU2VDcy24mTDUejTYurDjS3x481
         Twgg==
X-Gm-Message-State: AAQBX9fN56Xmwt4P6Jagfmlw5/fQJJ26VZMyyueXgAcPS4z+PawswuI+
        eBcpMcq8FvPcw/8K8HtUcAw=
X-Google-Smtp-Source: AKy350awpeY8bOldqL9b57hQSiQ97WJ7Hx0J70LbNPhE78MTqPCx2YMDST61xjpihFh1ASflsS8iYg==
X-Received: by 2002:a17:903:2847:b0:19e:bc01:610e with SMTP id kq7-20020a170903284700b0019ebc01610emr17418538plb.33.1680078769983;
        Wed, 29 Mar 2023 01:32:49 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id bi11-20020a170902bf0b00b0019f11caf11asm22501787plb.166.2023.03.29.01.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:32:49 -0700 (PDT)
Message-ID: <1ba9f9f4-2198-1fbd-5031-cd8be214c210@gmail.com>
Date:   Wed, 29 Mar 2023 16:32:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 06/12] dt-bindings: arm: Add initial bindings for
 Nuvoton platform
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-7-ychuang570808@gmail.com>
 <ba59626b-454b-f7d9-fe51-6e588c1ed40e@linaro.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <ba59626b-454b-f7d9-fe51-6e588c1ed40e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Krzysztof,


On 2023/3/29 下午 04:19, Krzysztof Kozlowski wrote:
> On 28/03/2023 04:19, Jacky Huang wrote:
>> From: Jacky Huang <ychuang3@nuvoton.com>
>>
>> Rename the bindings/arm/npcm directory as nuvoton.
>> Add binding for ARMv8 based Nuvotn SoCs and platform boards.
> Typo: Nucotn?

I will fix it. Thank you.

>> Add initial bindings for ma35d1 series development boards.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../bindings/arm/nuvoton/nuvoton,ma35d1.yaml  | 30 +++++++++++++++++++
> Anyway robot pointed to issues here...
>
>
> Best regards,
> Krzysztof
>

The robot report path error in MAINTAINER. I should modify it when I 
rename the npcm directory.


Best regards,
Jacky Huang


