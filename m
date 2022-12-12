Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233A0649A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 09:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiLLInh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 03:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiLLInc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 03:43:32 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC49DFDD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:43:31 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a19so11792655ljk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 00:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KcizEOAflU8nL3kXDkXvERIMTQxYo9ZlA1993PIR43A=;
        b=bB1VcnYtUe9V6xbUT9waAkiZAjNCQiFR0pU8qanqXML/mkXovOAXogEfdpJXYO9yfZ
         gG/Wvx+YJaf6K+Lx9G/Np87XaiKd3HhgncAtY+hEgnygKHNM9JWNjNf+D4W3HRSjFkYv
         KB0ftkAMJvwQ/0PfWm1BbCugZjnlBURin8p38kFTknRtf2n5CO5Dwd8Nfu7TCEm3zAaM
         NiIJgdK96tV+OgahCgvZ4KN8TTMnwuBKUot58h0KveWfoIkJv4WTLRyNxh3QbLT49ugi
         FugY2xWM0Uw8UwLMdXjyudSvv1EWXnrY3aXu79DXwxszeHFrA9DnxAIfMKxoNbZT+GmX
         8M0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KcizEOAflU8nL3kXDkXvERIMTQxYo9ZlA1993PIR43A=;
        b=W24TEvKy5LRG9Q8AosPqEc8myj59QRHZcLOjSS4ZQ23d7CgRsBfC6wzHbqxWsfALS8
         1viT4OIoaRUZV8VDx5HeMXOoekZAa1u1tHY8WLNdcKAtMxRgC2cnJPzThNw2/3sD+LnO
         Ag9UCWeStyewU9BTKmNfTWexIhEY0xKY80ZxGruH4dFJ1Pl0BuGbfNt5dgbxWtvJBjPs
         XS2/G/qQ4bW/B1YPDdUarUGhKl1ZNf22QD8DPDCks5AXujO3peoxid0qsdgLoh/jonES
         S1ul6CHcFvFyDTT5UHCX5OPT9aClakTcf/wmLsfV+BeRB4Hs28HjbNHWMsZ9oDELRHqM
         P0FA==
X-Gm-Message-State: ANoB5pl08awRCD3JlD7EV1Vuh+/rrEmTbesn2A+P596rSeS8k/1Kdhjr
        tgar5PKtJDa2EumVZ0BzMxeNtw==
X-Google-Smtp-Source: AA0mqf6h4tMG1fuGOvuR3GJh1I8TgOiGxwOhtz5fpxW1qpsQHIN4joxUpGs4G2Q8CGupezfhU/wshw==
X-Received: by 2002:a05:651c:1a2c:b0:277:85f:db68 with SMTP id by44-20020a05651c1a2c00b00277085fdb68mr5599896ljb.51.1670834609525;
        Mon, 12 Dec 2022 00:43:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id h26-20020a2eb0fa000000b0026fbac7468bsm1098322ljl.103.2022.12.12.00.43.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 00:43:29 -0800 (PST)
Message-ID: <06e56601-9e4e-1de8-6b83-5d8c3ab86b0c@linaro.org>
Date:   Mon, 12 Dec 2022 09:43:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 4/4] arm64: dts: qcom: sm8250: move sound and codec nodes
 out of soc
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221210115704.97614-1-krzysztof.kozlowski@linaro.org>
 <20221210115704.97614-4-krzysztof.kozlowski@linaro.org>
 <f1aa7f4c-35e4-47d2-2443-8271175dc5af@linaro.org>
 <61b4b894-2c49-881f-c2eb-107e8e558232@linaro.org>
 <CAA8EJpqZiJd9=T8rdj65RZ2b5_OTai_a7MOektVB2gH8hGKdQg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAA8EJpqZiJd9=T8rdj65RZ2b5_OTai_a7MOektVB2gH8hGKdQg@mail.gmail.com>
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

On 11/12/2022 22:15, Dmitry Baryshkov wrote:
> On Sun, 11 Dec 2022 at 22:13, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 10/12/2022 13:31, Konrad Dybcio wrote:
>>>
>>>
>>> On 10.12.2022 12:57, Krzysztof Kozlowski wrote:
>>>> The sound and codec nodes are not a property of a soc, but rather board
>>>> as it describes the sound configuration.
>>> * in this case, there exist SoC-internal codecs
>>
>> wcd9380 is not SoC internal, so to which codec you refer to? Sound node
>> is for sound configuration, not codec, and sound configuration is board
>> specific.
> 
> The platform has several macro 'codec's, which are SoC-internal
> devices. On the other hand, these devices also have bus addresses.

Ah, so Konrad refers to "codec nodes" being a bit generic because we
have them also as part of SoC? These TX/VA macro are named codecs but
these are not really audio codecs - they receive already digital signal,
AFAIK. They are more like audio mixers and controllers. The codec in
traditional meaning is only the wcd9380 on the board. I'll rephrase the
commit msg to be clearer here.


Best regards,
Krzysztof

