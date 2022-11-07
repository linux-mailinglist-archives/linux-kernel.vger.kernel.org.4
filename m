Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887F161FB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbiKGRcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiKGRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:32:01 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22291F9FC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 09:31:58 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id k4so7587505qkj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=woU+1lgtcem9NqJltOZqq5m29+9ynwXinzYsm4A2SlA=;
        b=HoOGhiR3JhHQUMxS6SU1j+4qjzXK0TURBze3ZKYI/ewMFslGnsS3DS2YVVXrgYsp4z
         dcobS6lyQb+iSpz6VPdhjl/hTTGBS47YL8ZVSvWpLyeRhYVAdPfD13eNIxIEjNTDq6K9
         bIuANj9cgcWagRKRQoBWUMli5iajJJPX3+qf+7d/PG7gwEESgXnBf6K92IfuNdCWCZ/p
         28gyXJJ/g/kDE4B28GlBN29qVW8wVKDfHdO3CS+t1z0pZ35izkyY+B9dAR4DpBrDKjDb
         +ytQBAR1C64cQXMuCwXavnZnI2MWoWiS2Sj8J2RuJMDHYty/3SfETNhW4K0r361zcWYx
         wEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woU+1lgtcem9NqJltOZqq5m29+9ynwXinzYsm4A2SlA=;
        b=QyflVh++a6ytPGB9+vHR99DuiPqa7rzAuHDg/y1t+AGizV+bdvzW5J/IdE5wrzcjZ7
         ROuYXokibu92G2iJ/9u9sBVw4E0VFG/Js7XFsep8rdN6vItNR/Lz9C3HYFegxpcA9Oqu
         gr1iSsM0YimkX0gWjeMEEvsd6nDrH5Qe+BIu0MEw7cZglMaL8JxAHkaw/RZNO2dDmJln
         tGBWNVTV/kKxiCnvJLSJaqfJ9dSB9bs2Vvc9qMmjaVeOURyTwZWIhRNf00o6rGT/Nlcr
         vuK/Rwb75PyS47ZZ5pDgdBq/dmWfCmlilThvzZWHxzWBI23ORmnXgZZv+/+vFjoDX0j1
         batA==
X-Gm-Message-State: ACrzQf15SCzrf/IYVCTOkeu6ZevUUxZ69LGHfwBMQwtpk02Z4vS4XkDa
        fvqlysDEQ/A9ssEwIyrO1KY=
X-Google-Smtp-Source: AMsMyM7iHRUO4z9aKayePkw6NbABA6wO3MKMW2O8CsU/pyeKD+TQHRrYjYnrKcLC79+W5JUlUgsL1w==
X-Received: by 2002:a37:e30d:0:b0:6fa:6241:c858 with SMTP id y13-20020a37e30d000000b006fa6241c858mr20031987qki.553.1667842317854;
        Mon, 07 Nov 2022 09:31:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id cq10-20020a05622a424a00b00397e97baa96sm6507780qtb.0.2022.11.07.09.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:31:57 -0800 (PST)
Message-ID: <8ee17547-30ef-bc85-b163-f0d9efe70fcc@gmail.com>
Date:   Mon, 7 Nov 2022 09:31:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 06/23] arm64: dts: Update cache properties for broadcom
Content-Language: en-US
To:     Pierre Gondois <pierre.gondois@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
References: <20221107155825.1644604-1-pierre.gondois@arm.com>
 <20221107155825.1644604-7-pierre.gondois@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221107155825.1644604-7-pierre.gondois@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(way too many recipients, gmail's SMTP server would not allow me to 
respond unless I moved most people to BCC now done).

On 11/7/22 07:56, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).
> 
> Update the Device Trees accordingly.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Acked-by: William Zhang <william.zhang@broadcom.com>

This looks fine, but incomplete, you seem to have missed:

- adding 'cache-unified' to all of the cache nodes modified in this 
patch set that did not have one already

- bcm63148.dtsi, bcm63178.dtsi, bcm6756.dtsi, bcm6846.dtsi, 
bcm6855.dtsi, bcm6878.dtsi, bcm47622.dtsi

Thanks
-- 
Florian

