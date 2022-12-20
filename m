Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354666522FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbiLTOqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiLTOqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:46:03 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0CCFFC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:46:00 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id 128so11923115vsz.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7HC4qlOKB+DV/kQUmV/UX6t7pk+Pw6VldO/FKc2Kz+8=;
        b=q2JpO7TB5c5ty9Zf8VhtiI8gbxFjhI0pDBkJ3Z2u7pJ8g3VYOtRg/GX7Dgl2IRhzdR
         0/zVbXFUyfARbciZ98KtaCjD7WbtHJhwz+HvwzP0vTeE37CNb/gtVHR9gv8qfCluhgI/
         R9kSHQEv/4FA33N9H4vVSIY7zNVH0yZj+wMuRfAoPbH4Id3Rb3JRuMoXuV06H/rk0QrT
         eXiSiGJBhEEbf6cBEJgG+EdfGHKWO7xkFpFA4y9IK5/KVUojWWsLhb7Pb1kZyKm1d4Ud
         4uD4RIeyfkBMnOENbUi3tiGDmvlN83ItO/gmxSzGSg/Keqtf3JoSvVSitK+m6HbIZAiu
         LWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7HC4qlOKB+DV/kQUmV/UX6t7pk+Pw6VldO/FKc2Kz+8=;
        b=Kzjv+oPk0BNwSWekDmTzY1r2CPSVjd57U4feSW7erGQbMMecLDvQLLjOfltgEFLkj7
         mJHos3+FCzQh+1IAOsDd7JLFytr4M+2q6Bmy2wYvWWcGQXfvCxdcNjJJp9OsJaIl1wFO
         V6SL3zpwzR1/Sg6aRROHqWY66Dl36ctqlx5mZ5NR4RlpeXtb8Z5HKBBeZLsDL2WEaVhr
         OQTON/RlaqYkpQPWg04IGzvJxpi6YRIuGBmlokNv3g4UqGKlSTM54vTxziFVaGZig0TD
         QaZV9Aligql3siuLRPDoAGHKgMWFGZlXgF4UU9iq+g8Rb48Hcr7sGqhdiDTGIrYXqUuY
         k4AQ==
X-Gm-Message-State: ANoB5pm2LVKr21sRwgU02HdQ48HaeZp8gykYIIv8nq0Z2r41qAM7wG5q
        V+6Nn/Tb0tsLW3xwd4Z3egQ2jzzXjl5BLIFRAoepog==
X-Google-Smtp-Source: AA0mqf5yQLmpSVdtAnFMtorbc897HTaDSF7eVW0ETN5ux8oIwTgrBEdfaw5c3Sxp5LRxc7nKc9yDcFgo2JBf25RTsAQ=
X-Received: by 2002:a67:bd14:0:b0:3b2:e40d:1d9b with SMTP id
 y20-20020a67bd14000000b003b2e40d1d9bmr12372544vsq.51.1671547559757; Tue, 20
 Dec 2022 06:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com> <20221219204619.2205248-2-allenwebb@google.com>
 <Y6FZWOC1DSHHZNWy@kroah.com> <CAJzde06et8qZPmu=zF13rJt8=v_etMjgTRhv9y75wdrX7doC0g@mail.gmail.com>
 <Y6HHb8alGpMHLpM/@kroah.com>
In-Reply-To: <Y6HHb8alGpMHLpM/@kroah.com>
From:   Allen Webb <allenwebb@google.com>
Date:   Tue, 20 Dec 2022 08:45:48 -0600
Message-ID: <CAJzde05ZWmXrxKE+B8_YHd1nEzHpFfodSdGbS6jVOCqKAj-fxQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] imx: Fix typo
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, stable@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 8:32 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Dec 20, 2022 at 08:26:06AM -0600, Allen Webb wrote:
> > On Mon, Dec 19, 2022 at 3:23 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Mon, Dec 19, 2022 at 02:46:09PM -0600, Allen Webb wrote:
> > > > A one character difference in the name supplied to MODULE_DEVICE_TABLE
> > > > breaks a future patch set, so fix the typo.
> > >
> > > What behaviour is broken here for older kernels? What would not work
> > > that makes this patch worthy of consideration for stable? The commit
> > > log should be clear on that.
> > >
> > > In the future, it may be useful for you to wait at least 1 week or so
> > > before sending a new series becuase just a couple of days is not enough
> > > if you are getting feedback.
> > >
> > > So before sending a v10, please give it at least a few days or a week.
> > >
> > >   Luis
> >
> > On Tue, Dec 20, 2022 at 12:42 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Dec 19, 2022 at 02:46:09PM -0600, Allen Webb wrote:
> > > > A one character difference in the name supplied to MODULE_DEVICE_TABLE
> > > > breaks a future patch set, so fix the typo.
> > >
> > > Breaking a future change is not worth a stable backport, right?  Doesn't
> > > this fix a real issue now?  If so, please explain that.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I will update the commit message to say that it breaks compilation
> > when building imx8mp-blk-ctrl as a module (and so forth for the other
> > similar patches).
>
> Can that code be built as a module?  Same for the other changes...

Nope, I will remove the cc: stable and revert the commit messages back
to just referencing the future change, but this time I will be more
specific.

SOC_IMX8M
symbol value 'm' invalid for SOC_IMX8M

ROCKCHIP_MBOX
symbol value 'm' invalid for ROCKCHIP_MBOX

STMPE_SPI
symbol value 'm' invalid for STMPE_SPI
