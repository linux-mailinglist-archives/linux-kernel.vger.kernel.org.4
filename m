Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE22D730176
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245493AbjFNOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245507AbjFNOPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:15:54 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF52CD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:15:53 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd6df68105cso978371276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686752152; x=1689344152;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HyxJUC+ggEK6dr+Cv8s7hAwz0UuDDFgEK68ULk5W7mU=;
        b=hlSASfmdf95l6QbzQ3fTLZfUMNONKaFKa/5PK/w9IyO9XfSLYxNrqqtvosvvZSif1e
         LI3fBAs0/TMzWjtfnsVoYfIqYpJ/ewrksL1PJSxpWO3zTFX/20QDjk8NZMXhv/cbW5HM
         8BAEpVWNAmInPlZlrDC/h29Y/RKSbENk9hDPFICG2JDXGZjkZebco1rVDXD6JX7RQIm6
         vIH6pM8tWGJEMF8GP/HXPdYMMrTVEqD14VyJdcUFEPG4Fxi5E0WLAUErCb9XtGVjNgmp
         iftESueAkB7OB+sX/M6oBgBbhv3ZrHO7exeD5R+SCygrf1DIdWKfIbaC877aTM3t3Ec6
         dbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686752152; x=1689344152;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HyxJUC+ggEK6dr+Cv8s7hAwz0UuDDFgEK68ULk5W7mU=;
        b=amY/19QeqDOG7zjhoXRiuhAo84ZqAFd0LdQsS3Xov6C07RLYICQqxg2bB9u64kQbjF
         9XioNna0ul9Io+gjXsIsWvYUzvGnitQL80D3ZC7fZGOcwq1xZjrgEfgc/8lhi+zvMx+P
         vWtRHZp0wmjZO4yiykQ7/k9XKN2FqpYpOXMUZ0nJPuHu/OwE+HBBTAHJh6vo9m5nslsp
         IQcvzWB59giO4TaX519y3YMtJTnG5etcxFkdTNHDB3iyYlImSN4+tVFmYRrpeqUGggBs
         jy1pFkIgpGz+ejn4OixneWmc8y/vVM3c8dDBXPFB8F5GXTAJ0UB54HgNcqa35s3dDWNC
         SWDg==
X-Gm-Message-State: AC+VfDzH0Lpyvj5CWO5IbKsJTWixUQUUKrv3eshBf1h1ujMGYGOibxO6
        qzoD/PJT0MWHvapaIy1xSmp+Dwb3Ong=
X-Google-Smtp-Source: ACHHUZ57W8rzqxbJrL52S1c85P/owRVhPYIdJcTC5dSko1414FTQprcFTMsekp8j3wY/FlGzlyV+eG+PfAM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1783:b0:bd0:4e03:a247 with SMTP id
 ca3-20020a056902178300b00bd04e03a247mr1054400ybb.5.1686752152293; Wed, 14 Jun
 2023 07:15:52 -0700 (PDT)
Date:   Wed, 14 Jun 2023 07:15:50 -0700
In-Reply-To: <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230612164727.3935657-1-carlos.bilbao@amd.com>
 <ZIihRqZljMaMRGcK@google.com> <DM8PR11MB5750D16B08B769173DCD740AE75AA@DM8PR11MB5750.namprd11.prod.outlook.com>
Message-ID: <ZInLlkXsgnej9ZpT@google.com>
Subject: Re: [PATCH v2] docs: security: Confidential computing intro and
 threat model for x86 virtualization
From:   Sean Christopherson <seanjc@google.com>
To:     Elena Reshetova <elena.reshetova@intel.com>
Cc:     Carlos Bilbao <carlos.bilbao@amd.com>,
        Jason CJ Chen <jason.cj.chen@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "kraxel@redhat.com" <kraxel@redhat.com>,
        "dovmurik@linux.ibm.com" <dovmurik@linux.ibm.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhaval.Giani@amd.com" <Dhaval.Giani@amd.com>,
        "michael.day@amd.com" <michael.day@amd.com>,
        "pavankumar.paluri@amd.com" <pavankumar.paluri@amd.com>,
        "David.Kaplan@amd.com" <David.Kaplan@amd.com>,
        "Reshma.Lal@amd.com" <Reshma.Lal@amd.com>,
        "Jeremy.Powell@amd.com" <Jeremy.Powell@amd.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dinechin@redhat.com" <dinechin@redhat.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "berrange@redhat.com" <berrange@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>, "tytso@mit.edu" <tytso@mit.edu>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "leon@kernel.org" <leon@kernel.org>,
        "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "cdupontd@redhat.com" <cdupontd@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "security@kernel.org" <security@kernel.org>,
        Larry Dewey <larry.dewey@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023, Elena Reshetova wrote:
> > > +The specific details of the CoCo security manager vastly diverge bet=
ween
> > > +technologies. For example, in some cases, it will be implemented in =
HW
> > > +while in others it may be pure SW. In some cases, such as for the
> > > +`Protected kernel-based virtual machine (pKVM) <https://github.com/i=
ntel-
> > staging/pKVM-IA>`,
> > > +the CoCo security manager is a small, isolated and highly privileged
> > > +(compared to the rest of SW running on the host) part of a tradition=
al
> > > +VMM.
> >=20
> > I say that "virtualized environments" isn't a good description because
> > while pKVM does utilize hardware virtualization, my understanding is th=
at
> > the primary use cases for pKVM don't have the same threat model as SNP/=
TDX,
> > e.g. IIUC many (most?  all?) pKVM guests don't require network access.
>=20
> Not having a network access requirement doesn=E2=80=99t implicitly invali=
date the=20
> separation guarantees between the host and guest, it just makes it easier
> since you have one interface less between the host and guest.

My point is that if the protected guest doesn't need any I/O beyond the har=
dware
device that it accesses, then the threat model is different because many of=
 the
new/novel attack surfaces that come with the TDX/SNP threat model don't exi=
st.
E.g. the hardening that people want to do for VirtIO drivers may not be at =
all
relevant to pKVM.

> But again I will let Jason to reply on this since he knows details.=20
>=20
> But what you are saying more generally here and above is that you don=E2=
=80=99t want
> pKVM case included into this threat model, did I understand you correctly=
?=20

More or less.  I think the threat models for pKVM versus TDX/SNP are differ=
ent
enough that accurately capturing the nuances and novelties of the TDX/SNP t=
hreat
model will be unnecessarily difficult if you also try to lump in pKVM.  E.g=
. pKVM
is intended to run on portable client hardware, likely without memory encry=
ption,
versus TDX/SNP being almost exclusively server oriented with the hardware b=
eing
owned and hosted by a third party that is benign (perhaps trusted even), bu=
t not
necessarily physically isolated enough to satisfy the end user's security
requirements.

One of the points I (and others) was trying to get across in v1 feedback is=
 that
security requirements for CoCo are not the same across all use cases, and t=
hat
there are subtle but meaningful differences even when use cases are built o=
n common
underlying technology.  In other words, describing the TDX/SNP threat model=
 with
sufficient detail and nuance is difficult enough without throwing pKVM into=
 the
mix.

And I don't see any need to formally document pKVM's threat model right *no=
w*.
pKVM on x86 is little more than a proposal at this point, and while I would=
 love
to see documentation for pKVM on ARM's threat model, that obviously doesn't=
 belong
in a doc that's x86 specific.

> > > +potentially misbehaving host (which can also include some part of a
> > > +traditional VMM or all of it), which is typically placed outside of =
the
> > > +CoCo VM TCB due to its large SW attack surface. It is important to n=
ote
> > > +that this doesn=E2=80=99t imply that the host or VMM are intentional=
ly
> > > +malicious, but that there exists a security value in having a small =
CoCo
> > > +VM TCB. This new type of adversary may be viewed as a more powerful =
type
> > > +of external attacker, as it resides locally on the same physical mac=
hine
> > > +-in contrast to a remote network attacker- and has control over the =
guest
> > > +kernel communication with most of the HW::
> >=20
> > IIUC, this last statement doesn't hold true for the pKVM on x86 use cas=
e, which
> > specifically aims to give a "guest" exclusive access to hardware resour=
ces.
>=20
> Does it hold for *all* HW resources? If yes, indeed this would make pKVM =
on
> x86 considerably different.

Heh, the original says "most", so it doesn't have to hold for all hardware =
resources,
just a simple majority.
