Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C347C5BA9CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIPJ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiIPJ5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:57:37 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9308AAA371
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:57:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so19526716wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=e9qNivKSI+tAk7Ilr6w1jOZ6tyxRUOCiEDIpnIGeBlU=;
        b=HlF6DXwpJx3AWLaPS6HAhAFEpFY1m9+upNd6MVNMYJeAjiAmK53vh89r4jHSuccefK
         No/y1hQQkpF+2fmKnE1vN4GG2O9aRhKrjQ/pryJ9e7dsB9dxRrGtzsR7KGLpkuchI6/w
         GOELy8hPz+nokB469JK44vntfzTkPwCS9cTj3VuYdZAaS4yN49Hm+R73UoXFd96bI/oG
         a75JVutzGgDaSp5jPlIbg2LReCOkp+F7nnglH3R5tL0o6YV6EnSv245dfimdW9nFajvE
         p2w5PJfApKI2Ea4KGDT2MUt9tnfVUpIDbKMBCv0SbOl31EsSC/knIcHgWWG4e/jCsHG8
         96gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=e9qNivKSI+tAk7Ilr6w1jOZ6tyxRUOCiEDIpnIGeBlU=;
        b=bt4acMmcFKJBQXgSAa7IJCL3TMLdj2cs1Riv7chUBcd+44BnPRLdAqFxVCFwE4H7QT
         Mr7P3aWGPspPz9Fn+6ZdQlNX+oqQyywf59YREN+S60n63k1Eyt/WqPWN2MfPyVvwQeuO
         QMshW5k0NQNA9G1KrzihbkLohp6ssx60mHFDPWle8sieiVQslSJ4XsCM3DKQWrhTM69M
         ooiEUoYkdB5BNyjfvImxahA6UKjWogtWQNnCBoiZnZnUOxbaKOIqA2QG39IZ7gTVx7OL
         fOuUp+T6fXnTPOGwXZdKY9ezvi6cXHGoZbe9wF/jrb1dk3bApKeBBzibZOSpkVMbx3AY
         XQoQ==
X-Gm-Message-State: ACgBeo2UNGHdvrOtVaD0NvL1uPWL5WH0KhGI9DtsJv8u6GOr+wSaRxdE
        sw4MwCfTTf6BckMSKwu6VAS5SQ==
X-Google-Smtp-Source: AA6agR7eSH//h3ZELnIxOVv6NmxFqhex5WBRBuKkg+SLN97rZWOlrtpdSOGBnKDYBF73LfFEIo6gMA==
X-Received: by 2002:a05:600c:1e13:b0:3b4:74c3:620b with SMTP id ay19-20020a05600c1e1300b003b474c3620bmr9884551wmb.168.1663322255099;
        Fri, 16 Sep 2022 02:57:35 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id v12-20020adfebcc000000b00229b76f872asm5507798wrn.27.2022.09.16.02.57.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:57:34 -0700 (PDT)
Message-ID: <e6ecf9a3-4e8a-ff2a-aa82-5e65f99d76ac@linaro.org>
Date:   Fri, 16 Sep 2022 10:57:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 0/8] Add support for J721e CPSW9G and SGMII mode
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux@armlinux.org.uk, vladimir.oltean@nxp.com,
        grygorii.strashko@ti.com, vigneshr@ti.com, nsekhar@ti.com
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kishon@ti.com
References: <20220914095053.189851-1-s-vadapalli@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220914095053.189851-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 10:50, Siddharth Vadapalli wrote:
> Add compatible for J721e CPSW9G.
> 
> Add support to power on and configure SERDES PHY.
> 
> Add support for SGMII mode for J7200 CPSW5G and J721e CPSW9G.

I got two same patchsets from you... version your patches instead. See
submitting-patches doc.

Best regards,
Krzysztof
