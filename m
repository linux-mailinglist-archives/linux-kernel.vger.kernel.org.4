Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863C46360C7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbiKWN7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbiKWN6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:58:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4A62040
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:53:06 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id io19so16689496plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9CmsBIWPbQRo+TQhWjPbgMCBvMUGNV8/tiPp8eu33A=;
        b=yxrVfZ0wWyZdqelxuvxh/YdZ1nBYHWUwk6oxwPvk304duX4I9vWxogIpb/cfsEI9zH
         dCIdvO8YnEFqAOJLXg0N1SOM+SnEXBRVhIqLMx6Rmzku19LfNnyUCTa50K3hCFIWIEZE
         QCIawit9/k4dg2LsuT7kqRWAf/POAws9KaYOSg7DCNAVEGu/Z3vM96SDxTj18uQqUftz
         xDWV+lHziX73nHBXddpuF6QFG72Rtye6ddy8nUvhCS4ZgcFGtWTDqqwqdSgFX8dE5AWa
         va+hedob9txWrBhyl10U3on6RwBARyMaZp4UVjeiyJrHl/BrYkb4SBTWFiKj3C9lmBUo
         Xo2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9CmsBIWPbQRo+TQhWjPbgMCBvMUGNV8/tiPp8eu33A=;
        b=l6Mu64N/A+iKTua7jKWqgUU+nasmydXdbGnqpyG5O1soBzthPsw27THqZCiH0Hziqb
         A1VWYDW99WYwcUtnl3WeS+j2Q93pbkevAQEcRkMa2ZeX4j+qnMzJXVkSSZtY+lbnjUc0
         g9sZTWhVzyCpyI9e7srUPQRNiqv7NdQ8Sh0AfD02Lc4OSf/8KkN1gEB9m9J7DooSglFB
         1+2nH6axAAlpqnOaSyFnBtwX4F6TAGukQF5FLOfxDZnyExHCztgT8EI4ro/L2p5ZaXKn
         V3cB1CU39VZNPWYZzxp93uyvWGUdSHfcYcPHQG9pg+QrXRGCUt5vXMW06FAbOVaSHzfR
         2zjw==
X-Gm-Message-State: ANoB5pkiwB/asojLyA0ZfiD5mNmy90sSer4r77oEMKR13j18ynZ8gxUH
        11TsCBBPiqvA0+37ussnQD1GGQ==
X-Google-Smtp-Source: AA0mqf5sVEtPanjRBHYnlAf9OAv84TFp0ljtU0HTcjdOSxHLvWkAQFzNWw/gOjyRff/Sv+CxIY6HSw==
X-Received: by 2002:a17:902:f68a:b0:189:b07:10fd with SMTP id l10-20020a170902f68a00b001890b0710fdmr8726256plg.151.1669211585735;
        Wed, 23 Nov 2022 05:53:05 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c3-20020a170903234300b0018862bb3976sm2222618plh.308.2022.11.23.05.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:53:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Jinlong Chen <nickyc975@zju.edu.cn>
Cc:     linux-block@vger.kernel.org, hch@lst.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <cover.1669126766.git.nickyc975@zju.edu.cn>
References: <cover.1669126766.git.nickyc975@zju.edu.cn>
Subject: Re: [PATCH 0/4] random improvments and cleanups for elevator.c
Message-Id: <166921158474.84780.6332237082581853166.b4-ty@kernel.dk>
Date:   Wed, 23 Nov 2022 06:53:04 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-28747
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022 22:21:22 +0800, Jinlong Chen wrote:
> This series updates some function documents (patch 1 and 3), removes an
> outdated comment (patch 4), and adds a warning message (patch 2) in
> elevator.c.
> 
> Jinlong Chen (4):
>   elevator: update the document of elevator_switch
>   elevator: printk a warning if switching to a new io scheduler fails
>   elevator: update the document of elevator_match
>   elevator: remove an outdated comment in elevator_change
> 
> [...]

Applied, thanks!

[1/4] elevator: update the document of elevator_switch
      commit: ac1171bd2c7a3a32dfbdd3c347919fee32b745a1
[2/4] elevator: printk a warning if switching to a new io scheduler fails
      commit: e0cca8bc9cd8d6176921cb3f5f466d3ccfbc6b99
[3/4] elevator: update the document of elevator_match
      commit: f69b5e8f356e4e57e94b806ca1dcb9771933bb9c
[4/4] elevator: remove an outdated comment in elevator_change
      commit: 4284354758d67cf77ab2a4494e28d4c05fb83074

Best regards,
-- 
Jens Axboe


