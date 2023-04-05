Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5C6D73CC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 07:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbjDEFd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 01:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDEFdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 01:33:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252D1717
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 22:33:53 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9338d479a21so20131766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 22:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680672831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5p7/w7fewOj51IYhvuMJQO0zEkYIY4fxshYNz4tS5Y=;
        b=vjYYQV1/IV2PXItK+wqdQAt9jWBIA7Ol0nbWL2g5mXvHPI3Ba1Y/H59Ev+4hzAvDvX
         BCgIK9tZ4QksbVxDRJDnKWLoyQhkvfSHgMpcnKd/Nu4SjmkB0jpK5Ef+H5GaDfVkyWXw
         luJPQt8EV/BHCntuXYRq/7NBwCXFjdNoDRwyp90YWnJr4dKJzhQyGzZhKjvCGDZhtFvE
         glNFZqkRQeVuHZYY0EtN/yD6VU1NFfIuB97sXrND4iLsBbC2fYhl48JZAoI6v1DOClAJ
         GhcHXnb9oVvQsHX+b90ezhVnqhcTstfSQ5tl7Po3KcgSpd8Ut5NWmHmFdRt0jUTcipml
         6UjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680672831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5p7/w7fewOj51IYhvuMJQO0zEkYIY4fxshYNz4tS5Y=;
        b=evDtVMKs3YGjQh24G7qiLB0R0ZJAv2GzHmDccESiJ7z2bBH/PJD9dkr38Ohu3tiu/n
         9ya0rkWBk8v46DkmZwekZ1hIetp3NyHko+OsB9gnTmg7O9oTPyRbM93OwuhBXML7AJqV
         xzm90xOarWjZYpPoYkOCRHvrTKQTP4OIZrWBS+a9HGZvB+MBxV9PN4t3mvdCAurY2aKS
         BOpDlQwIqkn1SpaU+ZznYzLOj6EwmXHo8r3aRyyZP6lij8DcC/Lj73e1voEbC1iQpGeU
         NQS6vfLKkComvLw4+qSd3QJekRFB5a7C8Zk/GlT5C8W5Yr08xO/AjrSnRznNapJXaFuI
         UXUQ==
X-Gm-Message-State: AAQBX9cmzgqJFxv7snRjTmkkcixrS/VS78mJz1BsPiRVPBBmMUxLSD47
        Bon2Ca2P3GGAKUg4ImVFZ896Xw==
X-Google-Smtp-Source: AKy350a1hhobYidWMtmGwHc2cqturh8pPENTzcMZlrZsJplF4cgSqwj5OmgmWwkrOq/D5lBNennaxg==
X-Received: by 2002:aa7:d350:0:b0:4fb:59bb:ce7c with SMTP id m16-20020aa7d350000000b004fb59bbce7cmr634483edr.32.1680672831526;
        Tue, 04 Apr 2023 22:33:51 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:3f:6b2:54cd:498e? ([2a02:810d:15c0:828:3f:6b2:54cd:498e])
        by smtp.gmail.com with ESMTPSA id a9-20020a509e89000000b005024e725aefsm6762542edf.33.2023.04.04.22.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 22:33:50 -0700 (PDT)
Message-ID: <fa2d5794-5750-0558-e298-bc059937a597@linaro.org>
Date:   Wed, 5 Apr 2023 07:33:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] dt-bindings: mfd: dlg,da9063: document XVP
To:     Benjamin Bara <bbara93@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
References: <20230403-da9063-disable-unused-v2-0-2f1bd2a2434a@skidata.com>
 <20230403-da9063-disable-unused-v2-3-2f1bd2a2434a@skidata.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403-da9063-disable-unused-v2-3-2f1bd2a2434a@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 07:29, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> Document that the da9063 only provides UVP *and* OVP in one, and
> therefore requires both configured. Add an example for clarification.
> 
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

