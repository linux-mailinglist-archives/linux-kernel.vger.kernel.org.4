Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2812C5EE69F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiI1U1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 16:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233045AbiI1U1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 16:27:40 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BBA9C3E;
        Wed, 28 Sep 2022 13:27:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r6so4209709wru.8;
        Wed, 28 Sep 2022 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0vRKlOW+FXFARTH97TRXJzeeQ6P3wCzrkOoYdofwqpA=;
        b=dNSmY5zP7L+HWWgQiaS4oqn6KFLWdGYXjvasgcErm4UO3UxpnHFYsNTQDl8wQraAG1
         Tiixhr9g/gL8OfzGCBVtOYAmcdEeCVqRePTNZ0TaJYqZS6IGVM5sYDtTEwUy6gUkDFoz
         PzkMUOG0Kq0d3FvYAr5zjFct++yiy3QVdM27kv9CT1kGV93A+ZwLFZJNcch0Fc7j2LZu
         E58dQPUn2DxMRwxubsIWkHQahGyZJXwXnFnOk+qq88sq7Qj7yW9N/4O/LMg+qLigeSi6
         fbdJBF/9Eg+T9UcC7HyNGbgnNQAYvTrYBIlLVg1h9dhH9rAucbimcwND7Id/BBAo7jHf
         OtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0vRKlOW+FXFARTH97TRXJzeeQ6P3wCzrkOoYdofwqpA=;
        b=UCLj36M/igY+dDpZ0Mxjg9HaKE1Cp7DAXY+f93NfniuFpYCoYV5+AyCXwEvaeDFMiO
         fpdjURrpuSlpOCFA6yanWlOauigpUL2W7UPbRpiH1MCY1JdFfQ99tBxQGxf/lhL+cWQQ
         6UdGECVlce5BSNsAQn7VrGsBWVwHxobf6p1JKqGJuO5md2u1EoIXUVul9OL2W9UbWXNv
         OXxBRZu7qPLx3lziMLVkiJwoh45D9y87JCCdK8+3pN3sR5V3t1Iwzg5UkwQDiyLW7xVJ
         fzsVBCPIGbKAj47Q1XvHuXdR4JXarCxmICzTfJnMAjoFZUz4cCyPlnw0Hx6hwX6iYalK
         L3lg==
X-Gm-Message-State: ACrzQf3vMt2GfWoS/RQ5mbNFLJ9g67sug2ERqiv4boXnjIktl+37BWIX
        aWBGT/tm1ud/waFG8xLAGl8FbH4vXzuuUw==
X-Google-Smtp-Source: AMsMyM6cwUP4KZlO1qoPFnWMz5aXn9N8+rZ8OO9VsKJ52U25s/hA6ar/iy1yAWlQI3WtpfBNJjflJA==
X-Received: by 2002:adf:fb05:0:b0:228:6463:b15d with SMTP id c5-20020adffb05000000b002286463b15dmr22028235wrr.534.1664396856634;
        Wed, 28 Sep 2022 13:27:36 -0700 (PDT)
Received: from michael-VirtualBox (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.gmail.com with ESMTPSA id n16-20020adffe10000000b0022b014fb0b7sm4862879wrr.110.2022.09.28.13.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 13:27:36 -0700 (PDT)
Date:   Wed, 28 Sep 2022 23:27:34 +0300
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: Re: [PATCH v2 2/7] HID: ft260: improve i2c write performance
Message-ID: <YzSuNlP5LlvSdYYT@michael-VirtualBox>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
 <20220928144854.5580-3-michael.zaidman@gmail.com>
 <f9be53a647cd4b698ed820a70b67b7d4@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9be53a647cd4b698ed820a70b67b7d4@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 03:50:36PM +0000, David Laight wrote:
> From: Michael Zaidman
> > Sent: 28 September 2022 15:49
> > 
> > The patch improves i2c writing performance by about 30 percent by revising
> > the sleep time in the ft260_hid_output_report_check_status() in the
> > following ways:
> 
> Spinning in kernel for several milliseconds isn't friendly at all.
> 
> 	David
> 
We do not sleep if the estimated I2C transfer time is below 2 ms since the
first xfer check frequently takes about 1.5 ms on the real HW (i7-4790K @ 4.0GHz).
That means the condition is usually satisfied already on the first 1-3 checks,
as can be seen in example #1.

On the other hand, sending a large amount of data at a low I2C clock rate
saturates the internal FT260 buffer and causes hiccups in status readiness,
as shown in exemple #2. Aligning the status checking wait time to the worst
case significantly reduces the performance.  

Exemple #1

$ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S

  Fill block with increment via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  49823           73             256           16          16

[Sep28 21:40] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.005031] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.016531] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001710] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000227] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011805] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.000747] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000189] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014932] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.000806] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000223] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000178] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.010921] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.000704] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000181] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000228] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000182] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014243] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001220] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000143] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011332] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001533] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000183] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011865] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.000934] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000197] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014102] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001722] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000181] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014000] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.000845] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000172] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.013294] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001499] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000190] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.011524] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001238] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000291] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000182] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.013632] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.000967] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000184] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.013505] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001302] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000140] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.012673] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001147] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000140] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000217] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.012426] ft260_i2c_write: rep 0xd4 addr 0x51 off 0 len 18 wlen 18 flag 0x6 d[0] 0x0
[  +0.001172] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000192] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000192] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000184] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000211] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000193] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000194] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000197] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000175] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000226] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000132] ft260_xfer_status: bus_status 0x20, clock 100


Exemple #2

$ sudo ./i2cperf -f 2 -o 2 -s 128 -r 0-0x1ff 13 0x51 -S

  Fill block with increment via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  65553           86             512           4           128

[Sep28 22:04] ft260_i2c_write: rep 0xde addr 0x51 off 0 len 130 wlen 60 flag 0x2 d[0] 0x0
[  +0.005707] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000846] ft260_xfer_status: bus_status 0x20, clock 100
[  +0.000002] ft260_i2c_write: rep 0xde addr 0x51 off 60 len 70 wlen 60 flag 0x0 d[0] 0x0
[  +0.005155] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000245] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_write: rep 0xd2 addr 0x51 off 120 len 10 wlen 10 flag 0x4 d[0] 0x0
[  +0.001593] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.016725] ft260_i2c_write: rep 0xde addr 0x51 off 0 len 130 wlen 60 flag 0x2 d[0] 0x0
[  +0.005433] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000240] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000193] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_write: rep 0xde addr 0x51 off 60 len 70 wlen 60 flag 0x0 d[0] 0x0
[  +0.005547] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000185] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_write: rep 0xd2 addr 0x51 off 120 len 10 wlen 10 flag 0x4 d[0] 0x0
[  +0.001575] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000235] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000186] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000195] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000160] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014875] ft260_i2c_write: rep 0xde addr 0x51 off 0 len 130 wlen 60 flag 0x2 d[0] 0x1
[  +0.005596] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000230] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000188] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_write: rep 0xde addr 0x51 off 60 len 70 wlen 60 flag 0x0 d[0] 0x1
[  +0.005568] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000190] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000175] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000172] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_write: rep 0xd2 addr 0x51 off 120 len 10 wlen 10 flag 0x4 d[0] 0x1
[  +0.001287] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000226] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000176] ft260_xfer_status: bus_status 0x41, clock 100]
[  +0.000234] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000201] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000173] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000223] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000180] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000218] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000195] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000178] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000129] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000128] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000130] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.014159] ft260_i2c_write: rep 0xde addr 0x51 off 0 len 130 wlen 60 flag 0x2 d[0] 0x1
[  +0.005546] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000196] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000183] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000251] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000141] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000191] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000181] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000225] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000001] ft260_i2c_write: rep 0xde addr 0x51 off 60 len 70 wlen 60 flag 0x0 d[0] 0x1
[  +0.005693] ft260_hid_output_report_check_status: wait 4260 usec, len 64
[  +0.000180] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000227] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000151] ft260_xfer_status: bus_status 0x40, clock 100
[  +0.000002] ft260_i2c_write: rep 0xd2 addr 0x51 off 120 len 10 wlen 10 flag 0x4 d[0] 0x1
[  +0.001321] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000185] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000179] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000234] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000162] ft260_xfer_status: bus_status 0x41, clock 100
[  +0.000237] ft260_xfer_status: bus_status 0x40, clock 100



> > 
> > 1. Reduce the sleep time and start to poll earlier:
> > 
> >   Before:
> >     $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S
> > 
> >       Fill block with increment via i2ctransfer by chunks
> >       -------------------------------------------------------------------
> >       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
> >       -------------------------------------------------------------------
> >       40510           80             256           8           32
> > 
> >   After:
> >     $ sudo ./i2cperf -f 2 -o 2 -s 32 -r 0-0xff 13 0x51 -S
> > 
> >       Fill block with increment via i2ctransfer by chunks
> >       -------------------------------------------------------------------
> >       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
> >       -------------------------------------------------------------------
> >       52584           80             256           8           32
> > 
> > 2. Do not sleep when the calculated sleep time is below 2 ms:
> > 
> >   Before:
> >     $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S
> > 
> >       Fill block with increment via i2ctransfer by chunks
> >       -------------------------------------------------------------------
> >       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
> >       -------------------------------------------------------------------
> >       26707           73             256           16          16
> > 
> >   After:
> >     $ sudo ./i2cperf -f 2 -o 2 -s 16 -r 0-0xff 13 0x51 -S
> > 
> >       Fill block with increment via i2ctransfer by chunks
> >       -------------------------------------------------------------------
> >       data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
> >       -------------------------------------------------------------------
> >       37034           73             256           16          16
> > 
> > Link to the i2cperf - https://github.com/MichaelZaidman/i2cperf
> > 
> > Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
> > Tested-by: Guillaume Champagne <champagne.guillaume.c@gmail.com>
> > ---
> >  drivers/hid/hid-ft260.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> > index a35201d68b15..44106cadd746 100644
> > --- a/drivers/hid/hid-ft260.c
> > +++ b/drivers/hid/hid-ft260.c
> > @@ -345,7 +345,7 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
> >  static int ft260_hid_output_report_check_status(struct ft260_device *dev,
> >  						u8 *data, int len)
> >  {
> > -	int ret, usec, try = 3;
> > +	int ret, usec, try = 100;
> >  	struct hid_device *hdev = dev->hdev;
> > 
> >  	ret = ft260_hid_output_report(hdev, data, len);
> > @@ -356,10 +356,14 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
> >  		return ret;
> >  	}
> > 
> > -	/* transfer time = 1 / clock(KHz) * 10 bits * bytes */
> > -	usec = 10000 / dev->clock * len;
> > -	usleep_range(usec, usec + 100);
> > -	ft260_dbg("wait %d usec, len %d\n", usec, len);
> > +	/* transfer time = 1 / clock(KHz) * 9 bits * bytes */
> > +	usec = len * 9000 / dev->clock;
> > +	if (usec > 2000) {
> > +		usec -= 1500;
> > +		usleep_range(usec, usec + 100);
> > +		ft260_dbg("wait %d usec, len %d\n", usec, len);
> > +	}
> > +
> >  	do {
> >  		ret = ft260_xfer_status(dev);
> >  		if (ret != -EAGAIN)
> > --
> > 2.34.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
> 
