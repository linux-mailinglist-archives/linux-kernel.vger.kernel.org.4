Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CAA5BB992
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiIQQsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIQQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:48:00 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716B326C2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:47:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id c7so17884116ljm.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=W5ITQm8Ly79yOis0DGm5sinpsbqXJ5om11eayITaMFY=;
        b=Ms3fu3/5E0cICaPnr2YEt2RxJS8MbEHoBdcJVDo/4VIWe8Mh0PpPgurP7ivv5yPPqp
         0RnLAtFJm3WiKJ1l1hwiUaUQJQJFh0+R34r6qOi6LgBF7BbwuYJ87MHF8G189Sp0WGpJ
         3uyDQDB9pvI1aO4lon7UunRzQU/DTVQVi1K/E+pHTysePq8JqOHSM0RmWwZxGXzfnV/c
         nyNOAETrs2meIoLywp+lUt4e4ebB2aVFVpG3hVre1EKHsFW1uciz8J3d/BIIe6bDV5tB
         Vm5714yeY/h6rONeQrC8YFJNOJMW7e5Wo8FWIqBc7IqMLG1ZB8UtntEgyfV10Ya3ZSFu
         884w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W5ITQm8Ly79yOis0DGm5sinpsbqXJ5om11eayITaMFY=;
        b=EnLQ+asH3Hz5GOLZ/U7CXAM8sE310lAQ7mxOQJZ/YrrukvKbxuhGQpJhfMOBnIqjnF
         lGM7nGduOuDURDrHQjkbvB/a/pNrP8e4PmXI+svhszO/sgfwd2JEkyyffih6ZMAbOgHz
         qUl2gMMm4crgiUSw8a8g900xhio1d07f2nHXzmXLG5pFGfDyOocqUWckQuGQFRvCYHAc
         Pefys1v6KwZ/Yf0G54rS5vd6T7DSWHpS96ctUjorb3TQLInx9IR+sYg/nbqZ5c66aliQ
         Pv3225IYnqqdJsB4eYI0nZrUuEIolwZtc9rFwpLIkbkUGGVTgDXH2huImcCh15T19atG
         vjgQ==
X-Gm-Message-State: ACrzQf3R+iOMhToAHgEG1a/R12vyJsel/XBIvPBaO0EuRmeLe3g1/Vel
        MyBAECeKvxpIMhOu03GaHTgEYA==
X-Google-Smtp-Source: AMsMyM5/QVv7lIPIliMSbe8S2oA/B80sG+dW4sZDnC4PEWW3P1+exHuooHn5iDaC56s8d/cuSTui3g==
X-Received: by 2002:a05:651c:238e:b0:26c:17ce:fa3 with SMTP id bk14-20020a05651c238e00b0026c17ce0fa3mr2801777ljb.529.1663433277884;
        Sat, 17 Sep 2022 09:47:57 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t2-20020a2e8e62000000b0026a92616cd2sm1566609ljk.35.2022.09.17.09.47.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 09:47:57 -0700 (PDT)
Message-ID: <2b549080-7ce4-bae1-d85a-a56946f055f5@linaro.org>
Date:   Sat, 17 Sep 2022 17:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to
 video-interface-devices.yaml
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 14:35, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> video-interface-devices.yaml isn't used so just drop it from the
> DT binding doc.

Same question - the schema is used - you can see it with your own eyes,
so please explain in commit msg what exactly is not used.



Best regards,
Krzysztof
