Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4126E4AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjDQOEl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Apr 2023 10:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjDQOEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 10:04:35 -0400
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB993F2;
        Mon, 17 Apr 2023 07:04:07 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-506a44cd9a0so122791a12.0;
        Mon, 17 Apr 2023 07:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681740229; x=1684332229;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMGdkWPY4wn1qRFSgU+nnMTUSEo599lD2CAXxhYpTLI=;
        b=a1rTOT1qX/Z8UcKdqK8WCTSzGyY770iQE6SpTciE0D8mOjTQAT3U/HZs/PO0GBuHVZ
         tW/4uOLYaKcbprr2YrPTSEF4qv40AC41guqXmbVsEAWTtV6PmaHN3Q7JnXurUh4/6Lhf
         m8tJpMd84+bELi6jxJthNwpGegq5xAgPEYtijiwvc17ce3WOKAuF+XkZuUWpWPfV+ZtU
         HGnHX9zQPUc7CKLgPuKXmgBfwCJy1xGMxUlNP4EIeQU/0LeLLnv1kuIOfqbobBfLkuUj
         +iIL269Yc5cXa2OnFbR0N62yyFIjaTYhMdXYmReefXwGR4R5n7Ormj7ZRkXG3Bayyqn3
         cnag==
X-Gm-Message-State: AAQBX9eIIu+b2PVux1EQHK+Igajtzuh425iFGh3sTxT4VLYbpS/Qpwfk
        KEl9AW2aZBO/4MF89WZendeK41pkh7bJV//8vb7D1zBk
X-Google-Smtp-Source: AKy350Y2btpVArGToWvIHtqD0EvlOz3NQ1/99RCPQ1qWMfJZbBfYxbCe4KdP+ScGBCEY261s9VplDdRcmUWDivOqrtE=
X-Received: by 2002:a17:906:5d:b0:94e:d688:fc92 with SMTP id
 29-20020a170906005d00b0094ed688fc92mr10146132ejg.0.1681740228659; Mon, 17 Apr
 2023 07:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <43723ee9-f786-b423-b2ce-f4c549581d49@gmail.com>
In-Reply-To: <43723ee9-f786-b423-b2ce-f4c549581d49@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 Apr 2023 16:03:37 +0200
Message-ID: <CAJZ5v0ij+kBOCdmAbZFGiPBG0HL3VuFm1-XwqhzHr_qSDhJ_zQ@mail.gmail.com>
Subject: Re: [GIT PULL] devfreq next for 6.4
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 4:20 PM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> Dear Rafael,
>
> This is devfreq-next pull request for v6.4. I add detailed description of
> this pull request on the following tag. Please pull devfreq with
> following updates.
>
> Best Regards,
> Chanwoo Choi
>
>
> The following changes since commit eeac8ede17557680855031c6f305ece2378af326:
>
>   Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.4
>
> for you to fetch changes up to 376b1446153ca67e7028e6b9555d9b17477f568b:
>
>   PM / devfreq: exynos-ppmu: Use devm_platform_get_and_ioremap_resource() (2023-04-04 00:09:32 +0900)
>
> ----------------------------------------------------------------
> Update devfreq next for v6.4
>
> Detailed description for this pull request:
> 1. Remove unneeded SRCU selection in Kconfig because it's always set from
> devfreq core.
>
> 2. Fix minor updates of devfreq drivers
> - Drop of_match_ptr macro from exynos-bus.c because this driver is always using
> the DT table for driver probe.
> - Use the preferred of_property_present instead of the low-level of_get_property
> on exynos-bus.c
> - Use devm_platform_get_and_ioream_resource on exyno-ppmu.c
> ----------------------------------------------------------------
>
> Krzysztof Kozlowski (1):
>       PM / devfreq: exyos-bus: drop of_match_ptr for ID table
>
> Paul E. McKenney (1):
>       PM / devfreq: Remove "select SRCU"
>
> Rob Herring (1):
>       PM / devfreq: exynos: Use of_property_present() for testing DT property presence
>
> Yang Li (1):
>       PM / devfreq: exynos-ppmu: Use devm_platform_get_and_ioremap_resource()
>
>  drivers/devfreq/Kconfig             | 1 -
>  drivers/devfreq/event/exynos-ppmu.c | 3 +--
>  drivers/devfreq/exynos-bus.c        | 4 ++--
>  3 files changed, 3 insertions(+), 5 deletions(-)

Pulled and merged into the linux-next branch on linux-pm.git.

Thanks!
