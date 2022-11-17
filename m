Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF22A62DCFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240176AbiKQNkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiKQNkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:40:14 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6C4742DB;
        Thu, 17 Nov 2022 05:40:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id i10so5111968ejg.6;
        Thu, 17 Nov 2022 05:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=dOA/XrnM55biePtmSgVQuz/vvaK7Pp/nrxDlHicjXLw=;
        b=b55P44Wa551fN/B8v9btv1bZewuklhAEgqDACB3G4DxO/3tSA+sMxdYw79PP7i80z5
         /sVk8z6Z/ARHsSepF2anN36AOd8gexjbGfhK26rciQbxdkKhb9vn8KyzriTRPVB2kMEM
         BHxe73XSue/R/bzTj2piXsRdJ5SgLqwV+E9Pwc/C5gHFgqdc1qJYwmqN7865ePorvG4M
         RDTmId2tnAr4IBFbw3VlRu9cYDr1GiOL16dxTuDfxgz2dLoLoThE0kNwsv+kdenLKzsY
         EH7hxIxJOu4fvN045NCztwjhhpGrImBWX5L/cRK2m6N45tm3ZYG/rqVRO252aDUQcpyQ
         gzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOA/XrnM55biePtmSgVQuz/vvaK7Pp/nrxDlHicjXLw=;
        b=A/+2AkMG1eOm6Ay9p+vBKYHA7fxZFjRxaYwyZ2yhE2e7mV2TmnsYbqhqRoU931bCFK
         m96min/p4UGtJFQFJwXLRwGtGeLfJVVmeQFuMqoGmseOzbzwt668pNZaRNK2Va27HHyk
         6O6206K3o3NUFIKyem9uenQopZp6zq8tR9QlfP7G4I3uxymked1GRJtGU1NlP1HEh5hk
         pxqOZb1k/XNeHyILnMyHMxPJirNGPpsltgkBTdgypnWSOcuLuExG4no8IksZEBH+261Z
         j2bm2IVm7hqQXbKH+s/7OnEHQ1UzzM+hQ2/JoM5aDovgETnwcurULS+r7RwN3usHqLR1
         JnWg==
X-Gm-Message-State: ANoB5pmvc/2B4eFHEUxxzCVCNdwLE5lfTDNCaoszlw5C+hCNZ+rmv0PZ
        mvnoyy0g9u8Cvw3YPaOFSYs=
X-Google-Smtp-Source: AA0mqf6BksfbC9nZboB5WTuEjWop9CJaYyFiqnM/7Bx6amuVd+tme9UjR6NShhiXVh2I+/3cyukngA==
X-Received: by 2002:a17:907:767a:b0:7ad:e518:13fd with SMTP id kk26-20020a170907767a00b007ade51813fdmr2155160ejc.323.1668692407595;
        Thu, 17 Nov 2022 05:40:07 -0800 (PST)
Received: from ?IPV6:2a0e:41a:894f:0:7a60:27eb:954c:5ab1? ([2a0e:41a:894f:0:7a60:27eb:954c:5ab1])
        by smtp.gmail.com with ESMTPSA id bw10-20020a170906c1ca00b0078dce9984afsm373454ejb.220.2022.11.17.05.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 05:40:06 -0800 (PST)
Sender: Carlo Caione <carlo.caione@gmail.com>
From:   Carlo Caione <carlo@caione.org>
X-Google-Original-From: Carlo Caione <ccaione@baylibre.com>
Message-ID: <cd2d4d1e-f42a-da5b-e498-fbb32f792094@baylibre.com>
Date:   Thu, 17 Nov 2022 14:40:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] drm/tiny: ili9486: Do not assume 8-bit only SPI
 controllers
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20221116-s905x_spi_ili9486-v1-0-630401cb62d5@baylibre.com>
 <20221116-s905x_spi_ili9486-v1-2-630401cb62d5@baylibre.com>
 <Y3YWdeTLfmDh7UyB@sirena.org.uk>
In-Reply-To: <Y3YWdeTLfmDh7UyB@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 12:09, Mark Brown wrote:

> I don't understand what the commit log is saying here.  The 
> meson-spicc driver advertises support for 8 bit words, if the driver 
> is sending data formatted as a byte stream everything should be fine.
> It may be that there is some optimisation available from taking 
> advantage of the hardware's ability to handle larger word sizes but 
> there should be no data corruption issue.


There is no data corruption but the 16-bit pixel data have per-pixel
bytes swapped: for example 0x55AD is sent instead of 0xAD55 and this is
causing the wrong color to be displayed on the panel.

The problem is that the current code is sending data with an hardcoded
bpw == 8 whether the data is swapped or not before the sending.

For 8-bit only controllers the data is swapped by the MIPI DBI code but
this is not true for controllers supporting 16-bit as well, but in both
cases we are sending the data out the same way with an 8 bpw.

So the same image is basically displayed differently whether the SPI
controller supports 16 bpw or not. I'm trying to fix this by sending
data with 16-bit bpw when the controller is supporting that.

Please note that this is what it is done also by mipi_dbi_typec3_command().


>> +	/* +	 * Check whether pixel data bytes needs to be swapped or not
>> +	 */ +	if (*cmd == MIPI_DCS_WRITE_MEMORY_START && 
>> !mipi->swap_bytes) +		bpw = 16; +
> 
> You should check the SPI controller compatibility here.

This is already done in mipi_dbi_spi_init() by using spi_is_bpw_supported().

Cheers,

--
Carlo Caione
