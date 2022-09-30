Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7325F10E0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 19:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiI3Rax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 13:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiI3RaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 13:30:21 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80ECC77DD;
        Fri, 30 Sep 2022 10:30:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p5so5482701ljc.13;
        Fri, 30 Sep 2022 10:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=y3ldtOTPE4r5odoH0+tTaflEwixWUb/0F7j9EagJulU=;
        b=R9XqN/5CgHjv85wlJMJb1mshI6f6474mxDwiMmNEUo2an4lbvQ0zUTEHchwfVW3O38
         SfUGECAfFzMeiPePod6xKEF1u8NzrbCSUZI0uA816Vsr+264sfbGxmuacxe7KGLVPgmH
         mYoiO0mzWFna5SVOOiQHFBu/8tN4Byos61jg9D0eiITmecZ9SZhGzQ/oeihf6UpDhIR6
         ooeN/RgP2s6AjN73Qs891g28DFyRgo5Zm1qhVJmt3WYW679SNReFtEGqdVeUE9UVFLQW
         pvAMtJTt2yXYAezLeHPuU0N1PxWRE7gKJ2hldntTRBoj1RS6zlajfHwK+cU1y84Ye7BF
         tISQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:content-language
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y3ldtOTPE4r5odoH0+tTaflEwixWUb/0F7j9EagJulU=;
        b=XJQIcMWmizk4tbRhPm/lN7riiT6R4FaC9DRAFHOyG2d+MDaRcgMkeCnHgUAkQJWN8c
         3DOmedGH+Grv0uVusq6krz21htyjuw/gb7gcfu8Nn8FqFlYGCP6zDTIZzy3LNl6rId+B
         sw/qJrKCooXIx6ofScBjhhSJq/g9H8qx5OnXBcUWwZAy5nebEv5PwihWcuGE55VthHyH
         DaFCWUMdrWzqpLd0AGKSjzXCV3Uha9bpiuOBF3TcIg+ZhHpOt2mtdDr090kES35vqxkP
         dKZTHPVESRNlVzy/wPX7aAUwMREGp5qcDEwNrDes/U7AhVrtUjQFPYwHQ0TeHh7cgz3M
         n1Cw==
X-Gm-Message-State: ACrzQf17dmmGrpPbvaRXDFnoPwve4HcsKebqNBY8FGDSiMXn9Lk1fBBb
        RrQsGr48AK0sPwSeRSLsiN9kUrzi134=
X-Google-Smtp-Source: AMsMyM77+DIeooxXytl4jtyCbXyZIpZrVPy8CSkX0rd5YOYHquHrAwTFR7RRc44FEuPP2DabYn3kPw==
X-Received: by 2002:a2e:7e0a:0:b0:26c:5aec:f849 with SMTP id z10-20020a2e7e0a000000b0026c5aecf849mr3429140ljc.296.1664559013131;
        Fri, 30 Sep 2022 10:30:13 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm347761lfq.287.2022.09.30.10.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 10:30:12 -0700 (PDT)
Message-ID: <7921d7e8-09c8-dd68-8c0d-aef33e4ecbd1@gmail.com>
Date:   Fri, 30 Sep 2022 20:30:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
To:     kernel test robot <lkp@intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     kbuild-all@lists.01.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mihail Chindris <mihail.chindris@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <876c338d0ae33a474a3ff95d4350d45bd4779066.1664534676.git.mazziesaccount@gmail.com>
 <202209302235.hHrSjkSb-lkp@intel.com>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH 2/2] iio: Fix unsafe buffer attributes
In-Reply-To: <202209302235.hHrSjkSb-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps,

On 9/30/22 17:17, kernel test robot wrote:
> Hi Matti,
> 
> I love your patch! Yet something to improve:

Ouch.

I overlooked the fact that the buffer was also used by iio-dmaengine 
(which I had not configured to be compiled). Also the 
cros_ec_sensors_core.c evaded my grep.

Changing these to use iio_dev_attrs as well seems trivial - but I am 
afraid there may be other culprits if the pointers to those buffer 
attributes are memcpy()-ed somewhere else as well... (The attribute wrap 
function did this).

I will include cros_ec_sensors_core.c and industrialio-dmaengine.c 
changes and re-spin the series - but I guess I need to add [RFT] here...

Best regards
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

