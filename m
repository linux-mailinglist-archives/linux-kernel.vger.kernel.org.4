Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE80723774
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFFGTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235019AbjFFGTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:19:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B293F10D9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:18:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9786c67ec32so51410166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686032335; x=1688624335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcC1qoneJVOOtN78kGiXwcDuBc2gcGUkS51tsnB17tQ=;
        b=U7Bp26lblxK6rqz4f36Z4rtc6s3UtK/o69ihCBp9Zc5AlbJCK6B3LWUnaJMxA+UjxR
         d/F1ZT8piNAH0EowaLW+cCTPSDV9WcRvjYuWyQuBnxVJMI10bBDFND0jX67IPpHDOo3D
         tFevT8ChE05cOcTigYLVWPb7Qs0cerEwMYkTbQv9443J9SKrjDYkENxJaqRIP5ZaQbDU
         IiNLKf5p7W7S71qeEiRRHfbPXj4Y/vONki9nZbhwY0dDSbNIGBOCXBao4rH7fEICI46K
         9PY4d9nJzpa3MiWXu67naiVbtn8EcyphiEm17+8RgAEAzQr22hmqvvDFz89nfhJbpBrz
         Fcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686032335; x=1688624335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcC1qoneJVOOtN78kGiXwcDuBc2gcGUkS51tsnB17tQ=;
        b=BtWZUixvjpuxqLY1ch52n8ar6xSbnLFGBHFLvp7QILyAftPWHoor+P4ru5O02QoHmP
         zMnPKXD/+KjhZE+2Sk8lxDJGDrKR0b2IoAyXrK/9ZAjsWRnWY9/tewVO4o/QeFD/fyrz
         qEB7rZE9LN8iOTZqrl1Nl7z5qaMY9QZWv6G17sQG6hDRDIayVZl3tQ0KVc7jerFHuoPq
         6ciyHwaEgo0dDKkdsIPzGXGrlaS6YLAeN7661V140m1rK3dOaYcK0vXUrLeDqq0TnvC6
         V24Hl5SZUAZXzEvAfTMG9pjh+9FvpBmJcFsWOqmb1wGimsdFZg5lnd/flHvlSWKiNArf
         WZPg==
X-Gm-Message-State: AC+VfDxOjgdzh97ctM1ZFEjMlhn00K8/jIWL3nb+uOTkftHsRns4Q4Vc
        iGCILqVIh9Cubmb4uWwKyLV3sQ==
X-Google-Smtp-Source: ACHHUZ45G9j0pzeQUOct1hHceG1+pc3xYwnKX0l7Q33gXId8y2o0MSSsfIAY11FDamNiTNnC/yckpg==
X-Received: by 2002:a17:907:6e89:b0:973:da59:7c91 with SMTP id sh9-20020a1709076e8900b00973da597c91mr1356581ejc.51.1686032334949;
        Mon, 05 Jun 2023 23:18:54 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id f14-20020a170906494e00b0097461fecc91sm5088128ejt.81.2023.06.05.23.18.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:18:54 -0700 (PDT)
Message-ID: <dd5f274f-46f5-c20b-bc61-ba7d1c4e4869@linaro.org>
Date:   Tue, 6 Jun 2023 08:18:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: qcom: Split sdm845-db845c to add headless
 support
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230605094710.2037879-1-amit.pundir@linaro.org>
 <cd71ee53-391a-90fd-27ca-c174f2b24a94@linaro.org>
 <CAMi1Hd0MhOyn1HHq5YYFxJwWrkMZbS9ZqksNDBLM9Ayx67rEOg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMi1Hd0MhOyn1HHq5YYFxJwWrkMZbS9ZqksNDBLM9Ayx67rEOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2023 08:11, Amit Pundir wrote:
> On Mon, 5 Jun 2023 at 16:07, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 05/06/2023 11:47, Amit Pundir wrote:
>>> This is a follow-up of the upstream discussion,
>>> https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u,
>>> around adding a reserved memory region in sdm845-db845c
>>> for the framebuffer memory (the splash region set up by
>>> the bootloader) but the general opinion was to avoid
>>> adding that reserved memory for the headless DB845c
>>> usecase.
>>>
>>> So this patch splits the sdm845-db845c into a common dtsi,
>>> a new sdm845-db845-headless DT, which disables the mdss
>>> display subsystem, and a new sdm845-db845c DT with an
>>> additional reserved-memory region for the framebuffer.
>>>
>>> The default sdm845-db845c.dtb remains pretty much the same
>>> (with an exception of additional reserved-memory region),
>>> while others can use sdm845-db845c-headless.dtb for their
>>> headless systems.
>>
>> You should describe the hardware in commit msg. What is "headless"? If
>> no HDMI plugged in, then it is a NAK because plug or unplugged HDMI
>> cable is not a property of a DTS.
> 
> Hi, my only intended goal [1] is to add a reserved-memory region
> (specific to the framebuffer memory reserved by the bootloader for the
> boot splash) in sdm45-db845c. But I have been told that reserving
> these 30+ MBs for every DB845c is a waste in case we are not using
> display at all (a headless system?). So I prepared this patch for RFC.
> The definition of headless is ambiguous to me as well. It could be no
> HDMI plugged in or no display drivers enabled at all. I believe it all
> comes down to specific use cases.

HDMI is plug-n-play, thus you do not need new DTSI to describe that
something is plugged or not. How would it even work? You plug HDMI, so
you need to boot your system with different DTB!

Whether driver are enabled or not, does not change the hardware and does
not matter. If I disable MMC driver, shall I create a "no-mmc" DTS variant?

NAK

> 
> As far as my use-case (vanilla AOSP) is concerned, display is a
> critical component and device doesn't boot to completion unless it is
> hooked to any kind of display. 

That's problem in AOSP to fix, not in DTS. Systems with no display
attached are perfectly normal and valid systems. They do not need any
tweaks, changes, fixes.

> May I suggest we go back to my original
> change [1] of adding a reserved-memory region for now and let the
> users of a headless system, define or come up with their respective
> use-case?
> 



Best regards,
Krzysztof

