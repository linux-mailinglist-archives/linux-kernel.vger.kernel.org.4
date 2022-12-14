Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0659D64D135
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 21:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiLNU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 15:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiLNU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 15:29:13 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC71F30568
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:17:18 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b13so12364526lfo.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 12:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVCzLs9D4iYxpfqj24EzHAUSz5EHGUoRFeOu3fx9tXA=;
        b=ygY6f1uDy6PQVrgq3liO18DWIg23Q25cp2LqBqD33rr3dpOMX1F4ZWQ53xxQsYfmrz
         Ww15xobuVSL9b/EdC/HOuZDYDhWfD3kEv/9x9dXO+w2SUBRJ0X6mNiD7nWGhbW0Tsp0g
         P7l44egFmR7MDaIR4ZWYqjsCc+r48R/SnJ0pDtzc4/CAQHW3OCtd85ER7x9WNepMMutj
         XyjUyq0vr/2HeV6oZMwbVplOvXm77YmzpHf+8QJhCAA1vrscIJ/4nqM0nCfMjQBWksj2
         NxMveiH437h39e6JxzGhfWcpNKDS95ni3SRQRak2ZaCLKtDSGT4pYx6h6Lfsq7Mpe+yI
         WD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVCzLs9D4iYxpfqj24EzHAUSz5EHGUoRFeOu3fx9tXA=;
        b=Oof2DQsMRehj1fitBYuSgYgNjNwUNGUXbIg527yLaTEe1QDoKOjTcvzuJgb4S63RaB
         hkdkdg4HZfNBu+x9IS/gwyi87+R5R8cW/G85wuW8nPiTNFw2G31yJguwqFs6HmHevFr4
         J3Zmu+0lpGWjSgL0Fj5IemwsiiATt4LqPWy6BMKAXKk9tDwg1fN9fexcCRlvkAklVJJZ
         GzhEgW6CnG3yTwAnCVUfl0XCBeXZSHiGMH0X4MhsN5psgmFc/j1yns5r6ldU0RIy6lNs
         b1c3w55xyWFqLaZS7BasZuUAJydxCSwdBEJjkhLPGyxEVKCGcGsdivHQxZtAsFUpdxyq
         X/FA==
X-Gm-Message-State: ANoB5pk3Ad55CvazpRfE/LwSiooMKia8QvkKpWuC2HdH0zbRPXDgKJCm
        cG/OxZolcG04PyCEhpziScdAhSQNxb/smNHB8FPjKw==
X-Google-Smtp-Source: AA0mqf7K66olADXQFu8z7rpJyj1Hb3u+MKjYRnnnwsTP5ymnBDUeoO12x4aocwT/naEiY9zWYrOK4erYNR7nagCtBUY=
X-Received: by 2002:a05:6512:16a4:b0:4b2:5c79:ae9c with SMTP id
 bu36-20020a05651216a400b004b25c79ae9cmr33556193lfb.619.1671049036909; Wed, 14
 Dec 2022 12:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20221115153753.2065803-1-ben.levinsky@xilinx.com>
 <20221115153753.2065803-2-ben.levinsky@xilinx.com> <20221125180509.GA622847@p14s>
 <C981698C-5B9B-49B6-9EC2-CC7A0737B155@amd.com> <20221202170042.GA165812@p14s>
 <ba21b0e5-80e2-d976-1bf3-98a91825086b@amd.com> <20221208190523.GA636328@p14s>
 <b49ad56a-f008-55e3-22a7-c47afe5bdd3e@amd.com> <20221213215318.GA893317@p14s>
 <20221213222123.GA1128798@p14s> <D93BFC0C-F90C-413E-899F-9CF5C6FB794A@amd.com>
 <f996e5a4-13c3-a195-ccc8-73e09c485112@amd.com>
In-Reply-To: <f996e5a4-13c3-a195-ccc8-73e09c485112@amd.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 14 Dec 2022 13:17:05 -0700
Message-ID: <CANLsYkzjmkqfp9uQydB=cFx70LxuG=3AtVVhX10dhfT92iJb8g@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] remoteproc: Introduce rproc_get_by_id API
To:     Ben Levinsky <ben.levinsky@amd.com>
Cc:     "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "bill.mills@linaro.com" <bill.mills@linaro.com>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2022 at 10:17, Ben Levinsky <ben.levinsky@amd.com> wrote:
>
> Can confirm this works for my use case! Thank you!
>

Thanks for getting back to me.  I will send an official patch in the
coming hour, please add your R-B or T-B and I will queue it when
6.2-rc2 comes out on the 26th.

> On 12/14/22 9:16 AM, Levinsky, Ben wrote:
> >
> >
> > =EF=BB=BFOn 12/13/22, 2:21 PM, "Mathieu Poirier" <mathieu.poirier@linar=
o.org> wrote:
> >
> >      On Tue, Dec 13, 2022 at 02:53:18PM -0700, Mathieu Poirier wrote:
> >      > On Fri, Dec 09, 2022 at 11:01:47AM -0800, Ben Levinsky wrote:
> >      > > Hi Mathieu,
> >      > >
> >      > > On 12/8/22 11:05 AM, Mathieu Poirier wrote:
> >      > > > On Tue, Dec 06, 2022 at 08:23:13AM -0800, Ben Levinsky wrote=
:
> >      > > > > Good Morning Mathieu,
> >      > > > >
> >      > > > >
> >      > > > > I did some testing and replied inline.
> >      > > > >
> >      > > > >
> >      > > > > On 12/2/22 9:00 AM, Mathieu Poirier wrote:
> >      > > > > > On Wed, Nov 30, 2022 at 09:39:33PM +0000, Levinsky, Ben =
wrote:
> >      > > > > > > Hi Mathieu,
> >      > > > > > >
> >      > > > > > > Thank you for your review. Please see my reply inline.
> >      > > > > > >
> >      > > > > > > Thanks
> >      > > > > > > Ben
> >      > > > > > >
> >      > > > > > > On 11/25/22, 10:05 AM, "Mathieu Poirier"<mathieu.poiri=
er@linaro.org>  wrote:
> >      > > > > > >
> >      > > > > > >       CAUTION: This message has originated from an Ext=
ernal Source. Please use proper judgment and caution when opening attachmen=
ts, clicking links, or responding to this email.
> >      > > > > > >
> >      > > > > > >
> >      > > > > > >       Hi Ben,
> >      > > > > > >
> >      > > > > > >       On Tue, Nov 15, 2022 at 07:37:53AM -0800, Ben Le=
vinsky wrote:
> >      > > > > > >       > Allow users of remoteproc the ability to get a=
 handle to an rproc by
> >      > > > > > >       > passing in node that has parent rproc device a=
nd an ID that matches
> >      > > > > > >       > an expected rproc struct's index field.
> >      > > > > > >       >
> >      > > > > > >       > This enables to get rproc structure for remote=
proc drivers that manage
> >      > > > > > >       > more than 1 remote processor (e.g. TI and Xili=
nx R5 drivers).
> >      > > > > > >       >
> >      > > > > > >       > Signed-off-by: Ben Levinsky<ben.levinsky@xilin=
x.com>
> >      > > > > > >       > ---
> >      > > > > > >       >  drivers/remoteproc/remoteproc_core.c | 64 +++=
++++++++++++++++++++++++-
> >      > > > > > >       >  include/linux/remoteproc.h           |  1 +
> >      > > > > > >       >  2 files changed, 64 insertions(+), 1 deletion=
(-)
> >      > > > > > >       >
> >      > > > > > >       > diff --git a/drivers/remoteproc/remoteproc_cor=
e.c b/drivers/remoteproc/remoteproc_core.c
> >      > > > > > >       > index 775df165eb45..6f7058bcc80c 100644
> >      > > > > > >       > --- a/drivers/remoteproc/remoteproc_core.c
> >      > > > > > >       > +++ b/drivers/remoteproc/remoteproc_core.c
> >      > > > > > >       > @@ -40,6 +40,7 @@
> >      > > > > > >       >  #include <linux/virtio_ring.h>
> >      > > > > > >       >  #include <asm/byteorder.h>
> >      > > > > > >       >  #include <linux/platform_device.h>
> >      > > > > > >       > +#include <linux/of_platform.h>
> >      > > > > > >       >
> >      > > > > > >       >  #include "remoteproc_internal.h"
> >      > > > > > >       >
> >      > > > > > >       > @@ -2203,13 +2204,74 @@ struct rproc *rproc_ge=
t_by_phandle(phandle phandle)
> >      > > > > > >       >
> >      > > > > > >       >       return rproc;
> >      > > > > > >       >  }
> >      > > > > > >       > +
> >      > > > > > >       > +/**
> >      > > > > > >       > + * rproc_get_by_id() - find a remote processo=
r by ID
> >      > > > > > >       > + * @phandle: phandle to the rproc
> >      > > > > > >       > + * @id: Index into rproc list that uniquely i=
dentifies the rproc struct
> >      > > > > > >       > + *
> >      > > > > > >       > + * Finds an rproc handle using the remote pro=
cessor's index, and then
> >      > > > > > >       > + * return a handle to the rproc. Before retur=
ning, ensure that the
> >      > > > > > >       > + * parent node's driver is still loaded.
> >      > > > > > >       > + *
> >      > > > > > >       > + * This function increments the remote proces=
sor's refcount, so always
> >      > > > > > >       > + * use rproc_put() to decrement it back once =
rproc isn't needed anymore.
> >      > > > > > >       > + *
> >      > > > > > >       > + * Return: rproc handle on success, and NULL =
on failure
> >      > > > > > >       > + */
> >      > > > > > >       > +
> >      > > > > > >       > +struct rproc *rproc_get_by_id(phandle phandle=
, unsigned int id)
> >      > > > > > >       > +{
> >      > > > > > >       > +     struct rproc *rproc =3D NULL, *r;
> >      > > > > > >       > +     struct platform_device *parent_pdev;
> >      > > > > > >       > +     struct device_node *np;
> >      > > > > > >       > +
> >      > > > > > >       > +     np =3D of_find_node_by_phandle(phandle);
> >      > > > > > >       > +     if (!np)
> >      > > > > > >       > +             return NULL;
> >      > > > > > >       > +
> >      > > > > > >       > +     parent_pdev =3D of_find_device_by_node(n=
p->parent);
> >      > > > > > >       > +     if (!parent_pdev) {
> >      > > > > > >       > +             dev_err(&parent_pdev->dev,
> >      > > > > > >       > +                     "no platform device for =
node %pOF\n", np);
> >      > > > > > >       > +             of_node_put(np);
> >      > > > > > >       > +             return NULL;
> >      > > > > > >       > +     }
> >      > > > > > >       > +
> >      > > > > > >       > +     /* prevent underlying implementation fro=
m being removed */
> >      > > > > > >       > +     if (!try_module_get(parent_pdev->dev.dri=
ver->owner)) {
> >      > > > > > >       > +             dev_err(&parent_pdev->dev, "can'=
t get owner\n");
> >      > > > > > >       > +             of_node_put(np);
> >      > > > > > >       > +             return NULL;
> >      > > > > > >       > +     }
> >      > > > > > >       > +
> >      > > > > > >       > +     rcu_read_lock();
> >      > > > > > >       > +     list_for_each_entry_rcu(r, &rproc_list, =
node) {
> >      > > > > > >       > +             if (r->index =3D=3D id) {
> >      > > > > > >       > +                     rproc =3D r;
> >      > > > > > >       > +                     get_device(&rproc->dev);
> >      > > > > > >       > +                     break;
> >      > > > > > >       > +             }
> >      > > > > > >       > +     }
> >      > > > > > >
> >      > > > > > >       This won't work because several remote processor=
s can be on the list.  If
> >      > > > > > >       another remote processor was discovered before t=
he one @phandle is associated
> >      > > > > > >       with, the remote processor pertaining to that pr=
evious one will returned.
> >      > > > > > >
> >      > > > > > > I didn't understand. From my point of view passing in =
the phandle of the child-platform device here will work because each child-=
platform will have its own entry in the remoteproc list.
> >      > > > > > You are correct, each child platform device will have it=
s own entry in
> >      > > > > > @rproc_list.  The problem is that r->index may not match=
 @id that is passed as a
> >      > > > > > parameter.
> >      > > > > >
> >      > > > > > > Also " If    another remote processor was discovered b=
efore the one" Here this prevented from what I can see because the remotepr=
oc_list is protected by a mutex_lock. Seehttps://github.com/torvalds/linux/=
blob/master/drivers/remoteproc/remoteproc_core.c#L2288  for the mutex_lock.
> >      > > > > > >
> >      > > > > > > Additionally the calls to zynqmp_r5_add_rproc_core() a=
re called sequentially so this also prevents the race condition.
> >      > > > > > >
> >      > > > > > > I think I am missing something in your paragraph above=
. Can you expand on this issue?
> >      > > > > > As explained above, the issue is not about race conditio=
ns but the value of
> >      > > > > > r->index and @id.
> >      > > > > >
> >      > > > > > >    Do you mean to say that if we use the cluster platf=
orm device you think using one of the existing APIs will work? For example =
rproc_get_by_child() or rproc_get_by_phandle()
> >      > > > > > >
> >      > > > > > > Athttps://git.kernel.org/pub/scm/linux/kernel/git/remo=
teproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=3Drproc-nex=
t#n923  " zynqmp_r5_add_rproc_core(&child_pdev->dev);" Here if we use clust=
er->dev this will work? To dig deeper into this for both the Xilinx and TI =
R5 remoteproc drivers, I think this proposed solution will create an issue =
in that for Split modes, the existing getter APIs will not be able to retur=
n one of the corresponding rproc instances because both cores will refer to=
 the same platform-device structure.
> >      > > > > > >
> >      > > > > > > I can bring up the above in the community call.
> >      > > > > > >
> >      > > > > > >       There is also an issue with rproc_put().
> >      > > > > > >
> >      > > > > > > If passing the cluster platform device works for the a=
bove then rproc_put() should work correct? We can test this on our side as =
well. That being said I can bring this up in the community call
> >      > > > > > Yes, using the cluster platform device will work with rp=
roc_put().
> >      > > > > >
> >      > > > > > >
> >      > > > > > >       I think your description of the problem is mostl=
y correct.  The intermediate
> >      > > > > > >       devices created by the cascading entries for ind=
ividual remote processors in the
> >      > > > > > >       device tree are causing an issue.  The "compatib=
le" string for each remote
> >      > > > > > >       processor can't be handled by any platform drive=
rs (as it should be), which
> >      > > > > > >       makes try_module_get() fail because r->dev.paren=
t->driver is not bound to
> >      > > > > > >       anything.
> >      > > > > > >
> >      > > > > > >       Looking at the code for Xilinx's R5F support tha=
t I just queued[1], the simplest
> >      > > > > > >       solution may be to pass @dev, which is in fact @=
cluster->dev, to
> >      > > > > > >       zynqmp_r5_add_rproc_core() rather than the devic=
e associated with the
> >      > > > > > >       intermediate platform device.
> >      > > > > > >
> >      > > > > > >       That _should_ work.  It is hard for me to know f=
or sure since I don't have a
> >      > > > > > >       platform that has dual core remote processor to =
test with.
> >      > > > > > >
> >      > > > > > >       Get back to me with how that turned out and we'l=
l go from there.
> >      > > > > > >
> >      > > > > > >       Thanks,
> >      > > > > > >       Mathieu
> >      > > > > > >
> >      > > > > > >
> >      > > > > > >
> >      > > > > > >
> >      > > > > > >       [1].https://git.kernel.org/pub/scm/linux/kernel/=
git/remoteproc/linux.git/tree/drivers/remoteproc/xlnx_r5_remoteproc.c?h=3Dr=
proc-next#n923
> >      > > > >
> >      > > > > I have an update on this.
> >      > > > >
> >      > > > >
> >      > > > >
> >      > > > > I tested the following using the RPU-cluster platform devi=
ce:
> >      > > > >
> >      > > > > test 1: RPU split with 2 core
> >      > > > >
> >      > > > > test 2: RPU split with 1 core
> >      > > > >
> >      > > > > test 3: lockstep RPU
> >      > > > >
> >      > > > >
> >      > > > > I tested with the zynqmp-r5-remoteproc platform probe usin=
g the (RPU)
> >      > > > > cluster platform device instead of the core/child platform=
 device. When I
> >      > > > > used this I was unable to properly use the API rproc_get_b=
y_phandle() and
> >      > > > > there was _only_ an issue for test 1. This was because eac=
h core will have
> >      > > > > its own call to rproc_alloc(), rproc_add() and each core's=
 remoteproc
> >      > > > > structure has the same parent device.
> >      > > >
> >      > > > You haven't specified if my proposal worked with test 2 and =
3.  I'm guessing
> >      > > > that it does.
> >      > > >
> >      > > Sorry, yes tests 2 and 3 work with your proposal.
> >      > > > >
> >      > > > > This results in the later call to rproc_get_by_phandle() n=
ot behaving
> >      > > > > properly because the function will return whichever core h=
ad its entries
> >      > > > > added to the list first.
> >      > > > >
> >      > > >
> >      > > > That is a valid observation, but at least we are getting clo=
ser.  The next step
> >      > > > is to find the right remote processor and I think we should =
look at np->name and
> >      > > > rproc->name.  They should be quite close because rproc_alloc=
() is called with
> >      > > > dev_name(cdev).
> >      > > >
> >      > > > I will look into this further tomorrow morning if I have tim=
e, but I encourage
> >      > > > you to do the same on your side.
> >      > > >
> >      > >
> >      > > For the case where the cluster is in split mode and there are =
2 child nodes
> >      > > here is my update:
> >      > >
> >      > > 1. The rproc_list has 2 entries as follows:
> >      > >
> >      > >   as expected each entry has the same r->dev.parent (E.g. the =
cluster node)
> >      > >
> >      > >   The entries have the  with device name rproc->dev name 'remo=
teproc0' and
> >      > > 'remoteproc1'
> >      > >
> >      > >
> >      > >
> >      > > 2. For my use case I am trying to pass in the phandle of the c=
ore node
> >      > > (child of the cluster). If I pass in the core node then
> >      > > rproc_get_by_phandle() returns NULL because the r->dev.parent-=
>of_node does
> >      > > not match. This is expected because at rproc_alloc() we passed=
 in the
> >      > > cluster and not the core.
> >      > >
> >      >
> >      >
> >      > I had a serious look into this and trying to do something with t=
he rproc->name and
> >      > device_node->name won't work.  As such, I suggest the following =
(uncompiled and
> >      > untested):
> >      >
> >      > struct rproc *rproc_get_by_phandle(phandle phandle)
> >      > {
> >      >         struct platform_device *cluster_pdev;
> >      >        struct rproc *rproc =3D NULL, *r;
> >      >         struct device_driver *driver;
> >      >        struct device_node *np;
> >      >
> >      >        np =3D of_find_node_by_phandle(phandle);
> >      >        if (!np)
> >      >                return NULL;
> >      >
> >      >        rcu_read_lock();
> >      >        list_for_each_entry_rcu(r, &rproc_list, node) {
> >      >                if (r->dev.parent && r->dev.parent->of_node =3D=
=3D np) {
> >      >                        /* prevent underlying implementation from=
 being removed */
> >      >
> >      >                         /*
> >      >                          * If the remoteproc's parent has a driv=
er, the
> >      >                          * remoteproc is not part of a cluster a=
nd we can use
> >      >                          * that driver.
> >      >                          */
> >      >                         driver =3D r->dev.parent->driver;
> >      >
> >      >                         /*
> >      >                          * If the remoteproc's parent does not h=
ave a driver,
> >      >                          * look for the driver associated with t=
he cluster.
> >      >                          */
> >      >                         if (!driver) {
> >      >                                 cluster_pdev =3D of_find_device_=
by_node(np->parent);
> >      >                                 if (!cluster_pdev) {
> >      >                                         dev_err(&r->dev, "can't =
get driver\n");
> >      >                                         break;
> >      >                                 }
> >      >
> >      >                                 driver =3D cluster_pdev->dev.par=
ent->driver;
> >
> >      This should be:
> >
> >                                        driver =3D cluster_pdev->dev.dri=
ver;
> >
> >      >                                 put_device(&cluster_pdev->dev);
> >      >                         }
> >      >
> >      >                        if (!try_module_get(driver->owner)) {
> >      >                                dev_err(&r->dev, "can't get owner=
\n");
> >      >                                break;
> >      >                        }
> >      >
> >      >                        rproc =3D r;
> >      >                        get_device(&rproc->dev);
> >      >                        break;
> >      >                }
> >      >        }
> >      >        rcu_read_unlock();
> >      >
> >      >        of_node_put(np);
> >      >
> >      >        return rproc;
> >      > }
> >      >
> >      > Let me know if that works for you.
> >      >
> >      > Thanks,
> >      > Mathieu
> >      >
> >      >
> >      >
> >      > > np->name in the loop is then name of the cluster node in my sa=
mple device
> >      > > tree that I booted with that is 'r5f_0' where the cluster is '=
rf5ss'.
> >      > >
> >      > > If I am trying to get the rproc entry with name 'remoteproc0' =
and I pass in
> >      > > to rproc_get_by_phandle() the cluster node's phandle (that is =
of rf5ss) then
> >      > > the API _does_ work for getting the first entry from the rproc=
 list.
> >      > >
> >      > > But If I am trying to the second rproc entry (dev name 'remote=
proc1') and I
> >      > > pass into rproc_get_by_phandle()  I will still get the 'remote=
proc0' entry
> >      > > because the phandle of the first entry also matches in the loo=
p.
> >      > >
> >      > > Thanks
> >      > > Ben
> >      > >
> >      > > > >
> >      > > > > For reference I placed the logic for API rproc_get_by_phan=
dle() that loops
> >      > > > > through device and the rproc_alloc() line where the dev pa=
rent is set:
> >      > > > >
> >      > > > >
> >      > > > > Here is the getter API where the loop checking the remotep=
roc dev parent is:
> >      > > > >
> >      > > > > https://github.com/torvalds/linux/blob/master/drivers/remo=
teproc/remoteproc_core.c#L2109
> >      > > > >
> >      > > > >
> >      > > > > if(r->dev.parent&& r->dev.parent->of_node=3D=3D np) {
> >      > > > >
> >      > > > >
> >      > > > > Here is the rproc_alloc() call where they set remoteproc d=
ev parent:
> >      > > > >
> >      > > > > https://github.com/torvalds/linux/blob/master/drivers/remo=
teproc/remoteproc_core.c#L2448
> >      > > > >
> >      > > > >
> >      > > > > rproc->dev.parent=3D dev;
> >      > > > >
> >      > > > > Thanks,
> >      > > > >
> >      > > > > Ben
> >      > > > >
> >      > > >
> >
> > ep
> > is to find the right remote processor and I think we should look at np-=
>name and
> > rproc->name.  They should be quite close because rproc_alloc() is calle=
d with
> > dev_name(cdev).
> >
> > I will look into this further tomorrow morning if I have time, but I en=
courage
> > you to do the same on your side.
> >
> >>
> >> For reference I placed the logic for API rproc_get_by_phandle() that l=
oops
> >> through device and the rproc_alloc() line where the dev parent is set:
> >>
> >>
> >> Here is the getter API where the loop checking the remoteproc dev pare=
nt is:
> >>
> >> https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remot=
eproc_core.c#L2109
> >>
> >>
> >> if(r->dev.parent&& r->dev.parent->of_node=3Dnp) {
> >>
> >>
> >> Here is the rproc_alloc() call where they set remoteproc dev parent:
> >>
> >> https://github.com/torvalds/linux/blob/master/drivers/remoteproc/remot=
eproc_core.c#L2448
> >>
> >>
> >> rproc->dev.parent=3Dev;
> >>
> >> Thanks,
> >>
> >> Ben
> >>
> >
