Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891346F8D02
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 02:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjEFAGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 20:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjEFAGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 20:06:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB2E5FD1;
        Fri,  5 May 2023 17:06:11 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6439b410679so1271037b3a.0;
        Fri, 05 May 2023 17:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683331571; x=1685923571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=klXs9v7aA7ej680xjzts2OUwm25v6knlJ8Zui0RxixI=;
        b=B8euot9+iL9V/P1xe3MbEAtjNia4Ar85AQqNOMJsfqS2SRW0byLuRO5tzC5Lly7c0H
         su+mzKY6srmS+cB7Q/bZH9tS+d5hfnjNUyhQyu/KAutZkDRtlSABvUHdgr37pofT6KCP
         p46o6+LFKG0tsDQmRL948YADaBTSbai1Sk0oP6mDzzFclv/FoInKttstB97YcSykLemK
         Y9sEBu3ATjQohSd9v/OpmtxiyMlOn+7EJQOVUzLNVpHzb29r3c/vSdfFzbWHB2b8oZVk
         fHiBNhWvoVGGX1m1wjvcRLjRsFIQpGVZywMZkJnCv4xCX8Eh0tcCnz5yhCFOrlM0NHR7
         WKeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683331571; x=1685923571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klXs9v7aA7ej680xjzts2OUwm25v6knlJ8Zui0RxixI=;
        b=AGaWPvAgg0W3lmgNMInSlUKuhatMSjcNmWiKGSoY11sUz/HnepWNNWxPjJNn93sBsP
         YiGaB+ADVfubZu6UxKiQseA5mAtooJWBT362y//b4O725zvboWDX/ZsIBQ48yUFVEqsM
         lr+0MIPuHtwK+RKZ0CBYgg2pRafv5DOQ0UKCQx3CLxTtvmZWiYuDneYt0+sZtkMks/L7
         L6hblOLrbPaqhPgQJTcKr8l4bsexTzJPRpgLRrYR90ZD84UkDWl8svl47ls6zGA6kJK2
         ib+L5JjlguB1Csnjjq0GdQJ3JgwaQOMuyT+iR1OD3lKTgONaT3AHuITM4llS0QiIsVpO
         GHHQ==
X-Gm-Message-State: AC+VfDyFnU1FQvW6EYTDwI2k/VKOfObPfQrhMConEOCZn8SbPNlnelUb
        PZcLlmktwRkj+p9u/NWMrcBmF2I/RcY=
X-Google-Smtp-Source: ACHHUZ49tXczQW5SVIUYa/FGEJcucQomcFSS4BP2inuPdG18DUtp/4T/8bhsvFh2Cr/Y9JMg5ITZOQ==
X-Received: by 2002:a05:6a00:24cf:b0:63d:3411:f9e3 with SMTP id d15-20020a056a0024cf00b0063d3411f9e3mr4717752pfv.19.1683331571122;
        Fri, 05 May 2023 17:06:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:4440:ecf6:7bf5:244])
        by smtp.gmail.com with ESMTPSA id e19-20020a62ee13000000b0062e0c39977csm2094238pfi.139.2023.05.05.17.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 17:06:10 -0700 (PDT)
Date:   Fri, 5 May 2023 17:06:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: google: Don't use devm for hid_hw_stop()
Message-ID: <ZFWZ785FRHDii/+5@google.com>
References: <20230505232417.1377393-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505232417.1377393-1-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 04:24:16PM -0700, Stephen Boyd wrote:
> 
...
> Unfortunately, the hid google hammer driver hand rolls a devm function
> to call hid_hw_stop() when the driver is unbound and implements an
> hid_driver::remove() function. The driver core doesn't call the devm
> release functions until _after_ the bus unbinds the driver, so the order
> of operations is like this:

Excellent analysis, but the problem is not limited to the hammer driver
(potentially) and shalt be dealt with appropriately, at the HID bus
level.

Actually, it is not even limited to HID, but exists in most buses with
non-trivial ->remove() implementation. For example I fixed similar issue
in I2C in 5b5475826c52 ("i2c: ensure timely release of driver-allocated
resources"). I tried fixing it in SPI but Mark has some objections, and
wanted to fix it in the driver core, so I was thinking about it and then
dropped the ball. At this time I do not think fixing it at driver core
makes logic any clearer, so I think we just need to fix a handful of
buses.

Anyway, I'll CC you on an alternative patch.

Thanks.

-- 
Dmitry
