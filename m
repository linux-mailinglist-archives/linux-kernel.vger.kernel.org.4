Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067DB67B8A7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbjAYRdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjAYRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:33:19 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234FA3FF0F;
        Wed, 25 Jan 2023 09:33:13 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id b6so13865577pgi.7;
        Wed, 25 Jan 2023 09:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0yAW9awaWCAFYQgXU2rgzVSORqoFGaa28Ixzc+MNDJc=;
        b=Yg/+baKKDeXy3RDRxkb6ubdNS+d6cFCtqowuCBvMfnHQciLccF8Jv3/k+iXUN86R+z
         pVAfEdJ7jD5fqjqO+C7pBCBEcJshSOPo5AL3kzoZraTuS5Nli8WGMmdabJD2DgWSF6SN
         y7vBQPmAuPIKrxn1qrwpfK2I8FpseutGJx2xnwGMdWnOFFb/vF7u/pDODqjA9MrEJC1w
         6MRKrZRd+m8LOxqpkpEbqmuVs2bkka+fBT8t6frY/ImDZblhUItrJR+x8KjlJCuwCKki
         mtP/cNVWH6pcgD8fvVQ6bzUBdJxjtxEY/WqvXLCWT1rb1s8dE7YINAzlmr9B/0sM4r1T
         9Xjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0yAW9awaWCAFYQgXU2rgzVSORqoFGaa28Ixzc+MNDJc=;
        b=Ir28XiHu9QQsthfsmYegLEy1GGTBPTYFT8EU4GIbkNKEP0NpjzOFCWPd8+IpEJFupc
         JopdJTmEcyYdvjCu5p76pjyMeE6pcAX1R6cdBOcptT2F1FZr9igAAn3CG5mU9Qx389aZ
         ztJfa99iS7NUw+8GvxKjkjISW9BetY4CX07G8K0+IED90XcTmKxLf+BAsv0L2FvTZE9R
         nYtaqVaRbqKhAf3iBYsjfBusNamQS6unZ/qn7s3fRriP4ezrBejZIuOh74nJyvbFkRbU
         vuEmcr1CkRBk62IVli5WUZt0qEt4jtRLN0nCVIyaBalb85CArHrGVtG356KE6wqpINGf
         z+8Q==
X-Gm-Message-State: AFqh2koTr9TCit+/ASCxNfMZ8AiyRpegIPgDdWMWXKTXsCeDQ/ZH2XSR
        iX/gOUIbcDBRnuNLY/ZlQdE=
X-Google-Smtp-Source: AMrXdXuyB2HFb0zu+T3HVa2Z1+Tkuq4CTsUzrV1IpW49XUDYjL71bczJ2bPsL85M4O4J1A1HZ5ad9w==
X-Received: by 2002:a62:3896:0:b0:58b:9b4e:5292 with SMTP id f144-20020a623896000000b0058b9b4e5292mr31483812pfa.1.1674667992480;
        Wed, 25 Jan 2023 09:33:12 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:4a48:6d55:c521:9057:460b? ([2600:8802:b00:4a48:6d55:c521:9057:460b])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7804b000000b0058bca264253sm3852667pfm.126.2023.01.25.09.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 09:33:11 -0800 (PST)
Message-ID: <4a09ff59-278b-9fc4-8d74-0efb8daea970@gmail.com>
Date:   Wed, 25 Jan 2023 09:33:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: brcm,brcmstb-waketimer: add
 alarm interrupt
Content-Language: en-US
To:     Doug Berger <opendmb@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230124201430.2502371-1-opendmb@gmail.com>
 <20230124201430.2502371-2-opendmb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230124201430.2502371-2-opendmb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 12:14 PM, Doug Berger wrote:
> A second interrupt can optionally be specified for this device
> to be used for generating RTC alarm interrupts.
> 
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
