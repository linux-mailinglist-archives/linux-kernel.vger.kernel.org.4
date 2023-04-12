Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8096DEC4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 09:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjDLHMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 03:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDLHMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 03:12:31 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84B619E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:12:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sg7so37751799ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681283533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=20NxWQfu7PegmR8o2TW3jbG60xzKoW5JlKk1pLi3MVk=;
        b=ifEb6C0R/XP32vAVfxk35tZQ5NEGs5Ujp8nvXHAWnyQmhEA1nhPNI+njR+Du2uqEKx
         K9S6X8zj7ofPflCfF+S7KsKfdSBEbFzxsKyayAhNslmRbeJDD1AI4H9B3h1r6eeKAlMe
         JT0OIiAqSJ/oQu++Pfm8WyUPzXPXbyOW1YSH5rVR3IxWb6y/D2nWuPjXb/OpRnRLkfoe
         f6Y/2aoPonjexPDPAS7RgDh1Xqw9zrwsUxE7RZeXthRs3C2zEtgjljVt8FUI8UKIWWun
         vKYVO7y5HuBnFwajYudTuMWVh6XQxMC8CqJxtSNQAv0Qa7wa8AO2i3ShZvVNRdpTC1t8
         5G+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681283533;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=20NxWQfu7PegmR8o2TW3jbG60xzKoW5JlKk1pLi3MVk=;
        b=SCoOghJVRsTb3gh7Pux9x9Gw4/CDPsWPsDC4VVIu0LJQC4lkOV7CiD5SbbTuy1vTdl
         bTVutkkZtkl1oNWGNQMXswzOlrjbwrayaKoW28uzx4NnvTh0tvyI97z0XmJv+GgFdC0T
         h5uN7FVxkdHjjSryfR64sST/6AgUNyWs3Zr9EYG1q+tRon9YHXjW75MKqXJq9rfL0kae
         GeBjjQXJyqtrrpzXj4ayTaLJ0l/2/IzUdV6E9TuVRE8OMW0pdOupq0ERqZV80c1a7Lu4
         3CqDAH2bY9EHHeuUtHo65FMm4DbPSCUfB7KugBeg6x+manGKXNgwyhEtWgokKAHjcQ5s
         z7mw==
X-Gm-Message-State: AAQBX9dGCHk50uasDALmeygsXqOkZU7vnv54wQH8F6QUZUvU5bYxewoA
        FGTYqvSMyH37OnL4hESja2iMCw==
X-Google-Smtp-Source: AKy350YmkEI2tgNQNV4yU8eK/xvG2fPNOxH4v21/n+cYhBNKjefVMOQZN5nw5RA1THkfprKhX879kg==
X-Received: by 2002:a17:907:8a24:b0:94a:3ff1:53ad with SMTP id sc36-20020a1709078a2400b0094a3ff153admr13430307ejc.75.1681283532867;
        Wed, 12 Apr 2023 00:12:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id nd11-20020a170907628b00b0094e570909c7sm438648ejc.67.2023.04.12.00.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 00:12:12 -0700 (PDT)
Message-ID: <7e98fefa-da9b-f07f-eafc-688b54011e64@linaro.org>
Date:   Wed, 12 Apr 2023 09:12:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/2] dt-bindings: Document APDS9306 Light Sensor
 bindings
Content-Language: en-US
To:     Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230411011203.5013-2-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 03:12, Subhajit Ghosh wrote:
> Add devicetree bindings for Avago APDS9306 Ambient Light Sensor.

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.


Best regards,
Krzysztof

