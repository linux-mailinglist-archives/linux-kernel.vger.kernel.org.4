Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E9F7291BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239206AbjFIHvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239428AbjFIHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:50:54 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EF63A9C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 00:50:05 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2465D4A2;
        Fri,  9 Jun 2023 07:50:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2465D4A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1686297005; bh=/BcCXmbco9SeK0eCgqg6VHWpw+U78pdn+NsHAzWOXYk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=BUBHrycEKDrcJNrJVomFASxChWKEpBKGEi89BrCopM8lHdJKz60Ya0qg+YcxFnQKs
         Y7jE3UFCvQpsCyAeQDxBt4kFSwo33KIse2Ra7oLZ1ctIApTxsGPeS/ieTAP/NzhPPO
         5k71E+KFm1KP3ptOl37M/fJJBdv6Zh7Htj1CfnuKn9e5JbGnk46C7Vrom219h0p9NH
         MouDQFG4l6w0iXtnA+1gTPbMFxquh06Xc14Q1ZUnvLAhFSgmmDc9BJV0UmNMNH5HHi
         sNATjJ1KLIjDugcHk0ylbbQinESjEGvjEoTLBA9YbHks3wnDn68mSE9NE3Xp4+oZnm
         r8WAfJj5EYgQw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>,
        ojeda@kernel.org, danny@kdrag0n.dev
Cc:     masahiroy@kernel.org, jgg@nvidia.com, mic@digikod.net,
        linux-kernel@vger.kernel.org, joe@perches.com,
        linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr,
        =?utf-8?B?w43DsWlnbw==?= Huguet <ihuguet@redhat.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
In-Reply-To: <20230601075333.14021-1-ihuguet@redhat.com>
References: <20230601075333.14021-1-ihuguet@redhat.com>
Date:   Fri, 09 Jun 2023 01:50:00 -0600
Message-ID: <87sfb1oz13.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=8D=C3=B1igo Huguet <ihuguet@redhat.com> writes:

> EditorConfig is a specification to define the most basic code formatting
> stuff, and it's supported by many editors and IDEs, either directly or
> via plugins, including VSCode/VSCodium, Vim, emacs and more.
>
> It allows to define formatting style related to indentation, charset,
> end of lines and trailing whitespaces. It also allows to apply different
> formats for different files based on wildcards, so for example it is
> possible to apply different configs to *.{c,h}, *.py and *.rs.
>
> In linux project, defining a .editorconfig might help to those people
> that work on different projects with different indentation styles, so
> they cannot define a global style. Now they will directly see the
> correct indentation on every fresh clone of the project.
>
> See https://editorconfig.org
>
> Co-developed-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>
> Signed-off-by: =C3=8D=C3=B1igo Huguet <ihuguet@redhat.com>

So I must confess to still being really nervous about installing a file
that will silently reconfigure the editors of everybody working on the
kernel source; I wish there were a straightforward way to do this as an
opt-in thing.  We're talking about creating a flag-day behavioral change
for, potentially, thousands of kernel developers.  Something tells me
that we might just hear from a few of them.

I wonder if we should, instead, ship a file like this as something like
Documentation/process/editorconfig, then provide a "make editorconfig"
command that installs it in the top-level directory for those who want
it?

Or perhaps I'm worrying too much?

Thanks,

jon
