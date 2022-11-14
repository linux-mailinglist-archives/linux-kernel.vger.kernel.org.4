Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77769628648
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238014AbiKNQ5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:57:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238175AbiKNQ5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:57:00 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BDB15715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:56:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id l12so20267628lfp.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y58GC68qONNsMENmg/gVzchuwfipMrSIXXvNyA3gkbg=;
        b=erS66v2Lwbd/Bxw+cRVGXpnK35dtxrMBXRB+gqK+ylQztNcHOO9KdsKrDgfgjZcEX+
         ouaZTMB5YfsbyHkyDGm6jELbRu5So6/39tYq+IF6XHddJfI5TTmJ4z6iAg8DVsHMGfl0
         HaJS/gZBtc22idWiPmbWpoymiy/5C7d267VVNe/NDMKjydsr3ooRdpDux5wD1rFsajuf
         7siXOYyiajlxTPPIFiuXXDqe/6sddtRVNlm3w3MN/yBBk+Bcfsh4/TSgWH0yt5p50G56
         2ymTpYLIj7UDHMugg/DMFidpg2JVq3pWUw/KNzYlaCzSBmeDP7NsY+xy/0oLaJSQmZxz
         U4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y58GC68qONNsMENmg/gVzchuwfipMrSIXXvNyA3gkbg=;
        b=wesSll4HWXBJ9CF65UnjnomiwmvjfShcha2ThMihG9ZeTbxxDxV0xTNckTaIXmvZpG
         QyGVgFJ3kHkE7rRBlF+k1yd1+pfUjfkj/GuJXcaA70p9fsg/KmQXi8vcbKZLHYzLBGk9
         qETEu6M4hzniSDm0aZdHJFOnO55/m4c7dsatzl1ee+jGhMEeMizh9SSOk4BYbZ3pXout
         xF3Jnd/Kc1g203J00KoYtEw5YQnS2GX/rtFbmbJC5DDBe+AFcIqlSkKiD5oUrRCXQybQ
         3PbCEARncEo/0EvlfRiz8IJB4KKIGsbh9mEpEbT+Vc2FtNYBG4YjMk99P1MvgUK1apWt
         h8kQ==
X-Gm-Message-State: ANoB5pnPWwyapXdwWB7tDabVkmurIbVmkXnMdOKErc74ELG4vh4K3dJy
        JR7dUmSf+h8Ao/cVxE9uBoPm/Q==
X-Google-Smtp-Source: AA0mqf6nd4/xXmES0TovIm34CZ9x5BlOLPTUbu60+ZDPXCjvtXdVhANJep/PDnB+Ud+HWFXHnhLUzQ==
X-Received: by 2002:a05:6512:3414:b0:4a2:2b23:f17f with SMTP id i20-20020a056512341400b004a22b23f17fmr4121950lfr.688.1668444983295;
        Mon, 14 Nov 2022 08:56:23 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id q3-20020a19f203000000b00493014c3d7csm1882169lfh.309.2022.11.14.08.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:56:22 -0800 (PST)
Message-ID: <8420c342-9dce-aea7-8d1e-f141e0c1ebb5@linaro.org>
Date:   Mon, 14 Nov 2022 17:56:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
 <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
 <Y3JCVzJ74YsfcDz4@hovoldconsulting.com>
 <de3a426a-03e8-ed15-a9a1-bb300e776e5f@linaro.org>
 <Y3JOO0kNnaNhnW3K@hovoldconsulting.com>
 <02725b78-04ad-8f4a-25c2-9cdaa1e37ab7@linaro.org>
 <Y3JthM1jC2vH1Kn+@hovoldconsulting.com>
 <efd412d0-7411-8b0b-4700-9e183a592048@linaro.org>
 <Y3JxZ+yFMLZkwNBi@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3JxZ+yFMLZkwNBi@hovoldconsulting.com>
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

On 14/11/2022 17:48, Johan Hovold wrote:
> On Mon, Nov 14, 2022 at 05:39:26PM +0100, Krzysztof Kozlowski wrote:
>> On 14/11/2022 17:32, Johan Hovold wrote:
> 
>>> Fair enough, I'll drop it. But there doesn't seem to be a good way to
>>> describe the indexes currently and most bindings simply ignore to do so.
>>>
>>> So what is the preference then? Just leave things undocumented, listing
>>> indexes in a free-text 'description', or adding a free-text reference to
>>> a binding header file and using those define names in a free-text
>>> 'description'?
>>
>> Either 2 or 3. Several bindings for small number of constants choose
>> option 2.
> 
> Ok, we have three now, but USB4 will bump this to ten or so.

Then probably header file is the way to go.

>  
>>> And if going with the last option, does this mean that every SoC and PHY
>>> type needs its own header for those three clocks or so to avoid having
>>> a common dumping ground header file where indexes will not necessarily
>>> be 0-based and consecutive.
>>
>> phy-qcom-qmp-combo.c has one qcom_qmp_dp_clks_hw_get(), so why would you
>> have many of header files?
> 
> We don't know what kind of clock outputs later revisions of these PHYs
> will have. The only way to guarantee 0-based consecutive indexes appears
> to be to use per-SoC defines (e.g. as for the GCC bindings).

Which is also fine. I don't understand still why it is a problem - even
if you have multiple files, one for each SoC/phy. If USB4 brings here 10
more clocks and other SoCs/phys might bring many more options, then what
else can you do? Grow the binding file with big text-based mapping of
IDs? It's not a viable solution. Header or headers is the only
maintainable way for such cases.

Best regards,
Krzysztof

