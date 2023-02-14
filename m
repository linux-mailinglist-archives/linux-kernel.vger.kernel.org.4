Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A7B695CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjBNIaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBNIap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:30:45 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3113C29
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:30:43 -0800 (PST)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31E3DHbq011515;
        Tue, 14 Feb 2023 08:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=wuoJ6r6eQQHpVjedcQiVNRnSIKJNx9fEPJ//3yi88Ao=;
 b=WHYH7MCZhEijaLPmxvi4IBHGx+MU6R+drNzHPWjBOHzXFhnNgVW17pMqpgh3KEoVB9gz
 HiOMtvThyz+kG/tLgXvskWW9k/iLSbtpICnTvQhjkKD9s233wFmvbcLs4yKoD7zcvQNm
 q9BmWVC6EXV7xjaCvA0/JJeKdx0YojAsHyy6zCyo4v0pLDoYgDDGyGJufSznVC3z8Iy8
 pekoPGjcHOYIIcuphdlYF5oXntd+00XsjmEeltJSmetOMnbTQjkoP7DC0iN6msWnnvj+
 UYbcsBX0zDR+ASB+dPerntYOY+IZbpp0hfpZYTkpZLcK4LTkj69TeVkCw/k//iptEDs/ Lg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3nr26r1vct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 08:30:25 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id DA90F130F9;
        Tue, 14 Feb 2023 08:30:24 +0000 (UTC)
Received: from blofly.tw.rdlabs.hpecorp.net (unknown [16.231.227.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 2A758804BDB;
        Tue, 14 Feb 2023 08:30:19 +0000 (UTC)
Date:   Tue, 14 Feb 2023 16:30:17 +0800
From:   Matt Hsiao <matt.hsiao@hpe.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Gaba, Aahit" <aahit.gaba@hpe.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "dhaval.experiance@gmail.com" <dhaval.experiance@gmail.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "arvind.yadav.cs@gmail.com" <arvind.yadav.cs@gmail.com>,
        "standby24x7@gmail.com" <standby24x7@gmail.com>,
        "wfp5p@virginia.edu" <wfp5p@virginia.edu>,
        "jslaby@suse.cz" <jslaby@suse.cz>,
        "prarit@redhat.com" <prarit@redhat.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>
Subject: Re: [PATCH v2] misc: hpilo: relicense HPE iLO driver as Dual MIT/GPL
Message-ID: <20230214083017.GA22428@blofly.tw.rdlabs.hpecorp.net>
References: <20221116103457.27486-1-matt.hsiao@hpe.com>
 <Y3TLSON/7XRG5BiN@kroah.com>
 <20230209033812.GA17928@blofly.tw.rdlabs.hpecorp.net>
 <MW4PR84MB1539887EFAA00D60D777C75696D99@MW4PR84MB1539.NAMPRD84.PROD.OUTLOOK.COM>
 <Y+YqscpBXMMTWT6V@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+YqscpBXMMTWT6V@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 9Xy5WeBPyd2hDOgGwTGiR4lYz3vBn_EK
X-Proofpoint-ORIG-GUID: 9Xy5WeBPyd2hDOgGwTGiR4lYz3vBn_EK
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_05,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 12:29:53PM +0100, Greg KH wrote:
> On Thu, Feb 09, 2023 at 03:59:04AM +0000, Gaba, Aahit wrote:
> > On Thu, Feb 09, 2023 at 09:29:00AM +0530, Aahit Gaba wrote:
> > > On Wed, Nov 16, 2022 at 12:36:40PM +0100, Greg KH wrote:
> > > > On Wed, Nov 16, 2022 at 06:34:57PM +0800, matt.hsiao@hpe.com wrote:
> > > > > From: Matt Hsiao <matt.hsiao@hpe.com>
> > > > >
> > > > > Currently, the hpilo driver is licensed as GPL. To run OpenBSD on
> > > > > HPE servers with BMC (HPE iLO) functionality, a dual MIT/GPL license
> > > > > is needed for porting the hpilo driver to OpenBSD.
> > > > >
> > > > > Signed-off-by: Matt Hsiao <matt.hsiao@hpe.com>
> > > > > ---
> > > > >
> > > > > Hello contributors in the CC list,
> > > > >
> > > > > Thanks for your contributions to the hpilo driver. Please kindly
> > > > > review the license change and hopefully you would agree and approve it.
> > > Thanks!
> > > > >
> > > > > Patch v2:
> > > > > ---------
> > > > > - Change MODULE_LICENSE to Dual MIT/GPL too
> > > >
> > > > As I asked for on the v1 version (delayed email on my side), I need a
> > > > lawyer from HPE to sign off on this change as well.
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > > 
> > > Add HPE attorney Aahit Gaba to sign off.
> > 
> > Signed-off-by: Aahit Gaba <aahit.gaba@hpe.com>
> > 
> > The reasons we want to dual license Linux hpilo driver are:
> > - There are required bug fixes that are not copyrighted by HPE in the current Linux hpilo driver.
> 
> And have you identified them and gotten a sign-off from those copyright
> holders?  I don't see that here documented at all, so I imagine you
> documented it somewhere else?  If so, where?

We are under the assumption that hpilo contributors would reply to this
thread with their 'Acked-by' or 'Signed-off-by'. Is that the proper
approach?

We have contacted a number of hpilo driver contributors through email
outside of the Linux process. We do have their emails giving permission
to dual-licensing their contribution. We can provide those emails if
they add value beyond the 'Acked-by' or 'Signed-off-by' process.

> 
> > - We want to maintain one hpilo driver between Linux and OpenBSD, and dual-licensing of hpilo driver's existing codebase and all the future bug fixes are the requirements for it. Therefore, we requested all other copyright owners of Linux hpilo driver to accept dual-licensing (MIT/GPL-2.0) for their respective contributions.
> 
> You can request, you can not require, right?
> 
> How are you going to deal with the fact that the driver really can not
> be shared between these two operating systems without a lot of rewriting
> and changing of the code?
> 
> Also, this code uses GPL-only symbols out of the Linux kernel, how are
> you going to handle them in openbsd?  Do you have a port of the code to
> openbsd somewhere for review that shows how this all is translated?
> 
> And this is really a tiny driver, why not just rewrite it from scratch
> for openbsd anyway?  Odds are that's going to be required to fit into
> the openbsd driver and coding style, right?
> 
> thanks,
> 
> greg k-h

We shouldn't have used the term 'one driver'. More accurate description
is we want the core driver features and any changes or bug fixes apply
to that dual licensed. We understand that the parts of the driver that
are calls to Linux specific functions would be different in OpenBSD.
There are also some Linux infrastructure things that would be different
in OpenBSD. The key for us is that the core driver features and any
future changes be kept in sync between Linux and OpenBSD.
