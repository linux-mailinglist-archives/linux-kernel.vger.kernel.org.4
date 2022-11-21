Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC56631F08
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKULFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKULFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:05:17 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626E522297
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:05:16 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id z4so4700554wrr.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YaIiikUQITopaZC738kqFEHiw7e57otc7id5Rv4UvzI=;
        b=WJJXwuLReaJtwxy6Bw0sm6p1bzQ1AKkXHJY45SLeDgJCMCJxYJz+YpCRh9F0Co8fwf
         Lc6+dtsYDgb9qBmZShzVW6y22UH4rn3Z5JVYnmiCnd/BM/yW0sU6UsI7iO9TeCpKblH4
         sF0lfkkQoEdKBtNzl5E+Sw0+rvHG8rUVKMkIiQfm4NN7Bu+r/Y2KHiEorQ8TELQY5m+U
         /JrGQOQpnpru26SjhwDnu/MtJrWDziYQJc22N/T/PjW9enYvVPdPyCNBU5DhHRKnxTg8
         ueT0OXpQry4mmuQdCkZ9VVKpjapYhr6lnhfqucd5odf/pyIUTQykKgyP/SIARr7yD0aH
         eMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaIiikUQITopaZC738kqFEHiw7e57otc7id5Rv4UvzI=;
        b=dDz35Us1L4jDq+YcDJ+Ru18iGLG35azSgqotJc0OD4BfhdC+tkh8A122AQdGjqUJLn
         jem4bpcIDmKuTvVqQJMJh5CXXP0N05nRA2cXL5lLVZI+hRJ39rI7RtJttEy8gYDjpSAT
         Opgtx6ZESFqcdw0h3XwDziu0ovT6fICd+DX85yOq9og6w054wqnuDMfE/jW8qfdlLeki
         n192vSifSJe6HopppbgcB9k1uCOq79Mfo5Q23bxmhmgqFxjy+o2jP0xP1yGFGlJHOHyh
         Q4n7gTuA1T4poAiy/kiuCh3Gifw//oE/bxji/lra/Dr2CoAIa6jh6XL03IBqiYExptMO
         MXwA==
X-Gm-Message-State: ANoB5pl+QazgYHYpcc16y4R0F3mdM7DdNYMXAkaamyDoC8E/66mhso5z
        S1fP/aNVwXv0VAi5dUNER1ErHQ==
X-Google-Smtp-Source: AA0mqf4D21+0QnufM39rLE0tMSVRA8jM5QGBO8Vgd4xHGkTH7YG4WUn7z7t7CB/SUqdrQDVuVtK7lw==
X-Received: by 2002:adf:e303:0:b0:22e:3c66:bda1 with SMTP id b3-20020adfe303000000b0022e3c66bda1mr2066072wrj.139.1669028714799;
        Mon, 21 Nov 2022 03:05:14 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id n27-20020a05600c3b9b00b003cfa81e2eb4sm14716314wms.38.2022.11.21.03.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:05:14 -0800 (PST)
Date:   Mon, 21 Nov 2022 11:05:11 +0000
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
Subject: Re: [PATCH 588/606] backlight: bd6107: Convert to i2c's .probe_new()
Message-ID: <Y3tbZ2VN/vtVYLn3@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-589-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-589-uwe@kleine-koenig.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:22PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
