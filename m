Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1CD66B89E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjAPIB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:01:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjAPIBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:01:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481604695
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:00:58 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 18so39594432edw.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hRcPPcKl8l6HimLtXqG+dhNtbHx4LXcAEzJ5JUHT+Yo=;
        b=CxKc+v8/gkzhMyLtMlUalA9tpB2MR/Fsvd5InjdW1/0FtKK2M/QL6NyHJ5GBu/si0M
         hMTNuIh++CLkEeT1+Jzq8PyjRT9urF8X8/h2vHwpWCN7wPKIjcdypBIXlbXZ6tFbE4xk
         CIijC2ImdntkD3X6UE9mh2VkA9ro1gm+pAxLPHZldoc9H0uRCrjwEIaqXk8HEHP5CSL6
         3UktxtP9n94NAb+9cHwA+pC/hgs8xrIUw9AmaalGTQKqda1QzZnUXIBrWeDGR7Mzvndy
         7RzM4vnqq7J8IXJf/xYpb5rhG1dum67J52KK7PRzpG0xMlVSPGoEpLckuB1mmIAN9FRl
         cAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hRcPPcKl8l6HimLtXqG+dhNtbHx4LXcAEzJ5JUHT+Yo=;
        b=psAFwTVo3xMsw7mF/md/OhLeaoPnDxlXhP0p+3kQW6YjCyjOV6PGSl2LOC3tlUXfgc
         ODSHlrWMoasGYzOYFPIP7vqIVJWRr7z3DlfVpm4kYFDua2x8uo+Wx3bydjdsK5iAyfLE
         LMJ7YqT8jt8o72oxbSUZRporwUxEy84z6TGy/tPsqxNvGDedO0wxb3i+Ls8ljAe57Fiq
         8EaRsQJZlg0cHmktg5r2TMolMYkSXg7JjeLTlOa1zhKK65iWHYHtRUk9EHu8SmfsX6CX
         A3FEYHf8FbcbA6EPfOD9VWX403ORVL1CWmtUgTRtaGvk6ENjwjXMlJ1+jBPtOdfwtnBV
         f8cA==
X-Gm-Message-State: AFqh2kpbRlqfJpwQ6XGSO43Ywko5DHBZhUhXIz2BUg6/muErGju9UhQd
        zkMOPvGtF3Jpa37/7i5insF4pQ==
X-Google-Smtp-Source: AMrXdXsaXXXEwOyq1RNmSbugZN83uyUrb/G2s/2ksOUaet9ssaySB5n5Qe465BxS1g2zQ/WWrZ+pcQ==
X-Received: by 2002:aa7:d288:0:b0:498:1ca:80d0 with SMTP id w8-20020aa7d288000000b0049801ca80d0mr34933986edq.28.1673856056899;
        Mon, 16 Jan 2023 00:00:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s1-20020aa7cb01000000b00463b9d47e1fsm11096530edt.71.2023.01.16.00.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:00:56 -0800 (PST)
Message-ID: <ce4d2d3b-a826-ac59-e077-2fa452d115a3@linaro.org>
Date:   Mon, 16 Jan 2023 09:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 01/10] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Content-Language: en-US
To:     =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20230113054304.21841-1-moudy.ho@mediatek.com>
 <20230113054304.21841-2-moudy.ho@mediatek.com>
 <329aed63-4522-9859-4359-2a450c46dcc0@linaro.org>
 <fa386a3ab2f2ed0c963d5fdec8bbea56ba276169.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <fa386a3ab2f2ed0c963d5fdec8bbea56ba276169.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 03:42, Moudy Ho (何宗原) wrote:
> On Fri, 2023-01-13 at 12:58 +0100, Krzysztof Kozlowski wrote:
>> On 13/01/2023 06:42, Moudy Ho wrote:
>>> MT8195 vppsys0/1 should be probed from mtk-mmsys driver to
>>> populate device by platform_device_register_data then start
>>> its own clock driver.
>>
>> Unfortunately I don't understand why this justifies removal of
>> compatibles.
>>
>> How do you propagate or instantiate devices is not really connected
>> with
>>  the hardware description.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> 
> Refer to the comments of 0/8 and 1/8 in the following series:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=702518
> 
> This patch is used in conjunction with another one(Message ID = 
> 20230113054304.21841-7-moudy.ho@mediatek.com/) to fix the binding
> warnings caused by newly added in MMSYS.

The patch should stand on its own. IOW, it should explain everything
needed and it should justify its existence.

Best regards,
Krzysztof

