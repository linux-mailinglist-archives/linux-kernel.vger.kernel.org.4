Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5153A6ED659
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 22:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjDXUw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 16:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjDXUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 16:52:25 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3545F59EF;
        Mon, 24 Apr 2023 13:52:24 -0700 (PDT)
Date:   Mon, 24 Apr 2023 22:52:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1682369540; bh=RnI6wAllvx7EXwm7mKuVfBm0F3a7/yHS3AmhCwJZTq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AhSb1eZCohGLYsqfark6DNXc0VLNVBJtayD1pUutLpSyBqiwV4q7xkYexUg49SX7i
         YIpBQfxO6tZx2DL+SraexH5XP0fLOb+ijfaaXbGuvg4SfDUI8Tlvfg18xL1Exujsn7
         YAoSr9Au6/pFp/t+VHDAVPyfHY73Htr0XKQBFOwA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Jorge Lopez <jorgealtxwork@gmail.com>
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/14] HP BIOSCFG driver - Documentation
Message-ID: <80c448f8-f043-460a-908f-e87e6b8215dc@t-8ch.de>
References: <20230420165454.9517-1-jorge.lopez2@hp.com>
 <20230420165454.9517-2-jorge.lopez2@hp.com>
 <dc902d52-7186-4095-9be9-60c728a24f05@t-8ch.de>
 <CAOOmCE-N9yMn7Cvr9bK5TpAwpv7_Lam1huWRrYaFzXVtf4v_aA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOOmCE-N9yMn7Cvr9bK5TpAwpv7_Lam1huWRrYaFzXVtf4v_aA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jorge,

On 2023-04-24 11:11:41-0500, Jorge Lopez wrote:
> On Sat, Apr 22, 2023 at 3:51 PM Thomas Weißschuh <thomas@t-8ch.de> wrote:
> >
> > On 2023-04-20 11:54:41-0500, Jorge Lopez wrote:
> > > Based on the latest platform-drivers-x86.git/for-next
> > > ---
> > >  .../testing/sysfs-class-firmware-attributes   | 98 ++++++++++++++++++-
> > >  1 file changed, 96 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > > index 4cdba3477176..73d7b8fbc0b2 100644
> > > --- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > > +++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
> > > @@ -22,6 +22,12 @@ Description:
> > >                       - integer: a range of numerical values
> > >                       - string
> > >
> > > +             HP specific types
> > > +             -----------------
> > > +                     - ordered-list - a set of ordered list valid values
> > > +                     - sure-start - report audit logs read from BIOS
> >
> > In the treevie you sent the Sure_Start attribute does not have
> > a "current_value".
> > This indicated that it's not actually a firmware attribute but just some
> > standalone sysfs attribute.
> >
> > In this case it should not be documented here, but handled the same way
> > as the SPM stuff.
> 
> I will update the documentation as indicated.

This will also need changes to the code.
Only the audit log stuff is needed then.
