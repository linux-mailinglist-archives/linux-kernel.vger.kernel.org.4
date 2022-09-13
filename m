Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F985B6B96
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbiIMK0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiIMK0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:26:22 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1495A15C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:26:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id wc11so11865961ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=+IOkPYBVudVE123a/Rn57DKbqImHDs6xTaqKWEnTeaU=;
        b=Nfk47yS3sUEC5dccsd1Iyj46AmGAEd7oULrPAaV2ntNTv4H6cik+Lnp0JZv5WgPaqC
         5YvNXCmWL7tE9d7slhCFvfDIOeH5Bs7ycBXQuGjFBJuZkcrfz2fyQj7mlmI7/WHw3dKw
         1sYpJ4c5CHpp4CxJY2ifsndF8feZvN3D3OW099UnO6WN/9VhQa8Em8TtlOtmbmtea6i7
         eEBXEt7Z2aQ8yQI1q1+I/iP8iDMcsHk/16RVT2qI13WdHHT3D9PY3GRIhLDebfX0Oxyr
         OkC3QypYHsanPvw3hGwnQbcFYIVmuv0hLTSujkVfwv9/XHU+7PWl5LFMHa8kSF3YiEFS
         PKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+IOkPYBVudVE123a/Rn57DKbqImHDs6xTaqKWEnTeaU=;
        b=8MobNiYUYl0Kupw5CD/0Wu+AXpQBixGZmhj6MxJ+F9qQ2EIizXja0oUIgsvK9IefCI
         pNfjjCjz4PIdOhn1SrWipaK1CofN8vt6Up5SCEy8bydeAhs/GiLkcOT0UsqegAFCEBh2
         AB8C6p7gJMgczhMyCpSQWOWSId6+OLGkUCHH5tFMvYYJ7VAoMb0UtlQt4yA5uLebRICq
         1mYuYdIjrMrWXHp4z85GTPcVYWGJPvA0MAB/+Lwr0r7ftf4xwXlqAbb2odu/azfQa0i3
         YiB1+JU6YSH4OCLmMxK/iZ6lYCo4+PY1k82uuJ/V0jMMeU7367QbsOPIPmJUqhRiAhox
         2kYg==
X-Gm-Message-State: ACgBeo1iNquV8XfAqBee54jhbkf5m00v+pomPRC83PNLUGRyJJlARVT1
        ZVpWoGTv36DzaeVxymMn1wMIA/GvcL3DyU0LE9I=
X-Google-Smtp-Source: AA6agR4IBfaolp178MWTLswZnL/5MtTcjGxzN+aYc7M207wsXPfzViRRjNMXBsan1xZpMx9pKMtj5hwpKn6VMVPauEI=
X-Received: by 2002:a17:907:9484:b0:73d:8c67:a945 with SMTP id
 dm4-20020a170907948400b0073d8c67a945mr21348062ejc.634.1663064778800; Tue, 13
 Sep 2022 03:26:18 -0700 (PDT)
MIME-Version: 1.0
Sender: oyebuchikalu29@gmail.com
Received: by 2002:a17:907:961c:0:0:0:0 with HTTP; Tue, 13 Sep 2022 03:26:18
 -0700 (PDT)
From:   Hannah Wilson <hannahwilson11254@gmail.com>
Date:   Tue, 13 Sep 2022 10:26:18 +0000
X-Google-Sender-Auth: eyTjtDV2lwTupPpaukh9Yy_zq64
Message-ID: <CAOkQLHUOode7epOr-iRpUMgEsBtfxW1BOoGajnqiMDdDTrKCrA@mail.gmail.com>
Subject: Hello My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs.Hannah Wilson David, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided you handover the sum
of($12,000.000 ) through I decided handover the money in my account to
you for help of the orphanage homes and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs,Hannah Wilson David.
