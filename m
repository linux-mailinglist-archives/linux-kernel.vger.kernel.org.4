Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4CC64CD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiLNP41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 10:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238543AbiLNPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:55:49 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E13228E2E;
        Wed, 14 Dec 2022 07:53:21 -0800 (PST)
Received: by mail-ot1-f45.google.com with SMTP id db10-20020a0568306b0a00b0066d43e80118so1986009otb.1;
        Wed, 14 Dec 2022 07:53:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky7CWyr1K56tgcvD1JqeLwmsHrDvSN4irv7fwBETXmo=;
        b=lnHTUM19TWA3os/xeNrBSUyUfj1xf1/uDwOEv0dO9EdVei2bJCGkDyyuwVoLiqk3vz
         tHkLg3H0xjiVrCP2lixr0S+9BfIX3lMI2RYpJ/cZI9FHvTtuS6OlOWFkCgfuVvKveACE
         p2QO21aqBnQgfoE9ISkQ2sRJSHftYKxz+0ivNBSiw91KrJVaIy7dbhbO5dxU8hsJ4aud
         pGpO9cYnMAYAe4EyCqErnQUaBPszhQouQSqLJ+yoDol5DqbDcRUleXJv2ndZt3hWfOau
         M4jdsnU73llZ2RnniC6V3/0SQEGNalRVVg4LAKgnPJwqJP2PjE5JrkTXyQ823ATu/iMG
         2ouw==
X-Gm-Message-State: ANoB5pmiSh5uoy2R3S4hSzdwXfnqAc+CwuTkKgQ6IgBN1s1Sx//XnPPy
        xyuCRpssXzkn49aO3cO+5Q==
X-Google-Smtp-Source: AA0mqf6Jy4JxfKbg0+GmdD9/xG8edNlc+K2I6SLZBGFlYNtCsBXx1+2czz2rWLJhnt4uFNrSJIz7nw==
X-Received: by 2002:a9d:7cc7:0:b0:670:5d89:b1d4 with SMTP id r7-20020a9d7cc7000000b006705d89b1d4mr12535835otn.35.1671033200310;
        Wed, 14 Dec 2022 07:53:20 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id a2-20020a05683012c200b006705829996fsm2488526otq.56.2022.12.14.07.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:53:20 -0800 (PST)
Received: (nullmailer pid 1128398 invoked by uid 1000);
        Wed, 14 Dec 2022 15:53:19 -0000
Date:   Wed, 14 Dec 2022 09:53:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: ntc-thermistor: drop Naveen Krishna
 Chatradhi from maintainers
Message-ID: <167103319775.1128325.7970103574763866861.robh@kernel.org>
References: <20221213100626.36150-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213100626.36150-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 11:06:26 +0100, Krzysztof Kozlowski wrote:
> Emails to Naveen Krishna Chatradhi bounce ("550 5.1.1 Recipient address
> rejected: User unknown").
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ntc-thermistor.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Applied, thanks!
