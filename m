Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D0D66B287
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjAOQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:22:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjAOQWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:22:45 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F245ECDC9;
        Sun, 15 Jan 2023 08:22:44 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id i5so3256313oih.11;
        Sun, 15 Jan 2023 08:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFEz1YP7mDc9kIKl/6A2QBgCrlrE/z2Z4ocdAtEZchg=;
        b=bEsHg3JCZix5DkhIkbp6nBcz3upD/6u3PSPteaCoEgjgQkh4JHm2tTL4dGezmc+6fj
         S+qW0/5zA3kD5RxOGHopVsB6K+UQrMxTZ714y6oPF+39nRq1AeiGirt6OlAM3oaHXxgO
         4RUEsKKS4gb43s/qHbRstmuvZXJxN6coQmgsrUIqPY8BTChIeweYrlMpUualrkqmJwHY
         6rw8RLAYFjGINuUwH/oVc+e9BEF6nFgr5YfLyE+tzis+Jpv1TaCuUFD/04/E2B3cbRne
         srr/ucfgPVIFxmrysf+3a0MrcejUiF7Zy4HCbdaPMgifdejCRNPiIw2Molwic7UEPC7G
         lq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vFEz1YP7mDc9kIKl/6A2QBgCrlrE/z2Z4ocdAtEZchg=;
        b=JUMB++Jfv+7gbYAO+bMbiSOaPk7rEcpxkG/+17CQjrqsuY2wZeClGHy8PTp8xeY1Ef
         girBDpubIURb6gp2vkf6Xn23KqfzQ4f2Hcy7N55aTdZudOyRbO6lLTi1oCVylM6UofIw
         c4q7h1BfrMu/Gcpu9j9PjCWPz6VYpAk9HGPyeo9aoAyoP6H6Rt/O/voca00GPdgQlTDN
         ahzjw8XaxwJVvvZgZw5AwFMTKsXN4ntFElfgInScvVALV/u8rDVwxaqDlz7AsCDprZLH
         YSDWr/8FvU0WQT2Ny+red7d8DKQUh+gQvIySryCfq0CanRdeKp1aW59HLZx1z2M8ldMo
         Tbig==
X-Gm-Message-State: AFqh2krp24GGbYoM3F4whg7+JiALFXXAsmkLVSi3hU4CzsbfGQTdzzQD
        Fg3dja60+oTu2SxrcjqJSbFV7MvwUv4=
X-Google-Smtp-Source: AMrXdXt2QAqDmJc0mKv8dTh6IJS40oBg8dcJJE57YisFcaKKAEnbGuvwpfT8xnm5bfC/4Nveovw59A==
X-Received: by 2002:a05:6808:1b06:b0:364:b2bb:8951 with SMTP id bx6-20020a0568081b0600b00364b2bb8951mr4586523oib.24.1673799764341;
        Sun, 15 Jan 2023 08:22:44 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 73-20020a9d04cf000000b00684a10970adsm8057801otm.16.2023.01.15.08.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:22:43 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:22:42 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] hwmon: (ftsteutates) Convert to
 devm_hwmon_device_register_with_info()
Message-ID: <20230115162242.GA1247464@roeck-us.net>
References: <20230105225107.58308-1-W_Armin@gmx.de>
 <20230105225107.58308-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105225107.58308-2-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:51:05PM +0100, Armin Wolf wrote:
> Convert driver to use devm_hwmon_device_register_with_info()
> to reduce module size by ~30%.
> 
> Tested on a Fujitsu DS3401-B1.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter
