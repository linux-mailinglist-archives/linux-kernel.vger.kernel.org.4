Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7280760D260
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232411AbiJYRW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbiJYRWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:22:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C15E09B9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FA3D61A5F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 17:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC39C433C1;
        Tue, 25 Oct 2022 17:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666718539;
        bh=b2jLgOkbVkgTFTZHzgyPA7Qmaai4R+6ZbvML08sPZ8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGcaCVTWH69C0Hr/M2My2JludMZyyrkr7NYNOM8i6rIGudr+GcROIX1eqmUgJvi1m
         rOQp1BVl++YOu+PK1vY/AVI7g5pDGh1eUqVRNkG8tUVDXudml2D4uZDGTJQUt4AaWA
         zTdg0yObDCvWmchtRx6I5H264wxT7WZiBolLodaM=
Date:   Tue, 25 Oct 2022 19:22:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kang Minchul <tegongkang@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] staging: r8188eu: cleaning up unused variables
Message-ID: <Y1gbOfBBkqt1m5rS@kroah.com>
References: <20221024084925.262289-1-tegongkang@gmail.com>
 <CA+uqrQDuJQ3yBY8_re===u0f97pyr_hn_VNu6LqLJAZnDeqhVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+uqrQDuJQ3yBY8_re===u0f97pyr_hn_VNu6LqLJAZnDeqhVQ@mail.gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:23:08PM +0900, Kang Minchul wrote:
> 2022년 10월 24일 (월) 오후 5:49, Kang Minchul <tegongkang@gmail.com>님이 작성:
> >
> > This patch series cleans up unused variables in r8188eu
> > causing coccicheck warnings.
> >
> > Difference between v1 and this patch is that this patch series
> > include making function amsdu_to_msdu in /r8188eu/core/rtw_recv.c
> > into void function.
> >
> > Kang Minchul (4):
> >   staging: r8188eu: remove unnecessary variable in ioctl_linux
> >   staging: r8188eu: make amsdu_to_msdu void function
> >   staging: r8188eu: remove unnecessary variable in rtl8188eu_xmit
> >   staging: r8188eu: remove unnecessary variable in rtw_ap
> >
> >  drivers/staging/r8188eu/core/rtw_ap.c        | 5 ++---
> >  drivers/staging/r8188eu/core/rtw_recv.c      | 5 +----
> >  drivers/staging/r8188eu/hal/rtl8188eu_xmit.c | 3 +--
> >  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 4 +---
> >  4 files changed, 5 insertions(+), 12 deletions(-)
> >
> > --
> > 2.34.1
> >
> Oh, I guess patch 4/4 can be fixed as well.
> I think the function rtw_sta_flush can be void as well.
> 
> I'll resend the patch later.

You broke the build in this series, please fix up and send a v3.

thanks,

greg k-h
