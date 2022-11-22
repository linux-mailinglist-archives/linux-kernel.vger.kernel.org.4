Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 047C3634092
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbiKVPv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 10:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKVPv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 10:51:26 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EBA716CD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:51:25 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id s18so8748744qvo.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 07:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zEFNHUyLUEbyu4qT1zUf5LJn5/2APYPQvsP3GKgKfiQ=;
        b=Pkc6P4W3LxVcw/WQufFoYOJKMktfq8Bx3TWo4VgNUGskNLTugz0Hw1jOOlXT8qplG4
         1GoKzR3RkSimoc2fGczFkWkknXHEjHp2gUzsSh0XBNhOzg91hsrwAnzOM6GFiJr/X9Gr
         0ru4Mqvt4BfhKv9zgzHrAc8rKwLec7+0mIvUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zEFNHUyLUEbyu4qT1zUf5LJn5/2APYPQvsP3GKgKfiQ=;
        b=G0mi4O4Bkh8Zgrz/GucOOqqjcaKcWF1QRRfeP07nLvrRtArRGt4E4AZGgkIAIDolGI
         bx54/bSfB5zgPF6b4Dt1p8h9fdX4MPUAtk2XEXdbhEas6A6nwpKy1nH4qL0pVaMs+6KA
         2qpn6Ky196uK3Vj+0mTySLG25sN1kyJV0T3aH8dPtZFCg33pu0zCVs9MWHQo6K4jwkMr
         oBUGmApt/KW1yaH/g3Hs4dJUBnV+hsXKDZk6xl3giz6fMYU1bkwYYNRqXJLhJm+Sk7ON
         wSr7Z3lYcfTxP3GMnJ0UHJf9kziptEA5wXi76dK6leXQeWG9NQCm/5oX+yDuryeLm4Ea
         2I9w==
X-Gm-Message-State: ANoB5pmlheEwCBNjumdMuh+KsxObpDxq9pkCodu1zmlvTMy7mg1+ainQ
        Tqn83NNXzBirCEMSKVTOpZ2W2f5nF0IwFA==
X-Google-Smtp-Source: AA0mqf6ZXjTL75zqXqXjUk2/vAK4va4H6sjpXe9bq6HfTmQdZILStThXhdag4hPyZuBSd1czltVftA==
X-Received: by 2002:ad4:43eb:0:b0:4bb:7ad8:deae with SMTP id f11-20020ad443eb000000b004bb7ad8deaemr5934336qvu.92.1669132284990;
        Tue, 22 Nov 2022 07:51:24 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id u8-20020ac80508000000b0039cc47752casm8242733qtg.77.2022.11.22.07.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 07:51:24 -0800 (PST)
Date:   Tue, 22 Nov 2022 10:51:22 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: git send-email friendly smtp provider anyone?
Message-ID: <20221122155122.edxtmsqpjxgj4dsj@meerkat.local>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
 <20221121151922.jaal6ym7z2ejju4q@houat>
 <de12952f-8346-8995-236d-69dcb70f19f6@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de12952f-8346-8995-236d-69dcb70f19f6@tronnes.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 07:13:28PM +0100, Noralf Trønnes wrote:
> > Otherwise, you might consider using:
> > https://b4.docs.kernel.org/en/latest/contributor/send.html#authenticating-with-the-web-submission-endpoint
> > 
> 
> That's an interesting option. I did briefly look at b4 a few months back
> but it looked like it was under heavy development so I figured I'd wait
> before trying it out. I think I'll give b4 a spin to see how it works, I
> wonder how it handles patch changelogs.

I'd be happy to help set this up for you -- to date, this service hasn't been
used beyond a few test posts.

-K
