Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BF85BC411
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiISILi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiISILf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:11:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C656412AA2;
        Mon, 19 Sep 2022 01:11:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id bj12so62535309ejb.13;
        Mon, 19 Sep 2022 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uaaC5NpEP5M16o9EvNJUMGgKA5Dn5bLVJkmIuFDo+u4=;
        b=CQDfUDBxETlR3Pihlmgw3n0a9kbhgTkpSYYUmy2rRc9rx/Inqq7TJC6HLVCftKcBUK
         fi6iPV75xqW5cWcV1PHPPQT3NQ1hlfUP1BuAqFOlbpTzsfMvCk1tPqPVu4SmD/I0HpDw
         CT7enZnU185EME9FQNUAmHpPmClbTufnxXOVJUeWeHMuIWOETmBB3zdcuMqAjIEq/o+3
         pZFfcgt4cCOEhT0oNwwMpKyC/GQ2BL950DGrRGGEckFg9AZB1Z+7aogTPPLfIMhkPacJ
         AZMU4XfaTcwAv8CmsAZkvwtxYUXmyaBvvi7ZSglh019n3JWuHxum0M7b19GeJuwnk5xf
         lDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uaaC5NpEP5M16o9EvNJUMGgKA5Dn5bLVJkmIuFDo+u4=;
        b=UqTuCHr8dTikYbEsdzynMsyR+0Hx/k/yjzz4TMtvWsAqY37Og8ZfsfeBlBavya8pXa
         Duuk+ZjArijrVt4RLI4B5GO1Nlzs2UzGdz2A9G0LJxC7rhx7BEdBQh2uzP7akT2P5LJ7
         6G249QSXZ71AEAnHM4Efwri3wy3xvpIiz9IJ7QeyLEyRn+fBaZzJZlA8Aeh1myk4M3/Z
         2BE3QEeuqM13FVaEP2os46ViovcjcLr+FzlCSrcL2W1j5wv7sYcExFatw40j/zhAQuu3
         4EW1N6B8rjFD+lzmuRa7O98qou76DjN/FwOq1F5J0d58nxk6Q4jwxP+5lQv/kRX4Nxu1
         rDhw==
X-Gm-Message-State: ACrzQf0YzuJShSPj9hJoc+M0KSqwtKskCDJwcWnC98/t1mw/fersNcKU
        SaRA9oHm+CMPh+I0iRKQWvRz8qNvnFXB7b/4Nxo=
X-Google-Smtp-Source: AMsMyM68dOWdxMNbmWOqc1XBClupZWRdFa0XaXBH+lSIVajtZhqKQnBhTqPco96NumkI2fkVoG6OYnkcvU/FoBM46AI=
X-Received: by 2002:a17:906:591:b0:73d:c3ef:84ae with SMTP id
 17-20020a170906059100b0073dc3ef84aemr12112023ejn.155.1663575092296; Mon, 19
 Sep 2022 01:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220916133521.73183-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <2b549080-7ce4-bae1-d85a-a56946f055f5@linaro.org>
In-Reply-To: <2b549080-7ce4-bae1-d85a-a56946f055f5@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 09:11:04 +0100
Message-ID: <CA+V-a8t3rbxD7o14ZhAfYSyAzdNhDCKQ7U5WX3i4j0es8mvYEA@mail.gmail.com>
Subject: Re: [PATCH] media: dt-bindings: i2c: ovti,ov5640: Drop ref to video-interface-devices.yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Krzysztof,

Thank you for the review.

On Sat, Sep 17, 2022 at 5:47 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/09/2022 14:35, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > video-interface-devices.yaml isn't used so just drop it from the
> > DT binding doc.
>
> Same question - the schema is used - you can see it with your own eyes,
> so please explain in commit msg what exactly is not used.
>
As Laurent pointed out I need to additionaProperties to
unevaluatedProperties instead of dropping this reference. I'll update
the commit message with this change and send a v2 (and also similarly
for the ov02a10 binding)

Cheers,
Prabhakar
