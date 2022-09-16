Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696A65BB47E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 00:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiIPWu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 18:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIPWuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 18:50:22 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF84419B1;
        Fri, 16 Sep 2022 15:50:19 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w2so12297899pfb.0;
        Fri, 16 Sep 2022 15:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/NIEWxp84RPL8Tgo7ZFc7L3ToLk8XFjLsKTX32EoRvI=;
        b=KVJ4Cjsrd+TreR4REwUPihTqfA4NWE1SOoXdCq+2k37aDrhS8BOi6U7Qdd3J0u9VpS
         wEXsvTQoUiOzDjtHRZ4dJSBC0MaykbH4r6joOiRrw2y1szMTr0lTL5D8woYrEIZK4UIU
         1jo05WeS7yP3kWiNyHu/Z5SH4hVFV7wKn0E2aFeWFKjcdR8XREJezBzFKoqCRJcqtMxr
         3CCYsX51bnJeU2e6chl4k6Y/Ab+XNCmHUykPdqOxJBOmgI9kQojH6edoI3qc63grNf/8
         DaVFQrQGx26p12I4kFvsPed/BjT10k/wyHsgGGphURT77Mj95nj7b4cg2wN3nCXYQ+Hw
         OQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/NIEWxp84RPL8Tgo7ZFc7L3ToLk8XFjLsKTX32EoRvI=;
        b=EVRPDWJDqeLoggyTCug72wy5EKwyC84v7NRbC6deKxW6umWA51t5UnfaGp03OWyArS
         qCprHG2JEAF5fUojGxHSwx63eYTl2CX2NxCveUMpGmP1RsQIt/6nL5vvU4cUy4jesZMt
         t8cMHldSLq+5GWbtWG+Rp4aoaZ1ijZswEVZeex7RmgFG0gBYgtAHAtcU1fvxRgh410Rc
         m8ZtNRpJIaAA/06JoVS96nYXrjI/JHjS82xm26KnCf6jeWxEQ5Yz/m11DSuwZJpRJUKg
         vntkFloyLNlORcz8heWsTOX24ik7ISH+FO8tLczZ5dTwuuVS5IL95/9q8F3Oc/yfxaSg
         R4CA==
X-Gm-Message-State: ACrzQf3OknG6JYspueL7uJ2Cs/E8wDAiG4iCVvbIcengvCGtSSC81UEV
        kZpXR+hGd7oACLoUz19AMO0=
X-Google-Smtp-Source: AMsMyM6FdG/co//roOJ7GUs1R6IX8Rivg9jAhFpX0XLIm89SQbChXfCzyJqqTbDHMzilMls2R/Lhnw==
X-Received: by 2002:aa7:910b:0:b0:537:cd65:e7d with SMTP id 11-20020aa7910b000000b00537cd650e7dmr7632639pfh.63.1663368618312;
        Fri, 16 Sep 2022 15:50:18 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:4b0f:4d7b:7d46:26aa])
        by smtp.gmail.com with ESMTPSA id u127-20020a626085000000b0053e80618a23sm15077883pfb.34.2022.09.16.15.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 15:50:17 -0700 (PDT)
Date:   Fri, 16 Sep 2022 15:50:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lyude Paul <lyude@redhat.com>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware
 update improvements
Message-ID: <YyT9p9Gf/sTgSW1I@google.com>
References: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
 <26790cfecb827245187233bc81f9fb89553bb4a7.camel@ew.tq-group.com>
 <c434ba87606d3d7696ae076684ceea67bfe662e3.camel@ew.tq-group.com>
 <a959cfe90356b702727413e7c14b246875eb88b6.camel@ew.tq-group.com>
 <4b0d603814c8740b125cc6130b67c79e37405d69.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b0d603814c8740b125cc6130b67c79e37405d69.camel@redhat.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 06:39:18PM -0400, Lyude Paul wrote:
> Would my review count at all here? I hadn't reviewed until now because I
> wasn't sure it would, but I'm happy to take a look if you think that'd help.

Absolutely. All reviews count, and they also show that there is interest
in the patches/new functionality.

Thanks.

-- 
Dmitry
