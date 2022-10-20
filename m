Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5DE605D81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 12:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiJTKjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 06:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJTKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 06:39:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3533A2FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:39:20 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t186so24090708yba.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JxIxHdFLYx573ZzqutYqPDFsYcwssvswibYT+YB9oc=;
        b=NzLHlb8d+oxnep2Jg7wz0EP81KhrBG54KDJGDcPzyyjYISqUSoEtuN5TUl4NWtnLws
         3YjUORVwWTBgaqQMHxgtH5Td3bTn2zmaq8ZVXYkuW5ra3QRQCcUZh1GNYWFQyNJMRw+r
         +y0uTkaeOoQ0OuxtxQE3RI/RYBuqpMtyt5P9DBo+SzsOLmjQwMS59z/PgqkC3oxuLDMj
         OFmgnJ5DWOPesOdfin4seVsymCWVsOVo10yJilytECT1YLrQA0fg/SJkFZyTsWcuMbrm
         B5xE2RYVMY79A/51ZQnIChwZx1co2FOtKIrzu7GDEF1s/pU2iS1w8FXkEMzQ5ukG4CzJ
         7ObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JxIxHdFLYx573ZzqutYqPDFsYcwssvswibYT+YB9oc=;
        b=Skbxft01gQF+eWERaD4pu2njbOr16zGNs7f0w5l0ndHQ0dSeGO/z0Zar3/F9c21dk2
         UEr1xTjo2NClGUE+Qn5SB9BqHZtPDxOy1omotAta2WbqYOjgK3aTAomASJUVRpGtZJ+u
         UXoNoLLcgP4bMXQE6oQljFrys4v+YsvYRtB6sDjS9y2j7uYmlRlS0iCM7JKYKKi576Gd
         DCFR0DqRdTkEN0g8ta5O5jmBhXZnw0hlYmAy1UBhlAiEm/2odtcN4NQY0CgJJz3LCacF
         uXhlXsFozA4bCd6H+GD+6KBtl5pChgLU2yor7Q3LerLr4J6skZlzNmv/lbFmJfSv9TJ0
         I82g==
X-Gm-Message-State: ACrzQf1dL6Hl8A/CgmXfcmMpRp0EwR521opb8MhrtAVFHu4Nygci9i54
        AnNouyNIWJsG78aTO2DoPpei2OLHRfLgtRKZkfTlbA==
X-Google-Smtp-Source: AMsMyM4YUHh8PiZkJl21yNZjHpFXDH4kEoQUyN+eMTsAwOoaqe63ANzLN4Wuww9u727GHrWV0/+X4P/qISpFB6O8iTQ=
X-Received: by 2002:a25:c504:0:b0:6c9:dee7:c201 with SMTP id
 v4-20020a25c504000000b006c9dee7c201mr5589107ybe.422.1666262359272; Thu, 20
 Oct 2022 03:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <76bb4dc9-ab7c-4cb6-d1bf-26436c88c6e2@arm.com> <CALPaoCiKUQC+LxDwKQ0gE5AQniJi_nbzrXi_HA9ZBRtiXdw_dg@mail.gmail.com>
 <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
In-Reply-To: <835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com>
From:   Peter Newman <peternewman@google.com>
Date:   Thu, 20 Oct 2022 12:39:08 +0200
Message-ID: <CALPaoCgiwtvxZMJ6f-BOTNMPXDbMB8QM42HyCAvYRi4grPiphQ@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 3:58 PM James Morse <james.morse@arm.com> wrote:
> This isn't how MPAM is designed to be used. You'll hit nasty corners.
> The big one is the Cache Storage Utilisation counters.
>
> See 11.5.2 of the MPAM spec, "MSMON_CFG_CSU_CTL, MPAM Memory System Monit=
or Configure
> Cache Storage Usage Monitor Control Register". Not setting the MATCH_PART=
ID bit has this
> warning:
> | If MATCH_PMG is 1 and MATCH_PARTID is 0, it is CONSTRAINED UNPREDICTABL=
E whether the
> | monitor instance:
> | =E2=80=A2 Measures the storage used with matching PMG and with any PART=
ID.
> | =E2=80=A2 Measures no storage usage, that is, MSMON_CSU.VALUE is zero.
> | =E2=80=A2 Measures the storage used with matching PMG and PARTID, that =
is, treats
> | MATCH_PARTID as =3D 1
>
> 'constrained unpredictable' is arm's term for "portable software can't re=
ly on this".
> The folk that designed MPAM don't believe "monitors would only match on P=
MGs" makes any
> sense. A PMG is not an RMID. A case in point is the system with only 1 PM=
G bit.
>
> I'm afraid this approach would preclude support for the llc_occupancy cou=
nter, and would
> artificially reduce the number of control groups that can be created as e=
ach control group
> needs an 'RMID'. On the machine with 1 PMG bit - you get 2 control groups=
, even though it
> has many more PARTID.

The first sentence of the Resource Monitoring chapter is also quite an
obstacle to my challenging to the PARTID-PMG hierarchy:

| Software environments may be labeled as belonging to a Performance
| Monitoring Group (PMG) within a partition.

It seems like the only real issue is that the user is responsible for
figuring out how best to make use of the available resources. But I seem
to recall that was the expectation with resctrl, so I should probably
stop trying to argue for expecting MPAM configurations which resemble
RDT.


> On 17/10/2022 11:15, Peter Newman wrote:
> > Provided that there are sufficient monitor
> > instances, there would never be any need to reprogram a monitor's
> > PMG.
>
> It sounds like this moves the problem to "make everything a monitor group=
 because only
> monitor groups can be batch moved".
>
> If the tasks file could be moved between control and monitor groups, caus=
ing resctrl to
> relabel the tasks - would that solve more of the problem? (it eliminates =
the need to make
> everything a monitor group)

This was about preserving the RMID and memory bandwidth counts across a
CLOSID change. If the user is forced to conserve CTRL_MON groups due to
a limited number of CLOSIDs, keeping the various containers' tasks
separate is also a concern.

But if there's no need to conserve CTRL_MON groups, then there's no real
issue.

> The devil is in the detail, I'm not sure how it serialises with a fork()i=
ng process, I'd
> hope to do better than relying on the kernel walking the list of processe=
s a lot quicker
> than user-space can.

I wasn't planning to do it any more optimally than the rmdir
implementation today when looking for all tasks impacted by a
CLOSID/RMID deletion.

-Peter
