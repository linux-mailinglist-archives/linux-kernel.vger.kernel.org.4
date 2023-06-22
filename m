Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDDD7396DA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 07:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFVFcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 01:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjFVFcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 01:32:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4A1AC;
        Wed, 21 Jun 2023 22:32:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bdeaf4032so1349249a12.0;
        Wed, 21 Jun 2023 22:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687411921; x=1690003921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFK3H0ojlfJROcy23LsIL0LZvyC8Gh3NV1rd3Juayps=;
        b=Ims4UQEZ0d/fkAv2MC3CsyLhkqjRpYsvOMROcMXzhQh8RdwL66EGq4QNCAlj+vIyUs
         nPhiQA9Hnn5mp3UGvp6UUlZb9erR2DfWpf08zOjz7cQdjLXU3XN651kxYaYE2yOf4J5g
         8DEWB1KYWO8e4kZlP7zQDysKSBWm6l6arwvgB8MnTeZvPzJr4YhdAjZMs5MBA7D9Slqy
         RtGbOCiJ4Yu01TSW56dJDPDq5Zu6KxtG2sF1ZdUqQkBd+uCigcSqeLHnl5CFStrsBbrW
         2AChrOKvXCkbyEQncRB4HKAPw0AKo7eZeUY/ernrO87DFI5UQFA4oXRogJcFiBCMhszY
         HCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687411921; x=1690003921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFK3H0ojlfJROcy23LsIL0LZvyC8Gh3NV1rd3Juayps=;
        b=N/qAlAbQk7XjikuaFmewpPI5oALAMvcOf2Jx0xFh+pW+vkojy4+g1yk8NRGLks4Kqm
         nkPovX86ubsHwZGiPog4M3FXja+f9Ecve+mssmtcXQTPIla8wPLc2KGpraXfsbVMP+iz
         m2DY8YwXBKH5jtdDLQ5ekrdAEhlivLwnkIxykFVqsyVfGWZqh1xvPXPFkNx8kptH/mFq
         0cGcye7ggUQ+8LCq51G2XqGhZkzQroN3QV53I/QIhDk8B755EZ3mXuARYVWrT5CYFO+8
         ADfBCu48VDI6+Vxkymi3Epo7HhbkYFXYnaG7aYd0ZXJExwMpl/Fj1QYFSdtgFBRiut7X
         burg==
X-Gm-Message-State: AC+VfDxaQWsEI13gshKkdiKwqEUUcJWVm1jml9PQIZwpd4uqtpVni3aC
        9lwhmDQcwBy2SnSHu14xUCk=
X-Google-Smtp-Source: ACHHUZ4+Td2x/8wkWMCignDnhIlUz3ZFg0kJi6TBTYcvhr3fs8kFtKju+jvBCw/9wEYrutjK0l1rPg==
X-Received: by 2002:a17:907:3e0a:b0:8b1:7de3:cfaa with SMTP id hp10-20020a1709073e0a00b008b17de3cfaamr17151770ejc.3.1687411920845;
        Wed, 21 Jun 2023 22:32:00 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id t19-20020a1709060c5300b00988d0ad4477sm4098408ejf.29.2023.06.21.22.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 22:32:00 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     alexander.stein@ew.tq-group.com
Cc:     bbara93@gmail.com, benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mka@chromium.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: onboard-hub: support multiple power supplies
Date:   Thu, 22 Jun 2023 07:31:54 +0200
Message-Id: <20230622053154.2235177-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <8701196.DvuYhMxLoT@steina-w>
References: <8701196.DvuYhMxLoT@steina-w>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Thank you for the feedback!

On Thu, 22 Jun 2023 at 07:16, Alexander Stein <alexander.stein@ew.tq-group.com> wrote:
> Am Mittwoch, 21. Juni 2023, 16:57:03 CEST schrieb Matthias Kaehlcke:
> > > +#define SUPPLIES_NUM_MAX 2
> >
> > MAX_SUPPLIES?
>
> Do we need this MAX_SUPPLIES macro at all? This essentially is
> ARRAY_SIZE(supply_names), no? At least it should be
> > #define MAX_SUPPLIES ARRAY_SIZE(supply_names)

Thanks for the catch, will adapt.

> >       if (hub->pdata->supplies_num != 0)
> >               hub->supplies_num = hub->pdata->supplies_num;
> >       else
> >               hub->supplies_num = 1;
> >
>
> In the kernel there is also this style:
> > hub->supplies_num = hub->pdata->supplies_num? : 1;

I dropped it in v4[1].

br,
Benjamin

[1] https://lore.kernel.org/lkml/20230620-hx3-v4-0-e56b3c6db60b@skidata.com/
