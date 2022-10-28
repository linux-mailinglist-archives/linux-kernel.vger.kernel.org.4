Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E694D6118F5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiJ1RKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiJ1RJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:09:59 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B1317D0;
        Fri, 28 Oct 2022 10:07:28 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id h24so3848731qta.7;
        Fri, 28 Oct 2022 10:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EADvVtie7X3d7ebp7w7C9BHI1pXSuINKX3NYj3HDseI=;
        b=TQCxWa7WUGaJNfmeH11sqf7bADIHG8Lekh008N+q08crxTxzz4srJOQUfmv3eOGjUi
         Jsc+P7cm4ity+kSM3NXYzOBMhDxwNzzq2CB/jOfSdeCjPRJlklzcWUufx9mQ6nHEem+P
         WVHirV0GZfcxBNCCrO/bN3G1Xa6wHKiFHer2adN7WibsuLPUO1ecf4hAj0VVUAlS4d4o
         EzrNxJY0KUgOxmljf/mQBRHwL2cOWPfOEqN4ATHkeAReEtgcnfN0UsHGGSBB93Zxk3sN
         5VS2cCwavulBta4FjCsbz8kt9WNNXXMKS0c21GguLEfSGV8ieq/Md4fC8+vZH9aE8Bsf
         3PBQ==
X-Gm-Message-State: ACrzQf2TEOGegYC7SLHyqS0yB0QVtesL2qcc0FVJ+tDPj6qMGQJvnjJ5
        qSQrX6R78M0kB/NBWJ35DixB34BQqqlcBr0DW3Y=
X-Google-Smtp-Source: AMsMyM79LRDg4BzYp/csv6h7kcqfXPWZFqP+CyBl/LyfIVQEAMSVn5AwR0IdbYgyUiMDhpbxDqEK7Zq/f+scRud6Q30=
X-Received: by 2002:a05:622a:44d:b0:39c:f7a4:5ee0 with SMTP id
 o13-20020a05622a044d00b0039cf7a45ee0mr458213qtx.48.1666976847379; Fri, 28 Oct
 2022 10:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <20221025061437.17571-1-zhangzekun11@huawei.com>
In-Reply-To: <20221025061437.17571-1-zhangzekun11@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 19:07:16 +0200
Message-ID: <CAJZ5v0hpYodc_fd1DtBM-VEmhxepq7eQcQkbDXvWn0uMQ_yGNA@mail.gmail.com>
Subject: Re: [PATCH RFC] ACPI: container: Add power domain control methods
To:     Zhang Zekun <zhangzekun11@huawei.com>
Cc:     lenb@kernel.org, rafael@kernel.org, patchwork@huawei.com,
        wangkefeng.wang@huawei.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 8:17 AM Zhang Zekun <zhangzekun11@huawei.com> wrote:
>
> Platform devices which supports power control are often required to be
> power off/on together with the devices in the same power domain. However,
> there isn't a generic driver that support the power control logic of
> these devices.

Not true.

There is the ACPI power resources interface designed to represent
power domains that is well supported and used in the industry.

If it doesn't work for you, explain why.
