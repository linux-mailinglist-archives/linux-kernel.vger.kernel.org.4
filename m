Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE226B6BEF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCLWVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLWVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:21:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0CC2387A;
        Sun, 12 Mar 2023 15:21:31 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v10so4317733iox.8;
        Sun, 12 Mar 2023 15:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678659690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CeAdxBrqTUyAYKttKLhS7gcvDyYqiZAsmqO7paKVPNY=;
        b=KIL+iLyt2FWfJRmDL0R98KYV/Kg5dLh5cYWykT3tdogKEBckSjCJUpPQf4kMFaCDpD
         k4CRERBSn7miZn7y0wI0lSnwt2UiAFcI+hPF3/Ehwv2lr7O0yaYt2YcLU+zwnPThLXDr
         tjIbZr1J3OOXDrZYLiPSBleI6pMSsBp3ktTXBO0+IYABpueKfJQrAdlkmrS2JQ1h+TFk
         ix1Tsl44lEMenPBVhYN6M0QMAFmTtzyhyxKxDgPmQHszdLL+9EztsDhnHHTWaNu0aeDP
         SuJhzZv8lR0gQ0I64pnGThVZFwhexKTViyolvlR9kBzluCpyVYSYJNDZTfpGqCUX2A/H
         rYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678659690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CeAdxBrqTUyAYKttKLhS7gcvDyYqiZAsmqO7paKVPNY=;
        b=e4385UunZxEiNz5h0LrKoJRgH5NpJHdIVG/rhuZKC8tXc87P+4LibZnqJ/rLM4z3BI
         PH27d6qWMecpRVQqlegFwleYUGTcL2z2Y3o/VEelL9VagNAu62bVsxPxJHZwvfRLF2Ke
         OW13osru8a0LfZeHScoyV5QgSXcB/4bdySeP+eNeL5rrurU3BUpDcjVbfoLzgOjcxWO9
         4XWD6cZV93SUwpYg/l9P2nIB3gwpCZiX/TMJYMS1pi8nMAWZ35vbIO2ML+36vsGgSllr
         ZLnKTUBhc/GYJzmxjJb5u+VEHQP+kjAjzp/4DuZ8gb9IkSo6znvoLujr0KTNRLeqajSM
         HfUw==
X-Gm-Message-State: AO0yUKVeZZq+LO9IbAw6euf1C571q1iFwg9Cb100emdzgi4w4xusA63Y
        WpYOvh5yQWD9Bo70AWurE3c=
X-Google-Smtp-Source: AK7set/kri0qgJj6wF/0ehVkbW3BJXFoiVIrYztz7A/XX8/UL2inzBVww3JTYPCUlBVoAntTfbUZug==
X-Received: by 2002:a5d:9606:0:b0:74e:8718:a174 with SMTP id w6-20020a5d9606000000b0074e8718a174mr7748324iol.1.1678659690237;
        Sun, 12 Mar 2023 15:21:30 -0700 (PDT)
Received: from ?IPV6:2604:2d80:4d87:cd00:9f51:32d7:1177:67d? ([2604:2d80:4d87:cd00:9f51:32d7:1177:67d])
        by smtp.gmail.com with ESMTPSA id i18-20020a02c612000000b004042607348dsm343542jan.34.2023.03.12.15.21.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 15:21:29 -0700 (PDT)
Message-ID: <d40faca2-fe5d-5b5a-eefe-68eb3e5e8125@gmail.com>
Date:   Sun, 12 Mar 2023 17:21:27 -0500
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
From:   Joel Selvaraj <joelselvaraj.oss@gmail.com>
In-Reply-To: <68b05c43-5808-5792-9b57-aeafffe84149@gmail.com>
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

Hi Markuss,

Thanks for the quick review! I agree with most of your comments and will
fix them in a v2 soon. I have a few doubts as discussed below.

On 12/03/23 15:40, Markuss Broks wrote:

> Why is the _ratelimited variant necessary?

I assumed in case of the interrupt working, but i2c reads fail for some
reason, it would spam a lot of error messages if the user touches the
screen continuously, like a swipe up gesture or something.

I referred to ad7879 touchscreen's irq handling code [1] and thought
it's probably best to do this, to be on the safe side. I will remove
this if it's not needed in v2.

> Overall, I think it's better to cast the data type to a struct, which
> would make this seem with less random.

Sorry, I am not sure I got this right. Do you mean I create an array of
struct called say "fts_point" that stores the x, y, type, etc. info of
all the points, then report it separately. Like similar to something
done by the auo-pixcir touchscreen driver [2]?

If I didn't get this correctly, can you show me some code in mainline,
that does it? It would be very helpful.

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/ad7879.c?h=v6.3-rc1#n250
[2]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/input/touchscreen/auo-pixcir-ts.c?h=v6.3-rc1#n162

> - Markuss
Thanks,
Joel
