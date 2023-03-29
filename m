Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640CD6CD546
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjC2Ixd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjC2IxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:53:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF401FEE;
        Wed, 29 Mar 2023 01:53:19 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q102so13420372pjq.3;
        Wed, 29 Mar 2023 01:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680079999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5acp6AQhlwlFMbsUP5vy6MLFKcrqnbcflb5MEM8oLg=;
        b=TUpEINDEFayGGsDrfLfN0rTTbAU05RCkYmXKJG5fm5tCS8FdXpsrf574OqpT8ddkrN
         Hpjms5xExEkX2Jp17FPQBL9Ev3v93QQTLTO8uWe5ZYb7etzt7LCNUX16iQd2grntbVWK
         6DLumLoBXJnbYJjv3wtXGVRbwdurgXTuVzJORhqOIfg7f2liUzYLR0fIKcQvHK/k976h
         Jck0t+YQRXd8yhCX4kvBjWUnP8MWXi63FvWMwE50pYVK9CoZnUML8MkVRprhDecOT9DE
         0q8rjM5FSd7IdftgKTEx1DUGj54tKD93hOcfdet0tvftt336QAwRrSiW0V+vGcAJvhZs
         fmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680079999;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5acp6AQhlwlFMbsUP5vy6MLFKcrqnbcflb5MEM8oLg=;
        b=TiQ9h+jpc27RzfD3Na6bBEZk1eyuorZh+LdzBoOzG3FzdA1j7H7GdZX+d30i6d3dqs
         mDdDPGJTfctJwhxPzkpWKwfscBCnZtw6lzf9SAbDh+up5Wa2MFlFzQkUouZQIIZa9hmn
         vLU1ppTuVkbi0wtK7YDR0NN8cCcbfr9dC7rMaNd0WKZfEQa41EtbkJcw4ysqD0xKetdC
         dLFrs+e43mviNyXS80kuwMK8FGoU/QEqUdMPjS7c3EP6xbZqgLZK/aSNgHjCFnqvLnLW
         Q/41jbGiH5h5LKxPFpP/MiUnDSxhsHNXVUusq1w5gP2cA7mo2iGP3Fgn8tnLy6+RYQ9I
         AelA==
X-Gm-Message-State: AAQBX9fz3LmuL5EImuZ3gs29rKZIirOlXzglAl6ZznbLNueaewHut/+z
        YixcqFvFmX79Myk/eIleOfw=
X-Google-Smtp-Source: AKy350a4gJx8D+PTIaoSFDTqQj66gF2BoV96BDG2IyVDNf4wsQKiAAfCez3ovrd5mXCyjmCqf8wKdQ==
X-Received: by 2002:a17:90b:4c8b:b0:23f:44da:208d with SMTP id my11-20020a17090b4c8b00b0023f44da208dmr21373666pjb.47.1680079999329;
        Wed, 29 Mar 2023 01:53:19 -0700 (PDT)
Received: from [172.19.1.47] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a17090aec0300b002311ae14a01sm946541pjy.11.2023.03.29.01.53.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:53:19 -0700 (PDT)
Message-ID: <a1df76e0-3a60-eeb6-9120-3aa7103c2218@gmail.com>
Date:   Wed, 29 Mar 2023 16:53:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 04/12] dt-bindings: reset: nuvoton: add binding for
 ma35d1 IP reset control
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-5-ychuang570808@gmail.com>
 <81d8a7b18901c85fd24705977e6b9ce3.sboyd@kernel.org>
From:   Jacky Huang <ychuang570808@gmail.com>
In-Reply-To: <81d8a7b18901c85fd24705977e6b9ce3.sboyd@kernel.org>
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

Dear Stephen,


On 2023/3/29 上午 01:48, Stephen Boyd wrote:
> Quoting Jacky Huang (2023-03-27 19:19:04)
>> +description:
>> +  The system reset controller can be used to reset various peripheral
>> +  controllers in MA35D1 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    const: nuvoton,ma35d1-reset
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - '#reset-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  # system reset controller node:
>> +  - |
>> +
>> +    system-management@40460000 {
>> +        compatible = "nuvoton,ma35d1-sys", "syscon", "simple-mfd";
>> +        reg = <0x40460000 0x200>;
>> +
>> +        reset-controller {
>> +            compatible = "nuvoton,ma35d1-reset";
>> +            #reset-cells = <1>;
>> +        };
> This is prescribing driver details to the system-management node. The
> reset-controller node should be removed, the #reset-cells moved up one
> level, and the "nuvoton,ma35d1-sys" should match a driver that registers
> an auxiliary device for reset functionality. Is anything besides child
> nodes like 'reset-controller' using the syscon@40460000?

OK, I will modify it as:

     sys: system-management@40460000 {
         compatible = "nuvoton,ma35d1-sys", "syscon",;
         reg = <0x0 0x40460000 0x0 0x200>;
         #reset-cells = <1>;
         };
     };

And my reset driver will use compatible "nuvoton,ma35d1-sys", instead of 
"nuvoton,ma35d1-reset".
There' no other node like reset-controller.


Best regards,
Jack Huang





