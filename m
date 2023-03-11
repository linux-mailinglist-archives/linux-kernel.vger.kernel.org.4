Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4226B5C12
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjCKNAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKNAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:00:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE42D2B61A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:00:28 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so12549847pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678539628;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FOVUGLyk0WaH0HGVxdTsj4sDJWFdVCG0i2OruRQuZy4=;
        b=lBo18Duv32tOvx+nbh2n/RSh3L0dKzxDqQkYBTupBedU065pc9W0WWuCXRxP1guQ3T
         ctiH4mgpNascl2fx8RPrfVXvht6YucDoZuMkSmAhLxBj9W/dLeFVvIpLYhoEmQyNcQSI
         xGiBD5V95dTuWHXTlK/klURpgf0QzpjkqQ94UyQrGPvslI+F7nYLXPcFVPa7emuGSgGL
         atLRfgPjQLi3ZAKNLEeEXON2xsswksdJrRFX0DuiL6TELssnqlhdtgi/cWJ6jQkUR6E+
         0lsri7rHBPLtMazWcaTTxnFk35cC4hpWPP6MPXoA5AtX9VWmX2KluaBckh8oLUxDic8X
         PTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678539628;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOVUGLyk0WaH0HGVxdTsj4sDJWFdVCG0i2OruRQuZy4=;
        b=HYccnRf5t5lJzJ2+g/VcB/2UZqmREljBoUjjoRF0er61NQVrlihKue82B/jVPOZTPr
         56s/wO/DNeMz4zqEIeuqLexrIrUTnro5Od4SdxPr3LSLpSsly6y+N3XuQEsAfxseZpGv
         67Uss/roByz1LT9eWutK7RbtCI89CFsS2fxUZqqAdN5w3mITejKwSR4e26IEZD7ZtrPc
         G8rIyxeRfPa161WDuO5Dr/sUeiL6Z1mjgMRObC2L/aHbJk5abzem6CD+UGcPfecFWzHa
         h2wc8A43tL/d81w96E2KLdtsL1PS1EveebfOlbQV4mG3D3rXFZ+6kRjBEls+vbu570AQ
         FVow==
X-Gm-Message-State: AO0yUKUTVtF3od+xedLGMgf9r/B/2r94g0VhfnK1OUTk5WIht0DAcqnm
        uJpepwLp1LUOoCx1C/64+io=
X-Google-Smtp-Source: AK7set/RMmZN1lZfq/y9ULfiegGNC3IR15eF59I0VUP7iwgwH5keRlqqTJOAa53NZaIokQnmcJoVaw==
X-Received: by 2002:a17:902:8a90:b0:19b:33c0:4097 with SMTP id p16-20020a1709028a9000b0019b33c04097mr25271135plo.27.1678539628305;
        Sat, 11 Mar 2023 05:00:28 -0800 (PST)
Received: from ubuntu ([117.199.152.23])
        by smtp.gmail.com with ESMTPSA id lg3-20020a170902fb8300b0019e56171eacsm1517713plb.198.2023.03.11.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:00:27 -0800 (PST)
Date:   Sat, 11 Mar 2023 05:00:23 -0800
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     error27@gmail.com
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: pi433: Change bit_rate type from u16 to u32
Message-ID: <20230311130023.GB14247@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d62635-b968-4dfd-aa10-e34e38a114a5@kili.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

The description in TODO is difficult to understand. I would appreciae if
you could help me understand it more in a step-by-step simplified means.

"This configuration needs to be moved to sysfs instead of being done through
+     IOCTL. Goind forward, we need to port userspace tools to use sysfs instead
+     of IOCTL and then we would delete IOCTL." 


