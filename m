Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B4A632007
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiKULNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiKULN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:13:26 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4392EBEAD6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:08:54 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id i12so15444375wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pKFN/qhJLz7mgPB83k+rnOu0PmFMybHP5ytr4JLJaN8=;
        b=skMPVaZW7ILGeRoxtx30vONIGtauHppYucwUioLbzrs3ayNy+JmTsntWDg04dYoH3b
         HF8vhGPUTX5cDsFpMtgSFUhFOBoMcf+9IL9M4nYrI55ja55xbrhlRIFCs0Bsth+Ixa+S
         MppqtJMBoy+vP3MfNHzbCc/RdrLvbYwilyussbFkEAym0PFcj/mJZg78Ht8bNO+nXSc0
         gCrRT00Q6xFI70WgpViyj3jZT0m425ddYS8rPsJxTg5J5DbaoEnTDuqDsEQnKyZQPAtz
         SwKtNRl9PXTmXn1zd+TnoFzX2vVnQOGr/F8JYxIWXNV9csANcDjnnEAvyVKY92C44t5A
         Z3Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKFN/qhJLz7mgPB83k+rnOu0PmFMybHP5ytr4JLJaN8=;
        b=PxVSYiyV41XFkq2u0cnK6Ol5gsIxKWH7D36IFKvPg5cSQiYiRRq6eMekly2Qrzf8hh
         ZaCtPajkxzU9WdzcsvHWZFRxnQPkN+0zJTOQfk+C/mtGD355bzgXQixrzLJqZ/ywVHEU
         W4jdv37Rm0NJlIBgbx5khlQLvsal+M8g6J3FU/jG8dOSWtankU+jeLDSlbPndwW12Hpj
         YmaeW4bd6CHjBdsjdZgaUD4kiJOeZgaPdUc9F041Oac7Y2krxMTm5XMs+lQkgLu7NUYb
         Xm3bG+xjAUEOm0B9Qm0mZz0iQzYtdpqOYIif5FJ6sjHIqC/J8agpYoUZfgnpgpHQLUvb
         YtPw==
X-Gm-Message-State: ANoB5pknlQSlOrqhgnsWomLES45IHnFcWIqIg07FHGlEbBdAc9+M0x1W
        JoPrkxIuMCeCioeff7wrwUCJtg==
X-Google-Smtp-Source: AA0mqf40H/ICnbr6ZBWHaqtwbFiAylS7QqqSPNSiszc0FzLclW6Lm03Q48bJYma9B2JABx2G9q/GyQ==
X-Received: by 2002:a5d:5955:0:b0:241:553e:5040 with SMTP id e21-20020a5d5955000000b00241553e5040mr4154181wri.578.1669028927942;
        Mon, 21 Nov 2022 03:08:47 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c350800b003d005aab31asm13554055wmq.40.2022.11.21.03.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:08:47 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:08:45 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 590/606] backlight: lm3639: Convert to i2c's .probe_new()
Message-ID: <Y3tcPeajtfN/hCce@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-591-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-591-uwe@kleine-koenig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:24PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
