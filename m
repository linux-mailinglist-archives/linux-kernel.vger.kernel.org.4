Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22442727547
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 04:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233807AbjFHCv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 22:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbjFHCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 22:51:20 -0400
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064BA1FF7;
        Wed,  7 Jun 2023 19:51:16 -0700 (PDT)
Received: by mail-vk1-xa34.google.com with SMTP id 71dfb90a1353d-463fdee669cso147754e0c.0;
        Wed, 07 Jun 2023 19:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686192675; x=1688784675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4iCMufvU+mSHmPOmnXMCrZIm6v3t8Nrs/bcmlqQqCU=;
        b=JKRyNhZ8bTG0BgOBUtLCvd/63nTwEAMUi/YoZ+JabRgc64hK9Jc+/4gll1b5cpxVJL
         waD71aWa0V2zpn9hL3NEPyYfvpn7+P89wrGyqNBS0zicSX1lktF+PYXW3KPFICXk+4aG
         6wm2GA80Vg53vRio3rR9tahUCTNPr9d1RerNYpnYjmgmIyWqlOnXgCYmKEIj4htcq/DP
         Wf9tEpi0xGKs6DG/OCxjNKHEhPLRnz2IQE2X4aXwAwORBeRfuweY5cQ+4cdKkvUrt/HV
         olB7OkwTLiY6CdMtC9eZ3xqDqD/VcctKbhvpilS2X6K/zlhil9ucXV4Zfo7eRjXfnw1c
         nzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686192675; x=1688784675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4iCMufvU+mSHmPOmnXMCrZIm6v3t8Nrs/bcmlqQqCU=;
        b=agmBw+imyaYEfFTqpsDeqmjOm2XIrUWVlU2I2F+M1m6WJQfKC9qYBSq8XG/ChgUMQt
         crosi2b7E7sp4JpBGuDNiSLtFWny6sOBsmDsb+QKcY6eEGPX3MysDxe07LEwhiAxwe+q
         l3iZj0xxu4oO0wQ5CWAlbP7tUn3zm1yTXMxPAsUCS1nlpYrP7r3oAmkP3+sbkatA3VeF
         k1z/hWEGFb+J5dMDtFiTfAdCNC7i47IBp6hl+mmKRyPXeSca++SOBv+bvTsFpq3GzuyJ
         mZonERQQ3iyGhg1n1OsE+gjvrovh/5i/T/V/g/CkWKAueGG8oC/eArLlSJoq3haxXye/
         LwEw==
X-Gm-Message-State: AC+VfDwWoVRRkg0JmxVwf0ND3/J+cLr3PmyUHCBbx1uKp25JBIvaJKTB
        OobtJ+i4wuJxYPgobFgKzeWBtNgfsGUrZ6n+IGShD/g+jIk=
X-Google-Smtp-Source: ACHHUZ45xdz52r6mci4tsf4hW5WjVNgXix00zbT41XCQNvK3y33Ok0aCpKw5aIYWRfWbw+QdwBYs5ZW/gUGomuqLCp0=
X-Received: by 2002:a1f:4551:0:b0:440:4946:fac with SMTP id
 s78-20020a1f4551000000b0044049460facmr407809vka.4.1686192674953; Wed, 07 Jun
 2023 19:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230606051217.2064-1-iecedge@gmail.com> <6ad5fba3-926a-7a23-b21b-abffd33708be@acm.org>
 <CAFA-uR_Zn4MdFKs6U6dqPjuVS60yN4RcYU4jJzjknqy7-RWyEQ@mail.gmail.com> <e9b8b9c5-f400-9152-0f4b-537b05203dd2@acm.org>
In-Reply-To: <e9b8b9c5-f400-9152-0f4b-537b05203dd2@acm.org>
From:   Jianlin Lv <iecedge@gmail.com>
Date:   Thu, 8 Jun 2023 10:51:03 +0800
Message-ID: <CAFA-uR83jHJsDXnn-3LWcrw251S4MizHC_JPJssYrgoD6kLoAg@mail.gmail.com>
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

On Thu, Jun 8, 2023 at 1:07=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 6/7/23 08:55, Jianlin Lv wrote:
> > 1. MegaRAID adapters associated with 24 local disks. The disks are name=
d
> > sequentially as "sda," "sdb," and so on, up to "sdx."
> > 2. STAT controllers associated with the root disk, named "sdy."
> >
> > Both the MegaRAID adapters and the SATA controller (PCH) are accessed v=
ia
> > the PCIe bus. In theory, depending on their PCIe bus ID in ascending or=
der,
> > the devices should be initialized in ascending order as well.
>
> Hmm ... I don't think there is anything that prevents the PCIe maintainer
> from changing the PCIe probing behavior from synchronous to asynchronous?
> In other words, I don't think it is safe to assume that PCIe devices are
> always scanned in the same order.
>
> > For cloud deployment, the local volume provisioner detects and creates =
PVs
> > for each local disk (from sda to sdx) on the host, and it cleans up the
> > disks when they are released.
> > This requires the logical names of the disks to be deterministic.
>
> I see two possible solutions:
> - Change the volume provisioner such that it uses disk references that do
>    not depend on the probing order, e.g. /dev/disk/by-id/...

Yes, The "/dev/disk/by-id/" can uniquely identify SCSI devices. However,
I don't think it is suitable for the volume provisioner workflow.
For nodes of the same SKU , a unified YAML file will be defined to instruct
the volume provisioner on how to manage the local disks.
If use WWID, it would mean that a unique YAML file needs to be defined
for each node. This approach becomes impractical when dealing with a large
number of work nodes.

Jianlin

> - Implement an algorithm in systemd that makes disk names predictable.
>    An explanation of how predictable names work for network interfaces is
>    available here: https://wiki.debian.org/NetworkInterfaceNames. The
>    systemd documentation about predictable network names is available her=
e:
>    https://www.freedesktop.org/software/systemd/man/systemd.net-naming-sc=
heme.html
>
> These alternatives have the advantage that disk scanning remains asynchro=
nous.
>
> Thanks,
>
> Bart.
>
