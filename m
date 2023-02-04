Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E7468A75C
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 01:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjBDAzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 19:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjBDAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 19:55:50 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2CA8412;
        Fri,  3 Feb 2023 16:55:49 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id g9so4907266pfo.5;
        Fri, 03 Feb 2023 16:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tBc9PufF8yq8ecca1vaKiSKt5NvyuWhFBAD5g9wxTs4=;
        b=oROydJaZs8C+A2H0sxl0UplPKkfv4lIJFC9ZjmAFyTVvBXA+Zh/LOm0U8Q7tZDJboY
         5EwrPnhtlSbFN/6xm+MTV1kEt4RzuiLeYxOEKB5oaebbIm9NNEqIGMUdq9qVm2+HMcig
         2U4EKvGmp1prAqalJifKWr+YMdKMNHZgd5Lnc9Q5G6g7dw51oox5VKQGXshBoHJalTCf
         8/UTcFE0m898qF3CcTTzlb7DERjRQTQau2UfE8KuznQ6uv9p9CC2YHGKgsx2XnJFz/2K
         doHbuoTdV+qMVPx1hRucrvx7Zyo9+ENCrfbBpGgVxFFM700BqNyCq38SOeAJh7BVDlCI
         8sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBc9PufF8yq8ecca1vaKiSKt5NvyuWhFBAD5g9wxTs4=;
        b=BWBTCQ5rC6nu29Dg/81FXVMLgG6NdsF2YvSRx7J+mF8J0mR7PXtBvXHqU8ATXYxbf9
         cCsQ1NPT1sINwG2Tf0Zu/jSxcX5w5BVqsF4fDAt/lhHPE6DNsS43sFhWoUzKJSupIhXv
         4sBcs1UtpyKyeAZluWzlwZfQPa39NtQYALpCl1wsxZJplLAz6LaPdlfBfCANY8x7wqXc
         Brr/nFuyem9ERj3GUDtJ59CqScpkf9BDLAlMasbr+2ucu2fcuthJWrM0Kl4IZVmWayOV
         p64aQbB3E6dT/A3IwvvphvVISxxpqgX3CYy4sndRsn1iAdHZfTpKmEHJ0oELcUHQYgE5
         mkQw==
X-Gm-Message-State: AO0yUKUtG9Sj+hN//X6XJUNU3C5REvn+UXV6k5pyO3GF3Zm5SyZAQ7hI
        f2gX76hgSYRpqsdRDoqLJEITDHuOPus=
X-Google-Smtp-Source: AK7set8P8LeW9nlAt+mi0Vby+KQeB3+RvrcSxSiaRkAN7ElaNBtrKWorMeETB9RSFMmKIv8Zh6HorQ==
X-Received: by 2002:a05:6a00:882:b0:593:908c:240 with SMTP id q2-20020a056a00088200b00593908c0240mr15989207pfj.14.1675472148465;
        Fri, 03 Feb 2023 16:55:48 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5a16:81a3:86ec:ceb2])
        by smtp.gmail.com with ESMTPSA id 194-20020a6219cb000000b0058bc37f3d13sm2451808pfz.43.2023.02.03.16.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 16:55:47 -0800 (PST)
Date:   Fri, 3 Feb 2023 16:55:44 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     linux-input@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4: Fix SPI device ID
Message-ID: <Y92tEG1UBrOJnS93@google.com>
References: <20221219133717.1638496-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219133717.1638496-1-rayyan@ansari.sh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:37:15PM +0000, Rayyan Ansari wrote:
> Currently, the ID being set to "rmi4_spi" causes this warning:
> "SPI driver rmi4_spi has no spi_device_id for syna,rmi4-spi"
> 
> Change the ID to rmi4-spi to stop this warning.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>

Applied, thank you.

-- 
Dmitry
