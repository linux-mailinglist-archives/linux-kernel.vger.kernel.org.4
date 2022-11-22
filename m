Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB155634934
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbiKVV0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiKVV0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:26:17 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0726ACEAD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:26:15 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id d18so7454750qvs.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 13:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H/3w9yKqqRG++46SYKw/BvQ7OXa5qiQLydJKuGizLjM=;
        b=OEeURiKxi5yR2FfAezt4doRA2iCud9LVWoVbXOvejmapl8ihM9YHEElXzysAANCfxa
         dQbQB24lXf3tDszqiMSczQqra98Kh8OeBOwMzLLYO6eEn5XnslrT3Q8IuV1dSqYl43xU
         Z4o9oM03xmFj1RJeJnOy6MUpYPiJiYbPu9mCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/3w9yKqqRG++46SYKw/BvQ7OXa5qiQLydJKuGizLjM=;
        b=oPEInAo7nBaT7FparNlFtrN9CnsLoqEqOfISXprsX3JuNgZ4khJZdZ0kDJBF351z4S
         rY5IFO0wMf+F4uC+7By8yOihTFyV9qMXZn8Cq+63pjSyC0TDyEKGT0/IW2ZMrozNsvgO
         wG8veeviunjPz8ajGWI1V9XRPwLX0TotiPKzkjoKXzykIkjmvokQ0FGzTNPgj8F4ntut
         nnyjfQ5gOrWS4IzXDpKq2SskfnIuJDDDXyfLP5NHZlUevgs3MJnw8muDoerJKMkssgUo
         RgjAZfbR8de4pIu5eTmjg6zxkX+rds7IFoWqQHFbr129kBIoC4UzmxL2fYwLC7WlFN7Q
         aVKA==
X-Gm-Message-State: ANoB5pmzTE5evtxqqkfCDdTuebBCsXoCA5BCdWJLAm9rdSHqCf0lc+SR
        86ZIL26hzfuyldKM7jMBNtZfq69B+in6Vw==
X-Google-Smtp-Source: AA0mqf6tagH+MzMTfd+Es3fiBHAq8mjPv7ni0PixV/V4F1Bx3v0jsuCgqKjaWc2ULHVGOTrQK7alCA==
X-Received: by 2002:a0c:90f1:0:b0:4c6:8f2e:9a2 with SMTP id p104-20020a0c90f1000000b004c68f2e09a2mr22270476qvp.100.1669152374770;
        Tue, 22 Nov 2022 13:26:14 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id f14-20020a05622a114e00b003434d3b5938sm8870457qty.2.2022.11.22.13.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:26:14 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:26:12 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: git send-email friendly smtp provider anyone?
Message-ID: <20221122212612.sbqv47ecsgiqmhss@meerkat.local>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <20221121151922.jaal6ym7z2ejju4q@houat>
 <de12952f-8346-8995-236d-69dcb70f19f6@tronnes.org>
 <20221122155122.edxtmsqpjxgj4dsj@meerkat.local>
 <3b06dfd5-0eb4-dbfc-6ba8-077b1a92865b@tronnes.org>
 <20221122185001.q6hmeblp64jqdzvz@meerkat.local>
 <02bc2442-e3b3-d720-9d13-ffcdfd760fb8@tronnes.org>
 <182643db-e5f4-2277-a971-0f159849dadf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <182643db-e5f4-2277-a971-0f159849dadf@tronnes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 10:10:47PM +0100, Noralf Trønnes wrote:
> Konstantin found a workaround, so I was able to push the patches.

Yes, this uncovered quite a few bugs -- which is excellent for me, not so
excellent for you. :)

> Here's the result if anyone is interested in seeing the result of using
> b4 and the web endpoint:
> https://lore.kernel.org/dri-devel/20221122-gud-shadow-plane-v1-0-9de3afa3383e@tronnes.org/
> 
> Patchwork gave me a new submitter ID:
> https://patchwork.freedesktop.org/series/111222/

Oooh, I see that patchwork is still not doing the right thing with
X-Original-From. It will only do the substitution when the From email address
is the same as the email address of the list.

https://github.com/getpatchwork/patchwork/blob/main/patchwork/parser.py#L437

There's unfortunately no fix for this that I can do on my end. :(

-K
