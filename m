Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254BE624AA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKJT3k convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Nov 2022 14:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJT3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:29:35 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA50865BE;
        Thu, 10 Nov 2022 11:29:34 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id s20so1774937qkg.5;
        Thu, 10 Nov 2022 11:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSVYD1v7K4BrYXK0u3SCv8ScBPQPneRqu4O2yg7mNMk=;
        b=hOfwHCJ8qqoKe+v7P7aZ703GZ2iIDHpQQ+Pps1kT6xhyI9sED5nIMrTPW52goguAA8
         zxJBNl7HEgS5OPbyCagcvXL1jDwfpLclPUqXNfo10IO0KIpuXQRAQ5MoonSMMWZZnD2l
         l6eIP/suh/N8r7/zewstbbTNWzDrZHhIZ6kMWH0j4fByMKadsdRYAZSwLyQ8KGZ1iS4G
         Hoy9rNVyxlSBobnddE2mySNynJWpIjM4kol7W2bnq1eZiWvvjHj9y10e77qUGRIgaU0g
         IUQhI4PiOe9jKclc5joVfQ6gscewd/+LdxKNVOxe6oKsQlRXY6PdefSKL3U6dkU4g/v3
         3WEA==
X-Gm-Message-State: ACrzQf3lMl3+5Jc97ZT7dcpuNMzzva0+Q5s6HKALTVA4FqAn0rD613QZ
        uJNkgH2GhGcuWwjLPT7VYOcXpKBGaa7a/EJpBYQ=
X-Google-Smtp-Source: AMsMyM5yJg+cU512ZzXG5/3nSOncbL3I3fJWCtg6E2p/m23cKJFAo2qUEgBISuBpUEaeeGsY+SuWVG6ByDdKlTkJeLg=
X-Received: by 2002:ae9:eb4a:0:b0:6fa:df0:f326 with SMTP id
 b71-20020ae9eb4a000000b006fa0df0f326mr1677320qkg.23.1668108573853; Thu, 10
 Nov 2022 11:29:33 -0800 (PST)
MIME-Version: 1.0
References: <20221110015034.7943-1-lihuisong@huawei.com> <20221110015034.7943-2-lihuisong@huawei.com>
 <20221110102528.6kuznowxtqkouvlb@bogus> <4f167ee7-ad50-d66c-8bd7-811fa0e83cfd@huawei.com>
In-Reply-To: <4f167ee7-ad50-d66c-8bd7-811fa0e83cfd@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 20:29:23 +0100
Message-ID: <CAJZ5v0h82m37Li3YOfP7_8aAS3ULwzunpWZJwRPncLooPqvE-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] mailbox: pcc: rename platform interrupt bit macro name
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
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

On Thu, Nov 10, 2022 at 1:17 PM lihuisong (C) <lihuisong@huawei.com> wrote:
>
>
> 在 2022/11/10 18:25, Sudeep Holla 写道:
> > On Thu, Nov 10, 2022 at 09:50:32AM +0800, Huisong Li wrote:
> >> Currently, the name of platform interrupt bit macro, ACPI_PCCT_DOORBELL,
> >> is not very appropriate. The doorbell is generally considered as an action
> >> when send mailbox data. Actually, the macro value comes from Platform
> >> Interrupt in Platform Communications Channel Global Flags. If the bit is
> >> '1', it means that the platform is capable of generating an interrupt to
> >> indicate completion of a command.
> >>
> > This is touching ACPICA header file, so it must be submitted to ACPICA
> > separately following the guidelines in the github and imported into the
> > kernel.
> Got it, thanks.
> >
> > However, I don't see any point in this change. Yes the language "doorbell"
> > is not used in this particular context in the spec, but it is implicit from
> > other parts. I am not opposing the change though if Rafael is OK and ACPICA
> > project accepts it.
> @Rafael, what do you think?

Well, I wouldn't send a patch to make this change myself, but if you
really care about it, please submit an upstream ACPICA pull request in
the first place and we'll see.
