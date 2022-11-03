Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11A26186A7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 18:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiKCRxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiKCRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 13:53:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2051B1A238
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 10:53:33 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b185so2304038pfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 10:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gh4tHwGdYqiA6FfBVtb4eaTZECdeDr+dtEfH6mIg700=;
        b=WiDvzWb07Nd95ou0RXLpYHaRo0kqVVVo4n0ExPUJKESfL6TOqXt408h6C23wWmKp30
         y53OsxEJOr2nNl1zjx+MOeonIGReZVmncVdT3AKaX4T6VpduRz0TcpNeGPdLMLAcc8ZJ
         lYAGFpMAvDJnVY3BpApDarK+s8PlKyvls1lTwv4JzGXxExA2TERW6nphT5UI8TuNNMYP
         pLC4P26Jt+2epBkG4bCuqbsG5jospL06fhiTw4JmaCpPJ80cIFRXmw2bCJVbdb5H1W9E
         hHt7GfPG4A4Myu29eLDVDtCCi3OmiQaW5ZyqRjv3BpAzuKQXeDQi/XEOrn7jGfVtDo9k
         b9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gh4tHwGdYqiA6FfBVtb4eaTZECdeDr+dtEfH6mIg700=;
        b=7nkaOUQvAVInzXeORoOOjQvTnZ1WCbChB6CoNM/t0ulA2cfz0Far7DViGYGLb5NoUS
         TMwQ0QrNhUvwG0hPhg7mWHyafBnRVoRkc36plk1Jk9wfqowOEO7/DMgJZFVWW/nRtEgo
         miFiNKMBAZxg9XccWqhdbfsvlntXhBt/sqjQLnkdPPNFvN53pW6kNH7DFh8r+BtUVKCi
         wWkoPsimfMgmb2PmBySwSIsyXA6MKYGruNhPJesr/p1awrYDiMUcD+z5yy8XSSSyHOpd
         kN6pAAWhHklNQ1kgnMPjutzjVgNatC0lYIIkeHnpQ6z91KgASL7+jNk5vnE0NQ10MjEe
         76mg==
X-Gm-Message-State: ACrzQf16lEyebVUYHXaLQ7Z6ETd5g3nW6cuTKTXyafui0D1YbOA4u5Nl
        ciFnyg8CxOBm5yWUbXUdbbElko5kx5Jyj2gW
X-Google-Smtp-Source: AMsMyM4ulepeXPsIA0hp3ORHkqmjCQ+/YpaBJ+3a+Y7uY7qnn6UlIRDNR9vuLc2PYRku4Evi49vFsg==
X-Received: by 2002:a63:f50e:0:b0:470:274b:53a2 with SMTP id w14-20020a63f50e000000b00470274b53a2mr2355814pgh.524.1667498012612;
        Thu, 03 Nov 2022 10:53:32 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b00180cf894b67sm972393plg.130.2022.11.03.10.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:53:32 -0700 (PDT)
Message-ID: <dc6c8f79-9830-dd1b-a064-3b25a3b74a35@9elements.com>
Date:   Thu, 3 Nov 2022 23:23:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
 <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
 <0c23e569-61e1-3eba-f9fc-4b42ed228b52@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <0c23e569-61e1-3eba-f9fc-4b42ed228b52@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Hi Krzysztof,

On 03-11-2022 06:43 pm, Krzysztof Kozlowski wrote:
>> +examples:
>> +  - |
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +        regulator@3a {
>> +           compatible = "maxim,max5978";
>> +           reg = <0x3a>;
>> +           vss1-supply = <&p3v3>;
>> +
>> +           regulators {
>> +               sw0_ref_0: SW0 {
> No improvements here.
I've addressed 4 space indentation, bindings are matched, compatible is 
moved to first, then reg then the rest.
