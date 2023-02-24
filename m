Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860D46A1A6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjBXKik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjBXKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:37:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E2029E04
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:36:58 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l25so13023446wrb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pvWmYx42QLJgDLZTYVYpNPOqGVtdvTfrF95OkRgApKM=;
        b=vlRzqA79qlN+ZYpncwnSbHM941EsreF5zS4Rz7hEPtJP612EUMzXC00x1KIqJ6dZqc
         Aw03cJBZh7IPEfEkKVNqwS/Aouaud1tgFe0w1JgZDFNeVwQ3ey1VwilSf3AWctzcHAkd
         VLU0K8Cu5VJOdd6sYssYaMjXH5A4Wdlj00bXUA43zcaHMJU9Xqbf/vatckom2lB5s2lP
         LDicGxgdfRoHkpZgRyeKvjN21LEOdNOsaCY+40fXl5eEJZKj016L9K6PFl/+6PFvMF6S
         2JUtEHe8XhiFA8GVG1dEyR7Z6XWSbbdCHaneBNU5/RPo1WjecZGGFzJIRKSrMSMBRnz9
         fPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pvWmYx42QLJgDLZTYVYpNPOqGVtdvTfrF95OkRgApKM=;
        b=VZ59vwwgf4QBVzZHgfivOnRlRvhikfuZnLq7dOBD/e9N5KCGCyV5TwdFrphiWhkw8Z
         uwZJlflw7pmJxMKAF+aF5CBCkKpd17d3nkym5rE+LjkTPh/3heXX8IQDdT97pnK0PSrM
         IVaw5oSmco+ICIGmfnzrJta1FD0BrFE3Z07ZSbmlSRCVTb87HVKgk8lFAlPW5326WSjU
         RF3Flbz4qIVEweiPtCgnnEYZZMNkHd6V8n383BXkd8S4HOt1yyJpucC6eDcPuqw8tcMt
         Rz7PVFlgHmZ8tv4+i1XdaCTQvYOKb1QtJBjdjItT/QPRqSs/HqrWxSsAofrga6XZHmol
         zI8w==
X-Gm-Message-State: AO0yUKUnpci15+c7/WhmPmeZv9pcuCSKzg1kWYDPHpkF9BHZpwr4fgTw
        HCTcFpeiCXbRxPn7HwDwaUmx8g==
X-Google-Smtp-Source: AK7set+ftr+1Us5pLfDMiYKzU/aFIDiOMntZLKpwkW2J4HZ+kkrJXl+yjlHb57cinOoe+r4IWJMmKg==
X-Received: by 2002:a5d:60ca:0:b0:2c7:e909:5fcf with SMTP id x10-20020a5d60ca000000b002c7e9095fcfmr106364wrt.3.1677235016741;
        Fri, 24 Feb 2023 02:36:56 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id o25-20020a05600c511900b003dfe549da4fsm2660059wms.18.2023.02.24.02.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:36:56 -0800 (PST)
Message-ID: <82a6780a-71d5-746a-aa69-c2bc32755979@linaro.org>
Date:   Fri, 24 Feb 2023 10:36:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v10 12/26] gunyah: vm_mgr: Add/remove user memory regions
Content-Language: en-US
To:     Elliot Berman <quic_eberman@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Cc:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212417.3315422-1-quic_eberman@quicinc.com>
 <db397198-d079-faa5-691f-c4b06822d2f3@linaro.org>
 <8f47b97a-9341-110e-c96b-7efdb395d110@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <8f47b97a-9341-110e-c96b-7efdb395d110@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/02/2023 00:43, Elliot Berman wrote:
>>> +/*
>>> + * ioctls for VM fds
>>> + */
>>> +
>>> +/**
>>> + * struct gh_userspace_memory_region - Userspace memory descripion 
>>> for GH_VM_SET_USER_MEM_REGION
>>> + * @label: Unique identifer to the region.
>>> + * @flags: Flags for memory parcel behavior
>>> + * @guest_phys_addr: Location of the memory region in guest's memory 
>>> space (page-aligned)#
>>
>> Note about overlapping here would be useful.
>>
> 
> I'd like to reduce duplicate documentation where possible. I was 
This is exactly what .rst files can provide.

If you have a proper kernel-doc type documentation in header/source 
files, these can be directly used in .rst files.

The reStructuredText (.rst) files may contain directives to include 
structured documentation comments, or kernel-doc comments, from source 
files.

ex:
.. kernel-doc:: include/linux/gunyah.h
    :internal:


--srini
> generally following this procedure:
>   - include/uapi/linux/gunyah.h docstrings have basic information to 
> remind what the field is
>   - Documentation/virt/gunyah/ documentation explains how to properly 
> use the APIs
> 
> I think it's definitely good idea to have separate documentation beyond 
> what can be described in docstrings here.
> 
> Thanks,
> Elliot
