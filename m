Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB5712E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjEZUnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjEZUnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:43:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9591D187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:43:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f1411e8111so1355562e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685133828; x=1687725828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/6174Ber5Dhvq9PCiuf7/gpcmZX6TBZczzj1WyeVUqs=;
        b=DLeHOHHN6h5+N/RAZjKMg4IFFEl2HxU8bvnY4oBeY32U/NZ1rscBtgCgX+JMTC1Ka0
         4qsVyQg7cYE/pfubShzugG+qFZCNXMR/O4jzvhBIe8r5APXu+/tI/HCnpBnYnivsJbtG
         PZ8OViniZoRnQabmJNUCmKR0DFk/3HxE8lzpTmwFUrVv1pbas0FLMFjTylUrXbfe1pNq
         uS6pidrzgs0YJxXqWaMouprb41l40xT4oVRT2ujDxWtAjZwyL8/YaeBlpwAX7CVKIPel
         E7oOuvcTJBruW7eyM4lPGCuvP3ydVUz6wT1QpIvPtxqihTnzN7m27VLqLilMaYvplkdg
         kcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685133828; x=1687725828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6174Ber5Dhvq9PCiuf7/gpcmZX6TBZczzj1WyeVUqs=;
        b=g3zu+t4Q/s62U34mcKv405foN9v9BVEBTz/4crtMz1+YNFZpHfhBM+sM1cjO0uq/3Q
         Al/hvs+/GBstv2PuVKUf0ZPxQIXfwJTL0gXHNndk/IOCQ599AL8aVHinHCrxTGIZ4YGw
         k9Qmfs45iHMi/wuVdpZ85p34Npozn43d7pi/hlN9O7D/xkZbdSLmAAldZMuB/TrwhUJS
         VJeaSJIvpZ+9SG4WfP61F0rLv1NwC31Rb3NtqYV86LWcghrfCZdld/DlsiSoZvXyVjij
         4bgHVbG0ZVVpWgl+p155qjQINkE4LgR0r4WXYZaJacPLrM1aZRlfk5jivnJ9o2OoGadX
         +kuQ==
X-Gm-Message-State: AC+VfDyrE3WPjIXjCeIx/8XuH7f2BLfUbZGxoISZHt9Q1ImQmyzBnH8b
        zOt5s4IqVlkmI16pCCv9Un76RA==
X-Google-Smtp-Source: ACHHUZ4dsoFDZcDnlXVTIkaLAUNQzwlWZcpLdFsQ0CmU+dEqOnfFnPq9c11FVGDpUaepA/R+EjGfpA==
X-Received: by 2002:ac2:547c:0:b0:4f4:af2c:97e with SMTP id e28-20020ac2547c000000b004f4af2c097emr721113lfn.11.1685133827858;
        Fri, 26 May 2023 13:43:47 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id v17-20020a056512049100b004e9b307d2c8sm760594lfq.238.2023.05.26.13.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:43:47 -0700 (PDT)
Message-ID: <265d1c93-0740-cd87-3ba2-e1ddf70a0c65@linaro.org>
Date:   Fri, 26 May 2023 22:43:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: media: camss: qcom,msm8996-camss: Add
 CAMSS power domain
Content-Language: en-US
To:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Conor Dooley <conor@kernel.org>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-2-y.oudjana@protonmail.com>
 <20230526-obstruct-venus-5833511a58af@spud>
 <838b134d-46cb-6237-49b0-0c287141ebb3@linaro.org>
 <20230526-street-pox-2ff5ee106c43@spud>
 <8d89c14f-b2c2-7db2-f637-aa6d90273f4d@linaro.org>
 <631e5eec-853b-dce2-c474-62e76e83d7e6@linaro.org>
 <5dc28004-5ff4-2102-0bb3-8f7bee7cfca6@nexus-software.ie>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <5dc28004-5ff4-2102-0bb3-8f7bee7cfca6@nexus-software.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26.05.2023 22:40, Bryan O'Donoghue wrote:
> On 26/05/2023 21:36, Konrad Dybcio wrote:
>>> oh the names
>>>
>>> no toss that
>> this should be
>>
>> if:properties:compatible:blahblahmsm8996:then:required:power-domain-names
>>
>> Konrad
> 
> Hmm, we don't depend on the names though.
Check patch 3!

Konrad
> 
> ---
> bod
