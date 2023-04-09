Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2776C6DC057
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 16:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjDIOYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 10:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjDIOYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 10:24:14 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CBA3C1E;
        Sun,  9 Apr 2023 07:24:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7606cf9c551so837739f.0;
        Sun, 09 Apr 2023 07:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681050253; x=1683642253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHSYHiDIzBHYaMVI0wzSHbeNEEeUgNK+KBUGPamVoTI=;
        b=fwJe44uxeTO23RKC1OfwUecw7FRiSCZSNDF7dFPwhmnc2Sh+dNlQrB3RmC08UJcM6i
         eeJthrJ26fhXHdoUn6uAejjroei+54f43vk6AMA5knEfO2r5MJWdTPftBBnliDfKe8rx
         vUb5OotTptb4muF7PMzIFq8SsOL48owkj/CKA1SMhDfxed/xpaqTBIzRpiUFeAgTK23t
         ArvNNPI3llK6DoY+Zo9O+xMlnEF3gyWTA5dFNf+JqPCf8+EcFg22/LZwEZS0VKovgZVU
         5vsxZmquy5Q+0SI7DXcwey3cV9E0FQtx4lFJnu3NtCV9eGcwQzsQ/PMCl47YP2AuugVq
         Z4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681050253; x=1683642253;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHSYHiDIzBHYaMVI0wzSHbeNEEeUgNK+KBUGPamVoTI=;
        b=xvX20GcYw8h18Tmqjng7ML8zyqYtZYif2D3YiFqOF+VdTPKYO0GUvYlwhbNfj8h8mW
         lO6Fp76lkDsYCd9QopDtd0RIzYSCEggFjdJkIzGgXG+mMpZDcrOve1kcYK3hPDsiMMjE
         ntOEMEpYBwE1FvGbZHniFy9GoxWjxOMe3+6CTd6TGZe7LMcLIJ2Xoz5heFH+z12rc2V9
         uSmkp1hv6pqgEdAFvQkaVNYLoL9F97JfD5KgswmJiNgh1sRklycj/9z/IcG1Nkp3KdrZ
         rcBzP9I+RHrGo9yfMeZ3YVH6xWzsL3oglRNOJGdzoLBu+nGJmKx1RP5NM1w4O9INJ/wA
         X9Xw==
X-Gm-Message-State: AAQBX9fErX2qlAttVCHw5Ca1V6GjRDnxTDchywB+AwLCalCd99YM0JBx
        pPfoaIIKM1/LaNJ/5kL9tFs=
X-Google-Smtp-Source: AKy350ajeWPC0FBnxE/7DVJzQIH1nvd4qauxyXv8VLbEMO9fTPhqsZZLJPPOw3a6w57EhWIkDlvSYA==
X-Received: by 2002:a05:6602:4192:b0:760:478f:e436 with SMTP id bx18-20020a056602419200b00760478fe436mr2453709iob.2.1681050252926;
        Sun, 09 Apr 2023 07:24:12 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id e12-20020a05660222cc00b0074555814e73sm2428949ioe.32.2023.04.09.07.24.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 07:24:12 -0700 (PDT)
Message-ID: <0f6e0854-5097-3abe-8e02-36cb7027bf61@gmail.com>
Date:   Sun, 9 Apr 2023 09:24:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/5] Input: add driver for Focaltech FTS touchscreen
Content-Language: en-US
To:     Markuss Broks <markuss.broks@gmail.com>,
        Caleb Connolly <caleb@connolly.tech>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Jeff LaBundy <jeff@labundy.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-3-joelselvaraj.oss@gmail.com>
 <68b05c43-5808-5792-9b57-aeafffe84149@gmail.com>
 <d40faca2-fe5d-5b5a-eefe-68eb3e5e8125@gmail.com>
 <f9c8e0d4-1d0c-cefc-866c-046d4d374576@gmail.com>
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <f9c8e0d4-1d0c-cefc-866c-046d4d374576@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markuss,

On 09/04/23 08:32, Markuss Broks wrote:
> By that I meant doing something like the Zinitix driver[1] does. It has
> a struct data type for whatever you read from hardware, e.g.
> 
> struct point_coord {
>     __le16    x;
>     __le16    y;
> ...
> };
> 
> from that driver. That way you can cast the data read to that struct and
> have it look a bit nicer.

Understood. Thanks for the clarification. Jeff LaBundy explained it a
bit too. I have addressed all the other comments in this patch series in
my WIP v2. However, I am having quite the trouble casting the buffer to
a struct. The register layout is bit weird. It would have been easier if
they are sets of 8bits or 16bits values. Instead it seems to be split in
terms 4bits and 12bits or I don't know. I am a bit new to this and
having trouble handling endianess with these weird splits in the buffer.

Here is a hand drawn image of the buffer layout [1]. Let me know if you
or anyone have any thoughts on this. Wonder if it's worth the trouble :)

[1] https://imgur.com/a/4RYrB1G

> This is just a suggestion though, you have the final choice in what
> design you choose for your code :)

I am gonna try it a few more days and if I can't make it work in a
sensible way, I will probably go with the existing approach.

> - Markuss

Thanks,
Joel
