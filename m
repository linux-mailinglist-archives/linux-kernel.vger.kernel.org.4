Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82CBB6B135C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjCHUu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCHUu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:50:27 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570CC898E5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 12:50:25 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id d36so19819919lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 12:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678308623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nYwLVEVSE2EPrgo1n3Ngcv+XtjRTRaLWqRbbxXSD/xk=;
        b=mF3UAgvW9FF5NIOI22wReRQfggzTMJgofFBBwKGOrmg5LAczUktEc2NObfd9ME/gd8
         76H2hBMj8VllegtTHYxUFxA3HNICN4w0HWvFBarUbPx9jihnOlT5jdq5a3bmmC5FefAj
         RhYSrkwmqjQJuThodWT/tgeQqD048TLpdu7HWCbuyWMHNA09CVrc6yl++BSIZ6K6FqZO
         88hd9tUo8kBN0tsNPorNeLdqOY9p7XAXTlZEYU3xDjBQjwtucgmbqt5GNwQZy4wo8nud
         VtOSgdaWV/qPvXDZ03R+FPoFNyDQzWCS2phJJMf8TEqZwhUzeQSeVxdBwEx+kZUhzuM2
         Tzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYwLVEVSE2EPrgo1n3Ngcv+XtjRTRaLWqRbbxXSD/xk=;
        b=etqkm+pbWgWscXaJeJE5OqSNsh8lx5HZwM5I/w8o7pdHb5+O8p1sO7sH4OxxdOo66e
         HSnZHyn4eLFMi6IjkxwDRkRtJoyd9e5KDnapx83if8RshxNDyPLDmh6p1bcdsYXjlzVo
         lOeVoUJmh42VPg8Q1+w1bbt//LElFvZmDpo2nJzxAzaO0+fnYB/GiF4opn1nIA9f+97F
         XHPqM0raT4MG80gp53uLpn8DiROHZnreNCgHG2vN2VeakA143u8eQcMxjHKocZpIrrtU
         m8L8IZfGWK1tMd2YVHW/3ZbmI0MurdRVUTk7hHZ0uJbPuoMQEV7l9xq+/OXJtFBMHHki
         54Sw==
X-Gm-Message-State: AO0yUKVnGZrbM6tD3OLKTODV25QgjBdy4bHUk3grSzBlSJkKXAR3QCQg
        y4dminluN0gm5JtybNkWNEVdoQ==
X-Google-Smtp-Source: AK7set9UKMCiINw0hFDIUgHmTG4rK1PxVHXXhak5Qc5uybqo3hZizJSkZ9eh9Krp8wzZcpbaW6cxtQ==
X-Received: by 2002:ac2:5630:0:b0:4db:384c:bb8 with SMTP id b16-20020ac25630000000b004db384c0bb8mr4868721lff.69.1678308623589;
        Wed, 08 Mar 2023 12:50:23 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id h3-20020ac25963000000b004cc8698c3f4sm2423472lfp.156.2023.03.08.12.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 12:50:23 -0800 (PST)
Message-ID: <88bd0152-8b53-5ae2-bb16-5060419ca580@linaro.org>
Date:   Wed, 8 Mar 2023 21:50:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC PATCH 3/6] soc: qcom: Add Qualcomm minidump kernel driver
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <1676978713-7394-4-git-send-email-quic_mojha@quicinc.com>
 <00b37174-f19e-ce59-b520-304891f6e2ef@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <00b37174-f19e-ce59-b520-304891f6e2ef@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8.03.2023 21:22, Srinivas Kandagatla wrote:
> 
> 
> On 21/02/2023 11:25, Mukesh Ojha wrote:
>> Minidump is a best effort mechanism to collect useful and predefined
>> data for first level of debugging on end user devices running on
>> Qualcomm SoCs. It is built on the premise that System on Chip (SoC)
>> or subsystem part of SoC crashes, due to a range of hardware and
>> software bugs. Hence, the ability to collect accurate data is only
>> a best-effort. The data collected could be invalid or corrupted,
>> data collection itself could fail, and so on.
>>
>> Qualcomm devices in engineering mode provides a mechanism for
>> generating full system ramdumps for post mortem debugging. But in some
>> cases it's however not feasible to capture the entire content of RAM.
>> The minidump mechanism provides the means for selecting region should
>> be included in the ramdump. The solution supports extracting the
>> ramdump/minidump produced either over USB or stored to an attached
>> storage device.
>>
>> The core of minidump feature is part of Qualcomm's boot firmware code.
>> It initializes shared memory(SMEM), which is a part of DDR and
>> allocates a small section of it to minidump table i.e also called
>> global table of content (G-ToC). Each subsystem (APSS, ADSP, ...) has
>> their own table of segments to be included in the minidump, all
>> references from a descriptor in SMEM (G-ToC). Each segment/region has
>> some details like name, physical address and it's size etc. and it
>> could be anywhere scattered in the DDR.
>>
>> Minidump kernel driver adds the capability to add linux region to be
>> dumped as part of ram dump collection. It provides appropriate symbol
>> to check its enablement and register client regions.
>>
>> To simplify post mortem debugging, it creates and maintain an ELF
>> header as first region that gets updated with upon registration
>> of a new region.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
[...]

>> +int qcom_minidump_ready(void)
>> +{
>> +    void *ptr;
>> +    struct device_node *np;
>> +    static bool is_smem_available = true;
>> +
>> +    if (!is_smem_available || !(np = of_find_compatible_node(NULL, NULL, "qcom,smem"))) {
> 
> just check for dt node here does not mean that smem device is available, you should probably check if the device is avaliable aswell using of_device_is_available()
> 
> 
> We should proabably return -EPROBEDEFER incase the node is present and device is not present.
qcom_smem_get() seems to handle -EPROBE_DEFER internally, so this check
may be entirely redundant.

Konrad
