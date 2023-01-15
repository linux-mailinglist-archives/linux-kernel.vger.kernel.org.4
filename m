Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4EA66B191
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 15:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjAOOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 09:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjAOOii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 09:38:38 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CEB113F9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:38:37 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id bk15so5097768ejb.9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 06:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ciei+9RK1lP1ir2O6VrlKkT6Olp4GCKQ9yN4RQZHNxc=;
        b=UF9T6/XDnO2y+7mSMLLO3flansazxWXJIU1S3Uardt/Isqon5iFZ1kyCnrEH3ZsyuH
         7u6t8k5yY0F3qhqmXu8T9wJcZaWEx6qpbd5MkZe9KoMyTcU3m80HXiKmTMXPhHGPo2Ge
         s51mkktv4D+9gwg2+kfo5a4sMaAsM0f27EaLfC6cWbyHABXJED9Sa0kUw8BOxe+qH7/D
         FuJi9WcxM3ZPdlbLJdRekr7MxWFulU4d+HC49WSjK8fJLUID/wPj+4WIpdLV5LdhHVg2
         ro4cdQU00K3bNnb6+/b57X2uMYU1sTdrYfiNlZ5e/QFtGep1fqwXB6nI8wlbzfOM8CcA
         YbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ciei+9RK1lP1ir2O6VrlKkT6Olp4GCKQ9yN4RQZHNxc=;
        b=5tcdG5GDp/TuUTLjMRej/as3y+op2PmnRErD3pl4qBUSyhgCHAAg8/OOYNGDaK4pRj
         OdOIH0+j+A9IfPpXVDe31s60VAk2AxauUTofsUcbZbzZK8M/pZXmzsfi8hViHoEykF9J
         gSo+HfYEa/DaxiWa2FmJQ7Y/2qwGXXTFxIF/s23dZ+6bvvLkRhduWpxa2E4+RDDErd+N
         7ZrFD/1q+LEBvPy75Nqwlow3cavxTdW73nafO/fnCMKkFLD+nF1deFodiBinx4XMrtnQ
         IlgMVedi3T+fpE3tQU8JbT76DnEf9DkgZS61MEP321f9Co7zZ5eiPV0bEXCdv5R6WaBs
         XpTQ==
X-Gm-Message-State: AFqh2koypiRoQt01d+v+njj5xw9K6xaDJ0qoqwyHqHN1eSIaTZh1kZxO
        xDy7paITa3iTkWH/jd9a0z5GWA==
X-Google-Smtp-Source: AMrXdXuA43mEvs+xddNRHWH4r6rh3XmWCN4ygPgTA2hYxPxnsVuVFNHY9JTMig4VsAowVle69yinow==
X-Received: by 2002:a17:906:2993:b0:86c:e53a:d20b with SMTP id x19-20020a170906299300b0086ce53ad20bmr5286286eje.21.1673793515741;
        Sun, 15 Jan 2023 06:38:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090653ce00b0085ea718a81bsm5362037ejo.198.2023.01.15.06.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 06:38:35 -0800 (PST)
Message-ID: <9f4994de-e468-43ea-f8db-d4a37ebc30e0@linaro.org>
Date:   Sun, 15 Jan 2023 15:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: sram: Tightly Coupled Memory (TCM) bindings
Content-Language: en-US
To:     Tanmay Shah <tanmays@amd.com>, Tanmay Shah <tanmay.shah@amd.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
References: <20230113073045.4008853-1-tanmay.shah@amd.com>
 <6f43e320-b533-e5fb-3886-1b6ccc7f9548@linaro.org>
 <b79f7e0a-8048-d0e1-ad0b-d15d72288fde@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b79f7e0a-8048-d0e1-ad0b-d15d72288fde@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 19:08, Tanmay Shah wrote:
> 
> On 1/12/23 11:52 PM, Krzysztof Kozlowski wrote:
>> On 13/01/2023 08:30, Tanmay Shah wrote:
>>> This patch introduces bindings for TCM memory address space on AMD-xilinx
>>> platforms. As of now TCM addresses are hardcoded in xilinx remoteproc
>>> driver. This bindings will help in defining TCM in device-tree and
>>> make it's access platform agnostic and data-driven from the driver.
>>>
>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
>> prefix is already stating that these are bindings.
> 
> Ack.
> 
> 
>>
>> Where is driver or DTS? Are you now adding a dead binding without users?
> 
> 
> TCM is used by drivers/remoteproc/xlnx_r5_remoteproc.c driver. Howerver, 
> we have hardcode addresses in TCM as bindings are not available yet.

I don't see usage of these compatibles there. You also did not supply
DTS here. Please provide users of bindings within the same patchset.


Best regards,
Krzysztof

