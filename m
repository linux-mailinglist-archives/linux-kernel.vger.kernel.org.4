Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79976C3269
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjCUNRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCUNRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:17:00 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC320CA1F;
        Tue, 21 Mar 2023 06:16:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn12so13876210edb.4;
        Tue, 21 Mar 2023 06:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679404617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGs2L7TUufPEiW2cOEV1fX2OGI/z2TE1t9eAbcIQHio=;
        b=aqNU+o7Kb7MilPuZNPms+rmjH/asbucVAlNeCMVqvFUUgapdKSTwHHoZGbmPOsb+Tq
         rn2FmkrgT09+xvKQHPC49sLLRhHRzpuidLOQd+dsUiZfooDDCrH2PpCmr4zjRDsWQZ/y
         B5dymsOBQJ5HfCpFRi3zrcbMJbBLlQQ7MhEGCDfsq50rwfvgVjl7BE9ujVrkZdwsTbCj
         X6oAMsUpYiC8JGqZQyTi1dax6vC11C/+I3YY4zioM6UGk5UCyKXn6mvCvIq4sgqSAV8u
         Y7FOqhruWGIUrzsuNKR7VOkT6U0PMsUsT45MKI9wFgsZs0cD32ItJJQjm/MIbus91OQN
         6uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGs2L7TUufPEiW2cOEV1fX2OGI/z2TE1t9eAbcIQHio=;
        b=Qn/rEZvctdeq0XBJFOEQA1Hwo51BJJMSww2wrj721lYsbfvHOpy7u8x6uJeiYTKYvR
         3uliRiMJaT1kSlifsW+MYZISLzhZsVYzH8ggEl7sHUwHqNJQCWrJG+//EEPAz9odXpTc
         6Vf9rmuBNdqN54v5bQs7faHYb2j58uIJ93f6WZmU+WQpt9yl6b0VTP3Hnbe2QK+xD41W
         eO0isz11O/GhPPHaHIUZtKNRjyeZB7XiWFO2Uw6MxYN+pkAkS0IqS98/IVxyRH6p9X18
         jGTlo0NO/O9AVvk2PICW5anIYOlHNkpLrg2Y09fqn68RSYsnEulvkHsX1Z0xTs6kWuwu
         NAlg==
X-Gm-Message-State: AO0yUKXl4ppO8s8rMLfy60pNlzmY3UBoVWyNME0u6elG6RJ6PuWtbMRA
        +LPc2yh0C6FVkbPWpUhzbjU=
X-Google-Smtp-Source: AK7set+yIdRqDG678Ifl6jwcggC1fXUYOXsQl/MS+F665QSqZOZaTqelQ5fuvsegGpbpFCwTpuvSzA==
X-Received: by 2002:aa7:d913:0:b0:4fa:39a6:af25 with SMTP id a19-20020aa7d913000000b004fa39a6af25mr3207856edr.16.1679404617148;
        Tue, 21 Mar 2023 06:16:57 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id i28-20020a50871c000000b004fd204d180dsm6245947edb.64.2023.03.21.06.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 06:16:56 -0700 (PDT)
Date:   Tue, 21 Mar 2023 14:16:54 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Message-ID: <ZBmuRqjDH9rTtiVy@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <00babd12-0ab7-de2a-857b-a58a0948b85c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00babd12-0ab7-de2a-857b-a58a0948b85c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matti,

On Sun, Mar 19, 2023 at 09:43:19AM +0200, Matti Vaittinen wrote:
> Hi Mehdi,
> 
> Things have been piling up for me during last two weeks... I will do proper
> review during next week.
> 
> On 3/17/23 01:48, Mehdi Djait wrote:
> > KX132 accelerometer is a sensor which:
> > 	- supports G-ranges of (+/-) 2, 4, 8, and 16G
> > 	- can be connected to I2C or SPI
> > 	- has internal HW FIFO buffer
> > 	- supports various ODRs (output data rates)
> > 
> > The KX132 accelerometer is very similair to the KX022A.
> > One key difference is number of bits to report the number of data bytes that
> > have been stored in the sample buffer: 8 bits for KX022A vs 10 bits for KX132.
> 
> The KX022A has 16bits of data in HiRes mode. This is the default for kx022a
> driver.

I am talking here about "Buffer Sample Level number of bits": kx022a uses
8 bits: just BUF_STATUS_1 to report the status of the buffer. kx132 uses
BUF_STATUS_1 and the Bit0, Bit1 of BUF_STATUS_2. 

That's the reason for adding the kx022a_get_fifo_bytes function. 

> 
> > A complete list of differences is listed in [1]
> > 
> > 
> > [1] https://kionixfs.azureedge.net/en/document/AN112-Transitioning-to-KX132-1211-Accelerometer.pdf1
> 
> This document is somewhat misleading. It does not contain KX022A but the
> older KX022. Kionix has the somewhat confusing habit of having very similar
> names for models with - occasionally significant - differences. (My own
> opinion).

Yes, I am aware that it does not contain KX022A, but from my
understanding of your code, the document can be used to highlight the 
difference I mentioned

> 
> I the "Technical referene manual" is more interesting document than the
> data-sheet:
> 
> https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> 
> I have heard that there have been a few very different versions of KX132 as
> well. Not sure if they have "leaked" out to public though. In any case, for
> the kx132 it might be safest to use the full model name - especially in the
> DT compatibles.
> 

I will change it to kx132-1211

> Finally, AFAIK the key "thing" in KX132 is the "ADP" (Advanced Data Path)
> feature which allows filtering the data "in sensor". Unfortunately, I am not
> really familiar with this feature. Do you think this is something that might
> get configured only once at start-up depending on the purpose of the board?
> If yes, this might be something that will end-up having properties in
> device-tree. If yes, then it might be a good idea to have own binding doc
> for KX132. Currently it seems Ok to have them in the same binding doc
> though.
> 

Correct me if I am wrong: the Devicetree is a description of the
hardware and the transitioning document states:

"From a hardware perspective, all these sensors
have an identical pad/pin layouts and identical pin functionality"

I was thinking about adding an advanced_data_path boolean to the chip_info 
struct and providing different driver callbacks depending on the value.

Something like in the bmc150-accel-core: iio_info for bmc150_accel_info
and iio_info for bmc150_accel_info_fifo

--
Kind Regards
Mehdi Djait
