Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBBE5EA2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 13:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237493AbiIZLMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbiIZLLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 07:11:16 -0400
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F264333E;
        Mon, 26 Sep 2022 03:35:24 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a14so6879740ljj.8;
        Mon, 26 Sep 2022 03:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=CUyy93fVWZiZBeHDU8yZwsYToR2inVd+vCWQtJE+jak=;
        b=Ojr9bKEyXSZ73KrB5cZzFDeH/ffP8PKSqHhrgt/se5yA3QCCeURStYLcNLSRiap7Yb
         96tFUYk28OgmUOR6qLy9UqlhpaSbiIreANSMfGPehSVRN0n7lew4eLBKpDV7McG8WpR2
         bBzHCd1+/0MEvjoLtwpWji2VArs+RbJijFUthbA0CR7JXMIJTcjWGu5O9/Q746/YpXak
         0g9goUG0yms1D7JTu75k1HAKLSM+gUW8awnOXJHXhHNlQzv6hSE5D4my5Yllwx+QhFZy
         Nph7JXrHdur+tpaj39lTV18CqOfgj6NfMx7pKG6zqzBPcEySvaXNfbydTLV42EclHQ3D
         Ac3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=CUyy93fVWZiZBeHDU8yZwsYToR2inVd+vCWQtJE+jak=;
        b=wc07T5KmD9l+qxiUNgFA9EBT5Sp7z5obl3pE4QJ3jrPCA1ee4my/orkJy+Mc5QXu2z
         veQSW1Ey9euuVGgURQamPQHl/R88IeZjYo48NAvq4de1BLpirXd7AdUcDG3cCvrXj0m5
         23r+HC2iR//4WKkspqj3JIIKWVw4hpRC1+sdwmyC/jvOPl6gl/6rT+JZtprykBgbkH31
         Qq12GWOSyu8Lx0mDUoLgQsAfQQlYLRr6yJ2JUS9sc3PnoglVwQ6EvpMq+Jze/6FW3s6v
         MnkvV3MUUj7rESUHFX+RVDFPOXG73Htuxj2fD1QvbzsaXTOQxRlx/APaSoCiAQf9I4XW
         DQCQ==
X-Gm-Message-State: ACrzQf21FdXBo2lzO5P8ZsnhHtX11/Mvik1A+yf6U2qNEiiikvbNOuH6
        MyT7gBEv+c+OQFL4oxtri1k=
X-Google-Smtp-Source: AMsMyM6twWJMns9Nj6O92abQQVYJrbXEAItYa+Af6NmgyGjiQ+iLyM5o8aiyb3vhInxeCAQCjbpIlw==
X-Received: by 2002:a2e:1458:0:b0:26c:3b83:e039 with SMTP id 24-20020a2e1458000000b0026c3b83e039mr7832436lju.484.1664188123948;
        Mon, 26 Sep 2022 03:28:43 -0700 (PDT)
Received: from [172.16.196.5] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id z13-20020a05651c11cd00b0026a92616cd2sm2343887ljo.35.2022.09.26.03.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 03:28:43 -0700 (PDT)
Message-ID: <c2aeab83-7bd8-a1b2-5dfa-4e99f2250aeb@gmail.com>
Date:   Mon, 26 Sep 2022 13:28:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Content-Language: en-US
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Mihail Chindris <mihail.chindris@analog.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: bmc150-accel-core: potential timestamp calculation issue.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps!

I selected you as a recipient purely based on get_maintainer.pl. Please 
drop me a note if the bmc150-accel-core.c does not feel like your 
playground and I'll drop you from the CC if I send further mails for 
this topic. Sorry in advance.

I was ruthlessly copying timestamp logic from the bmc150-accel-core.c 
for my accelerometer driver. I noticed there may be a problem if FIFO is 
not read empty:

The code computes time between two samples by

...
          *
          * To avoid this issue we compute the actual sample period 
ourselves
          * based on the timestamp delta between the last two flush 
operations.
          */
         sample_period = (data->timestamp - data->old_timestamp);
         do_div(sample_period, count);
         tstamp = data->timestamp - (count - 1) * sample_period;

Here the "count" is amount of samples bmc-150 reports there is in fifo.

As far as I understand, this works only if the old_timestamp match the 
time when first sample in FIFO has been captured. This is true if the 
previous 'flush' (where the old_timestamp is stored) has emptied the 
FIFO - but as far as I understand the IIO does not guarantee the flush 
reading all samples there are in the FIFO.

If the flush leaves - say 10 samples in FIFO, then at the next flush 
there old_timestamp will be time when FIFO was previously flushed, but 
this time does not match the first sample in FIFO, but the 6.th. Let's 
say the sensor has collected 10 new samples between the flushes. This 
would mean there is now 10 new and 5 old samples in FIFO, totaling 15 
samples. Yet, the time difference computed by

sample_period = (data->timestamp - data->old_timestamp);

will reflect time between flushes - which means time of 10 samples. The 
division which should compute time between two samples:

do_div(sample_period, count);

will now use incorrect amount of samples (10 + 6) and the sample period 
will be too small. (Or is there something I don't quite understand).

I added following piece of code in the driver I am developing:

        if (samples && count > samples) {
                 /*
                  * Here we leave some old samples to the buffer. We need to
                  * adjust the timestamp to match the first sample in 
the buffer
                  * or we will miscalculate the sample_period at next round.
                  */
                 data->timestamp -= (count - samples) * sample_period;
                 count = samples;
         }

I can send this as a patch also to the bmc150-accel-core.c - but I'd 
prefer someone who is familiar with this IC to verify my finding and 
suggested fix :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
