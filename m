Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6337060D6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 00:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbiJYWXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 18:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiJYWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 18:23:06 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B200A558A;
        Tue, 25 Oct 2022 15:23:05 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id v27so16308097eda.1;
        Tue, 25 Oct 2022 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xtG9UJwQ9xCT5GcRsSIwntHKnFlFfGi1m6Y+YTQWFGY=;
        b=ob/HF79763ku4U3fPDwMmMTsok1pWeiY8KTKwL1ptOtciBoKvRjMUkD5tnKSR59e24
         RwxSmhP3E4aGAcSGZGSW1R+JGQMW6ts2SVRs3cFz9OYMKGuunSBeyUP4OgU3q0XzMl5X
         spBEqC2Ft/qmKa/ijSkRYWVwVn8x19JNEr/2hUYIW9A8/4kvvdGDjQtfTmr0lb4QRuCP
         N0s2S2+nDfC9+Ex22ZBKX9seVtMArHVQ/dC1qPmaaInJOVd1JhY88gpNUEv+sXvbZl8c
         J6wc6kAh2k1IMOab0YzKKPoK6cm9qMsgVRsshhznyKPL6wes1FPUlysbf97kqdgAIfwD
         ByQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xtG9UJwQ9xCT5GcRsSIwntHKnFlFfGi1m6Y+YTQWFGY=;
        b=J8ERpQpxIBmNFneGsRsZqxzk9l25YhnO8iezCVAfIJowBEIgpi8XJofDC4F3nawwJh
         9iGJKpe/HZ92pLUPQnFrSSr0o6FeFvwecyjLuMXtvdIvFHe8FlaXOOhHQ7usU2Mt32Ur
         aBNEXWOAaVAsuICj7wZ/t6KP5ltscJkqhIx+onkZp8b4un+TJ9o07Ip6XAaIC/a2nGfU
         rUA8/9nVhb3zCZiTZAyw77QFpS+Vp0Y8K0LV79jneD0J5Ghy+RewmLZ0vWMiiIzvAOI4
         ohtmH1MWQVaCWN7uHNPH/jceTcpZSwYeTDGEOHuUGKQeMElbneVN/z/XQIiPQPArJvvW
         Z7Ug==
X-Gm-Message-State: ACrzQf1gx8uB7wAEpLrX7UicNWVV7aY+g1PIVCk1Eoc98AF9O4Qb8tKf
        ruUSJqeuWcTF+p9Z/P2QKcupaSzWxChDYsat0Z8=
X-Google-Smtp-Source: AMsMyM7TofUOT6/SSJqJHTTX0CLwhjl052Ms41mATxijLuCl+S3e8adVj6+MXPHXLcufxZlouFkOTWadNMoUnBSB9S4=
X-Received: by 2002:a05:6402:3217:b0:461:d6d7:7f19 with SMTP id
 g23-20020a056402321700b00461d6d77f19mr10396610eda.109.1666736584242; Tue, 25
 Oct 2022 15:23:04 -0700 (PDT)
MIME-Version: 1.0
References: <20221019152947.3857217-1-arnd@kernel.org> <20221019152947.3857217-15-arnd@kernel.org>
In-Reply-To: <20221019152947.3857217-15-arnd@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 25 Oct 2022 23:22:37 +0100
Message-ID: <CA+V-a8t7FupuGtN1YFLQJXu3aznQ_Liy71SQcKJDgLtZhm-z_g@mail.gmail.com>
Subject: Re: [PATCH 14/14] media: davinci: remove vpbe support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
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

On Wed, Oct 19, 2022 at 4:41 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> The davinci dm3xx/dm644x platforms are gone now, and the remaining
> da8xx platforms do not use the vpbe driver, so the driver can be
> removed as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Lad Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
Prabhakar
