Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB395662376
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbjAIKs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbjAIKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:48:39 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3B9B4E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:48:38 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bs20so7713105wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 02:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=JQKR5U5znHf/DfWUyfUr9vzj4JNhDBQ0tGJoSZ+fIdU=;
        b=AJD0I0Flt9tbFUUVpsRDBDiZfNkqxlpScRM3n+c+4053f3wFU+mlmCbMtX+jaDI6xo
         ZQk+lgrpkfBUy36PIuOJLTPauc2bFtE+KUzf9mwmiE3Af1daXVi6aTKeLuGDRFZFg19P
         yPXRnHGFCCDZYQGZ/nH++Sve8hyYO3lbRg53KViRYhtmlT9XKKaBmrH28v1753X/01Xc
         eclpiyl671nDZ+u+ZVxN8rfXJp9BY29zvmRkFD1HEZ922E2HZAMgEgk3rlZQ3XwCVlff
         Gf3Yo418xjZNDJ+VIjsYwrkh4wcN/gjzL59YvsaYZLV6knWhz/pgYCdR8kJN/NGFVvvV
         X56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JQKR5U5znHf/DfWUyfUr9vzj4JNhDBQ0tGJoSZ+fIdU=;
        b=Q/d/3NavqpJbrkBsBYntc7Hky1CwFkHm0v3ZraCgW+fxcF2b28dktvmEtSFsMITsWy
         gWLBjgQg1ewV/y98+l4QOYEmcSHGrhYCdRQHHuxuYfdl3EPzLpxONOqZ9Og/KpGeU8YM
         Rqq9TnIA6LVX/+xE9Z2T4WycFt5o1CtT4PTOBrboBPF4rTD696I+jdWLB++8PR2lDOfL
         rDT706AQXmW7Z68ywGaJEiQrtXQ8VwRBntsWsJbMTBFwet1yWPTQanjH/ypOzIY9COo+
         AkAMFyXuGe4nYHems3I4t93xCDDohOGR0PL8EkYNS1ofEsZi6ZoU4CHBjYHkfvsGQvaX
         w6PA==
X-Gm-Message-State: AFqh2kqJiTK9JRhkryOLP+bQd27FbS0lKEu1EjWtmQmO6ySOWIVxq79d
        9+QtMZKB+swte6cduchKIn+h9Q==
X-Google-Smtp-Source: AMrXdXuJg2KGksTmoxldAlx+tbyK7I8htbzmfXDCcRKnFvbxALeCVgd1GoSPDyD0GkM0Snv9qSPWUA==
X-Received: by 2002:adf:e74e:0:b0:242:2755:211a with SMTP id c14-20020adfe74e000000b002422755211amr41114653wrn.38.1673261317453;
        Mon, 09 Jan 2023 02:48:37 -0800 (PST)
Received: from [192.168.7.111] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4bc6000000b0027323b19ecesm8279221wrt.16.2023.01.09.02.48.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:48:37 -0800 (PST)
Message-ID: <72b62e61-5823-86cc-e01e-652673da94be@linaro.org>
Date:   Mon, 9 Jan 2023 11:48:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 1/2] dt-bindings: regulators: convert non-smd RPM
 Regulators bindings to dt-schema
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221005-mdm9615-pinctrl-yaml-v5-0-910019fb8b9b@linaro.org>
 <20221005-mdm9615-pinctrl-yaml-v5-1-910019fb8b9b@linaro.org>
 <CAL_JsqLrDGW118vEV9dnpTkeJmE+S79u0WXajuTOVi31WmF87Q@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAL_JsqLrDGW118vEV9dnpTkeJmE+S79u0WXajuTOVi31WmF87Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/01/2023 02:06, Rob Herring wrote:
> On Thu, Nov 17, 2022 at 11:05 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>>
>> Convert the non-SMD Regulators bindings to dt-schema, the old text based
>> bindings will be deleted later since the RPM bindings are not yet converted.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../bindings/regulator/qcom,rpm-regulator.yaml     | 128 +++++++++++++++++++++
>>   1 file changed, 128 insertions(+)
> 
> Looks like patch 2 was applied, but this one still needs to be respun
> and applied as linux-next has warnings now.

Ack, sent fixed version at https://lore.kernel.org/all/20221005-mdm9615-pinctrl-yaml-v6-1-6c913908bb85@linaro.org/

Thanks,
Neil

> 
> Rob

