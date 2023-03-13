Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745B56B6CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 01:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjCMAWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 20:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjCMAWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 20:22:05 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AEA38E91;
        Sun, 12 Mar 2023 17:21:58 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id w4so6245255ilv.0;
        Sun, 12 Mar 2023 17:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678666918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6sm0vPVDlzzX7R9q9j+GwtCn9EFllfv7TIz3i1LxV8=;
        b=G6czlN1zTjIenoOH1hZCtA6NEMrTfhphnXJB5d73Hl2RTaU0jzlODgu3d59Xmyl8lC
         tRvcd9+QljuIflX7cCFgIKrCdH859SG7q9J7Vak8CEimfTMsifCzRhsPkHWKOhJ1W9Yw
         yYcaKrEq13Op1zB2gT2DkBunXhLbX7N3waaIB1L3kMVr/V9KgK1PQDDKn7DlnkDUgHdX
         EiYSiVFDATLcUxlZNDlZ6aXUhfjjQcil2F/Del4pywdcd7qAxwVZ9OJIP4e82PhFR2zr
         W1EvcM3+mOLtSXAF5y11b7z0vSPDIyQQGX3+DrlGYGwUfx9gPBNHxCHlq8JinvaMJ2zo
         EaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678666918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6sm0vPVDlzzX7R9q9j+GwtCn9EFllfv7TIz3i1LxV8=;
        b=6/0d1qx24tUH8tIHTFa4lFlWVILsEgmX0kQCp1cO6bguepu6BsS7VgdaNHChflNjoJ
         HoLQX2JmUuhGPFPSM644qXJkDDlSwf2RYBOjWr/8PZnVDCqIGAGnDTu/qyfRzcj1pwoR
         Sdg/OzX2CdoH3qyC2G5qo9qA7fhnmtuoxjssqJN51qhEujDh++HejSGl1Msu37EkAHhe
         sorPUuQV08Y2705iLGSKnnoDVkxz89+/esSA02xgMRvFFWDZxKPZWTDa6RyoJfi4zVIP
         +ZBDG/T59+hUiXkWbAFHjWIWvwIw8hUI/qylrT96qpQjaf/tFlVRbZQB2lV9O00oa1I5
         GMHA==
X-Gm-Message-State: AO0yUKURu+A9HOP9wEv2xJKj2ptDdcS97i0dYX6Yy544utiziP1DkTCm
        OFYZOhBxfZ75xRcshTQgU28=
X-Google-Smtp-Source: AK7set9m6XiGAn3V7EaIQiBQlky8tE/G1ty6Ubbe73VObDkMvo/ytLKn289ZZMsQWao0iRUU7sJW0g==
X-Received: by 2002:a05:6e02:1c86:b0:317:16bc:dc97 with SMTP id w6-20020a056e021c8600b0031716bcdc97mr10545610ill.3.1678666917751;
        Sun, 12 Mar 2023 17:21:57 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id c5-20020a92cf45000000b00314201bcbdfsm1929864ilr.3.2023.03.12.17.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 17:21:57 -0700 (PDT)
Message-ID: <02012975-8b4c-58ba-b002-d2983c0e1500@gmail.com>
Date:   Sun, 12 Mar 2023 19:21:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/5] dt-bindings: input: touchscreen: add bindings for
 focaltech,fts
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        Markuss Broks <markuss.broks@gmail.com>,
        Jean Delvare <jdelvare@suse.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Job Noorman <job@noorman.info>,
        Alistair Francis <alistair@alistair23.me>,
        Chris Morgan <macromorgan@hotmail.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230312093249.1846993-1-joelselvaraj.oss@gmail.com>
 <20230312093249.1846993-2-joelselvaraj.oss@gmail.com>
 <c9db83e8-f87d-b94d-0c23-8114adb312e1@linaro.org>
Content-Language: en-US
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <c9db83e8-f87d-b94d-0c23-8114adb312e1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review! I agree with most of your comments and will
fix them in v2. I have a few doubts as discussed below.

On 12/03/23 15:47, Krzysztof Kozlowski wrote:
> I have doubts you will cover here all possible FTS controllers, so
> filename should be more specific, e.g. choose the oldest device compatible.

The driver is kind of widely used and can actually support 49 touch
panel variants as per the downstream code [1]. With some slight
modifications, the other touch panels can be supported too. However, in
real world, we have only tested the driver against the two panel we have
access to (FT8719 - Poco F1 Phone and FT5452 - Shiftmq6 Phone).

Although its very generic and widely used, I agree we don't know that
will be the case forever. So I am ok with changing it to more specific
one. But I don't think the panel chip number denote which is older and
which newer. Shall I just go with focaltech,fts5452, as that's the
lowest number panel that we have tested so far and is supported?

Or do I just keep it generic as it can potentially support a lot of
variants?

>> +  focaltech,max-touch-number:
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    description: max number of fingers supported
> 
> Why this is not implied from compatible? IOW, why this differs between
> boards?

Without proper datasheet it is kind of hard to say if this is the
maximum supported touch points by hardware or just a vendor specified
one. Because, downstream has it as devicetree property and we only know
what's set in that from each vendor tree. The FT8719 used in Poco F1
specifies 10 touch points in downstrean devicetree. But, if I specify it
as 2, it will still work fine. The FT5452 used in shiftmq6 specifies 5
touch points in downstream devicetree, but we won't know if that is the
maximum possible, unless we try to increase it upto 10 and confirm.

So, yeah without the datasheet, we will be just kind of assuming that is
is the maximum possible number of touch points by the hardware. I am not
sure if we wanna hard code that in the driver. Is it okay if we let this
configurable? Boards/Phones can use the max touch number their vendor
driver points too or if they have a datasheet, they can specify maximum
supported one too.

Kindly let me know your thoughts on this.

[1]
https://github.com/LineageOS/android_kernel_xiaomi_sdm845/blob/f1977d9edd01cff3fc9a12e09cd6a5a8052fc8ca/drivers/input/touchscreen/focaltech_touch/focaltech_config.h#L37

> Best regards,
> Krzysztof

Thanks,
Joel
