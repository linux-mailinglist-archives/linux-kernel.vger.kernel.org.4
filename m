Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91552632012
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiKULO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiKULO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:14:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3B7B4F16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:09:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i12so15447753wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DnxhI2K7v7qSJ3sei2vOI6evZb4ItU20SUWGl/JrUF8=;
        b=q+btIZnN7fy5J2xJ9mJzj7EjnGonxfALuWx62cKq/iaekn3WWksEUvaL7oLiCn9x2I
         v792N8rZUV9546bvPIfp/ukOKFLDbRcx5JQaGcQaD5PRvU9aZydTw8lWFfxaCZDWUkeB
         6u7gyHQt5wJGpBoqA4lePWbcVPqPU5agMXPV126jkXRoyHojYOv5aTRfkNYb5IGm448E
         cJ7DikilGO47coKGCONOwrT71/XRZLx9rrZf2Ja/t7dVLkn2OA7KvgPRYrRnhqMEFbWT
         bUxw288qvNy8sp+qY5UwtP7j61eeQ2QmMU+VFXm/pz0JMo85OLg2UdJoDOk7wBGouOfc
         +IOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DnxhI2K7v7qSJ3sei2vOI6evZb4ItU20SUWGl/JrUF8=;
        b=ELs5L+0BEbBHm9r5WNNGtDYDyeQFHFYYcfxjJP34jo8nsJST+Jrz+VzUvRDsPw2Qcb
         cG6BzdONCrvNYA0DZ3mDDMfosKCFTxMf6Su1j1jB7H+OB0uUbyG8rpTtjPJdjN5NjBmz
         bLUvI9Z/lSBsRHUe/RnId9Hwb7kRGoHhM18T0N5ko+EV6v5lNdj3GqP28lgQx7UINycT
         s/5L9Nylv7EOQSsVl6uRG2r0QNSrNUJivcKhJrA07ir2EirMXTHqMFb0iRgghjNOfVRi
         jYdaLkdtzJqQzj2fu64g3D+39UHcGAxQcRy6dsd3/Yv8ssubLXkCSHStkecPXmvXHPDT
         mD2g==
X-Gm-Message-State: ANoB5plIN6psqXX9/ZpIjeozRPvG+lWDHqNU/2TyRfx1x/O/eyE4bq+6
        5HvzRfmnTyEzHDmtVRyfdYglHw==
X-Google-Smtp-Source: AA0mqf5w+ji8vVQVFaaNoYdKQv16v0TqzZgCN32rFI32gp0Hh6iCyQ+D0Qy72UOYWXd+3t7vLQumgA==
X-Received: by 2002:a5d:458c:0:b0:241:d40a:bb50 with SMTP id p12-20020a5d458c000000b00241d40abb50mr2169169wrq.39.1669028979525;
        Mon, 21 Nov 2022 03:09:39 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c1-20020a5d4cc1000000b002365b759b65sm10913763wrt.86.2022.11.21.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:09:38 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:09:37 +0000
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
Subject: Re: [PATCH 591/606] backlight: lp855x: Convert to i2c's .probe_new()
Message-ID: <Y3tccSZrm+DRVA24@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-592-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-592-uwe@kleine-koenig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:25PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
