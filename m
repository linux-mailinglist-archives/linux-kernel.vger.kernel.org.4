Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB085B4EFE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIKN0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbiIKN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:26:32 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F62B19D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:26:30 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i26so10629198lfp.11
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=14hFcicxsn548zF5tUnuNbrYw8l13xnXDnsLcahEqfk=;
        b=frcJwqBtf0XHKe+56ABxIpvFvEaoysRlhFuJ0s0iUv5RTlrk8X41rUvhDo6nqLViAz
         eQJuYbWQy5ZCng4vacdrerB+QGj7gt07niFi4RcgFHOfQYZJZCZ6rH42Zidv59XsAXTC
         vs+IGBPhlAab9SoRs97HSwgQRasr7GuwygmY24VZUA8EMw16UODiZOuZMjLKvDNhKOAL
         acfFZErdpCLbPUB/3n0Uzd07wwz3RuaDJ+/6zqrgsd3tU9s/3TeYlkV/IINi0v1zNPcJ
         k/ZwF35lX6TQsikam/Ks53BJM+B01Uvm0ZN5qjTMvWNo0kyAFkppjBpzJYW0f80d+vRe
         IR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=14hFcicxsn548zF5tUnuNbrYw8l13xnXDnsLcahEqfk=;
        b=kwmT4QO0NFZfre8CtwFREn1H1J3RTvFQWAnU9WrDCMJR/5vpYakbT3YqJcCsJHjIpM
         xsO9Jia9l3RCYL67oUlDo4G8Eg0+fpYoTMRGiC2jU024exq0xZ81wbhPyCJB/WofIUO9
         7bqgw1dCVceWClSA1MiMgANDvKYnrqqYwGsllacGV9W/D9UTUQpKS/pum60+ynMY0CW2
         85ouRkprk9FH8dAnqzzJvFfTVX7RsjZ2PqYqkffjtUsLq/d8WPbELCoelHP0ry1wA96n
         H5MgDW61GWmqUWhJoc0egQpQK4vElojytPzNDXJ3aIPdPQvKORIMfvS7XouB2Gzenco5
         Vl/w==
X-Gm-Message-State: ACgBeo0L0s1g0hZXDEqx3yTnkKbWfz+chIuAtFQm4qvqWkDj8O2GkpNd
        KzodEKToL73x7hyeXmdnrM8lgw==
X-Google-Smtp-Source: AA6agR7pcPv7y7NYzQVSzmWGEtOD4Mtp8S102HDFmXzLHd8E9ye2Htr0ID91MSFLZ1YPLDuNe7akWQ==
X-Received: by 2002:a05:6512:3996:b0:492:dacb:33ce with SMTP id j22-20020a056512399600b00492dacb33cemr6988194lfu.445.1662902788579;
        Sun, 11 Sep 2022 06:26:28 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id z14-20020a19650e000000b00490b5f09973sm614410lfb.92.2022.09.11.06.26.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:26:27 -0700 (PDT)
Message-ID: <f63fcb88-77de-0d57-f3f4-5d61a6d4c133@linaro.org>
Date:   Sun, 11 Sep 2022 15:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 01/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix
 matching pin config
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
 <20220911111200.199182-2-krzysztof.kozlowski@linaro.org>
 <732d13e0-07a6-3b22-23e3-32f20cf7f750@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <732d13e0-07a6-3b22-23e3-32f20cf7f750@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2022 14:59, Iskren Chernev wrote:
> 
> 
> 
> On 9/11/22 14:11, Krzysztof Kozlowski wrote:
>> Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
>> does not work as expected because of linux,phandle in the DTB:
>>
>>     'pins' is a required property
>>     'function' is a required property
>>     'rx', 'tx' do not match any of the regexes: 'pinctrl-[0-9]+'
>>     [[59]] is not of type 'object'
>>
>> Make the schema stricter and expect such nodes to be either named
>> 'pinconfig' or followed with '-pins' prefix.
> 
> Well, now you don't allow pinconfig, so maybe tweak the commit message.

True, thanks!


Best regards,
Krzysztof
