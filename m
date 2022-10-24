Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F3C60ABD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 15:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbiJXN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 09:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbiJXN5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 09:57:32 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F6EE5E540
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:45:10 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id m6so5951786qkm.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6/Gkom4ZPWK7cMyC9zfoGrRQqMQlvaVxP5vBufeZGo=;
        b=mejxcpn1uI9RNrXj4eSCcG9DdTDntnxcnQ0p/X47na73KIw0QDk7VkvlILO4BSrYgp
         mkn7tFJD3SrWeBS8Di3gq9DA5FUvvsC50J/9oz4yxFiJJiejBjUzWJPi/ZKN3zvis58+
         hpSzdLcfitVxKOxLluaifzo8FoP0wUqqmZFtYg2hwCo2zafUy6EroWzcDjm3+xcDisq2
         N1CWbTgDk4vur3LIsKxe2Lco4CeujIspSWYT+2zDs8dCzln+2w8TC5Z2C3l8ky4Wqy6A
         gPjmAgKo3UBTk4REpOhQz3rp0lGnB8xu5+Q55qMdpYKPuP662wbj8Nkzqpu8TtC8RKxI
         SAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6/Gkom4ZPWK7cMyC9zfoGrRQqMQlvaVxP5vBufeZGo=;
        b=pvQACaFX0RnIPEDP973jAd9mYcZkgHj2PI07kYRlsmqU8EBj0L8TH0n3CtLJU/dAlZ
         l1h8ACfwDIq0RDx0aBxxVrpqgH7HqAtd2qMFVfHauwhPwLZS3h2L+ubtgS8qT59T4guy
         DIGk57TFIwbO+tIYNGGlo+QRo8uo4Oa9gs3rQ7ZTQmcLpgi/3pYP3lERjp2+dquyQPht
         djd/MABxcz/FFZmfYDtUiuCKJA1vhOOhN+fLV9j4thPk3hBkNE4l/xGelJJwUMxrPtxk
         SVapsO3pTUlv/fzWC+g7yzX4TESJ7rMY1GTX8jUn61lZO4elN0mFSvKsHXApouLHedE+
         MZ1Q==
X-Gm-Message-State: ACrzQf2+6Gw/gapdSejupj+DhVxYO+hVRZQWkhhUPJ1VgCbq11fCeRxQ
        xdWUBqBmIreLUeX5Ve3jP6KlVXqh5MJ9SA==
X-Google-Smtp-Source: AMsMyM7QY9u7Z1kYexxENhtYjDsCBL6DV4I13tRCpUzNLXQT4rVNiSMxlYrOH2XNj9HBkERybeb7Og==
X-Received: by 2002:a05:622a:134e:b0:39c:f1c2:60db with SMTP id w14-20020a05622a134e00b0039cf1c260dbmr27492997qtk.188.1666614612300;
        Mon, 24 Oct 2022 05:30:12 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id i8-20020a05620a074800b006cea2984c9bsm14548147qki.100.2022.10.24.05.30.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:30:11 -0700 (PDT)
Message-ID: <bb7840e1-6748-3d51-c491-6d6c0257e055@linaro.org>
Date:   Mon, 24 Oct 2022 08:30:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 06/21] ARM: s3c: remove s3c6400 support
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-6-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-6-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> No board file and no dts file references the s3c6400 now, it's only
> s3c6410, so remove the final bits as well.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

