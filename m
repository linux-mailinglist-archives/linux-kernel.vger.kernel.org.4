Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C78660B556
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiJXSVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiJXSU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:20:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858F52920F8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:02:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cr19so6012755qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VpFxVbNlUVx4khx8wR7XZ3WqQqzobxqL9P5HDrXvqlc=;
        b=VtmMvdAmjbQlupNcboZB0rYkr/vfgXXmpLysoK7V5k6cOP3hZENoSlDJcCHANlahB8
         UIoG0JHOiXdlN4kBaXY4TH5I1k8MZUxKzDcmFd41zxisSMb/oaM9JkFjAdMOdgztd2kE
         CmWIxolWQwmB2kmV4aPHXnTfE/VHN7fi/wTu2dKbUvO1pm+UXg4gibOU6vfj9DlfZKPq
         M8+PUy2IKVoBb0mCYs15vttJG0xGVXb+ywbmjjhDbGKS0zkZgUR8CTKQLWCdiZFnwZXB
         3OAq55fsKwpxhjOI63LrU9jcuHfR3oKCbAVXHwUs8ioSPq52PM284h5BtT6FWl5ghBp8
         bxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VpFxVbNlUVx4khx8wR7XZ3WqQqzobxqL9P5HDrXvqlc=;
        b=LKXvnbi+YZ3pjQjZDcJDW+PdfKODCZn2d5AICkuaXbLZ08bDnwQzyI+b2fAeVhgvj8
         1zkNyOINT1dB8AlJqYC939lYGyVdV5BmD/7J5FBtB68SSWXTl/ei3rr61xXAvEIsorqh
         Is9A8+2R+SFKPg33z//W9MU4yaixkl26197en2UMpJVUlIvZse00qzXqhI9p6i/ZLT0+
         sCOmdNwLXmehfVRhxXUlWuHuadHfEKTrSw5B2VukPZ3NjI+pBp0Qb9pWi/X6uB009UH3
         pI6jb0QlNnhE6RqNI9/lr0jKjnx6Fc6bP2XyB4g9ATMpR+hEpcXI0cwftGbEobrwateq
         JDRw==
X-Gm-Message-State: ACrzQf1sNV5C+dKtaXmHavtSI7YEyS14VU5ESg1rqCKdES0hh6Wvljof
        wleKifegya5oQsWOZDz0jAAxA70vSr78EA==
X-Google-Smtp-Source: AMsMyM4N7VSQhNGDlB28vU1BJ0fiLgP+WhtT+9B869oCikzicsq0fwHB+QI2//H2iNap7alEzCxiog==
X-Received: by 2002:ac8:5c49:0:b0:39c:d73f:a7cd with SMTP id j9-20020ac85c49000000b0039cd73fa7cdmr28269946qtj.317.1666630081466;
        Mon, 24 Oct 2022 09:48:01 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id l12-20020ac8458c000000b00397e97baa96sm266984qtn.0.2022.10.24.09.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 09:48:00 -0700 (PDT)
Message-ID: <db92a42c-e362-e40d-67a1-b003f8bcab55@linaro.org>
Date:   Mon, 24 Oct 2022 12:47:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v9 3/4] ARM: imx_v6_v7_defconfig: Enable the cyttsp5
 touchscreen
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Alistair Francis <alistair@alistair23.me>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linus.walleij@linaro.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        alistair23@gmail.com, dmitry.torokhov@gmail.com,
        rydberg@bitmath.org, shawnguo@kernel.org
References: <20221024111017.43859-1-alistair@alistair23.me>
 <20221024111017.43859-4-alistair@alistair23.me>
 <08cb81ce-7ebd-d79f-3f5c-4df596b5cb95@linaro.org>
 <20221024170232.6b0175df@aktux>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024170232.6b0175df@aktux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 11:02, Andreas Kemnade wrote:
> Hi,
> 
> I want to get that thing in, so I am tring to help as much as possible.
> 
> On Mon, 24 Oct 2022 08:21:45 -0400
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 24/10/2022 07:10, Alistair Francis wrote:
>>> Signed-off-by: Alistair Francis <alistair@alistair23.me>  
>>
>> you miss here commit msg explaining why you want to enable this.
>>
> proposal:
> The imx6/7 based devices Remarkable 2, Kobo Clara HD, Kobo Libra H2O,
> Tolino Shine 3, Tolino Vision 5 all cantain a Cypress TT2100
> touchscreen so enable the corresponding driver.

Sounds great!

Best regards,
Krzysztof

