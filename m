Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2C5F1D60
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 17:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJAPy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJAPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:54:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD7862AA7
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 08:54:25 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u26so2417275lfk.8
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 08:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=4V7O2JXnPY3cTTKQY4SPNRYDm09XFn4Xqtp+6GKFAG0=;
        b=morrR8f1uK1S8XBfgHcSSCLbWJ3k5BgMCdINFxF+qaqrsGZ+Skn95uyT77SitwYcu0
         60MHQvANTR5kK8H8Mwzygz9F1aWAQObi1WYs2TSXa+EvtWg8aHL1rtDdqlnxvQFeqOCb
         gNHUhmn264GOrOvoPqpJHy4irPiisQVyJTvWv5nZxrvc0EDdGWJR2cihvm2aL3XiezZS
         UzgzudAVv3LnrV/wrZi2pDxHmwTKGNGoQcEJCkhBjXC5drA3zlL+z8aelq5FafyyQDJK
         ueo252GC2+cFi5STSQSz5uXi6SLYC0ivc+K1bBOK6dBiBB7zbl1MalBPJASVdwDoiXTB
         h0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=4V7O2JXnPY3cTTKQY4SPNRYDm09XFn4Xqtp+6GKFAG0=;
        b=kAkp/JptLKtiP5x6VIVvcS+qF8lmEVlGCFfnymDBr95C087itaxvT6vSNFvdxXJZqO
         gQVt7nM+CQiLq7qI+0LEcUoXAYdwK/1P18uAb34xl2DNO1PaR9xfKkMONtct5XBYe3fF
         jmZ4ey867MPQj6oTtD/s4ilLUvTHHEfe8ih3jnAXlfJxWw5FU75UAB/JUtPF5upmcR3m
         GjaY4F+r0F4GOI3baA6sIcde8uiaJa3N9QkEJfsGwTwdZ3CuGkn78nxJdhyENx7fjx/T
         eXFZUr5GyH3Qtu4y/bA+UyKte0imrc7l0X7Hb1wrlcMluVjVilmh865Sm/15iNzVokF0
         /X5w==
X-Gm-Message-State: ACrzQf1HhcUK8TLfq0LTLm648MU9GrVNyGGkScnRl/+YbyoSvLcHu+dJ
        t3J1b2dvpmVh+0OWJ2iQ43tLYg==
X-Google-Smtp-Source: AMsMyM6tVqsDW4FYA7Rsjt0m3ZgqmVw/E9rcLI+obNI0lmang9stLP2OBSh6rWg9dTFkX30lH0yH1Q==
X-Received: by 2002:ac2:4e15:0:b0:4a1:b113:d431 with SMTP id e21-20020ac24e15000000b004a1b113d431mr4730723lfr.385.1664639663370;
        Sat, 01 Oct 2022 08:54:23 -0700 (PDT)
Received: from fedora.. ([78.10.207.29])
        by smtp.gmail.com with ESMTPSA id g14-20020a056512118e00b0049e9122bd1bsm792895lfr.164.2022.10.01.08.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:54:23 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Grzelak?= <mig@semihalf.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, mig@semihalf.com, mw@semihalf.com,
        netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
        upstream@semihalf.com
Subject: Re: [PATCH v2] dt-bindings: net: marvell,pp2: convert to json-schema
Date:   Sat,  1 Oct 2022 17:53:53 +0200
Message-Id: <20221001155353.10211-1-mig@semihalf.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <db7055da-b01f-3ca6-20f8-e9bc7ed892bc@linaro.org>
References: <db7055da-b01f-3ca6-20f8-e9bc7ed892bc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for your comments and time spent on reviewing my patch.
All of those improvements will be included in next version. 
Also, I would like to know your opinion about one. 

>> +
>> +  marvell,system-controller:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description: a phandle to the system controller.
>> +
>> +patternProperties:
>> +  '^eth[0-9a-f]*(@.*)?$':
> 
> The name should be "(ethernet-)?port", unless anything depends on
> particular naming?

What do you think about pattern "^(ethernet-)?eth[0-9a-f]+(@.*)?$"?
It resembles pattern found in net/ethernet-phy.yaml like
properties:$nodename:pattern:"^ethernet-phy(@[a-f0-9]+)?$", while 
still passing `dt_binding_check' and `dtbs_check'. It should also 
comply with your comment.

Best regards,
Michał
