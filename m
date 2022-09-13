Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB275B791B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiIMSGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiIMSF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:05:56 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE78E993
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:08:29 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11eab59db71so33840415fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AOGTh3GKdWU7THGxi9ZhEFRxJH4/0f8P0CcnJCbFnFQ=;
        b=xezzV1+jHEunSwyHWTjYMvGX27FDGUBgvQxpJjrMP4YnbtX8V5uxQCRzhQ7UM63Cjw
         E7KLs++hGZe6NNq27LTAf5bP82xxxCe13sKjR1NV1dxfd+EfEQ+oYM0qjI8qBXDoalVX
         r6L/IwrKJQmN4BD8gXyhqD/dHKCD6xXxPQNrEpQHJD10tW4F6S66dIzU759vKbIYwS5n
         Jm3HEgwl6JcukmgtHIFtq59Tgn/MUMeP8GVD2ga4gmvRGW0PyCtG7LhjOqM7PvjM7LT/
         HUK4/+pmrHQrGT9wgxMQM0fCBGdZwRXJVT12DSdZXNP+l8x2rIRoVvjnrIKP1N3cozCt
         PXZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AOGTh3GKdWU7THGxi9ZhEFRxJH4/0f8P0CcnJCbFnFQ=;
        b=Fchw1dBJgnQzi5XsEmef+xN0gmWqbUiUrkxv/fWdPbPzTxL/qChJTTvq2ik4vNi789
         p3/2uvn8NAtbYjK8CJ4DTgYPwuYbofpBNtVYiW+IDMeVe+I1v8LoU4Em4+Gsfv7JNZLD
         uYd/eMs/OyiKb9AiewP90adi13aaW2Fn6BRhrnObYq7EUwSfnLW5l2dYOqNWhiYjLOZS
         bydZqBvACESg8Qlm/J3CHyU6X4YkjJVtJ9SgR1UbBelJkvVWxvd6tWEOrU8kcDPXH7fh
         jtcR4fKXpYN8Hh4Zb00v7JXflKGN5E3kcz40ivLffz/qIZJTXUzH9KirRB/WEKEUcIiB
         MCeg==
X-Gm-Message-State: ACgBeo3N2lfnGRneehpf+rNkwHMHFp70sqO3RGfcyFKrZaUQHQoaeXUk
        tq85fpuAZIP7BIWZG7t7ApIefgvRtOJiHK+7TXp7RDaqQkDVsg==
X-Google-Smtp-Source: AA6agR7i9eei6FD8BfUnoGsGGBZZKBB08GdM+ONY19eFGhFLjSpFF19G6iK1ZJv7tq6Yyc76BOxYFFVTLeA3KFWW1rw=
X-Received: by 2002:a05:6808:1444:b0:344:f010:27d8 with SMTP id
 x4-20020a056808144400b00344f01027d8mr132857oiv.33.1663088908498; Tue, 13 Sep
 2022 10:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220913201557.2513488f@canb.auug.org.au>
In-Reply-To: <20220913201557.2513488f@canb.auug.org.au>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 13 Sep 2022 10:08:16 -0700
Message-ID: <CAJ+vNU2naFP=X1B3HwPCRez7Phft3OGA0sM6TMZUXJ78S5s6Aw@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 3:16 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> In commit
>
>   c1f84a75babe ("arm64: dts: imx8mp-venice-gw74xx: fix port/phy validation")
>
> Fixes tag
>
>   Fixes: 7899eb6cb15d ("arm64: dts: imx: Add i.MX8M Plus Gateworks gw7400
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line.
>

Stephen,

Sorry, that was my fault with my editor's word-wrap getting in the
way. I will be more careful in the future.

Is there anything that I can and should do at this point to result this one?

Best Regards,

Tim
