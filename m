Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087FD6DA065
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240174AbjDFS4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239433AbjDFS4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:56:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD8986AE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:56:09 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id l17so3730696ejp.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680807368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UKWsjR8dvIajtx2lwaiB5l0sOFoUN7LSgDCFNG47cFM=;
        b=XjEn4vgMEEWThuDKwwudOndDLakz8rYSUEfoHZwSYrR6827fNdSGSO5eLlexBm5Vnv
         tSV1KY44b4wSwtSr51m0PBvwMwp/0KLHLjqKJ96ZUc3ucHFXbi9LT6XdH8cjJoopAUrh
         Ym5qIw6Au09J4j2KcDO9vVWmeYCubuWXG375CMn+1emhdEhvUwcqL4RzuRFGmjXsxWbK
         r7fj/AMOTrPXVdbRheBL2iM6dw8z4NA/WYfN8ctJd6Kh+usy4dKzg6QQPS6MuvdUdA/4
         +emlWHLb6n8v1gvxdH6Tpkfz+AmWrjyQ9zC/GdwNnduqIZ1ZPGqPVK0d5djvwMW1RIX6
         wDJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UKWsjR8dvIajtx2lwaiB5l0sOFoUN7LSgDCFNG47cFM=;
        b=3xml4VBJtnUbo9NnMqixtS8jrTnyi+hOHLPzdhtLU2fnDXsKKh6WiXkrlP4Nu+ZhJQ
         ZLaoL+L9kKSDNFO5qs+84yDaX5g3+dgo0dp2gze6qzNhLQ9eEBdyoUph/BGZscjePUvg
         6KJlwdzGsneXCFrykCJDgx9pcJAjTCfIC0afsVoJV4QVZG+Ut5w/nE900eO6zwJhMRyu
         huFYF13PZIqgKBiBe1Xwhv3tl7ftEXNvF69HdtH69p1Z8G9LLDUQGgxAk3q77b2ELs9M
         nrcekbVtyZjZRl5sE0GbquU1gA7+Ga3Ks9Lkd1358IZ6b0oNe7m4YhbjZf1xzmypz6G3
         zQ9g==
X-Gm-Message-State: AAQBX9doowvbnZGBoPmN7HeqLOqf2bm7wvwSUpVHPFjYv/a6chB0/kAw
        vGDZ+WSu7uGRu4NdolVjge/W7g==
X-Google-Smtp-Source: AKy350b5CYgkCwCJEQ33zJ/y2kC09b+dJi0dyD9TAE8pwMa6j0ytFRRtCmrXrSvkvumeFJwFghiQKw==
X-Received: by 2002:a17:906:828f:b0:931:462f:f141 with SMTP id h15-20020a170906828f00b00931462ff141mr6219852ejx.20.1680807368361;
        Thu, 06 Apr 2023 11:56:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id qw34-20020a1709066a2200b008c76facbbf7sm1144477ejc.171.2023.04.06.11.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 11:56:07 -0700 (PDT)
Message-ID: <5e2e5b82-35ae-c3b5-becb-40d387226a7a@linaro.org>
Date:   Thu, 6 Apr 2023 20:56:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] dt-bindings: cisco: document the CrayAR
 compatibles
Content-Language: en-US
To:     "Daniel Walker (danielwa)" <danielwa@cisco.com>
Cc:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Marcin Wierzbicki -X (mawierzb - GLOBALLOGIC INC at Cisco)" 
        <mawierzb@cisco.com>, Rob Herring <robh+dt@kernel.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230405223028.1268141-2-danielwa@cisco.com>
 <6a9f041b-1c35-4691-8451-7119cd05ed17@linaro.org>
 <20230406151512.GL40472@zorba>
 <14634180-aca9-a3e9-d1af-dfaca77b42ee@linaro.org>
 <20230406183253.GM40472@zorba>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406183253.GM40472@zorba>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 20:32, Daniel Walker (danielwa) wrote:
>>>>> +++ b/Documentation/devicetree/bindings/arm/cisco/crayar.yaml
>>>>
>>>> How many (or not many) platforms do you expect from Cisco? We mostly
>>>> have one file per SoC manufacturer.
>>>
>>> We have two SoC's one called CrayAR and another called Craw. I've submitted the
>>> Craw dts file before , but I've not resubmitted it. Under Craw I think we have
>>> at least two, but more likely five variations. CrayAR we have one variation with
>>> at least one more planned.
>>>
>>> So we would plan over time to add two dtsi files and three to four dts files to
>>> this directory. Then more over time.
>>
>> So just keep them in one file maybe.
> 
> If/when I submit again with anther chip we can discuss it at that time.

Or you can do it now.

Best regards,
Krzysztof

