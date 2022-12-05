Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1FE642351
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 08:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiLEHEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 02:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiLEHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 02:04:16 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3284EBC1F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 23:04:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 136so9716811pga.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 23:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1bJFFDrDxQsc4ff8Y0/CXofAwUfqeUT0bE4h35AYNs=;
        b=Felel6oVSSOeWo9WtY3lbL22k+EDE+7nyP+Qd+OBtBrevi4M6iaRzTQ/eNKgUh1r8I
         4P2rqcxXP4yLd3r+vJw8EfRlBJprKkfnIFsxSiZFPyBwuFy+pdXecuWOwQiZMYV4M/+g
         pkh4XAhE2/ZTKtnq3m/QAZ4aEABmnM+LFJgjW+u+W5CTQKs4r+W9hn7wquyoa8aMYTLl
         FK6E9fSIfLYo1rjJ9WWKYOXlLgXQ4JjIT3xsez4pwdtHLOIqQT4CZoSa4CpxREQ6i4yI
         xBM4hFm4J0MQahDqNQ71M+luup1FFfiT+YELFlrpqVyq4w6AkoL0eZv1jiKM5MuRQWft
         ry/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1bJFFDrDxQsc4ff8Y0/CXofAwUfqeUT0bE4h35AYNs=;
        b=OfU+qvYrOh0Exba9lzsPYVvbmwpJcWmE44KqjqnidZzc/WfNMI7AWnN3e3UBFJiyeJ
         Jw3oCkkiS4sBWlDb5+qN316P9gLJBW5sJoT/FaImqVJ98nUvlbux2PFu9fUwjxekZ3lP
         XMka6+isft2UM758oJhBzCi/fenciWSzvNL5egRYZ+t4zGuLu3vB5Xlo2EEgSkGFWl8x
         HgEYWKYDxOsDc1OiLrLD0hPJLpEw9K7Nz3ySIGdmyHMlwpC3oylnHkiEUZjz1Xy95LHd
         QjfM1KpnD9z5X/fbmD44bkVKlM6uzjI7u58OqZ1imFdGJT4g8c19EcEiuAF5b6igyZoT
         buFQ==
X-Gm-Message-State: ANoB5pm9Kynkh6XmR0RfJazlQS6AvpRAW/pX8ZUnnf/U+6X/F/Wn8rGN
        NupIRTuDmQ9YDt834O3egjSHuQ==
X-Google-Smtp-Source: AA0mqf6vGyhJfE52eV9y6PzkBHCXdFvyEl+8lWX22unoM+rheK6oYjMO3iEPc3EPmL6c59Vo/KVNbQ==
X-Received: by 2002:aa7:9892:0:b0:576:4aef:f1e7 with SMTP id r18-20020aa79892000000b005764aeff1e7mr15811346pfl.18.1670223855619;
        Sun, 04 Dec 2022 23:04:15 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id px13-20020a17090b270d00b00218fb3bec27sm8532066pjb.56.2022.12.04.23.04.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 23:04:15 -0800 (PST)
Message-ID: <67b0db30-49d5-4ba7-1764-dbae16f13d7e@9elements.com>
Date:   Mon, 5 Dec 2022 12:34:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [RESEND PATCH v11 1/2] dt-bindings: mfd: Add MAX5970 and MAX5978
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        devicetree@vger.kernel.org
References: <20221124110210.3905092-1-Naresh.Solanki@9elements.com>
 <20221124110210.3905092-2-Naresh.Solanki@9elements.com>
 <166976687726.552364.17379342841980861555.robh@kernel.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <166976687726.552364.17379342841980861555.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-11-2022 05:38 am, Rob Herring wrote:
> On Thu, 24 Nov 2022 12:02:08 +0100, Naresh Solanki wrote:
>> From: Marcello Sylvester Bauer <sylv@sylv.io>
>>
>> The MAX597x is a hot swap controller with configurable fault protection.
>> It also has 10bit ADC for current & voltage measurements.
>>
>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>> Co-developed-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Co-developed-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   .../bindings/mfd/maxim,max5970.yaml           | 151 ++++++++++++++++++
>>   1 file changed, 151 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
>>
> 
> 
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Missing tags:
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> 
I was not sure about adding tag for patch resend.

Regards,
Naresh
