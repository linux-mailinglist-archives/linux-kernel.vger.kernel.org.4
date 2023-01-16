Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467466C8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjAPQmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjAPQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:41:45 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55332ED4A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:29:57 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j17so43475013lfr.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G8K1RmWXIkiPGKo5rdIMlyUws+ytI7cIHwrzZJ2azso=;
        b=Qwo73i7k4TFVW4W9ODHn2D31owplGN+ohI4BcXolF/ZQkD6do3Wcxz1nYOC9CNXonX
         jS1RVfnJcQQVABWLq0jNH4zheVyf4h+GMcbONNoUdnri7EXnXonvt/hUQXFZFO1J4VIE
         /jj/OeKV1qAbQdKi2V/45Q69RwkZ8rR1pOiTPZ1lgP/79MZ4kFTQhJqM76J+i1+8w8nD
         ayeX1QToZyVrwU1GjlFcCXzJZKQ2R6Xhc/a61usDxr0B9tyokNrdPmr3dzt94h2Cm+WG
         Sme/OPxLhDfUbhZysJgMsukjfrMJJnmj+xESqgD7xAN7XGm9ZDJkXBjaapDzuKZltmpU
         79hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G8K1RmWXIkiPGKo5rdIMlyUws+ytI7cIHwrzZJ2azso=;
        b=qbsY5R+Aodf2vzMgzmNCGT2w4D9940fzThQMVaXAh0xZriSB6keFjASa8kmDH/65Zk
         pp/1s7UgUI4IAVyr2NvHVts/B7m6Rb9buQZnTLPKml+fVw6ZfqS7B9hhVvRT+Gvhe4BJ
         BA37XIWs8cgNizQpT/knXcEp8/X9lGFUvWoVFe3y7CJ9ntJ2X6uRH7mzYJUjWuMm88GI
         iF/DptL3s2nq1b0e6MjYix73OFvQHCNlnwN0jGdKarmMk/KoEBxUZ+ESVjceUln9umWh
         P8v8lZIEgEI3VnP+LRiy/Tp0k0kEZd+OJHyJi3s1ddjnhJ050ThsjujgR7c9Q80HMbR4
         HhwA==
X-Gm-Message-State: AFqh2kpbsDojaotc9K+aNwetiA5kBrb7SQPdQ3B2m4qhYW7hv3lfm8pa
        a7xclfVjFLxtBnJntERzZXS+pA==
X-Google-Smtp-Source: AMrXdXsPIZj1jWkctfyszi9JmAGWKyuU0BIXMPnSpGeeviVYMWHd72EtUdKxhks7JtVTHMQhAtHFmg==
X-Received: by 2002:a19:e611:0:b0:4a4:68b9:608a with SMTP id d17-20020a19e611000000b004a468b9608amr24195186lfh.21.1673886596181;
        Mon, 16 Jan 2023 08:29:56 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id x12-20020ac25dcc000000b0049fbf5facf4sm5087974lfq.75.2023.01.16.08.29.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:29:55 -0800 (PST)
Message-ID: <09fe3e93-328b-13a3-540b-4ca47224b176@linaro.org>
Date:   Mon, 16 Jan 2023 17:29:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
Content-Language: en-US
To:     bhupesh.sharma@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
 <23b4551c-db79-d859-c037-6ed3c8a11883@linaro.org>
 <6f08d466-9589-ebff-c38d-bf9015a0f6ad@linaro.org>
 <64e4b3b0-fc71-1876-9de8-e51d503d6183@linaro.org>
 <3e18a79b-fdd8-63f8-c27a-7515bbb6cb9b@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <3e18a79b-fdd8-63f8-c27a-7515bbb6cb9b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 17:18, bhupesh.sharma@linaro.org wrote:
> 
> On 1/16/23 9:35 PM, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>> On 16.01.2023 17:02, Bhupesh Sharma wrote:
>> >
>> > On 1/16/23 9:24 PM, Konrad Dybcio wrote:
>> >>
>> >>
>> >> On 16.01.2023 16:43, Bhupesh Sharma wrote:
>> >>> On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
>> >>> <krzysztof.kozlowski@linaro.org> wrote:
>> >>>>
>> >>>> On 15/01/2023 22:33, Bhupesh Sharma wrote:
>> >>>>> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
>> >>>>> <krzysztof.kozlowski@linaro.org> wrote:
>> >>>>>>
>> >>>>>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
>> >>>>>>> Fix the following '#address-cells' & '#size-cells' related
>> >>>>>>> dt-binding error:
>> >>>>>>>
>> >>>>>>>      $ make dtbs_check
>> >>>>>>>
>> >>>>>>>      From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>> >>>>>>>           arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
>> >>>>>>>                 #address-cells:0:0: 2 was expected
>> >>>>>>>         From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>> >>>>>>
>> >>>>>> Don't we want rather to unify the soc address range?
>> >>>>>
>> >>>>> Well, the assumption in the original dt-bindings was that every reg
>> >>>>> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
>> >>>>> #size-cells to <2>). However, that is not the case for all of the
>> >>>>> SoCs.
>> >>>>
>> >>>> Hm, which device of that SoC cannot be used with address/size cells 2?
>> >>>
>> >>> As noted in the git log already the geniqup on sm6115 / sm4250 cannot
>> >>> be used with address/size cells 2 (See:
>> >>> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)
>> >> SM6115 (and pretty much every other arm64 msm platform newer than 8916)
>> >> should be using addr/size-cells = 2 along with (dma-)ranges of 36 bit, as
>> >> that's what their smmus use and otherwise some addresses may get cut off
>> >> in translation, or so the story went with 845 N years ago.. We can either
>> >> pursue this patch or I can submit the 2-cell-ification if you don't plan on
>> >> adding more nodes shortly
>> >
>> >
>> > Have you tested this combination on SM6115 like SoCs with various IPs? I have tried a few experiments in the past and not all IPs work well with 36-bit DMA ranges (atleast not on the boards I have).
>> Can you list any specific examples? I've been using it for
>> quite some time now and I see nothing wrong..
> 
> I remember seeing some issues with SDHC controller booting (uSD card use case) with sm6115, but I cannot find the appropriate dmesg right now.
FWIW it works completely fine for me, in fact I'm booting from
uSD most of the time.

Konrad
> 
>> >
>> > So, I think it might lead to more breakage (unless we are sure of a well-tested fix). A simpler patch to fix the dt-bindings looks more useful IMO.
>> I'm not saying no, you just have to convince Krzysztof :D
> 
> :)
> 
> Thanks,
> Bhupesh
