Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442156D9745
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237624AbjDFMsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238249AbjDFMr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:47:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA0683C5
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 05:47:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id g18so1086979ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 05:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680785275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pqoit8xToIIuamXko9dKq9ZZ926+j81KZy09Bd8PNx4=;
        b=G/F/oTUMG7RsJLcSeHUdaBppYpc/BuNKj4l++JGWZhVxnf7Vl5l68iWC5m3LFLKEzc
         QSb4rDa3EuImeJlLVF6BXX69m6uMo6E76GqDsxDx2Kvq2qBfNsIpbJOzHWnswiPUOiVP
         5Eri6wLu6urWUMyJNyyL5G1/hgUigz6ElJX/Lhphg3/TGI0QRsWkz0lZzpdsWXuVDWKN
         FZO1F3KxOmsKIfmPN2/BdsBi7xYOp2/UM7MeTTqgC8TS5gUW3OZWNc9+tIBbOJA7I6x6
         ZyYwd9/wg+Qmd3F0+ROkXIpfePTkGgZqmgqA0Ndrc3VA68wPFSmtcwLvyulPnKuJeukV
         i7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680785275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqoit8xToIIuamXko9dKq9ZZ926+j81KZy09Bd8PNx4=;
        b=4JqGI/dLp/ZjJvTEpaKsCu6+JyVPMxqiab2gA87Sws9vxsaIM/o+LDWs3jbAS1CLuB
         uoGNpttgKsHhqn93FcJ0G9+CuAMY1dC2VIji4iuOI7vVtEOGh2guw+JTs0d+caB1rqbE
         BfPAG31wiiU69gSfo1ZTdqcgcQ+fk4TJoCUHEe7KBvt+Xuv6IAHf4ZWAY7zEMVs1CvGO
         P29Ph9ONaL0ZrGvzjlfrArUWqxLrcB9GBIhVCoHlecZuOJeHQnFnginQawuvc1OrFFmS
         CsuVW95hBOgyxFWPk307KnGgX05Ll+21pc/nptIDIDANbUilrBHC3cfV+vM+OR236Nco
         F2AA==
X-Gm-Message-State: AAQBX9c3YThM/I0C1y4KvyqPnyeCTOUPAbM7QORIq56d5Iq4uqz2fzFl
        SXRpTGlhOJeMrgCitsHfWkipjQ==
X-Google-Smtp-Source: AKy350aM3WWcqkFjqN135s86mFmhTtptEqWBihfR8QDDR6DyjErhl/wU5dMg84byOFMXQr5ECmP6Yg==
X-Received: by 2002:a17:906:7b8c:b0:926:c9e4:f843 with SMTP id s12-20020a1709067b8c00b00926c9e4f843mr6268174ejo.59.1680785274910;
        Thu, 06 Apr 2023 05:47:54 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id lr7-20020a170906fb8700b009476dafa705sm764801ejb.193.2023.04.06.05.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 05:47:54 -0700 (PDT)
Message-ID: <2e08fb96-f965-f624-db7c-2c13c0c1e966@linaro.org>
Date:   Thu, 6 Apr 2023 14:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHv1 1/3] dt-bindings: usb: Add RK3588 OHCI
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230404145350.45388-1-sebastian.reichel@collabora.com>
 <20230404145350.45388-2-sebastian.reichel@collabora.com>
 <15dcd1fa-9adb-6bc2-9f01-454273368002@linaro.org>
 <20230406105129.nuv3jcmwl7ugql3q@mercury.elektranox.org>
 <0f671b8a-fbc4-a7c0-1469-a9e3f180e776@linaro.org>
 <20230406123321.vs64ff2i7xplovoo@mercury.elektranox.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406123321.vs64ff2i7xplovoo@mercury.elektranox.org>
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

On 06/04/2023 14:33, Sebastian Reichel wrote:
> Hi,
> 
> On Thu, Apr 06, 2023 at 01:02:44PM +0200, Krzysztof Kozlowski wrote:
>> On 06/04/2023 12:51, Sebastian Reichel wrote:
>>>>>    clocks:
>>>>> -    minItems: 1
>>>>> -    maxItems: 3
>>>>
>>>> The constraints here should stay.
>>>
>>> dtbs_check complained about the 4 RK3588 clock entries if this
>>> stays. That's why I moved them to the condition down below into
>>> the else branch.
>>
>> Which is not what we want. We want the constraints here (the widest).
> 
> So it should look like this?
> 
> clocks:
>     minItems: 1
>     maxItems: 4
> 

Yes.

Best regards,
Krzysztof

