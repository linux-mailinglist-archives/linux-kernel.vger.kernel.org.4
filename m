Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8292D5F5FE3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJFEDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJFECw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:02:52 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F861108;
        Wed,  5 Oct 2022 21:02:49 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y205so835047yby.13;
        Wed, 05 Oct 2022 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x3eehCTygRMcGwgA/sYSeNxSxRVYTsgJ/fp198wT1QM=;
        b=dH1fwDr41VvYjt4mkP8reQT8K4odY+grw3qyrkMvXr+Yrjc5xlRwGnsarS4VPiU2oP
         yUQPBg6RCuL501kqT6fh/O/5Xdebt5B6FLIHSDopXxAr+NXJNwoB1pWnclWtZ+7sdrHA
         pFyoZNXGZSBro9LErp9w5sdSWUrNLcArS+jixy13OnPHFO1Tip5qczRvADFkAX2Mprr5
         VylhLy/u+F7nIFuqjCaoU/d7721deESvggaw7XTO38ld0WZsqaYxRA3e5VreY7h9brap
         p6EB8jI3alJ6luXsBAvo2SPiLdlXiYtAAG6V1qdBrYxdblbu1SN9JnMNU9I1pcuBSlH8
         sBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3eehCTygRMcGwgA/sYSeNxSxRVYTsgJ/fp198wT1QM=;
        b=KRJ/Mu8DihrEk3o+D6UCJwg1aVXUNTzYpdnY/gv6j/+59dM3nAg+rDtzZ5fF0rbkWZ
         53LtPAPsGyr0nA1jSoY4Qbwg2Xy3qkuMruTsP/RRedrMdKUs9fqIlgQF7rIj8zo+vlJM
         9QGexgUHF7Dxa588iUDk/gzT4C8U1JTBQ/FACibC41ruP7D5gk6oIZqwjv7xUzES5dSX
         fqXShZAiy52TxPDaEOwCPhJpNCo2ZiDvwZBQU13ll/9kn+og7If9zOMQDfhP4Dq0hjU9
         az072+4oVkvE3wfTCBI4+bhB1kId1MqQPFadPckTbNu5RQ7lnxQqK/ZHsQnlkSbCZYqk
         c3aA==
X-Gm-Message-State: ACrzQf35t5uxqbgyhO3EaPxv+ZRzbTp9s1uDH1Z3m1eATbGgvkK7p7tX
        ye8FWtW5ADHDnNhzKDgW/tf9UWzW7m7CinzxAHM=
X-Google-Smtp-Source: AMsMyM7fiyr5BM7m9N9mEXoHZ2R9ieURlDQiuyGtzhga3iiXRDNGgKgvDLm8R94/tCeY0388UuL5oZlnyOFTYgHbNg4=
X-Received: by 2002:a25:bc90:0:b0:6bd:74b:3b7c with SMTP id
 e16-20020a25bc90000000b006bd074b3b7cmr3237174ybk.450.1665028968212; Wed, 05
 Oct 2022 21:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221002220126.18849-1-hcvcastro@gmail.com>
In-Reply-To: <20221002220126.18849-1-hcvcastro@gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Wed, 5 Oct 2022 21:02:37 -0700
Message-ID: <CAEc3jaBiN_b_AJGugkYSwxF-ZWHzD6ib4r99tm9Z4RwN2=bgzw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: hid: warn feature report 0x81
To:     Henry Castro <hcvcastro@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see in the other email. If it doesn't support this request, it is
likely a clone device. We are about to submit a brand new DS4 driver
(for hid-playstation). It will use a different report (0x12) if I
recall which does the same thing. That's the more mainstream one we
use.

Thanks,
Roderick

On Sun, Oct 2, 2022 at 3:01 PM Henry Castro <hcvcastro@gmail.com> wrote:
>
> Unfortunately, my PS DualShock 4, does not support
> the feature 0x81 to get the MAC address. Instead,
> use a unique hash to fake a MAC address, so I can
> use DS4 to play Retroarch :)
>
> Signed-off-by: Henry Castro <hcvcastro@gmail.com>
> ---
>  drivers/hid/hid-sony.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index 656caa07b25f..e3e9c58887cf 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2641,13 +2641,14 @@ static int sony_check_add(struct sony_sc *sc)
>                                 HID_REQ_GET_REPORT);
>
>                 if (ret != DS4_FEATURE_REPORT_0x81_SIZE) {
> -                       hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
> -                       ret = ret < 0 ? ret : -EINVAL;
> -                       goto out_free;
> +                       uint32_t hash = full_name_hash(NULL, dev_name(&sc->hdev->dev),
> +                                                      strlen(dev_name(&sc->hdev->dev)));
> +                       hid_warn(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
> +                       memcpy(sc->mac_address, &hash, sizeof(hash));
> +               } else {
> +                       memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
>                 }
>
> -               memcpy(sc->mac_address, &buf[1], sizeof(sc->mac_address));
> -
>                 snprintf(sc->hdev->uniq, sizeof(sc->hdev->uniq),
>                          "%pMR", sc->mac_address);
>         } else if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
> --
> 2.20.1
>
