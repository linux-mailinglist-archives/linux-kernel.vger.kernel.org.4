Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D076EDB35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 07:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjDYFb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 01:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjDYFb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 01:31:26 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8699001;
        Mon, 24 Apr 2023 22:31:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4ecb137af7eso5413859e87.2;
        Mon, 24 Apr 2023 22:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682400682; x=1684992682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8Fcm9fo+FycljEkzjAB6zQ+6H48xCf7qyMfx7tBzoI=;
        b=m5cmVmNVHU66wFR/uFoqmOcJevc+9jk0scTJK9/9dxeko2n0AODrn/3aslU0vnI1an
         PvCw591choxKe3KuItnn2xmqfyjET24CK4bkyWgdOHuzPbjRA/wQrnfykozo4I4c7H5a
         207nC17x0KYiMDAmmcOT+xH0dOnJfY1CQd9k9QLvSrYiaePVYumUDyqM+qpiXpNjWRFs
         SJ9XNd556CwgAI4aA1CbXM+RD3h/mwshFrPa1bUx2Nx3L//2d6Uh4Z6fv1dJhNgCq2Nw
         C1VoOzXf43Mt1cViueh8dzcBDc+87aF8NwC6rEZOaqKTbw+Pl1rgnURnQx0CdYGDl+dv
         UoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682400682; x=1684992682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8Fcm9fo+FycljEkzjAB6zQ+6H48xCf7qyMfx7tBzoI=;
        b=W2HYSK4GFYDIL4Faxfy1rhKLrmO2bSoQt51zHjbdcMphW/2W98s9UoP3J4ngW0IY4h
         BHDeDE1PQ2k9ylSrVZBYiNCPQSToSgflmNKMAk5ldpvjJl1KhxwA36sNAPgJlngh3TIx
         DTCTZoxtF4wfqo2uqH7EaLr3WRqYSBIKfuf/725hdIl7K3E7yERYlHlHlckVIQ/rFt3R
         zwo+HMUvPAE1+q+zzZODfHhhPh4DMzZxIqOhXkfqmEPWPOSOHD6YMAowuYE8GOLT1AFv
         lR+Xe+b5r8dFRut7H/u9HhP2sxWcA3av/vZoeDciLK8rq5soEwkekNXL2shoybXLg/OI
         zQDg==
X-Gm-Message-State: AAQBX9cXvziCVPTBgzdb3rvIWOXLKVpYDuDHxz8nB2ADKEC7OXovycmj
        0r0HnLcWTHQA8HJ/E9Z8rr44b/WuL9c=
X-Google-Smtp-Source: AKy350YXX9O0d1f0HRH4SW4gyu88enpLmJLWmPdpRz99lHA9T1TZ7gBnMraeZGZ1lz/Z9lNtGrBFDQ==
X-Received: by 2002:ac2:4152:0:b0:4db:3927:e2bc with SMTP id c18-20020ac24152000000b004db3927e2bcmr3775209lfi.50.1682400681857;
        Mon, 24 Apr 2023 22:31:21 -0700 (PDT)
Received: from [192.168.1.111] (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id w15-20020ac254af000000b004ef2d38a319sm1643983lfk.254.2023.04.24.22.31.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 22:31:21 -0700 (PDT)
Message-ID: <9b95a754-cc73-9d96-049b-35e708cd2e86@gmail.com>
Date:   Tue, 25 Apr 2023 08:31:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id
 table
Content-Language: en-US, en-GB
To:     Mehdi Djait <mehdi.djait.k@gmail.com>, jic23@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
 <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/25/23 01:22, Mehdi Djait wrote:
> Add the missing i2c device id
> 
> Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Regarding the question (Jonathan asked in previous version) if this 
really is a fix - I am unsure if this can be of help when dealing with 
non OF-systems? (I don't have much of recent experience on those).

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

