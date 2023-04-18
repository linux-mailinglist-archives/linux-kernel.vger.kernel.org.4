Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E626E680E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjDRP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjDRP0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 11:26:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FC9125AE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:26:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id kt6so36045681ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 08:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681831582; x=1684423582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9M4Cy3RAneTyQNPZZI73IssUJ+/tbZ24lCmil8/wy0=;
        b=htQXPSbwfbKehEj5O/7VedrIOI3id8b1ElfrdoQSSii8SiWKOLqlzSn6hWxhFIS8dg
         4oqduLcxCDchk60CK9IA7cQrPgG2/ON/bOhTOkF72rA/FpQq8gkL8nH0c5u/XUvbfwoG
         Lx1nWaGc9ruXXr9Vks/3SYMXKpEIjNpC3N1/neydjeKlWS/OAOJEvpg/P2djaizMOdDb
         c7zkFjq7XmHLex1XKayPQHWTKnuyxqHZ420lhoLFaygx5xwDvU5uPIx192J6wf2NyNUs
         B5Zz/GRuXQcipbrTJf+oyjWtJdDMJsnO7bzm87XX/sdMFXYNn2xkljaBlbJTSAAG9UuB
         VvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681831582; x=1684423582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9M4Cy3RAneTyQNPZZI73IssUJ+/tbZ24lCmil8/wy0=;
        b=jdHZTt0jx+GPDisz8pCi+oPqj6NyckzYI7dpd4dD43qdNpfHrysaaw7IwBQm8iZT+Y
         ZVY/v0UENlPKqT6aJ+wHdwFNCiLCErU7E8BMxY+cNryF6DPsfZ5uljle+YAyd0M/6f18
         w8lO3ZyyKR8CzRBybYAzq3kHhTeg6zhfOl/c3bbmArzrNvsZJOZxJ5ezKsV5Etcpw83W
         GhG6Cj65rOQff0Aow+tWpNvHOnW/U+rVLaZk0sT1UyVGmQOhCbWzeh2+Gan0pvCaFW0M
         Xj8ThqeIa24j38pELABIzClbXgjA7Q4c7kzp4dm9Sn8Pbt57MBcjLGNb8IzpzLLYm9aH
         NAJg==
X-Gm-Message-State: AAQBX9ft/Ccz63Tn/nOMw0/J5BoiHbNcd7V9VUrT7Fs6yrmXKD4SI93D
        esYIEfQukC1VqUG8HXz73fanYA==
X-Google-Smtp-Source: AKy350Y55KT8s6wtLY+JUO1aCm8Wql7NeBtVJbi/L7pgsU7v6MZvKexJNZSfPBUyTFJDx+wtKF8qXQ==
X-Received: by 2002:a17:907:918c:b0:94d:f66c:3cdc with SMTP id bp12-20020a170907918c00b0094df66c3cdcmr9596474ejb.51.1681831582049;
        Tue, 18 Apr 2023 08:26:22 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id gv35-20020a1709072be300b0094f07545d43sm5646849ejc.188.2023.04.18.08.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 08:26:21 -0700 (PDT)
Message-ID: <bd7ad4a2-3cd0-9d6e-00b8-5592c67d7205@linaro.org>
Date:   Tue, 18 Apr 2023 16:26:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/6] docs: qcom: Add qualcomm minidump guide
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, corbet@lwn.net,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-4-git-send-email-quic_mojha@quicinc.com>
 <24ec8534-60a4-b308-0831-9ab6b983d902@linaro.org>
 <55d3dc01-8909-db69-fbac-60e7636febdc@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <55d3dc01-8909-db69-fbac-60e7636febdc@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/2023 16:19, Mukesh Ojha wrote:
> +@Brian
> 
> On 4/14/2023 4:01 AM, Srinivas Kandagatla wrote:
>>
>>
>> On 22/03/2023 13:30, Mukesh Ojha wrote:
>>> +Dump collection
>>> +---------------
>>> +
>>> +The solution supports extracting the minidump produced either over 
>>> USB or
>>> +stored to an attached storage device.
>>> +
>>> +By default, dumps are downloaded via USB to the attached x86_64 machine
>>> +running PCAT (Qualcomm tool) software. Upon download, we will see
>>
>> Are these both PCAT and dexter tools public?
> 
> I think, PCAT comes as part of Qcom Package Kit.

yes, this is part of Qualcomm Package Manager.

> 
> Last time, I checked with @Brian, he was saying the they use PCAT 
> software tool running on x86_64 machine attached to QCOM device to
> get the dump(via USB) out of the device.
> 
> Dexter.exe seems private tool, that only requires if we use storage
> (via ufs/emmc) to save minidump on the target device itself and later 
> use adb to pull out the rawdump partition dump and pass it through
> dexter to convert it to same binary blobs which we got directly through
> PCAT.
> 
> I don't at least have any way to avoid dexter tool at the moment.
> However, i will think if we can develop any script which does the
> same.
That would be nice!

--srini
> 
> -- Mukesh
> 
>>
>> --srini
>>> +a set of binary blobs starts with name md_* in PCAT configured 
>>> directory
>>> +in x86_64 machine, so for above example from the client it will be
>>> +md_REGION_A.BIN. This binary blob depends on region content to 
>>> determine
>>> +whether it needs external parser support to get the content of the 
>>> region,
>>> +so for simple plain ASCII text we don't need any parsing and the 
>>> content
>>> +can be seen just opening the binary file.
>>> +
>>> +To collect the dump to attached storage type, one need to write 
>>> appropriate
>>> +value to IMEM register, in that case dumps are collected in rawdump
>>> +partition on the target device itself.
>>> +
>>> +One need to read the entire rawdump partition and pull out content to
>>> +save it onto the attached x86_64 machine over USB. Later, this rawdump
>>> +can be pass it to another tool dexter.exe(Qualcomm tool) which converts
>>> +this into the similar binary blobs which we have got it when 
>>> download type
>>> +was set to USB i.e a set of registered region as blobs and their name
>>> +starts with md_*.
>>> -- 2.7.4
