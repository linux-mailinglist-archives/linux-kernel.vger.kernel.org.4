Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0F862FF76
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 22:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiKRVlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 16:41:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 16:41:48 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB98DA4662
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:41:47 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h10so4229848qvq.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 13:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NEmbr3CpckQIhKpXHWOoRcTosgu064ftFbEADinoMhc=;
        b=A3PrIIpD9uqHtyy7k/x0ry2h6mxexs0T1AsiGMbwSMqa2YSaY9zlbV8ozgpl1BUzs/
         03L8QBonbm/cFSGhSBAkBred68QUKY1HoVSV+eyM/0EtQvM9PTN/xPaZvtKa847jA8sA
         VpJjTeH3QJxx8RjrixBlJX1TV5tUNqvcSEj0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEmbr3CpckQIhKpXHWOoRcTosgu064ftFbEADinoMhc=;
        b=pFu4NL94zNSgY9MRbQu+H7d7dP6xT+vs8+kTfATEsqNyXqXgX0D0jTtc9CH/mP93dV
         PPq7vId67UAtQaJ9oclRQfL/yYNDJTkWcrPajZzuFbqjt6Y5+3Lme/Hh3cq2UxMpsD+y
         tftJudw/27xpRPsGJ5zJdsfdSxS6dA7Vvy4zcQ1ThScQK1Z74+EJ8zUiVSbWYFRDbSR4
         LZAOrHC/BiNSRvSj22xCkPIrPPukGkUwD+aSGcDMJMU70BHuJTtIY82S8jtuqtAVFCsa
         /KRSVeNLoL6JWW7ZPjZi05pzk03J+F7y7pGHFyhLbL3/fLIo4JUzaaRK8Warf5yBAiT2
         gtDw==
X-Gm-Message-State: ANoB5pn5FhegFY1FUSQiy8qLP9UtNUaAGIaSfRPTYsPiiW2uYEl7xoHi
        jaXmoNIFxv47qU1DOcNFyI5nZgJgKmnhnw==
X-Google-Smtp-Source: AA0mqf5SkmMjfiQCyPWnw3LPK5kTi2HGiiAioVTxXYSKxGesJaW2XRgvfUmuM0G6e9p9x8uuP5bYww==
X-Received: by 2002:a0c:c682:0:b0:4c6:80d9:844d with SMTP id d2-20020a0cc682000000b004c680d9844dmr8496003qvj.34.1668807707055;
        Fri, 18 Nov 2022 13:41:47 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id f1-20020ac84641000000b00343057845f7sm2608807qto.20.2022.11.18.13.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 13:41:45 -0800 (PST)
Date:   Fri, 18 Nov 2022 16:41:44 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: Add linux-um archives to lore.kernel.org?
Message-ID: <20221118214144.cqvo234tjmo2bagn@meerkat.local>
References: <20221012191142.GA3109265@bhelgaas>
 <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com>
 <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
 <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
 <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 09:58:31AM +0100, Geert Uytterhoeven wrote:
> Is there anything from us you are still waiting for?
> Thanks again!

Nope, it's just waiting for some cycles. I should be able to get it done soon.
Thank you for your patience.

Cheers,
-K
