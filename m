Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1470B656B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 14:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiL0NqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 08:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiL0NqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 08:46:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8A31E8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 05:46:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FC3C60EDA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 13:46:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3148C433D2;
        Tue, 27 Dec 2022 13:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672148780;
        bh=ZJ/ZjbGyU7VityPykEjZ8EwTiNZtNPUtoHiQvrCZAcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UcDuSPNVh61pUWJk61BTgf3fxRIDYtBoAm3Tzbbu+ua81A1cH3txkE6ElUFgDWjoy
         9Gwbq/PZ9Igl4ezg/Xn5ybCvb8sC3fADPCeglLv+4BUbVtOfviJh9JNwl2B6/pk5hv
         L9WTo9sb85UjtR4JmoPs6UrFgxvu0oY/LkZiYC9Q=
Date:   Tue, 27 Dec 2022 14:46:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     airlied@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 1/2] habanalabs/uapi: move uapi file to drm
Message-ID: <Y6r3I5M6IQdSb5LE@kroah.com>
References: <20221226213227.26953-1-ogabbay@kernel.org>
 <Y6qeDQY+X6ZRn3bi@kroah.com>
 <CAFCwf11GO4n-nOhyLDAG9k9MSJ1xfjj6_1nH=X9vKgdbvY62yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11GO4n-nOhyLDAG9k9MSJ1xfjj6_1nH=X9vKgdbvY62yw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 02:04:14PM +0200, Oded Gabbay wrote:
> On Tue, Dec 27, 2022 at 9:26 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Dec 26, 2022 at 11:32:26PM +0200, Oded Gabbay wrote:
> > > Move the habanalabs.h uapi file from include/uapi/misc to
> > > include/uapi/drm, and rename it to habanalabs_accel.h.
> > >
> > > This is required before moving the actual driver to the accel
> > > subsystem.
> >
> > What requires this?  Isn't this going to break userspace code?
> Yes, most definitely it will break userspace code. Moreover, the
> patches I'll send in 1-2 weeks to change the device char files will
> also break it.
> Having said that, I'm not worried because I don't believe anyone is
> working with the upstream version because there is no NIC support
> (yet).

Ok, if you are sure that no one will complain about broken builds,
that's fine to move, but be aware that if they do complain, you'll have
to back these changes out.

thanks,

greg k-h
