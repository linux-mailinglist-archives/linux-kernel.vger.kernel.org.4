Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86865EC8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbiI0P7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiI0P7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:59:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101E4165B2;
        Tue, 27 Sep 2022 08:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664294385; x=1695830385;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=94Usqc87BKOJMsZqMwetyxtlbvxFJh5VRsFtzTTf6+g=;
  b=NgfdPgdciyVS8QoBvFmygWVuXslFhDqQNPHyYHHA1l2K7N0Yr2a8vX35
   okgX6VQFLKRUdEWLClg3vaGnW3+LZK0EU9QDQtVkNuvv5mpkco+j5qcJR
   yQnsIjk2sYrOir5aVLNvayiPbxFutHeNDO5ZyIFVwU6w7aIpOjfxWZLyO
   SqsPi0RAqwoC2PLpTXvzwC/hbEBc7tcUd5TEv5EHofjOyY3AiQYngjerP
   bgg393SkQSimYF4+YSDjDm+O+dILWi1TBFjSI5pDiReubeVxfffJRxi3/
   QNSog3yqq0mLWu79cMjAgeaJw16V45TZvz0L2meLDWEoFEbwkYF0Eve90
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301331494"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="301331494"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 08:59:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="725562481"
X-IronPort-AV: E=Sophos;i="5.93,349,1654585200"; 
   d="scan'208";a="725562481"
Received: from liukaren-mobl1.amr.corp.intel.com (HELO [10.209.44.66]) ([10.209.44.66])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 08:59:41 -0700
Message-ID: <a9a569566c2771621f170d017ce981dcfff2b1e7.camel@linux.intel.com>
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation
 and practices
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        LF TAB <tech-board@lists.linux-foundation.org>
Date:   Tue, 27 Sep 2022 08:59:40 -0700
In-Reply-To: <87h70tpw6d.fsf@meer.lwn.net>
References: <20220926211149.2278214-1-kristen@linux.intel.com>
         <87h70tpw6d.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-09-26 at 17:12 -0600, Jonathan Corbet wrote:
> Kristen Carlson Accardi <kristen@linux.intel.com> writes:
>=20
> > The Code of Conduct interpretation does not reflect the current
> > practices of the CoC committee or the TAB. Update the documentation
> > to remove references to initial committees and boot strap periods
> > since it is past that time, and note that the this document
> > does serve as the documentation for the CoC committee processes.
>=20
> Since this takes the TAB's name in vain, they should probably be CC'd
> on
> it; I've added that now.
>=20
> Thanks,
>=20
> jon

Thanks Jon,

>=20
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> > =C2=A0.../code-of-conduct-interpretation.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 24 ++++++++++-----
> > ----
> > =C2=A01 file changed, 13 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/Documentation/process/code-of-conduct-
> > interpretation.rst b/Documentation/process/code-of-conduct-
> > interpretation.rst
> > index 4f8a06b00f60..922e0b547bc3 100644
> > --- a/Documentation/process/code-of-conduct-interpretation.rst
> > +++ b/Documentation/process/code-of-conduct-interpretation.rst
> > @@ -127,10 +127,12 @@ are listed at
> > https://kernel.org/code-of-conduct.html.=C2=A0 Members can not
> > =C2=A0access reports made before they joined or after they have left th=
e
> > =C2=A0committee.
> > =C2=A0
> > -The initial Code of Conduct Committee consists of volunteer
> > members of
> > -the TAB, as well as a professional mediator acting as a neutral
> > third
> > -party.=C2=A0 The first task of the committee is to establish documente=
d
> > -processes, which will be made public.
> > +The Code of Conduct Committee consists of volunteer community
> > members
> > +appointed by the TAB, as well as a professional mediator acting as
> > a
> > +neutral third party.=C2=A0 The processes the Code of Conduct committee
> > will
> > +use to address reports is varied and will depend on the individual

Eek, I see a small error here - it should either say "The processes the
Code of Conduct committee will use to address reports are varied"
OR
"The process the Code of Conduct committee will use to address reports
is varied"

Perhaps this can be fixed when it is added to a tree, or let me know if
you would like another version.


Thanks,
Kristen

