Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489B05E9123
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 07:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbiIYFhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 01:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiIYFh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 01:37:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659EC3C8C8;
        Sat, 24 Sep 2022 22:37:28 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so3984170pjl.0;
        Sat, 24 Sep 2022 22:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=2lQ3BKfmLItfKW5iLMtD4GleXGk399C68O79h/sEFPs=;
        b=caOqhE6TdmSe4LdFUykrQAp/rz28oAuZwcrTiImwcUO8DJTL+W8K+qz5CDx1H2RIy8
         C9UYa4OBhCHM+z1/edkDYItWaQHbRGZoNF+W/H2lKTKbQ2gCHp9hyK30y8z1prqOvcPV
         dSV2cu3WFCbAWy5rV3fKHEQlzLnB6NzCP+7HWcmpkBd2yOyg52NvvCVUj+V0GM6tVdCH
         P95g8F9MQ4c2vOGqfuszEUjjWpjwSD85Jjvj2LKCw8dG8MUwEEXJFUaLUcMXQQ5TLuAQ
         lnQB5yOokTrRH1KSXXDwQoaMSELTF6VfbrG9Yg2yZAicdu8CcZoRRwKJ1OIIqZ2yWjsH
         iNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=2lQ3BKfmLItfKW5iLMtD4GleXGk399C68O79h/sEFPs=;
        b=NQTdDSsDrQ2Nt8oD+houmS4ZF9asZ4ds12GolzFMEZ18Fd5ftusumWl+zL7iGWDB8g
         co8+3F1ntDsz0TSovzjan6fpKy1ErLal91ecTEWLouBpMwB6hCC76vfbFpQBiyVcyd7Q
         9Pj3bH3nqSSAzDlICXyIbE4V/OE8hFj1ehY2k59EHKuT7ItoaQy4nLfsg6kD4KyZ49xL
         Cy6sygLhKAfjKIRSRvii9oUmF3QtV9vE/BcWjeEMY92uYsxlH9aUcbcivLGm8xe75HAi
         sq3JpTiOqqNG8vkP6Be/wS141khcLKfnAjgTnDRTZUA3V25HC8OZW+sFTdQpkokjZyho
         /JCA==
X-Gm-Message-State: ACrzQf1UaYon3WW/vGGLeM9VG4rAwkRKYXRtCouawnzzjlOzp+eyXflk
        7op9XDGv31ToLmJSfCGikKAsf2lQn+Q=
X-Google-Smtp-Source: AMsMyM7ltiRZUUklIiF3Q+79l79GwNDk0BM13OrOw4u4Q9pOmaCzRSCMZTG4Vq6B1veZK3acNUfrzw==
X-Received: by 2002:a17:902:b085:b0:178:3af4:31b2 with SMTP id p5-20020a170902b08500b001783af431b2mr16511098plr.122.1664084247757;
        Sat, 24 Sep 2022 22:37:27 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:37c:3916:9a45:14cc])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b001783f964fe3sm8689674plg.113.2022.09.24.22.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Sep 2022 22:37:27 -0700 (PDT)
Date:   Sat, 24 Sep 2022 22:37:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: twl4030-vibra - Drop legacy, non DT boot support
Message-ID: <Yy/pFF+Y6Fvq3bmd@google.com>
References: <20220616153323.29464-1-peter.ujfalusi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616153323.29464-1-peter.ujfalusi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 06:33:23PM +0300, Peter Ujfalusi wrote:
> Legacy or non DT boot is no longer possible on systems where the
> tw4030/5030 is used.
> 
> Drop the support for handling legacy pdata.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

Applied, thank you.

I suppose you will be dropping definition of struct twl4030_vibra_data
from include/linux/mfd/twl.h as well?

Thanks.

-- 
Dmitry
