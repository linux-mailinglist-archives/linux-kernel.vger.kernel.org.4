Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A71666D71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 10:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbjALJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 04:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjALJGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 04:06:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B603752741
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:02:07 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id qk9so43133059ejc.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 01:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6gs7ncFQfkYI2fHig91qe7q1AclJ2kNZKwU5d4VfqOo=;
        b=r9RscOYJgQkrS+a9PCGCimrjNTd1GiKH4RoURn+HjNbFpXQ/txdyB11jHMX4rnaa+/
         odSn4Ny63ApFLXnwoC90ArUG5CYuMUA6RkkbjWnMjgzJctEhdHi80DXTRGH3eCVd3Au3
         ATh+A4lIOpbjEGK3lD6wr5clGIpu6tlGkc3ucETdPp9q26owU9g/ccwauKxjy33qX9g8
         ADK2Vbey429rreGqLmkw3WsSs1ri5andl392EZUorKroCg5K2XEUE81EaRCaTr5m5pr/
         Vsm0w8V/fwfl2CACn8VtrVsgVrNAYIFvNccCDChgnXWS4bdz60aJnwMITq9FAtCLVCnK
         Pbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6gs7ncFQfkYI2fHig91qe7q1AclJ2kNZKwU5d4VfqOo=;
        b=c3/hwMgIwOYEXAztD9xFbxd6z/Tix8hSQdSm2SSHhjvBV1AHS/sDBNG/aVmlmysdNo
         wYYSVFrgjpJKIAKU1nxdnHV8Mv6J4HQXe8nkzw1Z5hk8SVy9jSjiRrVgiTjG3H1g8jiA
         E52vle3c4D1/vqaHARQB9fMP6yw4mwfaC4dqP1oSc0kg4/l02AANMBmwtxyBjRmQDew5
         Iy2dpzu6ZEi9RXhyHGOIClwhhYzD7acnmevtELI0jWRDTUtghZ2DRXZSTu1lMm6g/V3r
         b5Lmq8XBN+TpC7LY8473oioYpeu+IYgrr6OdtjNDN1uQijoKFyYqMZBVLpi0tbQGqZBQ
         pYtA==
X-Gm-Message-State: AFqh2korpgfqaWZv7AjQ2TwgNKdNz+2NWJVyhDM9HZ7iQmdHd7lGtnac
        xSSV880W5ZXS1oH0gAL7/9VKsA==
X-Google-Smtp-Source: AMrXdXuaa0nMPMSZmtKh+p0I0syiVT4ni3wfYqNeRZhL3G76s3abDWvbBQHSjUEXbuOkmp9A85YgwQ==
X-Received: by 2002:a17:907:a510:b0:866:d374:7b7e with SMTP id vr16-20020a170907a51000b00866d3747b7emr1171457ejc.15.1673514126348;
        Thu, 12 Jan 2023 01:02:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 5-20020a170906318500b00782ee6b34f2sm7144238ejy.183.2023.01.12.01.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 01:02:05 -0800 (PST)
Message-ID: <f7771bb2-59bd-a704-2dc8-82d050600d56@linaro.org>
Date:   Thu, 12 Jan 2023 10:02:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 4/6] dt-bindings: pinctrl: rt2880: add proper function
 muxing binding
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, erkin.bozoglu@xeront.com
References: <20221231160849.40544-1-arinc.unal@arinc9.com>
 <20221231160849.40544-5-arinc.unal@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221231160849.40544-5-arinc.unal@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/12/2022 17:08, Arınç ÜNAL wrote:
> Not every function can be muxed to a group. Add proper binding which
> documents which function can be muxed to a group or set of groups.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,rt2880-pinctrl.yaml        | 86 +++++++++++++++++--
>  1 file changed, 80 insertions(+), 6 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

