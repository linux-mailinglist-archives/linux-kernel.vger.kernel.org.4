Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F496652908
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 23:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiLTW13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 17:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiLTW1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 17:27:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF07DF7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:27:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b69so19583613edf.6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 14:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDN/5v5x3AD8aunYp6Yw+XZt6VK6NcKKWKn7atc35rQ=;
        b=hU83RSV9Vh0OlsC1VfiC3slmpdenrSL3zgNGmjJMSnkdfHdlGR1siYMFX3L1d7HkeJ
         cDbQ3svzofPMbLnjrRJFTstudiEuav80Yn5/3Hp6wCn45r37QvTMqZiJBJ6r8Du7IsvM
         76iVjt5ib665gPgLruBPzByzfHhwyM0ADXMWY5NrK7O2FfkfvMLT/6wcaSRRHoG1cv71
         eryFUR/OLlY/C4n7wZ9OtSb1er9TCGeo3LXQWjMhQRAd+Uwuz2rDwa+Va3m3Q9fF6n08
         1PprID5zblHKtoMdHb8bl8SMe8UxP62i3vKtH9K4ncQ983lh91FwEsFMtnnOOsG5uvi6
         S8dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vDN/5v5x3AD8aunYp6Yw+XZt6VK6NcKKWKn7atc35rQ=;
        b=N4nznWOD7Fs60/TVx4rQH0TLOwu9mPOfF09/ICsFi26HmtvlWC9Abpu2ww198yClq+
         3K/iuYMouAYqyJ1ERAkRrwAVKzqKuC5Z0DaDH1wal2ODsvUf6i2XqH+/OFLJAro2YQuN
         C0bIjiTayKLx7aQ9QFtlOUcRfW1u8/2xDZE89phEBDhmSxroHNU1Z73CstWtxE+4HklN
         LmxAAPPsCf0GTligk2TnRlWQoW85iMbvli66ZqIAURbrqex2aJPLSEdo6B240HKv72IC
         lZu5bMtgMGMau6ZGoNTCHANkJGznkN0JOH1o1fRfV2dh6tai+KzWhKozJr9BjGV64ZaI
         tmSw==
X-Gm-Message-State: ANoB5pnhjAPadchpOkZDSxd+NYWy9PkCtFN52PVyRwjmuravVsaZqrpt
        HLiK6bsdkAIjk+LM+/exZQ5KiA==
X-Google-Smtp-Source: AA0mqf7SLZvw2edI/x/p/oBKjSA6C0c+O6TQ6txc3QQJmXfuXeQ6PyPEU3ctG4om5l/tkc4VbK0qag==
X-Received: by 2002:aa7:d403:0:b0:470:31fb:cdcc with SMTP id z3-20020aa7d403000000b0047031fbcdccmr28813524edq.6.1671575240162;
        Tue, 20 Dec 2022 14:27:20 -0800 (PST)
Received: from [192.168.1.115] ([185.126.107.38])
        by smtp.gmail.com with ESMTPSA id t21-20020a056402021500b00463bc1ddc76sm6206860edv.28.2022.12.20.14.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 14:27:19 -0800 (PST)
Message-ID: <7549c8a8-bad0-7f7b-b07a-4a80d44d1ec3@linaro.org>
Date:   Tue, 20 Dec 2022 23:27:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v3 1/2] remoteproc: elf_loader: Update resource table name
 check
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, mathieu.poirier@linaro.org,
        corbet@lwn.net
References: <1671523269-21154-1-git-send-email-quic_srivasam@quicinc.com>
 <1671523269-21154-2-git-send-email-quic_srivasam@quicinc.com>
 <0d683526-5707-d5b4-e96d-b2d982d4b5da@quicinc.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0d683526-5707-d5b4-e96d-b2d982d4b5da@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/22 13:50, Mukesh Ojha wrote:
> Hi,
> 
> On 12/20/2022 1:31 PM, Srinivasa Rao Mandadapu wrote:
>> Update the way of checking resource table name with prefix
>> substring search instead of complete string search.
>> In general Qualcomm DSP binary is prepared by combining different ELFs',
>> hence section header name (e.g. .resource_table), appended with ELF name
>> to differentiate with same section(e.g. resource_table.ac_bin_process) of
>> different ELFs'.
>> Example readelf output of DSP binary:
>>      [60] .start.ac_bin_process PROGBITS
>>      [61] .resource_table.ac_bin_process PROGBITS
>>      [62] .comment.ac_bin_process PROGBITS
>>
> 
> Could we rephrase above like below ?

FWIW I agree :) I assumed Srinivasa was using a broken email client
that strips newlines and packs everything.

> It could be also taken why applying 
> the patch.
> 
> Update the way of checking resource table name with prefix substring 
> search instead of complete string search.
> 
> In general, Qualcomm DSP binary is prepared by combining different 
> ELF's. Hence, section header name (e.g. .resource_table), appended
> with ELF name to differentiate with same section(e.g. 
> resource_table.ac_bin_process) of different ELFs'.
> 
> Example readelf output of DSP binary:
>        [60] .start.ac_bin_process PROGBITS
>        [61] .resource_table.ac_bin_process PROGBITS
>        [62] .comment.ac_bin_process PROGBITS
> 
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> 
> Otherwise, LGTM.
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
> -Mukesh
>> ---
>>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c 
>> b/drivers/remoteproc/remoteproc_elf_loader.c
>> index 5a412d7..77330d6 100644
>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
>> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct 
>> firmware *fw)
>>           u64 offset = elf_shdr_get_sh_offset(class, shdr);
>>           u32 name = elf_shdr_get_sh_name(class, shdr);
>> -        if (strcmp(name_table + name, ".resource_table"))
>> +        if (!strstarts(name_table + name, ".resource_table"))
>>               continue;
>>           table = (struct resource_table *)(elf_data + offset);

