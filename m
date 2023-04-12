Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6446DEFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjDLIxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjDLIxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:53:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB109EE0;
        Wed, 12 Apr 2023 01:52:49 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id o1so13770232lfc.2;
        Wed, 12 Apr 2023 01:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681289527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXq0HU8lCi/BIMagcmNxGekbvjRXC/+TN8IilpjxaEE=;
        b=Ik89hVehJpMRhE2IKvpJv9wwIENxCE1lQeIZtswEIPc4MnQX7KsXK6rLvykO2K0QGM
         qQeg3IbaPBo2RfOF4Pslgo9VFuWq6vOLCpqzmmWMqIA9eTmQYvdLTxdPrra3J6I4S72g
         xb383ttr+yZpSNYM+U0uCH5AwPlaWS67URNDdunwHTajz/ODjr2yakZoZn3wCJnhHpMG
         cx6LsZd1vq0QDqb3ilynwjzZAk2Co5Iws73RfcubKDkzJ1vSU6RhJP5rMtuNk6K/GnBa
         rt5Se0+jJQspNP+3RFXLcLx+5NMjf3Pp7BRYDYadMztfz6WkDOax8apI2ze0owX+Khia
         jEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681289527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXq0HU8lCi/BIMagcmNxGekbvjRXC/+TN8IilpjxaEE=;
        b=5g+2cJwXOdUWGjRs0yFljiWJQ0+BWMWP8ZJ8FPkup1/WsBRw+m6zU2RWNy1pH3UYhv
         C92i6KFPJTNUqsvbRWWuL436J/Vtk9SZHjZXq/28Xvb5XdpplrFydzMd290rGlRucPo+
         CBF32LaABAAeTZOuTrIRsN4SS53lIXDFZeCFRp8i+mtZ9LUOmFKdbVriG4riWy9prPAD
         ID4uP4t5poxZd/7r4IHdrp0hJmdRQsk4kNkOC10GOqUooj4A1qG5iopXZKHBCusmZJKc
         qkqMqC4tIgq/l47rd0zHr24VSFo057GwyAdzmNSW4+RyfodNyyNaIj6aJk+4p6yT+qKk
         Blxg==
X-Gm-Message-State: AAQBX9dhd48SvyppxHGUwTIY3/gDz9UTnwjfxWULv4CbKmDhEwht2udh
        Wle7dEEBki/eJPauh6BV4Bg=
X-Google-Smtp-Source: AKy350bVEh1gkZXeDtFzDXv/HAtej4XIRWQ9JKxNiC9S21HLe96yp1nuFVqXyR4ls7L/S04Qd3DWVQ==
X-Received: by 2002:ac2:5607:0:b0:4eb:43f5:738e with SMTP id v7-20020ac25607000000b004eb43f5738emr1519644lfd.60.1681289526910;
        Wed, 12 Apr 2023 01:52:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ec8de8ab3fsm983980lfq.132.2023.04.12.01.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:52:06 -0700 (PDT)
Message-ID: <c221d0b5-a142-8154-08a1-5947d037d864@gmail.com>
Date:   Wed, 12 Apr 2023 11:52:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/3] iio: add documentation for iio_chan_info_enum
Content-Language: en-US, en-GB
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andrea Merello <andrea.merello@iit.it>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1677331779.git.mazziesaccount@gmail.com>
 <884c8f386541ac572939b8993df7aea6ad99613b.1677331779.git.mazziesaccount@gmail.com>
 <20230408113029.35429440@jic23-huawei>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230408113029.35429440@jic23-huawei>
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

On 4/8/23 13:30, Jonathan Cameron wrote:
> On Sat, 25 Feb 2023 15:55:25 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> + * @IIO_CHAN_INFO_INT_TIME:	Integration time. Time during which the data is
>> + *				accumulated by the device.
> 
> Unit? (seconds I think).

Holy moly. Thanks for bringing this up now. I just checked this and the 
API doc indeed says clearly and loud the unit is in seconds. This means 
the BU27034 driver as well as the gain-time-scale helper does this 
wrong. I hope you can postpone sending them upstream until this gets 
fixed. I'll try to cook incremental patch on top of the iio/togreg - but 
I am not sure if I can do it today as I need to run after an hour... 
Sorry and thanks!

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

