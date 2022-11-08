Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59883621916
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiKHQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiKHQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:07:31 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8C727B25
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 08:07:30 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so13452312pjs.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7NAfXgkas9FkKHI/2z5E8BO22HCnzrVgue2pmy0gYg0=;
        b=sk7Y9PKa+w99R34+0MwjGhMzFTxMNAAlYcKPisL5RJ7MWZQyhALuxmFw8BuDRQCg10
         jhfK1WFvKFpeBsZlQn/8c8V4WPdRTARIL+kf7prcvz0hihXOh/5gysNVX1efI8V5PHuM
         fW/T1dqEHiNDsEEwj5pux0GNUg0uKt9TZfuhffhFpIIOlxRYrcYM2bFIKC9+1JAJBR4R
         vJ+5+S5Tt9sAtyW4p5zYlh+3oGH74c3DYrpUDKiDWV2VeaiPQU+2ZNvKhaO0WYKgtzuR
         kd5avGmkkkzccD1up9eDjq91QNVLdCWUUKi9a0fmowWsZ9yKYTvcKBNmji/muSm2ny33
         39Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7NAfXgkas9FkKHI/2z5E8BO22HCnzrVgue2pmy0gYg0=;
        b=RmTSmo9BuiBnVBgEpbWoyVsmqDSmzemx2dN4PmCuD8Isa/rN64T7xZs8io9tVKza2V
         Cjk0zh4O98D0TQ0O9R6mw7aUtrQELFmYWixZP11DZLxipV7g+iarzXwpFFxtDe7+OK1U
         Bc8EtNVvIaWi1qcNZ9jhOKGl53RdYowcOqXXUTXJZc9AVu5TGXLGZftAodMT3LLj7fJL
         Af8VLqqVkNugy0Aam5HWUqwMhZXTNcmfSnL+ECc2TQTwwbIo62cuz/7PhOsa1s7OtOFE
         UF+wHQZVoklHxAGYZDOMX1WrdeW8dbhdsHSiaoX390Qh2wKH2K/DRXyu99KiIFjd4uRS
         nKpw==
X-Gm-Message-State: ACrzQf1ORRsThISFiNyPDc3/tBPBwVnM3yUwtkzcmzkRCdZHQZWBbuE2
        dT3AD6wcZummGCjE+9pOY+foEzpyN5v9hptUgaJHIzdU4zrhBA==
X-Google-Smtp-Source: AMsMyM7oM3bXz5WVKW5DBKRfmc0AsQkBWvQNOKDtvc9Xfc+qlIYy0ceRnQLtvd1JvXN7+UzATdoAuNY9jQP7t2GZpgw=
X-Received: by 2002:a17:90a:a781:b0:214:2921:41ca with SMTP id
 f1-20020a17090aa78100b00214292141camr36678689pjq.118.1667923649937; Tue, 08
 Nov 2022 08:07:29 -0800 (PST)
MIME-Version: 1.0
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
From:   Jassi Brar <jaswinder.singh@linaro.org>
Date:   Tue, 8 Nov 2022 10:07:19 -0600
Message-ID: <CAJe_ZhdKTM4kLvfHjNv4RozBFntxc2tBCWUuZ+dp567_ZqEFjA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: Add support for F_SDH30_E51
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 02:25, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This series adds support for F_SDH30_E51 IP and some additional functions,
> such as reset control, non-removable media, and quirks for broken timeout
> clock.
>
> Kunihiko Hayashi (4):
>   mmc: f-sdh30: Add reset control support
>   mmc: f-sdh30: Add support for non-removable media
>   mmc: f-sdh30: Add quirks for broken timeout clock capability
>   mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
>
For patches 1, 2 & 3
   Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Cheers.
