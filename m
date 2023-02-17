Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB4169A49F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBQEEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjBQEEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:04:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0198B166DC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:04:31 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id eq11so10794781edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HxmUSlJXaf6nTG5D0bylzf06QH492H43qo5VyH1HCv0=;
        b=Oe48S6nFeeuh57y6PJwlajhHUNdjJbA56bg8u8jzeqWafp9VdwUQWtaI4Iv9kimQOw
         bEeU8umc6LtnIkAx+iarURZvIHJP+nV23abXYGn5Mt7fKbMFiawcO1G+uSjsLlPAFlWw
         AhZzpg4wuH4yNoOEacLgs0Hb97xZJlOSZYyo1d8FQgjUUCpKhdBdH1woT6o2mIGsPyjq
         J4+/ZCP087BKhcE9R/JGgMkO3b8MXVhx/rwYxZs8mZkgbIO9ey0/f9ujCSzRVw4SCJ6v
         HqLZ7KODZVRXdFuhgf9Kct+UPi40QOqyAXrwt9/KxC7toh6TEtebKVaXHnTYqIz4oCgJ
         j/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxmUSlJXaf6nTG5D0bylzf06QH492H43qo5VyH1HCv0=;
        b=07nTpAoxvmr5YGiRGVr0JaCSCLzGWBeOFxEjAdRYxh2k+aQIvxnxBXwFYiYHNs8FOI
         UJ7nhyw72uLaCkPMtAce0oXP2EdyljINESbT1KrEOB03FGfz7T2xTapHt/7EDDxoCZEA
         RfTQHZS2IOeXxbC2qm07YNiufV91znb/qGNwq7rzmWdolN+QZ3ojMNIQAB7yPM2yh4d0
         IziEr2x5hk6a5U4XEVZEBVtIxsGzwcrrSpTj7vIDOtbyw5CMJYsndFj4YClmYsdSiUBe
         Y/hx3sJpqggI0T8Rwd0sUhsKdnQSl5OjdyOmMFtj1iFZS+uPdbTXQ7uiIHVcmAEx4Bdw
         mhEg==
X-Gm-Message-State: AO0yUKX4p4ZTuWM9MofN5ys0E5h9QnzZI8h5XcPVvBFM+Qz30sP9JZHd
        l4LLbV6KbMiNwhw2tgDojwrEPSEZWAVQQ9Twe/c=
X-Google-Smtp-Source: AK7set/SgkK+MozdQWfxYPFwSGuOVWulvR54xmNEnad8gOmp2yXZCJe4oU1TESzW5Sre9sFJlDU6+Y+2s4Zslm33OoI=
X-Received: by 2002:a17:906:6896:b0:8a5:c8bd:4ac4 with SMTP id
 n22-20020a170906689600b008a5c8bd4ac4mr3901584ejr.15.1676606669190; Thu, 16
 Feb 2023 20:04:29 -0800 (PST)
MIME-Version: 1.0
References: <20230111134513.2495510-1-conor.dooley@microchip.com>
 <CABb+yY3+83AP0B4RUGTabqjR=7rXJFMgAvXsM5Go3sz2RMJA1g@mail.gmail.com>
 <Y8w5NO9E/j/6eT5d@spud> <Y+6tK/OS13THpQo4@spud>
In-Reply-To: <Y+6tK/OS13THpQo4@spud>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Thu, 16 Feb 2023 22:04:17 -0600
Message-ID: <CABb+yY2u0LNiwiJeOwhYU69U_m+5bx5rsHOk5jbyJTRbVcjeYw@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] MPFS system controller/mailbox fixes
To:     Conor Dooley <conor@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 4:24 PM Conor Dooley <conor@kernel.org> wrote:
> >
> > > > Secondly, I have a question about what to do if a service does fail, but
> > > > not due to a timeout - eg the above example where the "new" image for
> > > > the FPGA is actually older than the one that currently exists.
> > > > Ideally, if a service fails due to something other than the transaction
> > > > timing out, I would go and read the status registers to see what the
> > > > cause of failure was.
> > > > I could not find a function in the mailbox framework that allows the
> > > > client to request that sort of information from the client. Trying to
> > > > do something with the auxiliary bus, or exporting some function to a
> > > > device specific header seemed like a circumvention of the mailbox
> > > > framework.
> > > > Do you think it would be a good idea to implement something like
> > > > mbox_client_peek_status(struct mbox_chan *chan, void *data) to allow
> > > > clients to request this type of information?
> > > >
> > > .last_tx_done() is supposed to make sure everything is ok.
> >
> > Hm, might've explained badly as I think you've misunderstood. Or (see
> > below) I might have mistakenly thought that last_tx_done() was only meant
> > to signify that tx was done.
> >
> > Anyways, I'll try to clarify.
> > Some services don't set a status, but whether a status is, or isn't,
> > set has nothing to do with whether the service has completed.
> > One service that sets a status is "Authenticate Bitstream". This
> > service sets a status of 0x0 if the bitstream in question is okay _and_
> > something that the FPGA can be upgraded to. It returns a failure of 0x18
> > if the bitstream is valid _but_ is the same as that currently programmed.
> > (and of course a whole host of other possible errors in-between)
> >
> > These statuses, and whether they are a bad outcome or not, is dependant
> > on the service and I don't think should be handled in the mailbox
> > controller driver.
> >
> > > If the expected status bit is "sometimes not set", that means that bit
> > > is not the complete status.
> >
> > If the "busy" bit goes low, then the transmission must be complete,
> > there should be no need to check other bits for *completion*, but...
> >
> > > You have to check multiple registers to
> > > detect if and what caused the failure.
> >
> > ...maybe I have just misunderstood the role of .last_tx_done(). The
> > comment in mailbox-controller.h lead me to believe that it was used just
> > to check if it had been completed.
> >
> > Am I allowed to use .last_tx_done() to pass information back to the
> > mailbox client? If I could, that'd certainly be a nice way to get the
> > information on whether the service failed etc.
> >
> > Hopefully that, plus when you have a chance to look at the code, will
> > make what I am asking about a little clearer!
>
> Just wondering if you've had a chance to look at this again! I know it's
> missed the merge window this time around but I would like to get this
> behaviour fixed as other work depends on it.
>
My opinion about adding a new api just to accommodate remote f/w's
behaviour change across updates is still no.
last_tx_done() is more abstract than you think -- it has to play with
dozens of behaviors of remotes. So may just wrap your whatever logic,
of "tx is done", in that.

This query within the patchset threw me off -- I thought you needed
the new api for the patchset, so I didn't look further.
Looking at it now, I am ok with applying Patches 1,2 and 3. If you want.

cheers.
