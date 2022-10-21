Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3505E6074AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiJUKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiJUKJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:09:45 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31578437E3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:09:44 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 63so2794588ybq.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+U9a6YuhyIQiRBIX0oFL2SCc+9ZE5crohQW0iwuFYyc=;
        b=RtF17LXw0yc8ZnIZp+gjq4cxOCf52YSR1UHiUaBUuXk7HOGzpgbh5hHEskGPYTLziw
         rVX5Us51zP2ZKFRfH+AcZoY7M8IMjmSWpOfcVnSmJBYRpgnBFqTQrY8dC25lXuDyNI/3
         6W8NtiVYZgPTnrwM6TzJo4HRt1b5VYZa70T164vF6rhOYe4XDApumUIc5VfAS7wmLNm1
         slB9BXge/Ty26kCV9EJkpfuOJIOsQmg5kvM5p02bEgl4zdYJJFMKKvhU7NVcpPzVq4vq
         m+lyr0bHNWj4iblQ55hSP28Ft9qCFl4zuCUQbjMFMmnXTlx8d74Cc8C2V9bwUCLw0am+
         sjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+U9a6YuhyIQiRBIX0oFL2SCc+9ZE5crohQW0iwuFYyc=;
        b=piD6XX0TO0CWu0S74gY5c8VLkqyGyIvAdjaLwbiikUWQVBMCvILxRzQJ4gOkk8nOQn
         awd6XWEPfqiyuoNBhvPgqUpH5SgpI7FQWXpwQ+C5Qk/zCRghwSJPBxaxlXkTr0YXsMIU
         wmJZRvK2ZVompTjwxQAlij2vS+QS4RRnfbSQQ9WjqQ9758xFdeRFqf62H/uCwtDDomgR
         +nHGl7PWWHJxNVkOgQRWiQ/IlxzzuGQPvQhcqvM0zBLbMEhYzdrP1aSzweRUG6xXtTsK
         xCqkxtKbht9ZNKHJGplGJ3A093T9Lz1Lpz0BVklFN4vdSmVFUy7Ew8aKYqS2y32xPeEL
         3ayQ==
X-Gm-Message-State: ACrzQf3PTWM6pY/J2m1z6XLGE94KlljZqx1iIL3QNt13+76LWER+vSeK
        O/HVDLhB39IFWwr0tT0B+dD2nB5wkL5SzsPp4bInuQ==
X-Google-Smtp-Source: AMsMyM6AohAOL5Mjr4kZGoZaJpwS9r8XfMr0l7gxNDB9ZxP2L3HWCUQMw/t3vA1WsAT428itNjwPh7+fAtzhHw4E7N0=
X-Received: by 2002:a5b:542:0:b0:6ca:1d54:fec8 with SMTP id
 r2-20020a5b0542000000b006ca1d54fec8mr8653609ybp.45.1666346983310; Fri, 21 Oct
 2022 03:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
 <b2e020b1-f6b2-e236-a042-4eb2fd27d8b0@intel.com> <IA1PR11MB6097236CFF891041DBA42ECB9B5F9@IA1PR11MB6097.namprd11.prod.outlook.com>
 <Y0BhzKkksSjSeE3W@agluck-desk3.sc.intel.com> <81a7b4f6-fbb5-380e-532d-f2c1fc49b515@intel.com>
 <CALPaoCjdeRjyX5L6BBX688ZM21eMwetuL9QLF1+GEDUskGcU2w@mail.gmail.com>
 <7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com> <CALPaoCg4zrODVoXF2y2b+LRYq_+jnV8yv5qB+T_3Z264cV82GQ@mail.gmail.com>
 <b931062a-1a70-2331-03cc-6bfa69a51bee@intel.com> <CALPaoCj8ps2YRH5T1eCRY-8MLwGi25cfbd0KNtjYXTq5baAXOQ@mail.gmail.com>
 <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
In-Reply-To: <da89ea90-8453-f848-38d1-a14195faa95e@intel.com>
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 21 Oct 2022 12:09:32 +0200
Message-ID: <CALPaoChgi9Z8J7sca_YRHveBW9NzB=PPC1Yp01S=TGiJLBxkQw@mail.gmail.com>
Subject: Re: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Gaurang Upasani <gupasani@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Thu, Oct 20, 2022 at 9:08 PM Reinette Chatre
<reinette.chatre@intel.com> wrote:
>
> If the expectation is that PARTID counts are very high then how about
> a solution where multiple PARTIDs are associated with the same CTRL_MON group?
> A CTRL_MON group presents a resource allocation to user space, CLOSIDs/PARTIDs
> are not exposed. So using multiple PARTIDs for a resource group (all with the
> same allocation) seems conceptually ok to me. (Please note, I did not do an
> audit to see if there are any hidden assumption or look into lifting required
> to support his.)

I did propose using PARTIDs to back additional mon_groups a few days ago
on the other sub-thread with James. My understanding was that it would
be less trouble if the user opted to do this on their own rather than
the kernel somehow doing this automatically.

https://lore.kernel.org/all/835d769b-3662-7be5-dcdd-804cb1f3999a@arm.com/

So perhaps we can just arrive at some way to inform the user of the
difference in resources. We may not even need to be able to precisely
calculate the number of groups we can create, as the logic for us could
be a simple as:

1) If num_closids >= desired job count, just use CTRL_MON groups
2) Otherwise, fall back to the proposed mon_group-move approach if
num_rmids is large enough for the desired job count

To address the glitchy behavior of moving a PMG to a new PARTID, I found
that the MPAM spec says explicitly that a PMG is subordinate to a
PARTID, so I would be fine with James finding a way for the MPAM driver
to block the rename operation, because it's unable to mix and match
RMIDs and CLOSIDs the way that RDT can.

-Peter
