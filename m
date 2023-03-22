Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3846C5483
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCVTGT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 15:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCVTGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:06:18 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB2298DF;
        Wed, 22 Mar 2023 12:06:15 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id cn12so31478393edb.4;
        Wed, 22 Mar 2023 12:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511974;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qX50foVihAGCHl7BTrP17dM7Mv2MYDDeekD5jmyzN/U=;
        b=BYQwuZbeX3hwMWu5GDR1K+eltVO86Mk1rfyoJkUc6TZ0k9G9y3yrG32V5NG1IpxWVR
         muUhIAewcVtWRjb19FhptjafHPiMKVIOJm4mKF+0QFTeFgy7994SccmRd66Zl0zBjTrM
         x9xB8zQt8JajrYzO6FN+gGUcDfyzsuCMKqpyTe1QjPVkgDwXAGH3krED6Nnoi2JBSvQO
         dNjxutrk6m85OKOlEigeUddBXtpyfpBoLk3921zgMnoMQDNcT4uAo9POoheo3liTzxX/
         0Vol4ruAT5rmTc6ozfTnWs8glnP9tvu7sX0s3H0Z4PyTsK610UUDLwvRbliJnUOan5gH
         6xow==
X-Gm-Message-State: AO0yUKWlhJGzbm1ZKoCdIy/HWLzoczIUIEb4k2yFL6OMKErcIcl2Qvvw
        z75BpB51MoK8YqyZDS0q06q6i8g3tN4VnzQxevk=
X-Google-Smtp-Source: AK7set/MThnDHCg2TQwiIXu7imRpwwC6h1OzWXqxhlQT8Fit/skpap+hzs+/YNgjVvLVfrYK1l7BgFHjCKWKsHx4/Ro=
X-Received: by 2002:a50:f683:0:b0:4fb:c8e3:1ae2 with SMTP id
 d3-20020a50f683000000b004fbc8e31ae2mr4165962edn.3.1679511974157; Wed, 22 Mar
 2023 12:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230320212019.2479101-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0ggn6q5WJsK7jP7EbxnRq6xxwzj2PwOMxhV6L6Rb5iSJw@mail.gmail.com> <86fc67ba-9a6f-950a-cf30-5e80ba8efeb6@linux.intel.com>
In-Reply-To: <86fc67ba-9a6f-950a-cf30-5e80ba8efeb6@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 20:06:03 +0100
Message-ID: <CAJZ5v0i5n8T5QUFZKM8M0=rKOmKFa-5Zo2DsJ_Eo89apBBEsBA@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 8:00 PM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On 3/22/23 11:31 AM, Rafael J. Wysocki wrote:
> > On Mon, Mar 20, 2023 at 10:21 PM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> The Confidential Computing Event Log (CCEL) table provides the address
> >> and length of the CCEL records area in UEFI reserved memory.
> >
> > The rest of this paragraph can be omitted.
> >
> >> To access
> >> these records, userspace can use /dev/mem to retrieve them. But
> >> '/dev/mem' is not enabled on many systems for security reasons.
> >>
> >> So to allow user space access these event log records without the
> >> /dev/mem interface, add support to access it via sysfs interface. The
> >> ACPI driver has provided read only access to BERT records area via
> >> '/sys/firmware/acpi/tables/data/BERT' in sysfs. So follow the same way,
> >> and add support for /sys/firmware/acpi/tables/data/CCEL to enable
> >> read-only access to the CCEL recorids area.
> >>
> >> More details about the CCEL table can be found in ACPI specification
> >> r6.5, sec titled "CC Event Log ACPI Table".
> >
> > Please provide a proper section number here and a Link: tag pointing
> > to the relevant section of the spec (which is
> > https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table
> > I think).
> >
> >> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
> >
> > If the original patch has been signed-off by that developer, you can
> > use a Co-developed-by: along with the original S-o-b tag here.
> >
> >> [Original patch is for TDEL table, modified it for CCEL support]
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> ---
> >>
>
> How about the following version?

Looks good to me, thanks!

> ACPI: sysfs: Enable ACPI sysfs support for CCEL records
>
> The Confidential Computing Event Log (CCEL) table provides the address
> and length of the CCEL records area in UEFI reserved memory.
>
> To allow user space access to these records, expose a sysfs interface
> similar to the BERT table.
>
> More details about the CCEL table can be found in the ACPI specification
> r6.5 [1], sec 5.2.34.
>
> Link: https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html#cc-event-log-acpi-table # [1]
> Co-developed-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>
>
>
> >> Changes since v1:
> >>  * Removed unnecessary parenthesis as per Rafael's suggestion..
> >>
> >>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> >> index 7f4ff56c9d42..687524b50085 100644
> >> --- a/drivers/acpi/sysfs.c
> >> +++ b/drivers/acpi/sysfs.c
> >> @@ -458,11 +458,28 @@ static int acpi_bert_data_init(void *th, struct acpi_data_attr *data_attr)
> >>         return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
> >>  }
> >>
> >> +static int acpi_ccel_data_init(void *th, struct acpi_data_attr *data_attr)
> >> +{
> >> +       struct acpi_table_ccel *ccel = th;
> >> +
> >> +       if (ccel->header.length < sizeof(struct acpi_table_ccel) ||
> >> +           !ccel->log_area_start_address || !ccel->log_area_minimum_length) {
> >> +               kfree(data_attr);
> >> +               return -EINVAL;
> >> +       }
> >> +       data_attr->addr = ccel->log_area_start_address;
> >> +       data_attr->attr.size = ccel->log_area_minimum_length;
> >> +       data_attr->attr.attr.name = "CCEL";
> >> +
> >> +       return sysfs_create_bin_file(tables_data_kobj, &data_attr->attr);
> >> +}
> >> +
> >>  static struct acpi_data_obj {
> >>         char *name;
> >>         int (*fn)(void *, struct acpi_data_attr *);
> >>  } acpi_data_objs[] = {
> >>         { ACPI_SIG_BERT, acpi_bert_data_init },
> >> +       { ACPI_SIG_CCEL, acpi_ccel_data_init },
> >>  };
> >>
> >>  #define NUM_ACPI_DATA_OBJS ARRAY_SIZE(acpi_data_objs)
> >> --
> >> 2.34.1
> >>
>
> --
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
