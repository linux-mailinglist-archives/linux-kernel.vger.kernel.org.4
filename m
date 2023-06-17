Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA7734381
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 22:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346414AbjFQU37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 16:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjFQU35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 16:29:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E371724
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:29:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-985b04c46caso316926166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 13:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687033793; x=1689625793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WotXs+XtzzrhlYB5laz6cnJm1VOdwaPgisww3kS+BtM=;
        b=lW9fTA9v9HxxmIHFjctBcM5mJ8sibJgQJFs7a+noaiQ3kf+VggSz3rxCQS77BYbuKj
         ibyDg5uP78O5Ypgznaqh1Y8JVeE+0649VRACesm/ssk3yZRpIKxHwqt8sBiR5QwvpnrQ
         ym94m87zIjd+jps/yrzwuUFHyyz/kBbeYTQM3IDQlWp+Tuyek65gi3/hZHV3GwZL4dFA
         4muMUlITlw2uO8ywZPtFhKoIdbzxUc0+4qaAbl+qdxHOu4ExleWtWpUpqCpIDKJJEmGn
         5T04eLpsuGKo1r2rRhWP7VBJL7dSFL9qcNT32JOCE8QXZpu94h2rTmVHE/QlafnT4wXm
         beog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687033793; x=1689625793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WotXs+XtzzrhlYB5laz6cnJm1VOdwaPgisww3kS+BtM=;
        b=e2GR4bRkj6zAgObgaXDRhpMf4T9CYobuG8l3GWMQKv5uGPtfQ3Bad58thfjA1TAqRx
         9vD0jUP+uTfPzHCFhH5UF7VPDFbukOOfqNd3IMA9Nb/grQE2Xy/AT9NBwok0jv/6OMFu
         ZOo5oPpU8l1umf6jPaFW/ymkU9MMt8ZouC/aZTicIzsNABakFz9EK9MFGV8BMNep3Ckm
         OHGcE72429UyZwagBVDaoIPAbjgw0+I+9Vs9qI/OIIcEI9XVdY2gAt+/6EonPcHyHpU3
         tjDzpVyMZyPBbiH/jbSmTHbR6xWCTfi03tNGbYIjoZbBS4KUhiwfjw4k7SjlWL8ZU/7L
         KMeg==
X-Gm-Message-State: AC+VfDyf90fKw+MBnUrCuuL9Iu/pDpd5TUC9Xy/AdeFK2t+Dg35UFLLv
        wumXIFF/z5xSEKJKytq735GWAA==
X-Google-Smtp-Source: ACHHUZ53sBLPaVvnnGgxK0nUyl1GvLMLow9cJxFJcPNV2oyhFecpAq7IGFCYchBcJkCqaWuR6eSlkw==
X-Received: by 2002:a17:907:3187:b0:96f:c0b0:f137 with SMTP id xe7-20020a170907318700b0096fc0b0f137mr5548380ejb.16.1687033793351;
        Sat, 17 Jun 2023 13:29:53 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709064ac200b00977eda0ea29sm12728337ejt.14.2023.06.17.13.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 13:29:52 -0700 (PDT)
Message-ID: <fe1f44f0-3c6d-4375-6aad-286d6d539d73@linaro.org>
Date:   Sat, 17 Jun 2023 22:29:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] Documentation/process: add soc maintainer handbook
To:     Conor Dooley <conor@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     "Conor.Dooley" <conor.dooley@microchip.com>, soc@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20230606-escapable-stuffed-7ca5033e7741@wendy>
 <05c50d10-080b-43ab-9131-98f71508ac2d@app.fastmail.com>
 <20230617-succulent-surgery-3dbbf9454737@spud>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230617-succulent-surgery-3dbbf9454737@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 20:32, Conor Dooley wrote:
> Hey Arnd,
> 
> On Tue, Jun 06, 2023 at 12:23:26PM +0200, Arnd Bergmann wrote:
>> On Tue, Jun 6, 2023, at 10:27, Conor Dooley wrote:
>>> Arnd suggested that adding a maintainer handbook for the SoC "subsystem"
>>> would be helpful in trying to bring on board maintainers for the various
>>> new platforms cropping up in RISC-V land.
>>>
>>> Add a document briefly describing the role of the SoC subsystem and some
>>> basic advice for (new) platform maintainers.
>>>
>>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>>> ---
>>> Changes in v3:
>>> - sort out a rake of spelling/grammar bits spotted by Randy, apart from
>>>   the one noted as a suggestion
>>> - drop the refs for document filepaths
>>
>> Thanks, I've applied this in the soc/newsoc branch of the soc tree
>> now, which is where I'm already queuing new platforms.
> 
> Having cited this document for the first time, it came to mind that I
> never mentioned putting the submaintainer trees into linux-next. Should
> I send a follow-up patch for that, or do you think that that isn't

This is common maintainer stuff, so every maintainer - not only SoC
related - should ensure his tree is in next. I would trim all such
common things from the document and store it somewhere else, because
otherwise people will just not read it.

Best regards,
Krzysztof

