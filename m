Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5D658AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbiL2Iot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiL2IoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:44:23 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67E12AB5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:44:22 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id co23so16826431wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AY1Qo88WZIkRuG+ZDC2KWB3/2P/di58fka+9ZuMd9IM=;
        b=fPUPE3V1beCIq5fdrMH7Hri78XL2FB98edJ99HrrtlBhq8l5XNRPF7iyUyCt+labeI
         C+SpCW/OrJuOVVXA4AN4cvZMhp9sogQgaY3o8p1xEre1OFeD4zkomkER7UrNO/yeBovW
         2MWRiRlJ2z5dpewZrT3uBB7DWkco4abciznSt++X9nE1FlJUhkLxbP0bjPmLVgo5bjRB
         Rq7BLJDe44lq1a+Tdmf6MrB3t3ILyAWTE0H2A0qO9A8vw974zruExDEJ5mobmwXNMC3Y
         d7ZzPM02CQLoKPfxRPDNrMNZa2wnhvrv1rAJAmfJzdDmMV5HM4b1ecOsgq/HvFhcYEpE
         Yh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AY1Qo88WZIkRuG+ZDC2KWB3/2P/di58fka+9ZuMd9IM=;
        b=ERubrfPkUufHcweuJYFQ4993bPaLTKFzHWLeFBfPV2hsCl+HJ3p78Qyi4oxHSddSDL
         pIANdfO7iBExWtL8idgEGbD1c8nPNvvAkORJf/Lorh3T0l1yGyyjSFdRBQwEHDiF/A4i
         iW3iG25RYE7NP+cb0wZws1XR/jPDC3hGnrUOTqL33p43Ki9B/krIUc9aoaRFHhhfj8lY
         rp4UZ3V8hJkWZacGATXw3QjI8E/F+LF7yYJobiAZlPEKlhVe1rVqqypo/1xMOi9FyBwE
         HejFOfr9FNjx3ZJuSOlSLUPWFxqjZFWPVg2IBLFNo1Y9jwc3gug7jABnGqtAOVkVWK1W
         ZzfQ==
X-Gm-Message-State: AFqh2kpAKy9CKCaH0P0AFaeMZMhF3tvsQihYLKeSm+AxgS6eMDGucAnw
        GJm9CUIHO+eYPLLMBs0gaHSazaK2HoJglg==
X-Google-Smtp-Source: AMrXdXsqovVilNtg829q36pX5SKURi5x+Zw5u+rQQfok5rU8zud7SCEYkrvUy5UdpOd3f2DUPO7rJA==
X-Received: by 2002:adf:e34e:0:b0:242:ac3:87f4 with SMTP id n14-20020adfe34e000000b002420ac387f4mr18442415wrj.50.1672303460711;
        Thu, 29 Dec 2022 00:44:20 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n14-20020adfe34e000000b002366dd0e030sm17686502wrj.68.2022.12.29.00.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 00:44:20 -0800 (PST)
Date:   Thu, 29 Dec 2022 11:42:48 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in
 comments
Message-ID: <Y61TCOiz2oaA7txp@kadam>
References: <Y6mYdPlqIK1VgQ0Z@local>
 <Y6mnBSg6i5wMCKUV@debian.me>
 <Y6nVIdQwIDdxbhY8@local>
 <c56b6b9e-27b2-a064-a4d9-a4926474f1bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c56b6b9e-27b2-a064-a4d9-a4926474f1bb@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 08:51:00AM +0700, Bagas Sanjaya wrote:
> Also, you need to edit the patch subject to "Fix codespell-reported
> spelling mistakes".

That's nonsense advice.  Please don't make yourself into a roadblock
for progress.

regards,
dan carpenter

