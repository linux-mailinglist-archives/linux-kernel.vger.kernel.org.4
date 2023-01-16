Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF6F66BA22
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjAPJUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjAPJSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:18:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AB918B31
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:17:46 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id kt14so7659157ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ww7Hxrw6n0J7k//JManeo1d6RMBOH6s8LbvXGDtzj+w=;
        b=v5qDCDI2V1SvQnjE03DuLKYjo6tGrNOI1fmyfrbtX1bfPSDjMuEb6AkRNNQjQqF4w9
         xvQA/XAhZyZU2S+cwiw5px7dPh6bGcR+xr6ngwFz5eeZXFQq5i9BbV7hirtq4T8QTrOJ
         4hPL6DWur+wbtCguPVrmyHlClK3FNqe73Xvc3EDFkvIuCX9VLZhXiC8qbzyFAwlvPi12
         AZXKsEJlsfb46On51cFyrW8NFIzom4xbLrii2c8cGPecK2Run3frV1V/pyOdDqs/qdwk
         WZqGxdYN+iUbvIBhL9SH0SnYV4aqeLBt8ThmSoPPW9TCZ4CRAwTB1bBAW2Ur3HV1UbxG
         tA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ww7Hxrw6n0J7k//JManeo1d6RMBOH6s8LbvXGDtzj+w=;
        b=3D/EK5VPuKN9O+8s/4LCc23+qsqCq2T+aXb8ol31cnMIcBldD5FCi9Yz7IWcuF8MZu
         luYh8B95NgB1TckIohAbP+qd9KDj1On2qkJ/xZXkFoFxkReDkkRjBQ8kkjlj4+pk8GqU
         PQOsH+1TVX9lfGTZSAKc8YetbhagmPtyWauVOP9wjHrxNTCZCLQdFhaJnM50sF95xvEo
         jmV9DA3m99hmnU9cm2zXAgrKBfRdG+Xukin6ixJGAlYJyuVG1K9OPh5qK0BAUDkOfW6R
         zBItE+W+f7UHXKWOIYzgeqCQ2gBxpnDtPV04ydjJ5T9ya0H3Pj5W7oqe8agXUspd8PJy
         mirA==
X-Gm-Message-State: AFqh2kqZakQUx1+F6G5r7hhMEkFMZllZaxGbdUq1+TO66XooG/K18Tdu
        0WCxb/AFRqiFW/6uUJmZ43lVyg==
X-Google-Smtp-Source: AMrXdXsKA+xBsKYbyxr+liaowz9b+i0Yta2/1SABcEZ2fAZj9G6NDYjCiRPwvXY9TodJyFWT6Ret/w==
X-Received: by 2002:a17:906:4acc:b0:870:b53e:86b9 with SMTP id u12-20020a1709064acc00b00870b53e86b9mr2489239ejt.39.1673860665533;
        Mon, 16 Jan 2023 01:17:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id g13-20020a170906538d00b0085a958808c6sm6941007ejo.7.2023.01.16.01.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 01:17:45 -0800 (PST)
Message-ID: <ea718cd4-db3c-12a8-aac6-688d7189fbf9@linaro.org>
Date:   Mon, 16 Jan 2023 10:17:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND v3 02/13] arm64: dts: mediatek: mt8195: add MDP3 nodes
Content-Language: en-US
To:     =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20230116032147.23607-1-moudy.ho@mediatek.com>
 <20230116032147.23607-3-moudy.ho@mediatek.com>
 <63f3d41a-1aa3-396a-b515-bc805f4a19b4@linaro.org>
 <47f79e0ffda3fe72e574596aad8c4562a3b6e14a.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <47f79e0ffda3fe72e574596aad8c4562a3b6e14a.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 10:14, Moudy Ho (何宗原) wrote:
>>> +		mdp3-fg0@14002000 {
>>
>> Node names should be generic.
>>
> https://urldefense.com/v3/__https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html*generic-names-recommendation__;Iw!!CTRNKA9wMg0ARbw!gmuIIk9pHTEGcVTtOXNeP3a8XUucoiTd5vTmxNK8lCHtytRDc3R8Eh44WOWNEUkJlv_pPCtg_DvPCHsCHNscg6_0cfJe$ 
>>  
>>
>> "0" suffix is definitely nothing generic. Drop such suffixes
>> everywhere.
>> Drop also "mdp3" prefix everywhere.
>>
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> May I uniformly name all MediaTek's media data path ver.3(MDP3) nodes
> as "mdp3@xxx"?

No, because it does not describe generic class of a device. Some nodes
are probably quite specific, thus we do not have generic names for them,
but then any prefixes are also not neeeded. If node is image-scaler, it
is just image-scaler, not "mdp3-image-scaler". If node is video-codec it
is not mdp3-video-codec. etc.

Best regards,
Krzysztof

