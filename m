Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC8F5FA3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 21:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiJJTHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 15:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJJTHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 15:07:30 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C300641525;
        Mon, 10 Oct 2022 12:07:28 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l28so1512459qtv.4;
        Mon, 10 Oct 2022 12:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tHbgSss03L35eJoiPvd6E+bOo+CK2kE8ZZuMTI5hMok=;
        b=ZLiCbmc+aLvVY6yK7PQS9yEjBx9W8tYKi8fpjZ1vBWhLhIJ8nQiLl2qIXAXSb+zai3
         dwLfe9FHOQHDeHis8L2jVeKaMteFBh3cz1qYG0aHxFlMbISl9PjSLsDmt8G5ARIIEPxC
         rLJP2JkpDijQTOgJmSBOp6wzr93kPscCY46zXKhjFbvTpQ+Bbj4C0kG9GQReLPuBFN68
         4ulyP9iMo7aKSCdiIITiCkRFXwo8WmqmbolIUecGab3+QFvFQ7G3jsYeG+N6I+HRjIhl
         tf8pCA3jjUo5VfnctePnGP4UziYpV7vcFtNPQK0HBkj+ltjPvhPZ1XC8sPM+fm9FNQEt
         jESA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tHbgSss03L35eJoiPvd6E+bOo+CK2kE8ZZuMTI5hMok=;
        b=IuuBhIqrUlMFQdNjMgp1LhCOpoBsDutBlRkIQX2zztO0VrSiHHICSPSHKgFdRKmJcJ
         ArBl5S6zRmIuYCOUd3EnZk7pZsLu6PCHSGMkUOgMH5JOffKy8lk21tmXHy5/Ih6MBe4h
         RXzK1gvW5cuL7yyIF7a41XrOmnWj7NpaZ1y/rGH1swH/H0m9P0z7zk0PYOjWcAdh3kxj
         gN3rba7BNPJ8DRwXEsXaDmTGYuKsTFPp6mhnrD4AEtrJLcaq47lBlbR8INOktW5h/JSp
         f9lRZAoEKaeMJcTn2KmkUiKtvHeCLK4zVAcs9JcZVnIxjxMxrJX4GaKFYzaC9Aj+BiNm
         wr1w==
X-Gm-Message-State: ACrzQf3FgOXlfbE4YLUMQAYmMDtbyDWXntbEm3/9+/9YpuBX+v6X9F51
        XqWJmZ4YeG4aj8CmmWCQCuw=
X-Google-Smtp-Source: AMsMyM4sqjylyecSB8SpRQyKOlV52WBMIcnfpUmsjSNs6YgKEywOKanh7L6jExlWXlG/AzcbJCI/uQ==
X-Received: by 2002:a05:622a:10e:b0:398:d464:eefa with SMTP id u14-20020a05622a010e00b00398d464eefamr8672655qtw.172.1665428847849;
        Mon, 10 Oct 2022 12:07:27 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bm38-20020a05620a19a600b006cebfea5c55sm11505848qkb.2.2022.10.10.12.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 12:07:27 -0700 (PDT)
Message-ID: <395633de-193f-609e-abc6-9dddb2cae3c0@gmail.com>
Date:   Mon, 10 Oct 2022 12:07:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 0/7] drm/vc4: Fix the core clock behaviour
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stephen Boyd <sboyd@kernel.org>, Emma Anholt <emma@anholt.net>,
        Ray Jui <rjui@broadcom.com>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dom Cobley <popcornmix@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
References: <20220815-rpi-fix-4k-60-v2-0-983276b83f62@cerno.tech>
 <20221010114420.beytjynzshjgiy6y@houat>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221010114420.beytjynzshjgiy6y@houat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/22 04:44, Maxime Ripard wrote:
> Hi Florian,
> 
> On Tue, Sep 20, 2022 at 02:50:19PM +0200, Maxime Ripard wrote:
>> Those patches used to be part of a larger clock fixes series:
>> https://lore.kernel.org/linux-clk/20220715160014.2623107-1-maxime@cerno.tech/
>>
>> However, that series doesn't seem to be getting anywhere, so I've split out
>> these patches that fix a regression that has been there since 5.18 and that
>> prevents the 4k output from working on the RaspberryPi4.
>>
>> Hopefully, we will be able to merge those patches through the DRM tree to avoid
>> any further disruption.
> 
> Could you review this? Ideally this would be merged through drm-misc due
> to the dependencies between the new firmware functions and the DRM
> patches.

I suppose I can review the firmware parts if you would like me to, for 
vc4 I am pretty much clueless, and despite efforts from Emma to get the 
vc4 driver to be usable on platforms other than Pi, that never happened 
unfortunately. It would be better to keep the firmware and vc4 drivers 
decoupled, just so "wrong" assumptions are not made, but for all 
practical purposes this is the only combination that exists.
-- 
Florian
