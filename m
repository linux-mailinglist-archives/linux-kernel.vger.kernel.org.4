Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8166C473
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjAPPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjAPPyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:54:45 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC58222FB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:54:43 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a11so3194553lfg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/J5BwwFc+cz/TVDnLga/TBpZtC0SR+xIrcvCr3tsklE=;
        b=mjEe8zC+F2uzPnl/V19BJ86H1CRNDA0hltY9Vvgnodci10MGhKWGVcfnVjG3kMJWq2
         C6EL8sZ5hOTQsKERCDp+oGg6RRkDkRUOcIg7e7fSwuidSM0XgyhEvG8lXWSoffnZSJYE
         tBvtE+U6BaD+q8NWWp6OuaqJMf9pN68BYeYepcxtDncxZojcgBJ1ClBKj6ppmrYGdEPS
         lOOkujclXuQWaQn7wHUNr6sBaR7OJEJx7CuJMgu2edIMVEOGbFMpORghxSA1CLP8F8RD
         tZa0DHcVYN5xa/Vovk9M7X6YYD82A7D6aUGHrTD/Idbb9ohDkIA9xNOHE9XHUe5QzkF2
         bE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/J5BwwFc+cz/TVDnLga/TBpZtC0SR+xIrcvCr3tsklE=;
        b=GfnriFein3BeV7h/eElcme3cRUdaHRaP+yDNotRB+Vg2ZQNOVbKPhkdetIHojrMTsO
         gX+PKBH1XPvb3w1tjPDJ3Kb3NmWPaco+4q/kEhY4t07+NbYlFJS3V0DnnNoc8iNERuxG
         IH2qZ9ELLgmoKNkHEVe+ZaVKaOC/6+TyAkPfjlZa/6dymLBwKJzXl712SQ3nK7mp0NeR
         ZqhIrAe0R/Q74vCj0fpD5+0mS4GccMgDvE/TqMXk+LV8eLvGA8GuAkTmguwUYoAz62Y0
         41j+RtXf1yisLaLIvb5aVEdUOZlbgcW42A3g8qaR8tXr64eXhjcN1fkpLPRNcil9hOxb
         bD3g==
X-Gm-Message-State: AFqh2krbeAdTmKBnBNYtsDeNcGMhc9lWadrGnYtpcn2w5qSppqtyqg5y
        tNoaA7V2+i4YGMUB5VfO2gnkaA==
X-Google-Smtp-Source: AMrXdXsBv/GWU6qRrChpha6bgiHRPoveqk+ry3Qo/ejYePhKMUqXzP3fbH+paG3qpb92rYWDro/jlg==
X-Received: by 2002:ac2:5fad:0:b0:4b5:964d:499e with SMTP id s13-20020ac25fad000000b004b5964d499emr24222483lfe.8.1673884481873;
        Mon, 16 Jan 2023 07:54:41 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id d23-20020a056512369700b004cc86bc8f22sm3604692lfs.90.2023.01.16.07.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 07:54:41 -0800 (PST)
Message-ID: <23b4551c-db79-d859-c037-6ed3c8a11883@linaro.org>
Date:   Mon, 16 Jan 2023 16:54:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: qcom: geni-se: Fix '#address-cells' &
 '#size-cells' related dt-binding error
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, andersson@kernel.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
References: <20230113201038.267449-1-bhupesh.sharma@linaro.org>
 <aef753a5-e8b1-5b7b-1b9e-e92a84de15bd@linaro.org>
 <CAH=2Ntx5rLWu4jzXV8DwKj+yweHPRqb4+Rv8uZpDn_brWDxyJg@mail.gmail.com>
 <b9aa6d30-5fe8-57a9-e478-c99bca70d185@linaro.org>
 <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAH=2Nty2gUL3DufowzHavhUNdeht2dcX4EU7ooM+xzax2vP7uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 16:43, Bhupesh Sharma wrote:
> On Mon, 16 Jan 2023 at 13:23, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 15/01/2023 22:33, Bhupesh Sharma wrote:
>>> On Sun, 15 Jan 2023 at 20:57, Krzysztof Kozlowski
>>> <krzysztof.kozlowski@linaro.org> wrote:
>>>>
>>>> On 13/01/2023 21:10, Bhupesh Sharma wrote:
>>>>> Fix the following '#address-cells' & '#size-cells' related
>>>>> dt-binding error:
>>>>>
>>>>>    $ make dtbs_check
>>>>>
>>>>>    From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>>>         arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dtb: geniqup@4ac0000:
>>>>>               #address-cells:0:0: 2 was expected
>>>>>       From schema: Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml
>>>>
>>>> Don't we want rather to unify the soc address range?
>>>
>>> Well, the assumption in the original dt-bindings was that every reg
>>> variable is 4 * u32 wide (as most new qcom SoCs set #address- and
>>> #size-cells to <2>). However, that is not the case for all of the
>>> SoCs.
>>
>> Hm, which device of that SoC cannot be used with address/size cells 2?
> 
> As noted in the git log already the geniqup on sm6115 / sm4250 cannot
> be used with address/size cells 2 (See:
> https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/qcom/sm6115.dtsi#L795)
SM6115 (and pretty much every other arm64 msm platform newer than 8916)
should be using addr/size-cells = 2 along with (dma-)ranges of 36 bit, as
that's what their smmus use and otherwise some addresses may get cut off
in translation, or so the story went with 845 N years ago.. We can either
pursue this patch or I can submit the 2-cell-ification if you don't plan on
adding more nodes shortly

Konrad
> 
>>> So, ideally we shouldn't set the  "#address-cells" and  "#size-cells":
>>> as const: 2 in the bindings.
>>>
>>> See as an example:
>>> https://www.kernel.org/doc/Documentation/devicetree/bindings/usb/usb-device.yaml
>>
>>
>> How USB device - so entirely different device, not MMIO! - is related here?
>>
>> Best regards,
>> Krzysztof
>>
