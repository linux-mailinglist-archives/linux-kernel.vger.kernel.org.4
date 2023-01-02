Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4101365B457
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjABPj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:39:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjABPjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:39:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEF3C0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:39:53 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id w1so14474807wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yMroW05oFhzknL98EQCsQ+SYSzTJ+LrSISoJgrOG1c4=;
        b=z6lnklFSzA0EUtdobeGYXiDOCKMR83l8jJ5DsNGAUKi0waNzUooYubwdcTs3pe5VVB
         9wGgFoHpBJXkvb9uCDCtHuhnqyYYQ1UXWu7zgGQMn4ki2w212Iz9sPYRJy/8tbD4h5Zc
         0Fq0NEgUwH0WA2H5bBzCS4BkvR4+3F5lgSbtoirwyuhuFeLJCLjhFHagaITMSHi5LN0G
         K69E+HsNzg0S28aO7qdYPIbL9+4Kz3w7ZCvsdzzovupAZWp7si7RhlBH4U598c41myEh
         WIXx2CsE6cZWP42xWUFNN/L6zU1to+73+sbv/Z0xVTu88f68x6iu7R79GSAvdrCnBXEc
         hnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMroW05oFhzknL98EQCsQ+SYSzTJ+LrSISoJgrOG1c4=;
        b=ImCSxUwtGNEY2VYZW4uRi9rutAB2uvzm77jTixXkY2nn1F8FFv1UHFa4eXpMrpHXGq
         v5oSj0B1vtspvlQdJfQYi+pVdxD8Q6MH108tyscwDE/Rms/AGbMsMRjNNP9O7Y6SCUQ8
         KvR5CMw+VaTYe8VpfOWy/momcvO+JWCQUJYmDV5FmktWXMCJ/F/olc0RlLgct+JlV5T8
         HbguANefuG4CmdIeO52nVqVj8oGgwrBKSiUOSui8cwDiAuAFI7uX86NE7gfUyfgywtKC
         0c5FmkiB8C3BVt6LgdTEUKkuPVYsfDU2Y78AVBpaFAY48TvpkR5u3S3Ld3zSWogR8H2Q
         zpvQ==
X-Gm-Message-State: AFqh2koyIwh+cTq48CCKvIdonb0Dg4k6N86bI2kptIjTHCpxXDPR8qQK
        7fj2iDwmM94UOcj8F3LGUcLxlQ==
X-Google-Smtp-Source: AMrXdXt7BEAS/UD6tVnAMFCTIvKMlxBXfdrbEMQxwT2ptAJu2hH0NGuN+4l8xPhfnxBWa97PDxnFUA==
X-Received: by 2002:a5d:4b06:0:b0:28a:87f4:b21c with SMTP id v6-20020a5d4b06000000b0028a87f4b21cmr10061768wrq.32.1672673992182;
        Mon, 02 Jan 2023 07:39:52 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id c4-20020adfe704000000b00241b5af8697sm29097757wrm.85.2023.01.02.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 07:39:51 -0800 (PST)
Date:   Mon, 2 Jan 2023 16:39:50 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v2] drivers/net/bonding/bond_3ad: return when there's
 no aggregator
Message-ID: <Y7L6xl0Xa9KhfG2Z@nanopsycho>
References: <20230102095335.94249-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102095335.94249-1-d-tatianin@yandex-team.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jan 02, 2023 at 10:53:35AM CET, d-tatianin@yandex-team.ru wrote:
>Otherwise we would dereference a NULL aggregator pointer when calling
>__set_agg_ports_ready on the line below.
>
>Found by Linux Verification Center (linuxtesting.org) with the SVACE
>static analysis tool.
>
>Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
