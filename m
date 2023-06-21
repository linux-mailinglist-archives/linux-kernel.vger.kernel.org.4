Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF5738A0B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjFUPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjFUPpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:45:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2429B;
        Wed, 21 Jun 2023 08:45:14 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-977e0fbd742so810977966b.2;
        Wed, 21 Jun 2023 08:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687362313; x=1689954313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cw7AjrQzIb0yz93itV9IidgEBv70/EYhS5N/v3j4hcA=;
        b=pFtKdMbslc5zH4eMpfjeX+zjhO1eJhy7szeX+llYddNhsIkLLJeuHyRG2cFy+mqRTF
         fhJKz3Z49CABwixub3hH4TGc8LYBEAJcG22GfkyA9jnu/uZOClSnTFONBRC5vUYz933r
         zdTnyiBBugPOwFd3KGQ+x9oYrAFmnUn/agPLPtLZ07wAgHw6KzqS2TqqoN2k41w3nyyj
         vB2qiiBjJ0DImTQmZmWHpj+x3FUEtK7ns6bIA1TaIVhlOPkWUIwOqHosc8qAQhTe7pzA
         FzKfdNRZzY78klnetu8/zqvjXlMHnh8rfTm/PF9qZmwHknRygPea4XpLKMHchR9+TA5J
         Z3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687362313; x=1689954313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cw7AjrQzIb0yz93itV9IidgEBv70/EYhS5N/v3j4hcA=;
        b=g1JjZXFFCsi49YWJxmol75qqeyfl9ScU3/sUTXYNF9prkPS2LBn8H5Q63UjJ2xst7a
         7JkPRv27mLg6c3DoP2RQbR0L0HW9kFQkBwK/OypfjDT9LGFWDJ7osIquLGYDVZ9yKplB
         ccYOUG3G2LqOq58rXd0VEznX5vZYOXGA5Z1QU9Dj6Rrp4Yc/yMYMXj7ZwmNYOC7kO19u
         c7VaMQRrCzHbRHFSnYLpZydMBJFkn+EnvJglfcQARWD+WhtS/NxH8wjnrfgSnbs5X3ex
         zhZMAIaEsx1DYorxtOaRVPipar55vLD7BVyj3bCJlW8NQhAQK7JPRlwGzb2xR4QeZyHQ
         ejTQ==
X-Gm-Message-State: AC+VfDxPe3THIRA0IdwWKe4BzXUdTcMUFq+bTFJ4o91HSlUF7P4aekPO
        X3HhzNg9i8KNp+uRdGwiPEw=
X-Google-Smtp-Source: ACHHUZ7W/uMgae1mGa5B1RkGawdjByjhC0dPkdc5N6T8/ihfppc7NB0lAt2bwVJXQModqCq4P97Ahg==
X-Received: by 2002:a17:907:a45:b0:96f:678:d2fc with SMTP id be5-20020a1709070a4500b0096f0678d2fcmr11739593ejc.22.1687362312835;
        Wed, 21 Jun 2023 08:45:12 -0700 (PDT)
Received: from PCBABN.skidata.net ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906498900b00986ad2e34f4sm3250381eju.205.2023.06.21.08.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:45:12 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
To:     mka@chromium.org
Cc:     bbara93@gmail.com, benjamin.bara@skidata.com, conor+dt@kernel.org,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/3] usb: misc: onboard-hub: support multiple power supplies
Date:   Wed, 21 Jun 2023 17:45:05 +0200
Message-Id: <20230621154505.2229794-1-bbara93@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZJMPv6Fm3On0ITFi@google.com>
References: <ZJMPv6Fm3On0ITFi@google.com>
MIME-Version: 1.0
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

Hi,

thanks for the feedback!

On Wed, 21 Jun 2023 at 16:57, Matthias Kaehlcke <mka@chromium.org> wrote:
> On Wed, Jun 21, 2023 at 04:26:27PM +0200, Benjamin Bara wrote:
> > +     hub->supplies_num = 1;
> > +     if (hub->pdata->supplies_num > 1)
> > +             hub->supplies_num = hub->pdata->supplies_num;
>
> Please change the above to:
>
>         if (hub->pdata->supplies_num != 0)
>                 hub->supplies_num = hub->pdata->supplies_num;
>         else
>                 hub->supplies_num = 1;
>

I would even prefer:
if (hub->pdata->supplies_num)

if it's fine for you?
