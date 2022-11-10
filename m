Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35076242CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiKJNFT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 10 Nov 2022 08:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiKJNFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:05:15 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF11A225;
        Thu, 10 Nov 2022 05:05:15 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id hh9so820057qtb.13;
        Thu, 10 Nov 2022 05:05:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RxTYnsjXo5H4D39/ukAjznyyf8nDU99QCOa9bcJlVXQ=;
        b=nLNvtXpAF0dxgh0auEXhKyfDBRTHZ8a2NWsahPpI0rhME/4c0CFyy/ZuiOZHaIGejF
         1mYDBraJbWtsFWbK5sim89hWWx2z8rQsCVcjM/uY0N3oIPGpl6+0exgM1Zh2PEpT+D2R
         nG20tISJoeU1JOYywutFRh7GPlkEgbP2yEKpbWH13U9xc+SsdOBd4lruVhwIFDl1DtuF
         t7FfUW7o6k7pSJzEo6G7MgvYDeFWB6o80+0UwY1Elm1Yb7QPcLwbBn069xzgRzXS/YE2
         bjPWUiVTXVwjB9FFKhpNcbnw9mObZ6aZ5FshLUJ87oCQjzgJ4PUOULbRuyUcHXt8la3N
         o1Bw==
X-Gm-Message-State: ACrzQf1CpFCmKLm7kk8kimWHtTZu4ty8/qS8fmW54k80mk76372D0LKK
        xi7S5kzq/RMKGqN4FzokKdX5H0uz1jJMbmjmy+o=
X-Google-Smtp-Source: AMsMyM4tkEwclJdmSLxdeTyebmD4pcDzg8GTwL0Lxaz5ycy0+rZhbj43Xyd45fj2n7BoHaaFb7v4Fre3jd/timITQc8=
X-Received: by 2002:a05:622a:4c07:b0:3a5:27ec:6dd3 with SMTP id
 ey7-20020a05622a4c0700b003a527ec6dd3mr43797482qtb.411.1668085514333; Thu, 10
 Nov 2022 05:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20221025061437.17571-1-zhangzekun11@huawei.com>
 <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com> <91e13efd-2de9-6fa1-188f-ec74958fff99@huawei.com>
In-Reply-To: <91e13efd-2de9-6fa1-188f-ec74958fff99@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Nov 2022 14:05:02 +0100
Message-ID: <CAJZ5v0h1zNSo4E-hk+vBemfV7_gsOe+3Gz-vAcn9AiufTCwX3Q@mail.gmail.com>
Subject: Re: [PATCH RFC] ACPI: container: Add power domain control methods
To:     "zhangzekun (A)" <zhangzekun11@huawei.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        patchwork@huawei.com, wangkefeng.wang@huawei.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        guohanjun@huawei.com, wanghuiqiang@huawei.com, lihuisong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 1:13 PM zhangzekun (A) <zhangzekun11@huawei.com> wrote:
>
> Kindly ping.

I'm not going to apply this patch if that's what you're asking about.

Please have a look at LPI which is the ACPI way of doing what you want.

If you need to extend the support for it in the kernel, please do so.

If you need to extend the definition of LPI in the ACPI specification,
there is also a way to do that.

What you are trying to do would require extending the container device
definition in the specification anyway.

> 在 2022/10/29 1:07, Rafael J. Wysocki 写道:
> > On Tue, Oct 25, 2022 at 8:17 AM Zhang Zekun <zhangzekun11@huawei.com> wrote:
> >> Platform devices which supports power control are often required to be
> >> power off/on together with the devices in the same power domain. However,
> >> there isn't a generic driver that support the power control logic of
> >> these devices.
> > Not true.
> >
> > There is the ACPI power resources interface designed to represent
> > power domains that is well supported and used in the industry.
> >
> > If it doesn't work for you, explain why.
> >
>
