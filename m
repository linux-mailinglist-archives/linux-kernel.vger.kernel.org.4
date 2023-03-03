Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC276A94AA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjCCKAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCCKAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:00:49 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08875C107
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:00:47 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id u9so8147251edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7ZZKx3KyHfLs8tx//0Kd7ENhPGl8+MuIEtu9zybv2g=;
        b=eY9+aK6YUtdny+sVn2scXcootpBZCveeyIqyzOgqEQzc1QcsiRQYLD5v9212Itif0V
         6rsqLvcqCDalNR/WyY7LajIEsnrNCd1o1E4aoBQjHY5jO5dg90YP19/lqitMl4+o/P5c
         nbY6kb37+Z6k5s62axePcleBSkyiGHAR+f4PqPlLKJbjQFmHuREI/nd/9Yzehianz8p5
         LDsG/7yKQrIT+WaSjzEi/yo6ODAAT8W/RYqK7h5SDUURkq15MnYqKpmmpcrVDF2PGtRh
         Ty2Bc+UMCExD0103c6pEGzOrBJdrG6T9XJzi7AiK//uJ8hpcJVal+LI3l8a9LCDx2pqk
         wICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7ZZKx3KyHfLs8tx//0Kd7ENhPGl8+MuIEtu9zybv2g=;
        b=lwsI60trFL4lEL08rJ6X9OaEypYGJgLrZue68VXllExF6PVVMK3fY8Rclh5wQn4efv
         LLvGU6KEnBsHc1TV91BtQAUQRaopYxBiTcqw+1xwO5iK0QnHsI/yBvFIbiVdG2gzFZ4x
         13QjQJ4mInYq1yRxp9akMqWWHNrg2C3iNEXJmO72I+PbnRnfZOWZmJOml1BdJ+fDeHyn
         L5SKhYWbaDWNib359QCZ1Dh8RdoFOEP80c6BVUBQutkTII2Fd77P8G8+0zD/7EXaryFq
         WFSM1dfD27GMldQdCo36MhoIYKL+7M7rLZg885pIdGyqHGN8+fYx6ub8WqscJ/Ra+hqm
         xg6w==
X-Gm-Message-State: AO0yUKWFaFJimT0PAYFgYhhJTyTJaYOiQi5nv5YBtDFV6ncp2I6V+7Jw
        6TP0LWNg+lQr4Tlj1XEBCOt1aQ==
X-Google-Smtp-Source: AK7set+vo0njO58meUIbCNRrpMKX4L7lQD1hlqnNFnHEHIkwMN3qm6vEcokdlhXgRr5BieE4o865xQ==
X-Received: by 2002:a17:906:da89:b0:8b1:7de6:e292 with SMTP id xh9-20020a170906da8900b008b17de6e292mr1346342ejb.9.1677837646256;
        Fri, 03 Mar 2023 02:00:46 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ay24-20020a170906d29800b0090953b9da51sm761159ejb.194.2023.03.03.02.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:00:45 -0800 (PST)
Message-ID: <3f147048-4cce-2c5e-6468-db46cd1e8f11@linaro.org>
Date:   Fri, 3 Mar 2023 11:00:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/9] dt-bindings: crypto: fsl-sec4-snvs: add simple-mfd
 compatible
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-6-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301015702.3388458-6-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 02:56, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> All the current vfxxx and i.MX device tree has simple-mfd as compatible,
> and it indeed supports RTC and ON/OFF key multi function, so add the
> compatible.

Paste it to Google Doc or Google GMail (with extended language
spellcheck/suggestions) and fix the grammar, please. Can be also any
other service, dunno.


Best regards,
Krzysztof

