Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6099D5E5527
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 23:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiIUVZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 17:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIUVZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 17:25:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9044F303C8;
        Wed, 21 Sep 2022 14:25:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE39632FD;
        Wed, 21 Sep 2022 21:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823A5C433D7;
        Wed, 21 Sep 2022 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663795500;
        bh=6mqhHKadTwSrIV8AEhV9mdkJaDowgQgjrzX1GdwzUxE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6S7oml5BEUQDpQzgg7br7KY5UemYjJRfwyN7llbgrY/fQapZSSC3aN9yQBsueAae
         5ikxRe5q9xG2HJjboHC2f52mYrEynCC1YmdPiSw6o6DipT5Hfl2OD0nz56wMchIrhV
         f7CAkY5LO8Nj4D7V6FYISxdYb6tYPfBG7hL/LHZ2EL41L7jRismUBLbMxIl/PziX8L
         vDgpE4cybveoIciRzbd+etYbe/NIg01PSbUfxwTF2ALYFj/HYALeulYW0BJcKUKkKJ
         Z3hzEKFzTvxtKaa/Chpn3LfqoOSQHrwVIU4mgJ+yI0CveT2N+cCxPYNvqdCfN5adri
         FrGwEeYLq0j7Q==
Received: by mail-ej1-f41.google.com with SMTP id sd10so8243084ejc.2;
        Wed, 21 Sep 2022 14:25:00 -0700 (PDT)
X-Gm-Message-State: ACrzQf1I0lHIx+WR4ft9oNFZMy7bDMiYYXukicZVePLex0TGlAjNvFfl
        aeOqm7qMs0QLKhwPqNIrLBB2RgU9Yb650uk3c2M=
X-Google-Smtp-Source: AMsMyM7i/eVuIVrLaeZtWtGpXCR6RhtvQMTWsCtsNN19iVpSniqUpCxRn42V0mZMBIE6AHrfNs9BKjaTQmucabgy0sY=
X-Received: by 2002:a17:907:9807:b0:781:feee:f87c with SMTP id
 ji7-20020a170907980700b00781feeef87cmr187773ejc.101.1663795498740; Wed, 21
 Sep 2022 14:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220921162837.29867-1-logang@deltatee.com>
In-Reply-To: <20220921162837.29867-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 21 Sep 2022 14:24:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5hK3TAVQPBod4REnuj6MaYOfR=VK41sj6ENcFrBUogdQ@mail.gmail.com>
Message-ID: <CAPhsuW5hK3TAVQPBod4REnuj6MaYOfR=VK41sj6ENcFrBUogdQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Updated MD_SB_CHANGE_PENDING fix
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 9:28 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hi Song,
>
> Here's the updated fix for the MD_SB_CHANGE_PENDING issue.
>
> I've run my tests on this change on a branch along with Yu's
> series for a few days now, and it seems solid.
>

Applied to md-next. Thanks!

Song
