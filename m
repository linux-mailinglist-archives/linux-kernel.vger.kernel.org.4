Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F876BE4A7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjCQI7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjCQI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:59:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF8E9DE0E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:58:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v16so3760233wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679043499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbO1OvwqFcbiXVIlcPvMmW3Zh+xLTD5sL8X+qjX3Xrg=;
        b=bePY+FUwUvTFE3lB0uGq2ndT/HW8VHTMhmZPQvKkDLVfKzvW1OpHR8jyqosFFcjKW+
         ykNDbK2X/rS3T6VkIRRqFCP3z87QndC19iXQOCZAHaj0vQA6o0kAXyjg+ZVKKoKBQnPW
         eO0WDXLBf8JXr8FODimMyazXxJG3RLfl/dwfxVC1gP6SR0mROYPPjDGuDJWlM3GIYAwu
         A5NbDoTciURkRY6PBhI9kU90e4kJS6C8AkGJzjXx7dpVOUsxCHvOR+9n9B3yCkmqx74k
         Y68NdTZq1u44kzEGLd3xoxrK4R5aAwsggzwn0B1c3tktcC0Q0By70BbUmWsHQV2RuyTI
         qG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679043499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbO1OvwqFcbiXVIlcPvMmW3Zh+xLTD5sL8X+qjX3Xrg=;
        b=3bwCJEE/PV4sn29GOqIkCOoBE8RDRYbCNEwMtpDYASokEAXz6iVWLMRq9DIDenjhwj
         GWxnDulQEIifpB+ZoXqTZVK+lI63tP0qc/fGlGOku8707BCLX5VBEH086kvKn2pQw+q6
         d+iYJ2lTMHRkNtiK1ytUmKcGEvwT8j5P0IuufvfsC3EBcElH1y4nEqTIPaxchkXsDmYa
         w027b3lxHmiVUt4ZtMzgfwjdfi1TIAZuvRMlTJyLhX2HrOQEfYzcRD5Vw1dkOI6kkHHg
         Y1XOpugUEPSBNWI/BjCQZ3/TyPM9lUKIdxt1cu/tkcY4Y3uoD6LZdlsnMAZDX97eoJAY
         vdQg==
X-Gm-Message-State: AO0yUKVEKSk6bQth6sunarILIxXfEmoGDWC7SPmTjagLhdRiE+RQXeM4
        YgktrXFrtMrEepRui1jd+9o=
X-Google-Smtp-Source: AK7set8HtdMekYq7Bz4xSG+wcGPmXUVFj9XJbevuknbtYfEyMJAvlSBgSwFuibxj1rh7UdZNilVgjQ==
X-Received: by 2002:a05:6000:142:b0:2d2:59cf:468f with SMTP id r2-20020a056000014200b002d259cf468fmr1768958wrx.15.1679043499172;
        Fri, 17 Mar 2023 01:58:19 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id t11-20020a05600001cb00b002c54241b4fesm1422562wrx.80.2023.03.17.01.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:58:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Date:   Fri, 17 Mar 2023 09:58:17 +0100
Message-ID: <2499410.4XsnlVU6TS@suse>
In-Reply-To: <ZBQTIVk0zsgv1hMH@kroah.com>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine> <ZBQTIVk0zsgv1hMH@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On venerd=EC 17 marzo 2023 08:13:37 CET Greg Kroah-Hartman wrote:
> On Fri, Mar 17, 2023 at 01:09:00AM +0500, Khadija Kamran wrote:
> > Initialize the module parameters, read_timeout and write_timeout once in
> > init().
> >=20
> > Module parameters can only be set once and cannot be modified later, so=
 we
> > don't need to evaluate them again when passing the parameters to
> > wait_event_interruptible_timeout().
>=20
> I feel like we are being too picky here, but this isn't the correct
> wording.  It is possible for module parameters to be modified "later",
> if the permissions on the parameter are set to allow this.  But that's
> not what this driver does here, so this might be better phrased as:
>=20
>   The module parameters in this driver can not be modified after
>   loading, so they can be evaluated once at module load and set to
>   default values if needed at that time.
>=20
> > Convert datatype of {read,write}_timeout from 'int' to 'long int' becau=
se
> > implicit conversion of 'long int' to 'int' in statement
> > '{read,write}_timeout =3D MAX_SCHEDULE_TIMEOUT' results in an overflow.
> >=20
> > Change format specifier for {read,write}_timeout from %i to %li.
>=20
> You are listing all of _what_ you do here, not really _why_ you are
> doing any of this.
>=20
> Anyway, if I were writing this, here's what I would say as a changelog
> text:
>=20
>   The module parameters, read_timeout and write_timeout, are only ever
>   evaluated at module load time, so set the default values then if
>   needed so as to not recompute the timeout values every time the driver
>   reads or writes data.
>=20
>=20
> And that's it, short, concise, and it explains why you are doing this.
>=20
> Writing changelog comments are almost always harder than actually
> writing the patch (at least for me.)  So don't feel bad, it take a lot
> of experience doing it.

Thanks for helping Khadija (and also me, indirectly, because I helped them =
to=20
make that commit message). After a little less than 200 commits already=20
upstream, there is still to learn how to make a good changelog (which I thi=
nk=20
it's not less important than the code in the patch). =20

> All that being said, I think we are just polishing something that
> doesn't need to really be polished anymore,
> so let me go just apply this
> patch as-is to the tree now so you can move on to a different change.

Yes, thanks. It's time to move on.

> You've put in the effort here, and I don't want you to get bogged down
> in specifics that really do not matter at all overall (like the memory
> size of your vm...)

You probably didn't pay attention to the problems Khadija has being=20
experiencing with memory exhaustion and compilation times.=20

=46irst time they complained had several crashes while building and message=
s=20
saying there was not enough available memory. Then several other problems w=
ith=20
builds' time. Finally, yesterday they wrote that "make modules_install=20
install" took "hours" (literally).

This is why I think they should also be helped with their VM configuration=
=20
(despite it was unrelated to the patch). They won't be able to work on some=
=20
projects if they cannot do quick builds and run hundreds of tests in no tim=
e=20
(e.g., I'm especially talking about Ira's and my project about the conversi=
ons=20
from kmap{,_atomic}() to kmap_local_page()).

I understand that this is only noise for you, as a maintainer. However I'm=
=20
pretty sure that they need help with speeding up builds and installation. T=
he=20
projects cannot wait "hours" just for install of modules and kernel images.

Again thanks for your precious suggestions about how to improve commit=20
messages.

=46abio=20

> thanks,
>=20
> greg k-h




