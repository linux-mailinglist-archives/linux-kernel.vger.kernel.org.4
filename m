Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B4C748DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbjGETcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjGETcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:32:12 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4FD183;
        Wed,  5 Jul 2023 12:32:12 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-666eb03457cso29922b3a.1;
        Wed, 05 Jul 2023 12:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688585531; x=1691177531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W9x6oxUx9tH7D0x/gLZxVpZVMqHeZPpBOII1XPg86iU=;
        b=FoOXRLY5GhxSeGLL6PsXfnyH0OylHWW1/RC0w/5E8pmnAGZ/MYfdcpl6So2azqI4Lg
         +uM8m0BbbTmGlMtlG2z48Vyz0YQ3Q687Pp759DYAm/6FWQUeZQ4MrkCZ3J8DjTMfPiYY
         vVqmMLk/LTAQlQXu5tTJoVh2UIGNS1zfiYoW26PdqYhJhPPZ5aauW/cmxsJJCfIQLT2P
         GoVC8cr2iZ2RiMozYGPXmaX3uGiBPnHM6yy07TprABEQ7hf+n/0fGXhsmUdM/i/uTmLx
         V+Ao+iB3wIwZYa4kcFeing3LCzr7+LtKtqmq7vIWpXPphBc0efyRIqTRvXjWyc0yl5YH
         EWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688585531; x=1691177531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9x6oxUx9tH7D0x/gLZxVpZVMqHeZPpBOII1XPg86iU=;
        b=k5Wpxc7Ir8C0KL8IbR9NnUabz614lw3p5+QN4rBa4kpnXNkLR14AmT7pRulrqZYWqX
         a2yron8dLFQJFWgnsHNpt2V0xEXTtlQEg17ad9WREuKr4lloKFDU1ITPhx97v/MVFG43
         EH+HjvqHoRxPnL8i3HNgWB6xcYDiItQQ17g8Q9DVTgRiopTPAmVh5/mCgUtqp8rlD0l+
         5CVKIqPiheShyOv2xHqxmta4bb7wWWwQLIJJE9vt0zNC702tRjdhZv9ZhfD5CkwOyUhl
         91lVx+Wrc9uJ7kWFsq4dUKKMjIt1DoObO0MlQKTdbrqDT4NvJAODZMwmjuHamcOnCypN
         Kaiw==
X-Gm-Message-State: ABy/qLbFbFmW0WOP6+5x86uXf1ge7kP5oi/ZwGOX1zp49iBSm44SpWO5
        jMlNOv4jO2aoWn9aUI+IFq/EBvyPL0E=
X-Google-Smtp-Source: APBJJlEjA5oA16bZdRvKrZsKuVfDXRTEFpiuEQ4EbkeRx1tVVjBk+Q18SvBD3ITwSjc0pP9uOCTwtA==
X-Received: by 2002:a05:6a00:2346:b0:673:5d1e:6657 with SMTP id j6-20020a056a00234600b006735d1e6657mr17198734pfj.7.1688585531348;
        Wed, 05 Jul 2023 12:32:11 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9fac:a99f:7f0a:397])
        by smtp.gmail.com with ESMTPSA id a17-20020a62e211000000b0066ccb8e8024sm17175313pfi.30.2023.07.05.12.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 12:32:11 -0700 (PDT)
Date:   Wed, 5 Jul 2023 12:32:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andreas Helbech Kleist <andreaskleist@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: exc3000 - add ACPI support for EXC80H60
Message-ID: <ZKXFOPOxIB2+huwS@google.com>
References: <20230705091817.1300928-1-andreaskleist@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705091817.1300928-1-andreaskleist@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:18:16AM +0200, Andreas Helbech Kleist wrote:
> EXC80H60 is used in Ambu aBox2 with ACPI _HID "EGA00001".
> 
> Snippet of from "apcidump -b; iasl ssdt2.dat" on target:
> 
>         Device (TPL2)
>         {
>             Name (HID2, Zero)
>             Name (_HID, "EGA00001")  // _HID: Hardware ID
>             Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)
> 		// _CID: Compatible ID
>             Name (_S0W, 0x04)  // _S0W: S0 Device Wake State
>             Name (SBFB, ResourceTemplate ()
> 
> Signed-off-by: Andreas Helbech Kleist <andreaskleist@gmail.com>

Applied, thank you.

-- 
Dmitry
