Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E073CAA5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 13:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjFXLpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 07:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFXLpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 07:45:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD3D1FD7;
        Sat, 24 Jun 2023 04:45:49 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-763ddc4259dso141548185a.3;
        Sat, 24 Jun 2023 04:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687607148; x=1690199148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zP3mUhmYFxJcONcmqARo3rbXN0HiQgVUbkY1nlHKpiE=;
        b=PQTR28s2V9NwNSHTiFgMA/4gp/BNDeredmuKpPYE/IJcPnQYIn6HzOw/VcSlkvnVlq
         JF4qgEYsbhTkSP8gfxaLQFLcco+2LWWhurgdiMSwR72tASXyVcaWVCOfjGmhpuGXsXf4
         OkVvRlezkY6aNvW/ojZfBmvCw/nBb0aryxy6mq3+slpE76i6FAO2zFpqPJ+FGLu+m7jk
         ud9GrDy9D2vSuhptsiEcaKuOt+ENoC0823u3mtlBg8b7sh8Z5+InDtkk/LH51K/y+cgs
         8NZyT3Pq5AVus7GldHPXihb4hPjTPIDiNxzNbyy/nS9c405pEUjxQNwMMekEaXkrhTLm
         zzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687607148; x=1690199148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zP3mUhmYFxJcONcmqARo3rbXN0HiQgVUbkY1nlHKpiE=;
        b=OPbEEn/gmi6fyA8zkdM5UOTtNJytoE/8XtPjTX/fmIdxARLrxKq/mAaEFVlW6PuIVX
         t/L6P7bP7Tz1ONErO0YAv86NqXfHm7gzI4XZ8uIFn1Vi5wxqjo4mTBUXlMzrHmgu50Gq
         ac+pUIOo7Mnfghdlh3VtN8j67fZdFEToSFmnC/MIdcp7sGkAlH+ydhOYh+2xwtOPqpLg
         iz0W6mbS8CTuHjRvWA28a1gS6vDvGz/GUFNwD6yvVzdqov/w2GovgzoaMWSNQ1A9Rqz6
         seZhrlpC5bmZX1WDoAbQnmzNSZpk4WemDnOAYbLa/CJd63JfEFAGXMCXbAsSl15S78Gg
         No4g==
X-Gm-Message-State: AC+VfDzMoaTREnvyDCQ6ozuyJoMC4KBYCx5np4mKIEQgynrsaBJxR5L+
        Azx6R9D7mRTHbZbi1/MgcFiTiQIHkJPdx12ec00=
X-Google-Smtp-Source: ACHHUZ6bf6KUSVdzdiaMFp337uOJ561gzdBdvqL0oPQm/uUN2weYcc0ipWTtYFaAeekf3yWRxtNp1NKp2DwnZEzEi3w=
X-Received: by 2002:a05:620a:6847:b0:763:a7e9:6cfc with SMTP id
 ru7-20020a05620a684700b00763a7e96cfcmr16109209qkn.11.1687607148658; Sat, 24
 Jun 2023 04:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230606051217.2064-1-iecedge@gmail.com> <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
 <CAFA-uR_Zn4MdFKs6U6dqPjuVS60yN4RcYU4jJzjknqy7-RWyEQ@mail.gmail.com>
 <e9b8b9c5-f400-9152-0f4b-537b05203dd2@acm.org> <CAFA-uR83jHJsDXnn-3LWcrw251S4MizHC_JPJssYrgoD6kLoAg@mail.gmail.com>
 <5b898dde-2f76-51af-5d2e-c4572719a5be@acm.org>
In-Reply-To: <5b898dde-2f76-51af-5d2e-c4572719a5be@acm.org>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Sat, 24 Jun 2023 19:45:36 +0800
Message-ID: <CAFA-uR_jk6jCmf9DTebSVBRwtoLuXuyvf1Biq+OObqRVAOZbBw@mail.gmail.com>
Subject: Re: [PATCH] scsi: sd: support specify probe type of build-in driver
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com, paulmck@kernel.org,
        bp@suse.de, peterz@infradead.org, will@kernel.org,
        rdunlap@infradead.org, kim.phillips@amd.com, rostedt@goodmis.org,
        wyes.karny@amd.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-scsi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 12:23=E2=80=AFAM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 6/7/23 19:51, Jianlin Lv wrote:
> > On Thu, Jun 8, 2023 at 1:07=E2=80=AFAM Bart Van Assche <bvanassche@acm.=
org> wrote:
> >> On 6/7/23 08:55, Jianlin Lv wrote:
> >> I see two possible solutions:
> >> - Change the volume provisioner such that it uses disk references that=
 do
> >>     not depend on the probing order, e.g. /dev/disk/by-id/...
> >
> > Yes, The "/dev/disk/by-id/" can uniquely identify SCSI devices. However=
,
> > I don't think it is suitable for the volume provisioner workflow.
> > For nodes of the same SKU , a unified YAML file will be defined to inst=
ruct
> > the volume provisioner on how to manage the local disks.
> > If use WWID, it would mean that a unique YAML file needs to be defined
> > for each node. This approach becomes impractical when dealing with a la=
rge
> > number of work nodes.
> Please consider using the paths available in /dev/disk/by-path.

Sorry for the late reply.
I carefully checked the server in the production environment and found
some corner cases where there are differences in the dev/disk/by-path/ of
nodes with the same SKU. These differences are caused by inconsistent
target_numbers.

For example:

diff -y aa-by-path bb-by-path
pci-0000:86:00.0-scsi-0:3:86:0 -> ../../sda |
pci-0000:86:00.0-scsi-0:3:88:0 -> ../../sda
pci-0000:86:00.0-scsi-0:3:87:0 -> ../../sdb |
pci-0000:86:00.0-scsi-0:3:89:0 -> ../../sdb
pci-0000:86:00.0-scsi-0:3:88:0 -> ../../sdc |
pci-0000:86:00.0-scsi-0:3:90:0 -> ../../sdc
pci-0000:86:00.0-scsi-0:3:89:0 -> ../../sdd |
pci-0000:86:00.0-scsi-0:3:91:0 -> ../../sdd
pci-0000:86:00.0-scsi-0:3:90:0 -> ../../sde |
pci-0000:86:00.0-scsi-0:3:92:0 -> ../../sde
pci-0000:86:00.0-scsi-0:3:92:0 -> ../../sdf |
pci-0000:86:00.0-scsi-0:3:93:0 -> ../../sdf
pci-0000:86:00.0-scsi-0:3:93:0 -> ../../sdg |
pci-0000:86:00.0-scsi-0:3:94:0 -> ../../sdg
pci-0000:86:00.0-scsi-0:3:94:0 -> ../../sdh |
pci-0000:86:00.0-scsi-0:3:95:0 -> ../../sdh

I'm still not sure what causes the target_numbers to be different.
However, the existence of such corner cases makes /dev/disk/by-path
unusable for the volume provisioner, similar to /dev/disk/by-id/.

So, If it's not possible to configure disk serialization detection, then
it seems that implementing predictable disk names is the only option.

Jianlin

>
> Thanks,
>
> Bart.
