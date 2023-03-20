Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2E46C1E48
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjCTRkf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 13:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjCTRkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:40:02 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45314303EF;
        Mon, 20 Mar 2023 10:36:14 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id eg48so49756406edb.13;
        Mon, 20 Mar 2023 10:36:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679333722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/QjLJro0ozwvQtAPPR3kthvt1S0gysI2a8deVUCjjkU=;
        b=K+oZ3duqAE9yeKq9dEwPpH6PUArOyL/Xa8bA66dXFE5bRf0VjabSFge1KvoDkolusG
         CCV4akOsaa7wndYVb5n5XsoNz8GV4IWoTAWH3QFdcRZRTTASCFNHHHxBaCxtdruHWMPc
         hp/JQCib39etGjvvwMbmRu8eFsoUGFIa7Oh2/QadKILvsWi3L25Vs0w+ev4A+fqDlN+O
         TnRtk6lS0j1+cJmNJ5Og3tY6W/SWhzEm05oHqpYYkbV+44iXpPpnp6g1jvC+eWOc4rDj
         hnl4NrC6tAgdUJqptmMy9LgE2iQWaRh5evJk643qCQflJLfKwIqU82AKfpCdYMBoTkuG
         HfaA==
X-Gm-Message-State: AO0yUKUYc/wz3+EPFcgcC7+av4msszo9E7ByJUeKdwq431guK0Byn/45
        jhUoP+s7F/pHC6iELjiB+zJyltzNv3d5FjZg/N0w8ZSj
X-Google-Smtp-Source: AK7set+VA/rcOUmpoZp8eUYkOmJGipU8Zizu65yISHQcCQ3wzfK76tFC/CrVN58vbC56wW3FLuLW+piLzR7dMmE8XJU=
X-Received: by 2002:a17:906:896:b0:8b1:38d6:9853 with SMTP id
 n22-20020a170906089600b008b138d69853mr3919355eje.2.1679333721776; Mon, 20 Mar
 2023 10:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230302071327.557734-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAJZ5v0gB7WSB3F3+kTnB-r83xO9G7Sk1Vyh2os0=AeYNvHK_Mw@mail.gmail.com> <39d7b92a-8f30-8302-049b-d2ee9e6c1a78@linux.intel.com>
In-Reply-To: <39d7b92a-8f30-8302-049b-d2ee9e6c1a78@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 18:35:10 +0100
Message-ID: <CAJZ5v0jpJ1yq7bS7TLLAzCL6k-_HWCVSQLx4U=3wuM_2=V-sHQ@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: sysfs: Enable ACPI sysfs support for CCEL records
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Rafael J Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 6:34 PM Sathyanarayanan Kuppuswamy
<sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On 3/20/23 10:15 AM, Rafael J. Wysocki wrote:
> > On Thu, Mar 2, 2023 at 8:13 AM Kuppuswamy Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >>
> >> The Confidential Computing Event Log (CCEL) table provides the address
> >> and length of the CCEL records area in UEFI reserved memory. To access
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
> >>
> >> Original-patch-by: Haibo Xu <haibo1.xu@intel.com>
> >> [Original patch is for TDEL table, modified it for CCEL support]
> >> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> >> ---
> >>  drivers/acpi/sysfs.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
> >> index 7db3b530279b..afeac925b31b 100644
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
> >> +           !(ccel->log_area_start_address) || !(ccel->log_area_minimum_length)) {
> >
> > The inner parens in this line are not necessary AFAICS.
> >
> > Otherwise I have no objections.
>
> Yes. We can do without it. Shall I submit v2 with this change, or you want to
> fix it when applying?

I would appreciate a v2.

> >
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
>
> --
