Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E2769D857
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjBUCNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:13:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjBUCNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:13:36 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6913B1A4A2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:13:35 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id j17so3038627ljq.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 18:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AiW1Ta6IBbAqhmcXMDuesOeKjslnZyHw8cj0RcHsMpM=;
        b=q2n3pOcNSff0lmLUH6TzkO4y2Wbwsgs7VVt5p4KOyIs0+e00UIkUexaic4YPCWLnII
         QKdsQo0BQmEhQzFa1qX+A3zCO/El+bSe6gviIsJMUBJgsrNYhfQ55tsDYxt/iSgY3co3
         2sFb4wrYsu5UkgyaR1PC+OrvNduvWQM4kPY9v8zXoZAxQH7Gxeq+c2Rb59P0QVSdGfha
         DH8iOrM2WPmuazOee6skUPCkYk7zLrzTWL2Qt00M1/rJMWqdRkSmFsOCgbVSnrsmAyZD
         X99DVVLFvrGkFt8hbjjn2faV+BbxoiOqDtANNkWPW4w/R2OYzlQkkavOv1m4vyBtCv15
         27FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AiW1Ta6IBbAqhmcXMDuesOeKjslnZyHw8cj0RcHsMpM=;
        b=DdV/G7flNMAii80OFOC/X4HlX2K7CE1YQLhx6JjvXGqP6e0d652RWlpMR70GDpTwWF
         Zd2agQdul+vtbJgfQYw5imDV3yMAATf5i3D/aM3A8wVUBPgrwRwrrhBpBDSPw8fcgNEO
         iXxZfuXDpfeJtnKtg0QhFIo1ZYpE7JLutwrbxUEJv4QuJ2EElx0EpAme99SRZk0tjQDc
         GMWWslJEqJFeWTmdg8/hDzsXHLLt9Cure1+blszqLigWGwjWSx598FbKJsgXx6Ye09rd
         +ItouO97cv7MxBJyjMZidPgjKCnmep10q+M/i7raduttKNMJRTsKSlQojnVf5YljWWmD
         Oc8w==
X-Gm-Message-State: AO0yUKV0j1DAUHLQeSAVHoFtT9eehSL8ZksKAbK3Q0zsSxWUcUZKl3R6
        FJ+zNmLK09hV7B11qKozMCJkJg==
X-Google-Smtp-Source: AK7set8WttfIXgREx/DW//8k7URrt/2t6ghhms3MAPdLGVDin45jZVDbJmSbypfK9cYXpJfSL7m1WA==
X-Received: by 2002:a2e:be07:0:b0:293:4bab:39c6 with SMTP id z7-20020a2ebe07000000b002934bab39c6mr1533436ljq.47.1676945613642;
        Mon, 20 Feb 2023 18:13:33 -0800 (PST)
Received: from [192.168.1.101] (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id e18-20020a2eb1d2000000b002934abfb109sm170466lja.45.2023.02.20.18.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 18:13:33 -0800 (PST)
Message-ID: <d9173dbe-8cf4-c6e6-d37e-878219631333@linaro.org>
Date:   Tue, 21 Feb 2023 03:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] dt-bindings: display/panel: Add Lenovo NT36523W BOE
 panel
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230217-topic-lenovo-panel-v1-0-9d7ee1602089@linaro.org>
 <20230217-topic-lenovo-panel-v1-1-9d7ee1602089@linaro.org>
 <20230221020859.GA818929-robh@kernel.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230221020859.GA818929-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.02.2023 03:08, Rob Herring wrote:
> On Fri, Feb 17, 2023 at 12:29:07PM +0100, Konrad Dybcio wrote:
>> Add bindings for the 2000x1200px IPS panel found on Lenovo Tab P11/
>> XiaoXin Pad devices.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  .../display/panel/lenovo,nt36523w-boe-j606.yaml    | 60 ++++++++++++++++++++++
>>  1 file changed, 60 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml b/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml
>> new file mode 100644
>> index 000000000000..43dcbe3f9f30
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/display/panel/lenovo,nt36523w-boe-j606.yaml
>> @@ -0,0 +1,60 @@
>> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/display/panel/lenovo,nt36523w-boe-j606.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NT36523W BOE panel found on Lenovo J606 devices
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: lenovo,nt36523w-boe-j606
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  vddio-supply: true
> 
> If only one supply, why not use panel-simple-dsi.yaml? Though probably 
> there's more than just an IO supply?
Display regulators (AB/IBB/AMOLEDB, not to be confused with LAB/IBB)
on modern Qualcomm platforms are controlled by the secure firmware
layer (yes, you read that correctly). Some panels require additional
supplies, but this one just has one positive, one negative and one
I/O regulator.

Konrad
> 
> Rob
