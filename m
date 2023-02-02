Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23B16878FA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBBJfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjBBJe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:34:56 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E446CC84
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:34:28 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h12so1081132wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 01:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jcIVaYwLzqhUyW7aVV/2uyJbb9dz1K7nROEBojvkbc=;
        b=v8URH2KYh2aUFd5hhaZ9YAERkce9uXimpfeG7uMjsXky6GHsJ8ZcYPO+6AdUKJHazq
         Y1NlmlkmrV15I7L6z9Y6wKhONXvStGJRcQlLD5OpNETvgmghUFHqPlipoK2xI180KwHp
         66eCQpnygg2QDc+ftOwTFXHBy0v4C2XYggvC6AhhEYEggtq1B0UTIgqtHJGjyikRTkXs
         1iLYJgyYkg6S3NL7pO0+ISkK3/YoTAfQVoutNhZlRGgfWbKXVpnMfp93UD5ySprgwVXj
         DKIzLzg9Y3G92v5RjX+2JiNYsTwKGzfmbU2iJRCD48pN2EAZjiJshovBuKOi8xHqqP0G
         R/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jcIVaYwLzqhUyW7aVV/2uyJbb9dz1K7nROEBojvkbc=;
        b=qkmcLvV9TaWzrBrlsmCf4bgw0eN/lvzmWacx3PnTnxNGakSlIf/39ASVyziL72McYa
         eaeKq4+OQHmEUadoDzWFcy6WKuoObUzpy9hUGFEJAhanQ8bSa+rANHrIjdNZWOnrXHAD
         itmNGpYwFc4hHrrTxrnzFOSCm7O7tv0afViWE1CRDAGQ7Vk919CVa7YrdTsoB24aT80w
         NPC5BCjWYuCQl0/Kx+NfDSJvqdY+OggezfozXiDPWl1DLDnxzNWMBKJPC6VxLgPgFC1c
         xFNerlifjW2pmsqe7EGMXznZB/wxdgF/HJX/GyZb6xiVAXjPtsF5yHIMp9t8hArSGX3B
         VAYg==
X-Gm-Message-State: AO0yUKXX4HUnZDtoGo6wR4/Y7rsTvlfSA79lvkKdL7HmH+NpadsNsVb1
        ZUN4GGyCvfVjNKNpojMtuvBJhw==
X-Google-Smtp-Source: AK7set/p/ZjNzmPMl3Z/we3foySlIRKgwQnT6uMw2CF+xHMJTxIzpM00/pI2PLs7ZsvWrX4+GLJY5w==
X-Received: by 2002:a5d:6d05:0:b0:2bf:ee65:b0b0 with SMTP id e5-20020a5d6d05000000b002bfee65b0b0mr6224355wrq.41.1675330462974;
        Thu, 02 Feb 2023 01:34:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19467485wrx.115.2023.02.02.01.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 01:34:22 -0800 (PST)
Message-ID: <71c9963c-98e3-d90b-116a-68a295feb24a@linaro.org>
Date:   Thu, 2 Feb 2023 10:34:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 0/2] leds: lp55xx: configure internal charge pump
Content-Language: en-US
To:     Maarten Zanders <maarten.zanders@mind.be>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202092325.21241-1-maarten.zanders@mind.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202092325.21241-1-maarten.zanders@mind.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 10:23, Maarten Zanders wrote:
> A new option in the devicetree "ti,charge-pump-mode" allows the user to
> configure the charge pump in a certain mode. The previous implementation
> was "auto" mode, which remains the default.
> 
> v1 of the patch implemented a bool to disable the charge pump and had some
> issues in the yaml binding.
> 
> v2 implemented all options of the charge pump as a string which was too
> complex to parse & check.
> 
> v3 (this version) replaces the string by constants.

Please resend without ignoring the feedback.

Best regards,
Krzysztof

