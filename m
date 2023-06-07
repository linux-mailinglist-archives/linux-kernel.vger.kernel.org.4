Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83C725FC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 14:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241018AbjFGMli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 08:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241026AbjFGMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 08:41:30 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5773E1BF5;
        Wed,  7 Jun 2023 05:41:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-565ba53f434so81610457b3.3;
        Wed, 07 Jun 2023 05:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686141667; x=1688733667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3W1JuI47URiCgppMqI7CfJp4KETvzWbAEnpPKIrCU0=;
        b=KJHpPjrJf4ChWSPrBt9rPnJP9fvwvLT3FXsQHlewbHXpHYSMggSId+tIvf7Wk9nNAL
         B2BK25FPa750aXPU9fZ16pZ/j0jy8FCYbt2lszXIf7nn1fDgTurJUymdHuG4be4M1Lki
         +TSeNmzGDhS2wlmqVd02cPZPkZYTX3+HLZwxZ5izCmfKpjVZRdsg/sIcJDg0TYwbty+x
         bsa7qnazdSiwL5I/p41q64+7AzTcPPZWAwAnNaLiq0Z5eHFClE9R63AC3Ewl4Zd6nSo8
         1+rzsJWDNotIQMkRzNUwy7F2lakLNI3DiTFO3mGBRpYYvA0a7Vb7wpkp0VCCskXO3KQK
         LFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686141667; x=1688733667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3W1JuI47URiCgppMqI7CfJp4KETvzWbAEnpPKIrCU0=;
        b=MhRfxCfR1rSs/wdZiarfLV6oDpEYs8eV5yMvkO4Z64YjQ0dCKtgZsiEW2FcnTODm8w
         Vu/r6dPRf2fbDpr+Cy1/EeoE22+ef+jHADtW0Nb5ZGKtz1/Zz43Xcam3CbvzoUXLDWZj
         wloQV/yuKzRs9Z11SV8TVy3ydLXQKCwHS1pragoYXN30e7a0oaaAhyxRmtqTY3fBZmp+
         rSywNi5ZxL80qps9r8lhEk/dXq8+egMQG+jg7k7B4DsTX5qX4njN4Ye0DvVxQxbtZNR+
         0TX3Rgg+2sSUSGPi6lVpKI4PWqteWH1hZTZe2v4XxfsPt/S8AcM0e9QcOR70VZ+68JxB
         PUXw==
X-Gm-Message-State: AC+VfDyQ2/WPHSnoxEGryQtkDWUc/e7Hw6dKa3Tjs/D9wJ07J3arRpfq
        bCa5qzBGsNjC8JbvS/QpbDgzNe6MaiPG8KVzVSg=
X-Google-Smtp-Source: ACHHUZ6vw/Yhp8nVhvM3voWe+gKtR/4Tgbabn4pTd+masS8WGYl65sXIhd9VnGok8H488loGlNA5k9T0T7WB03B4wy4=
X-Received: by 2002:a81:8984:0:b0:567:421c:cab5 with SMTP id
 z126-20020a818984000000b00567421ccab5mr6639448ywf.49.1686141666782; Wed, 07
 Jun 2023 05:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230527012206.133464-1-samsagax@gmail.com> <8ae3e2ad-27ff-4339-88d4-504c2f59e501@roeck-us.net>
 <CABgtM3h8DXs0swGQth=dcE3J_W8k8iejvfFgjVSm9nKbRmxHDQ@mail.gmail.com> <820cef00-4768-46ae-c5a5-ea7c0dff71c5@roeck-us.net>
In-Reply-To: <820cef00-4768-46ae-c5a5-ea7c0dff71c5@roeck-us.net>
From:   Joaquin Aramendia <samsagax@gmail.com>
Date:   Wed, 7 Jun 2023 09:40:55 -0300
Message-ID: <CABgtM3h0KMsOzZZvYKZLsFXn9A81V59ygSKizoF3TTkraMWr-Q@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add tt_toggle attribute on supported boards
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again. And sorry for my late reply. I'm struggling to find a
good solution to this functionality. It most definitely feels icky to
be attached to the hwmon driver so it should be a different driver for
those devices. Would misc be a good place for that single toggle? or
maybe platform? The latter seems most fitting since is very device
specific.

> You are attaching the attribute to the hwmon device. Moving the driver
> to another directory would just be an attempt to avoid review by a
> hwmon maintainer. Just for that reason I would NACK such an attempt.

By no means I intend to avoid review. Don't get me wrong. I'm trying
to understand what the best practice would be in this scenario. The
driver is part reverse engineering and part asking contacts from the
manufacturer (who is no longer in the company so it is reverse
engineering at this point). So any new functionality we find might be
a different driver for what i gather since it is not related to
hardware monitoring. The oxp-sensors as is now it is mostly done and
it works well for the users.

Thanks for your review and explanation. Any pointers would be greatly
appreciated.
--=20
Joaqu=C3=ADn I. Aramend=C3=ADa
