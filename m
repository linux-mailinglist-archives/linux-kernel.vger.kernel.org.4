Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26AD676D75
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjAVON2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:13:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAVON1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:13:27 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434DFF0A
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:13:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so8604284wrb.11
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 06:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SugIva74NLBWESanDTCiWyPSvA7ip4zXV7gKw6lUbrQ=;
        b=RtA0V7/CAARJiXkH3BrJd9ABPzAIusIdaM+jUH3z5+LkCZqCcs/MCd5IEwaS9ZAz59
         OlWEx1djJpKqmzSarWx3hxVnc5t2pFtAbqLQ6Z6lmeXy11P+vxc51XZlP3O5zSvcGph6
         cWKfrXUuomgoyMJraFQjXosGZYY+V5K7XCn6jILQPrlofpJ+5DxzI9zi4020J62JLmYl
         ik9431vEilugYV2udtLQwYhJ4QoVgFsdCPXgFQENgl//vV/qqt/h2ZIKOFhUNfNT6OIr
         XFShVJc40LjwCnQc7gz5CWnC+r4+geNboDL8Aq/U/6Xee7w5VNCcP93Ihsc5odM6keaF
         hzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SugIva74NLBWESanDTCiWyPSvA7ip4zXV7gKw6lUbrQ=;
        b=7hbZ6U6u9rp7qzWmF5LsVy+rNcbYQRWzOWJ1Sox+ycaa84wswllh70FbXzYAS7abJI
         gdROhi18U+r+4EEXImYC+rNYH083ptlgKWjLD5A0/5Cd9/yfkNNRlrPDOMIJEbtW/7o0
         2SeuY8WcA/7I3no42Q2jugi1Naym7c0S7nK7YnjYv7aR86cQga6hhibFsAuvXhxZaqDq
         x9avxW8vA0nSevfew6q/xzEUNY3i/2ISHsDbcSAHLbMt/2SYYIx+3Ol879hrISdGs9Of
         BLWB+ftHRZZdAmZ96L0AlXzHrllIsHVxaSbCxZZwNcpj6O2568V9jIRkC1de1VHG3Xp6
         VWOA==
X-Gm-Message-State: AFqh2kos1gOVyow2HXlP+FFczBy+2o8ekDiHTaXbHvSBf4QZMb08ypQf
        RBvcMtCy7k8aTYe6U/ejY92Vrg==
X-Google-Smtp-Source: AMrXdXsqPk8Wl8LBsZZhJL3bZObq5yLmvOCLaCUwEICuMLelSRGwqMatxMPiBhX9mXOa9NcdhRNGjg==
X-Received: by 2002:a5d:688d:0:b0:2bf:9551:e48f with SMTP id h13-20020a5d688d000000b002bf9551e48fmr5387696wru.47.1674396804511;
        Sun, 22 Jan 2023 06:13:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d6e83000000b00289bdda07b7sm2355229wrz.92.2023.01.22.06.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 06:13:24 -0800 (PST)
Message-ID: <1666baf9-0996-ec23-dfec-8e52fc92ddee@linaro.org>
Date:   Sun, 22 Jan 2023 15:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: qcom-cpufreq-nvmem: make cpr
 bindings optional
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230121000146.7809-1-ansuelsmth@gmail.com>
 <43ff6113-03ee-a40a-b454-53cadec8728a@linaro.org>
 <63cd42af.df0a0220.aae7d.51f1@mx.google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <63cd42af.df0a0220.aae7d.51f1@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 15:05, Christian Marangi wrote:
> On Sun, Jan 22, 2023 at 02:57:07PM +0100, Krzysztof Kozlowski wrote:
>> On 21/01/2023 01:01, Christian Marangi wrote:
>>> The qcom-cpufreq-nvmem driver also supports legacy devices pre-cpr that
>>> doesn't have power-domains. When the schema was introduced, it was
>>> wrongly set to always require these binding but this is not the case for
>>> legacy device that base everything on nvmem cells and multiple microvolt
>>
>> What is a "legacy device"? Why do you adjust bindings to legacy device?
>> Can't you just fix the DTS on these devices?
>>
> 
> With legacy I mean device where cpr (core power reduction) wasn't a
> thing and qcom used a different way to select the microvolt for the opp.
> 
> There is nothing in the related DTS to fix since they are not broken.
> The driver doesn't enforce cpr presence and supports both new and old
> implementation...
> 
> Setting the cpr as a required binding was wrong from the start. It was
> probably done when qcs404 was introduced and they had this bright idea
> of creating the schema and ignoring the other kind of configuration the
> driver supports.
> 
> Since now we want to send opp for ipq8064 that use the old
> implementation this fixup is required.
> 
> Probably I should drop the legacy term and just say that the driver
> supports 2 different configuration and the following schema permits only
> one?

Yes, it would be clearer.

Best regards,
Krzysztof

