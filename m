Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAB672CC5F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbjFLRYb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 12 Jun 2023 13:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236368AbjFLRY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 13:24:28 -0400
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDF110B;
        Mon, 12 Jun 2023 10:24:27 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9787d11a410so97761766b.0;
        Mon, 12 Jun 2023 10:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686590665; x=1689182665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5Hvx6Dau5hLXCc+MkPwK5vrK7hRtZQDi/JSaHrIrwc=;
        b=ZMeKiVJRVnlch0n8xiv6HhAQeBBoTNAQ8Imo1ICsQ2L5pZW57/SQ0txrTiSfOq4V6m
         e4pgKbngOxtm27QQJ78ukYDK4K8zuCKcoaC+05pvUaUK9bsWfEMabYgn7xI2kpeKqAXp
         T57iczt3kus8qSmKNxQHWZoagvYlvYa32UWCIryPtTzWlq/TQ29wC7Lkjcs39enXLuh3
         ym2GVSEZ4fsMEMIL/qBg+uTlmZotWq+oX2Q0XZz1d+dPQ+esF3rGJN3J1BjmX6Z+JMye
         NB46KOjAKZIUmQz3QJ3hkvJXM8xEui9FWUIGFD5kHGzfMQXbJDxTbwczaQd529i7Qq8F
         wBWQ==
X-Gm-Message-State: AC+VfDygkprFRcjHXXwoSsKiui0L4yDp4TV7RGwEBIM6D4MsTrFl9O1m
        /Se1ELt0OFWhAso3Aw0g+EpqNxaSky1dc2oO4Nc=
X-Google-Smtp-Source: ACHHUZ5hGudTfkhfmt5cBz2VmFEdPlhxuMv19+N2EhFKcr/uT4JUdODvuPaNslce3OItrzVTrPAZiOyTUIQ7NWiSLNM=
X-Received: by 2002:a17:906:1049:b0:977:cb73:ef6a with SMTP id
 j9-20020a170906104900b00977cb73ef6amr7188139ejj.3.1686590665590; Mon, 12 Jun
 2023 10:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230606122819.343378-1-linmiaohe@huawei.com>
In-Reply-To: <20230606122819.343378-1-linmiaohe@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Jun 2023 19:24:14 +0200
Message-ID: <CAJZ5v0jTo+bX7K2L=3cnVsd_R1e2h7H5w6LXGuA3d_WQc1K0AA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: mark bert_disable as __initdata
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tony.luck@intel.com, bp@alien8.de, ardb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 2:28 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> It's only used inside __init section. Mark it __initdata.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  drivers/acpi/apei/bert.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/bert.c b/drivers/acpi/apei/bert.c
> index 7514e38d5640..5427e49e646b 100644
> --- a/drivers/acpi/apei/bert.c
> +++ b/drivers/acpi/apei/bert.c
> @@ -34,7 +34,7 @@
>  #define ACPI_BERT_PRINT_MAX_RECORDS 5
>  #define ACPI_BERT_PRINT_MAX_LEN 1024
>
> -static int bert_disable;
> +static int bert_disable __initdata;
>
>  /*
>   * Print "all" the error records in the BERT table, but avoid huge spam to
> --

Applied as 6.5 material, thanks!
