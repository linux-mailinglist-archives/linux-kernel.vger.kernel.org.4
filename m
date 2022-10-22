Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39DE608E6F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiJVQVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 12:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJVQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 12:21:12 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5DE664FF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:21:11 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1322d768ba7so7221733fac.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1Al63W076jDkj8WpNZMYUiAhbLhcbuotAcSf3D7lGU=;
        b=rgbYmT2lH5OXpRmQ600zOpmN9g+NFdGkFM4zfjDPUetAWOyp3yZSBClOCbdCfQZzOw
         lNFsUBEoK6dU75k6JDg46PJpt/QRSk/iehjy06p4V4TejWFH9xxETNIZ/lPz6tfAwTXZ
         06T1H+FltsnKpb/tf5h+hMsTEhfeLDn0PrnqWgK5uw0wQKnYg3fCnAQfuInozJ9+/E8Z
         4lYmcWGm9arwyV3uzCOURc+9/g694PT6OMz9YhZRglFx//GaN+R2Rbjj+w4QMGAv4JXj
         Of6eGbeizkkFFIEMQCHR9nI11Q1ExQbChrXlgzmz4MO69aOfuW8DD1Yg7p88Bj3Sb5TN
         abOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1Al63W076jDkj8WpNZMYUiAhbLhcbuotAcSf3D7lGU=;
        b=qjo9d1gloFu2HYxIom3QCrCfKIHkUGQNIJOjbbi9O06bIh+W7qCUdkLg5f9Am755eD
         TAx+bndxXqlvaGpyggX408N/SyTZOlsciulVHa3Q14GcVBbjLISBdp1QqM7y5j7RE2e/
         a3+KQ/n/mae+TuWcnBXpVKZ8504AN0rgHKTvKETLg7k/2jCS7WghbFw+XzKBJ2C2Bhjf
         okzdvcLbT+h0tgM6COJSVxurq8k0OA2cMQ7NauuvrOSGdi1uakeVRe5+usmA745SvO20
         HgECkH9LazcKgSGs2rbfC4WewRE9rCpnhQHcby0wMzvnkbRHcZc2z9rTgCTyPskatSQS
         y0jQ==
X-Gm-Message-State: ACrzQf2EiHK/SqaaTlfAu2RSwRf2rz47g+5Qby0EqdhmYZEKeKut8d0t
        iCNV7ATuYsiBODDETGP4l8F0+XjkEYFIHQ==
X-Google-Smtp-Source: AMsMyM4lgxN81Bdg9UtMMFBkEJear9Fq+lfJJh3mNnqRnROYYU9eTzko7OsU+RY+0fHJK/So8NyAHg==
X-Received: by 2002:a05:6870:14c4:b0:132:c614:b0e3 with SMTP id l4-20020a05687014c400b00132c614b0e3mr33106688oab.204.1666455671097;
        Sat, 22 Oct 2022 09:21:11 -0700 (PDT)
Received: from [10.203.8.70] ([205.153.95.177])
        by smtp.gmail.com with ESMTPSA id v5-20020a056870310500b00136c20b1c59sm11595627oaa.43.2022.10.22.09.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 09:21:10 -0700 (PDT)
Message-ID: <5ef70149-5079-173f-ab6a-a9f0cc01f281@linaro.org>
Date:   Sat, 22 Oct 2022 12:21:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
References: <20221022082628.23876-1-vadym.kochan@plvision.eu>
 <20221022082628.23876-2-vadym.kochan@plvision.eu>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221022082628.23876-2-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/2022 04:26, Vadym Kochan wrote:
> Switch the DT binding to a YAML schema to enable the DT validation.
> 
> Dropped deprecated compatibles and properties described in txt file.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>   1) Fixed warning by yamllint with incorrect indentation for compatible list

I guess all my comments from v1 apply.

Did you test the bindings?

Best regards,
Krzysztof

