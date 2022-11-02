Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A1A616287
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 13:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiKBMQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 08:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKBMQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 08:16:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CA3233B8;
        Wed,  2 Nov 2022 05:16:38 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk15so24211298wrb.13;
        Wed, 02 Nov 2022 05:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MIQpV6ASdp5EtPUFNwNW4tWoOWg8tJ6K5b3MTsbc3g=;
        b=ajqXyytBL4q+7pjyyyhqP+XOg1aIeC4xjkoTAAYAG9mWwC+RrjG2HUgdZLMbzamOoG
         DuOFX4E4u9k2Ce9Q53fKg/X2RudHp8Bhs4byLBP5PVNHB/BUTIFss1e2wvKafDfIL4Ji
         ZyJDyyYYujIvEZ1xEvfNgTGvdTk6N52z+ZyxXXQ12ioIQdy4dlGM6sDaDE8jGOdcMVOi
         YFOa9G4ts/qScAFc3RojY9AT+FSaY7FNG+BhxkpPOisibYHKX4CC9fKIe3+A8uCTTFOW
         RUAXrwWa615oPXc01U2Q4EzWvNhVWFByUr/lW/pVkl6rHST/Tv9Bzo9ZNTK+bp5r98zA
         xFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MIQpV6ASdp5EtPUFNwNW4tWoOWg8tJ6K5b3MTsbc3g=;
        b=PuuVuCxqgdyPs1W9dF7xx473qmC8ENrglE2kpEFfjuDV6hjQL7AO4iofsjgUvxwbjt
         fUmicfIG+0VjKKv5REqcoOFyEA1z+Dwr4FG9ViJLLMSTobX6xRiIUK54gqJWdHPGyO2R
         8YaeNftgB0I5SOsICPQZWA2niQr1kX7wxN1ZItV2qVMBE048nywLLGv+SsuShKKq9S/f
         zlXEPl+O96whtSd7L5vcCTWgfJpab5bSxB2kAxCztmed5u1jL2KBPPVSV6NoHqriTdRs
         dUxSB7iRvhLRsbE1fDNjcQskRTQ4zFhiAV0F62/8Uz3H7XcnS4oGgGj9nAqFz/jdRxt+
         lCJw==
X-Gm-Message-State: ACrzQf1upv7jpXkrVodLbHeC8gQHkUY+rh8Hu1ORaauFsadsyrj1eRXb
        L6LQrcQcSRR2Em+B5EGeKkU=
X-Google-Smtp-Source: AMsMyM7qSDRpvHpsRDctTsuQynI0xFJBT21j2TX4W49PHbEB3lwdx5/hHi/PXvoSH1BX4K9+qgeQ5Q==
X-Received: by 2002:adf:e192:0:b0:232:3648:776d with SMTP id az18-20020adfe192000000b002323648776dmr15126189wrb.698.1667391397577;
        Wed, 02 Nov 2022 05:16:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k18-20020adfe3d2000000b00236705daefesm12583387wrm.39.2022.11.02.05.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 05:16:37 -0700 (PDT)
Date:   Wed, 2 Nov 2022 15:16:33 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Laura Abbott <laura@labbott.name>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-kernel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: drop Liam Mark and Laura Abbott
Message-ID: <Y2JfoWTaAW6QjavL@kadam>
References: <20221029131734.616829-1-bagasdotme@gmail.com>
 <20221029131734.616829-3-bagasdotme@gmail.com>
 <aad04e06-59b0-f630-7cef-fdb557860a56@labbott.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aad04e06-59b0-f630-7cef-fdb557860a56@labbott.name>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:44:56AM -0400, Laura Abbott wrote:
> On 10/29/22 09:17, Bagas Sanjaya wrote:
> > Emails sent to their respective addresses listed bounces (550 error).
> > Their last post on LKML was two years ago ([1] and [2]). Remove them.
> > 
> > Link: https://lore.kernel.org/lkml/alpine.DEB.2.10.2002201508320.1846@lmark-linux.qualcomm.com/ ([1])
> > Link: https://lore.kernel.org/lkml/b85fa669-d3aa-f6c9-9631-988ae47e392c@redhat.com/ ([2])
> > Cc: Laura Abbott <laura@labbott.name>
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> > ---
> >   Actually Laura's last post was a year ago from her personal address,
> >   where she announced 2021 LF TAB results [3], so Cc that address.
> > 
> >   [3]: https://lore.kernel.org/lkml/6e307861-3149-a984-cc79-088559caeab2@labbott.name/
> >   MAINTAINERS | 2 --
> >   1 file changed, 2 deletions(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 63a84d3218a7b4..564c3c66077e0b 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6221,8 +6221,6 @@ F:	tools/testing/selftests/dma/
> >   DMA-BUF HEAPS FRAMEWORK
> >   M:	Sumit Semwal <sumit.semwal@linaro.org>
> >   R:	Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > -R:	Liam Mark <lmark@codeaurora.org>
> > -R:	Laura Abbott <labbott@redhat.com>
> >   R:	Brian Starkey <Brian.Starkey@arm.com>
> >   R:	John Stultz <jstultz@google.com>
> >   L:	linux-media@vger.kernel.org
> 
> https://lore.kernel.org/all/20200108213055.38449-1-labbott@kernel.org/
> https://lore.kernel.org/all/20211207225458.622282-1-labbott@kernel.org/
> 
> I've sent a request to change this twice and I don't really have the
> energy to continue chasing it down. If you can get the removal merged
> go ahead.

You could send it through Andrew's tree.

Andrew Morton <akpm@linux-foundation.org>

regards,
dan carpenter

