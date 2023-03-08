Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3961C6B0785
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 13:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjCHM62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 07:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCHM6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 07:58:25 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795644C6E5;
        Wed,  8 Mar 2023 04:58:23 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id i34so65329189eda.7;
        Wed, 08 Mar 2023 04:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678280302;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C4SPW930V6699YB6lnuPMQUE2QmluKgsHI0Y8xGxQGY=;
        b=mPWxXwI3lEO/19TYqz8zAUSOxXJ2e5j9BCBeTzN9994XP6EWPZBj9XzMA/rJTHBKmx
         yXdwK+uXJ4lfZBrlNkCXkQSGjUi/VJRKDaIjpzVCG9NcDYR86EK4mkF5IsFYbmjHG/ns
         B3NfMf6gMhgoiDG3NHAfo6Ry0ohOpwmz2gXaC0KIMA6L0YASGjHEFBq6T+djveJ564e7
         0v32KyXauXJLNE458MJCuC9KSyAAbZ0K0Ul/Prh/801XPy927ZCXlQ3lEsLRvPqjMm74
         D60sDlZ89ZYyRZ+1JojAnPh/41TAQoWQf8e8si2ON/1FPS9HstklcUQG+Xaw/6g6IK6s
         8N5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678280302;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4SPW930V6699YB6lnuPMQUE2QmluKgsHI0Y8xGxQGY=;
        b=ZiTAb6yBgVtBmchRAVLFwjIr61EtKPwAr/ycctwHWjmFnT380H6EbCG1Wo4hFVTdfQ
         xG4A80ZKE/4HXacL5MQPlkUrqhQIb5FCaeSSUuHt4uLeY3KYbF8s8tRQldStsdgKwlFf
         Xq8Gt36muvDFLShdUS2Oo28Ggc8YIB6ow2wO0ZxjS3KyGkqrRcMX8fDxbU+BBOGftfZQ
         RpyJHdD/DkBBFVtxpT9mi04yGETbSduNVYf00s2TnMjJUMXgokNOdUvd5NUPC1jqgV5c
         Ubw67k0M9WlOH2d4J25A9d6MBmm40ORh+UL3z28whfmxt3+n5o8RkdWRH35YthWFQTmN
         cJQw==
X-Gm-Message-State: AO0yUKW/rJJO5BBKsa7W6QNuagP/cl9RnCdRhv3SSSzEw4sAaC3K7gaJ
        lQFd2niN2XbpYj88kwNnwX4=
X-Google-Smtp-Source: AK7set9hqzDkZiTTLbhjC+kWZ8yzzuAdciM3HwOw86U+HzG5twtpMjlxcwnPq4evtaKLeZGhGNtm1g==
X-Received: by 2002:a17:907:608b:b0:873:1b57:b27f with SMTP id ht11-20020a170907608b00b008731b57b27fmr24355331ejc.61.1678280301869;
        Wed, 08 Mar 2023 04:58:21 -0800 (PST)
Received: from [127.0.0.1] ([46.211.69.230])
        by smtp.gmail.com with ESMTPSA id 20-20020a170906301400b008cf1b61a73esm7457932ejz.41.2023.03.08.04.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 04:58:21 -0800 (PST)
Date:   Wed, 08 Mar 2023 14:58:20 +0200
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: hwmon: ina2xx: add supply property
User-Agent: K-9 Mail for Android
In-Reply-To: <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk>
References: <20230308094024.14115-1-clamor95@gmail.com> <20230308094024.14115-2-clamor95@gmail.com> <31ca0ede-012c-4849-bf25-d0492b116681@sirena.org.uk>
Message-ID: <6DBD0F5A-4625-4FCD-8D64-23293D734A82@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



8 =D0=B1=D0=B5=D1=80=D0=B5=D0=B7=D0=BD=D1=8F 2023 =D1=80=2E 14:54:34 GMT+0=
2:00, Mark Brown <broonie@kernel=2Eorg> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>On Wed, Mar 08, 2023 at 11:40:23AM +0200, Svyatoslav Ryhel wrote:
>> Add supply property=2E
>
>> +  vdd-supply: true
>> +
>>  required:
>>    - compatible
>>    - reg
>
>Unless the device can work without power the supply should be required=2E

Device can work without supply defined on most devices, but in my case pow=
er is gated with gpio and devices will not work without fixed regulator=2E
