Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD3B6406BE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiLBMYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233146AbiLBMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:24:02 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EED0CBA6D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:24:00 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a7so5195434ljq.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 04:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B1IE4PC6erRK/A01N47UIMsmxLEl+S0fBRDo4ibGO5I=;
        b=dn1rHkT/ZUpHyXQkzsJGPlvGVowx9j7sNI5P/+sOF6lJyJwhCYBWbkJwSr3gHcJJPT
         Q9r6ceBkL275DvXfUzbEqklBMKatqISFq5ByqpfiH77IxA+aqi1nsdx8UqE8aFKOCUve
         JVl4GDzVLUSZQmwVNuJ/GSOdKxu2UouZMWjkJfJHNeUZLbvWJMeGu6G7EkkctXoe+qmv
         rbHyfjT0CrCz0n2I7qy7bNGvfhYgxstTUXa3No67EHRP1GiAkgEqGl7/PYlbjat6XoMe
         Pa6uhNEly0HAYIIlDUmSuXuZXiB1sz/6HXkgNwufU+VG60kgLAEtS1ancfJo+5o2GS09
         PVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B1IE4PC6erRK/A01N47UIMsmxLEl+S0fBRDo4ibGO5I=;
        b=eaGRfgmJLPNTTFwY38B0VpcweN44KeA0hjkvRS2PKONOuGlxftRZbnw2zxpCFiRpji
         BN/u5311Hy8CfHh6R5Lt6t5brUcO/bdPfafHJC1LjHtwHqlRjZFZ5jKTRQRdcXCAPcu+
         7NiGCNcpwMGOJQmQz3WVBEw7Ljw3wkKFWJLKH1JKSaQ4TF++5//QrDVtEC8zk0+cVtOB
         E1VUbhQn4QK67//rcXGDHbDc2f4fbeJjfbtysY81RsXsJZmHDoWd4EvOsQLrK4YRRcS+
         xUmbeEWG/joX2iog+WyeMOQd/1DEl2z4NdROtrPVECW1/fQVDDVDj0caeLHe7Zk+2cTH
         jjQQ==
X-Gm-Message-State: ANoB5pn/tXmwceFeqq6lERKQsB7Bcq2oMqGZ8K6//fe/GUzTiDHV2v5L
        BQG1hPK57TXpiH/dqa8wMIFSJQ==
X-Google-Smtp-Source: AA0mqf5wOgdF/ULr5YJPk+SAVqYWOsw8ngbLK8kRKQAy9jLV7eusYZ85qij8jL5qnFKYUl2GvVdx6Q==
X-Received: by 2002:a2e:b894:0:b0:277:1c8f:7e8c with SMTP id r20-20020a2eb894000000b002771c8f7e8cmr18986171ljp.296.1669983838529;
        Fri, 02 Dec 2022 04:23:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c24-20020a056512075800b004a01105eea2sm997019lfs.150.2022.12.02.04.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 04:23:58 -0800 (PST)
Message-ID: <f633b0f3-9fdb-8beb-7edf-7967c7c0c3d5@linaro.org>
Date:   Fri, 2 Dec 2022 13:23:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH v1 2/2] usb: host: add xhci-exynos to support Exynos
 SOCs
Content-Language: en-US
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daehwan Jung <dh10.jung@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Artur Bujdoso <artur.bujdoso@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1669860811-171746-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221201021942epcas2p2429ed37e1f6146b6e1a5bef23141b3f7@epcas2p2.samsung.com>
 <1669860811-171746-3-git-send-email-dh10.jung@samsung.com>
 <Y4hgnxGMEuizJumr@kroah.com>
 <c524cba6-4438-461a-ab05-9325fe09f832@app.fastmail.com>
 <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec0ce90c-b165-d84f-340d-4973b65609b3@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 13:22, Mathias Nyman wrote:
> On 1.12.2022 11.01, Arnd Bergmann wrote:
>> On Thu, Dec 1, 2022, at 09:06, Greg Kroah-Hartman wrote:
>>> On Thu, Dec 01, 2022 at 11:13:31AM +0900, Daehwan Jung wrote:
>>>> This driver works with xhci platform driver. It needs to override
>>>> functions of xhci_plat_hc_driver. Wakelocks are used for sleep/wakeup
>>>> scenario of system.
>>>
>>> So this means that no other platform xhci driver can be supported in the
>>> same system at the same time.
>>>
>>> Which kind of makes sense as that's not anything a normal system would
>>> have, BUT it feels very odd.  This whole idea of "override the platform
>>> driver" feels fragile, why not make these just real platform drivers and
>>> have the xhci platform code be a library that the other ones can use?
>>> That way you have more control overall, right?
> 
> Agree that overriding the generic platform driver xhci_hc_platform_driver
> from this exynos driver is odd.
> 
> But I don't understand how this works.
> Where are the hcds created and added when this xhci-exonys driver binds to
> the device? all this driver does in probe is the overriding?
> 
> Am I missing something here?

Because it is not a driver for Exynos... it's a driver for wakelocks for
their specific Android use-cases which the manufacturer ships for their
Android devices. Due to Google GKI, they try to squeeze into upstream.
But this is huge misconception what should go to upstream and Samsung
does not want to keep discussing. They just send random patches and
disappear...

Best regards,
Krzysztof

