Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB75F716028
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjE3MmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjE3MmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:42:07 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31531192
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:41:49 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5289cf35eeaso3842543a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 05:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685450500; x=1688042500;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcpB52c/UtNvFZJAngMvWnMhtf2U/fgcu67BgG5nIYU=;
        b=ak2kwL1WfIK6rbLQVx8LyRPHqpOyh++Aw6IRctrHkgD6I/fgYEGZqRxTvhwMs+u2Bj
         H4nHuhQc2x5QG2QWSdqcIw+4otST3+PPvEFMzd+QEvFyLO33r087r3dZZLS4UUepEKug
         AecZDh/GLWGZEANN5Pk1veWI4Jam+RDSlWM8O6y3dIDvqg9vQsWgpz4vOsmJa2YYyTV4
         q01pEGTX4Ei3y7kYLAYVB1/KgGTU402wbzh3oHMmuZa9pBxwS/aRbUEA1PIAVSmoa6B0
         iXuzKGMYvve2mw9yxRmcP4d+gn1aYLEY8bMhMnt79Ix5gowczow5NBR3A49oSkPZ47nN
         jrIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685450500; x=1688042500;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OcpB52c/UtNvFZJAngMvWnMhtf2U/fgcu67BgG5nIYU=;
        b=Ig9FaBHA2eK4hJP5I648poRUreFwaUtrf+qqODeYlFIWkjOEp+l1AdfQD7sTWEeG7N
         uN3G11aDmCeV+VKzd87gCTOUCEtfnna13qJbJWImVj7Zj6nz3D9uiSr4LbriSzvjny1e
         potbz90LPgmYJZNLgrAJIldsGVSXrBcxg5I8me5tSfTl3Mr5APzrelwP4R7xeEMfJagT
         aqNtKYYj/lGd32YV7nr02CgLC5Va20djpMutEfYP449QND116cwyIb+qZqrF+HceZrl+
         fk1qOAf/RUGjXTsk0fBPFnleTNlx5N6DvgUGglTOxwqbA9Mqatp4TgS0niYRKwnwX0TI
         4g9w==
X-Gm-Message-State: AC+VfDwWD/APT8Za3XeihCYhA6B8qSm+cAN8MOu8tNGfW8RiccpylU43
        tSoOpWAMi57AlkoKQf1h7cJvbil7xtQ=
X-Google-Smtp-Source: ACHHUZ4hOUep/dS5YqlmauRgyXZ+kx76jLICMS8jSzjIekHzB6snZ7G64dbSii0o5Ple4ZrSIk2bYA==
X-Received: by 2002:a17:903:1111:b0:1ac:820e:c34a with SMTP id n17-20020a170903111100b001ac820ec34amr11046997plh.0.1685450499604;
        Tue, 30 May 2023 05:41:39 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id q3-20020a170902dac300b001b0499bee11sm3438873plx.240.2023.05.30.05.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 05:41:39 -0700 (PDT)
Message-ID: <cf4f50bf-99ca-f94f-f0cf-63081d531b4c@gmail.com>
Date:   Tue, 30 May 2023 19:41:36 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: regzbot dashboard stalled (no regressions reported generated for
 v6.4-rc4)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Regressions list on regzbot dashboard [1] seems stalled. It was
last compiled on last Sunday (2023-05-28 06:18:57 (UTC)). Is regzbot
not running, and why?

Thanks.

[1]: https://linux-regtracking.leemhuis.info/regzbot/mainline/

-- 
An old man doll... just what I always wanted! - Clara
