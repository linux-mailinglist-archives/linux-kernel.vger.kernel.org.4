Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFE6F4ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjECCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:19:33 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF42D69
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:19:32 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a950b982d4so161715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 19:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683080372; x=1685672372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctb1R3fy35Ln0l9ZfEUNBbFNpKA3q8wClyqzrQTbJpg=;
        b=21rXa6BKPsH1Q9DLffrghLCDtdO0rxkfIfXzRBY90U2BKxFSxAilOuBXsbhudPcv3r
         4QloLZeDs+Yzqgxyb6xfURzZRHYcsF1T3ICzP98bkBVwp8QlqwZqUKot6sfzZrAod4wA
         RnBM15xsIT31n8nDArb9G1R8SHb2Ll/jnt5P77w86TOmhoT5dbyewEnjwKRrQGO9NJU3
         5ELCU3L2UB8vAsU3nILJzhTq2BNmgtA8gK4S9Bm7ZQodM1D3jq7jfjBs/4Iq/v/Y/QJW
         WYMl6Mmuc5HH/xFkh0y8mqVfJjcTDAkSZ1jnM4XSpFf5mfjEv/P4g+23kyw78tFTVqX2
         hfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683080372; x=1685672372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctb1R3fy35Ln0l9ZfEUNBbFNpKA3q8wClyqzrQTbJpg=;
        b=R5OWMMrdkBwT5uDvO3WEF0cYNzjzretmbfwvBDKJihmoZdxYStRuL/Yac50LKlwP3J
         JhH26PK2WYgK2WZLS4TZXnq2svNqx3osYj8PedAnD2yEVRsaqBj0DS4p94BCasMYYQX2
         NNiOU5sYkgr1xAN01jE7giTa+K5/BttWl46/k6YmTlOngY6KP9k+/uKEjxpAXlp8LWLV
         reRHt1dwwG5eQbjLB/pDll6D1grqQmGIe8gd5+C7Cy6ICxB9iJXt2OkZn4HGekERmaZR
         PHD7PdBl4DgeMqF+CUmUF/qAhzRR4RpXJPCPP/eYGNzFIVlA8CSOTBy8y4vA5Z6P+u29
         6MMg==
X-Gm-Message-State: AC+VfDyDTIgsP/RaIBNanz5DRTWcq47nUB1FCikJRNxi+NbVCGmrxKrQ
        Vck4lK5kW9Zge7xzSFTSjSK7lF1zAj5GzGRjEVjKig==
X-Google-Smtp-Source: ACHHUZ4fW/UoAhnH6cLXbSIFupRrZXAhv+Av7tDVYL+xqu26Hu3gvOim8JtCuM7qsSSd3wIitG82hSp9P5pzrQjtto8=
X-Received: by 2002:a17:902:ce8b:b0:1a6:760c:af3d with SMTP id
 f11-20020a170902ce8b00b001a6760caf3dmr139870plg.16.1683080371574; Tue, 02 May
 2023 19:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230427221625.116050-1-opendmb@gmail.com> <CAGETcx-gDcqY7-_Ud0_rOtgvk7NbzevSa4UCV=NcqiV9zjAv7w@mail.gmail.com>
In-Reply-To: <CAGETcx-gDcqY7-_Ud0_rOtgvk7NbzevSa4UCV=NcqiV9zjAv7w@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 May 2023 19:18:55 -0700
Message-ID: <CAGETcx_xjNT1Tp0GeqoddFwGFpv3O33hZZpEiThNg1wwWcfEQw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] input: gpio-keys - fix pm ordering
To:     Doug Berger <opendmb@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Gergo Koteles <soyer@irl.hu>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 1, 2023 at 1:40=E2=80=AFPM Saravana Kannan <saravanak@google.co=
m> wrote:
>
> On Thu, Apr 27, 2023 at 3:18=E2=80=AFPM Doug Berger <opendmb@gmail.com> w=
rote:
> >
> > Commit 52cdbdd49853 ("driver core: correct device's shutdown
> > order") allowed for proper sequencing of the gpio-keys device
> > shutdown callbacks by moving the device to the end of the
> > devices_kset list at probe which was delayed by child
> > dependencies.
> >
> > However, commit 722e5f2b1eec ("driver core: Partially revert
> > "driver core: correct device's shutdown order"") removed this
> > portion of that commit causing a reversion in the gpio-keys
> > behavior which can prevent waking from shutdown.
> >
> > This RFC is an attempt to find a better solution for properly
> > creating gpio-keys device links to ensure its suspend/resume and
> > shutdown services are invoked before those of its suppliers.
> >
> > The first patch here is pretty brute force but simple and has
> > the advantage that it should be easily backportable to the
> > versions where the regression first occurred.
>
> We really shouldn't be calling device_pm_move_to_tail() in drivers
> because device link uses device_pm_move_to_tail() for ordering too.
> And it becomes a "race" between device links and when the driver calls
> device_pm_move_to_tail() and I'm not sure we'll get the same ordering
> every time.
>
> >
> > The second patch is perhaps better in spirit though still a bit
> > inelegant, but it can only be backported to versions of the
> > kernel that contain the commit in its 'Fixes:' tag. That isn't
> > really a valid 'Fixes:' tag since that commit did not cause the
> > regression, but it does represent how far the patch could be
> > backported.
> >
> > Both commits shouldn't really exist in the same kernel so the
> > third patch reverts the first in an attempt to make that clear
> > (though it may be a source of confusion for some).
> >
> > Hopefully someone with a better understanding of device links
> > will see a less intrusive way to automatically capture these
> > dependencies for parent device drivers that implement the
> > functions of child node devices.
>
> Can you give a summary of the issue on a real system? I took a look at
> the two commits you've referenced above and it's not clear what's
> still broken in the 6.3+
>
> But I'd think that just teaching fw_devlink about some property should
> be sufficient. If you are facing a real issue, have you made sure you
> have fw_devlink=3Don (this is the default unless you turned it off in
> the commandline when it had issues in the past).
>

I took a closer look at how gpio-keys work and I can see why
fw_devlink doesn't pick up the GPIO dependencies. It's because the
gpio dependencies are listed under child "key-x" device nodes under
the main "gpio-keys" device tree node. fw_devlink doesn't consider
dependencies under child nodes as mandatory dependencies of the parent
node.

The main reason for this was because of how fw_devlink used to work.
But I might be able to change fw_devlink to pick this up
automatically. I need to think a bit more about this because in some
cases, ignoring those dependencies is the right thing to do. Give me a
few weeks to think through and experiment with this on my end.

-Saravana
