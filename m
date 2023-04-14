Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94326E19B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 03:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDNB35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 21:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjDNB3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 21:29:54 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7198E;
        Thu, 13 Apr 2023 18:29:53 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p8so16988852plk.9;
        Thu, 13 Apr 2023 18:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681435793; x=1684027793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EHQxKuy5wo9zw7Q8sdOeV5ovgJI6/G8DeUagGTy+mSI=;
        b=X2d23oP2uaVFlH2Xg/bXwzONBT8jYtB5SYIcztjPKAvpAVc3E81jYvY+19pedJSO3K
         LdHCfQ6ED1R5LW95yIRbFxy92ClvuCxkBzKD3+efQzhtSCOqVfQrW34Ia8aecWib2ivz
         qR53HCswrP0Z7MyLy/OZ7cf0dVQq8XDm/BWK+q8VxcNbJyueuWpz2fe0ZnXmsIbVV35Y
         3ye42OBHuhYAbFLLaWfLTvGPniSZXLLzJLks+nBZOaPu7BEY8nTMyLsNGWt4LBafAia1
         MtFgsPxQufWYvPwcT/KuUfyzi6xg2R1gqsZjYmYNn2YHxD0cnwZ91GgOPZSr18AIJ1f2
         Ontw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681435793; x=1684027793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHQxKuy5wo9zw7Q8sdOeV5ovgJI6/G8DeUagGTy+mSI=;
        b=XfqPsvROxj5TMHrWRJ+VRCBex447B+CxvaLehl5ZKR3eGf8+xpgXNXv+POfCJBEJ28
         QQYTOeNt9SCmnivJBxCULT7dXVwtBdSrwQwzWnmJCH+MBrYyRyKKk6ty2Cf49l1qIsnS
         f5s7TLZFDMXh3QbFWeIk/bqINcS+TtLWRZCLdOZXzcIzXZGimtHXEIqUjSrAbxdqS5vq
         qGQ5W8Q2XpvbiYTSJVJQEtRbT9yUdCM3ksZU7VW7dW4fsgRkTHLxSKmuJvR2sFP+qImQ
         tUE8yGKnhX2+1CfJf08fiwuZYVENxGNHfHsb30pceFzw+jafVVqJh5IoaDBtzV5k9jCa
         1eJg==
X-Gm-Message-State: AAQBX9eq4eMO3v/Xoe8d0d4KJxKPdh+BD4kwnMWf3DnyRyhf0Ru1ILxu
        wogyiL4NgzFk4dB5M5JbijM=
X-Google-Smtp-Source: AKy350ZeNjNiFnX4q7xMSeXDszszH5NN7E7rJKkho2NlRXntdOxyUmqU0QTOqWByEVtw5uGyi3eNmQ==
X-Received: by 2002:a17:903:2091:b0:1a6:87e3:db50 with SMTP id d17-20020a170903209100b001a687e3db50mr929310plc.1.1681435793171;
        Thu, 13 Apr 2023 18:29:53 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id y19-20020a1709027c9300b0019ea9e5815bsm2070952pll.45.2023.04.13.18.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 18:29:52 -0700 (PDT)
Message-ID: <88310d3c-c0fd-33c8-920b-e589dbb60aae@gmail.com>
Date:   Fri, 14 Apr 2023 09:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v7 04/12] dt-bindings: reset: nuvoton: Document ma35d1
 reset control
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-5-ychuang570808@gmail.com>
 <7c11349662327534fc61477c5526a923.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <7c11349662327534fc61477c5526a923.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Stephen,


On 2023/4/14 上午 04:21, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-04-11 22:38:16)
>> diff --git a/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> new file mode 100644
>> index 000000000000..3ce7dcecd87a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/nuvoton,ma35d1-reset.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/reset/nuvoton,ma35d1-reset.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 Reset Controller
>> +
>> +maintainers:
>> +  - Chi-Fang Li <cfli0@nuvoton.com>
>> +  - Jacky Huang <ychuang3@nuvoton.com>
>> +
>> +description:
>> +  The system reset controller can be used to reset various peripheral
>> +  controllers in MA35D1 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: nuvoton,ma35d1-reset
>> +      - const: syscon
> Does it need to be a syscon anymore?

Yes, it should be removed. I will fix it in the next version.


Best regards,
YC


