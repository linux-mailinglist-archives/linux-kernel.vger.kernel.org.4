Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE06ACBB7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjCFR6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjCFR5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:57:47 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64683B204;
        Mon,  6 Mar 2023 09:57:16 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy23so42059914edb.12;
        Mon, 06 Mar 2023 09:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678125410;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcGVCjBVnayBicUZLCaTJTwidLa7WZprXWxqHPMKvHU=;
        b=RrYyQ8ecYhxf1ueE+o3E8jBDv/xryCrIK0MwVOYUJbjeoXHZxhHd8dANNJmkXshWLV
         vq/6XwX9Zu7JVU4bAbPC3efG3VQ4+FOSOFy4QnNvwNIKReh9Dauxb4pbTvoz/6B9rXmW
         C53sMfcgUoCgUiOhtd/F0aukbTFQ/zSyTnPkE+lw9uUdyVKLekuM0D04K/lt294L4hVu
         18t8XVth5HPmOT2Hidu+TMcwKaJNWjLxhSHCKbML4DIi8d3J3uFZBcq4jymyJLNu2DP1
         4EiSNY3e5aC9wGYMCVFMdC3LDLjCATxWHHmr0mjsLh3CzUlgdthsrpLOZTjPpV0m5CNT
         bFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125410;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gcGVCjBVnayBicUZLCaTJTwidLa7WZprXWxqHPMKvHU=;
        b=M7X+Q3lLIz9opAqRa8vVfuYRo+YLUphZC3bik6vRXoNYa4dUvjzUEYePOF50uQJj6D
         9RStCFiFR1naLezNCc4wqcNCrxblA1D2XfttSg2zc7Ekiq5M0m0lrG9xBWcqXg+ycwfQ
         VdXkPVWMr9IMH2i09AKlUutK3jTWq61v7Fjiv/11uKI2lxFXpLuywKbrsd2Nmhcd/+in
         /HiwiC5bM5vvHzgHaKw6No9j1QjuBnCRJYVNZz1BZOdBRz+WQV1/bT5o93F0wzHfsY/W
         YOEd2wMKnMNjUVsFwMiMl3jRGoWUaGznSszKt1VQFM3PqPJzT8meZpjgr41jt/PECp/q
         Wveg==
X-Gm-Message-State: AO0yUKUjbQKBcBk4YmLod17p5m217sfR9NgKKML62r5E+Gc9WimkRTko
        DLhECKO9puWDIhr/TC+zPlg=
X-Google-Smtp-Source: AK7set8oJXruZTf4lw5ZlxMs4p2XphASw+S0fj3ShIrQTy6/kgSDflozXx85/po2mzuuKmtQzEqPpg==
X-Received: by 2002:aa7:d78b:0:b0:4bf:c590:2a1b with SMTP id s11-20020aa7d78b000000b004bfc5902a1bmr9801990edq.34.1678125410211;
        Mon, 06 Mar 2023 09:56:50 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id x20-20020a50d614000000b004aeeb476c5bsm4782166edi.24.2023.03.06.09.56.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 09:56:49 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 06 Mar 2023 18:56:48 +0100
Message-Id: <CQZHT5ZZEIJZ.V4JBJD9VS4BF@vincent-arch>
To:     "Jason Baron" <jbaron@akamai.com>, <mcgrof@kernel.org>
Cc:     <jim.cromie@gmail.com>, <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-modules@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dyndbg: remove unused 'base' arg from
 __ddebug_add_module()
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
References: <cover.1677861177.git.jbaron@akamai.com>
 <16bcadc508cae9c93249d16a499fb714edb1f64d.1677861177.git.jbaron@akamai.com>
In-Reply-To: <16bcadc508cae9c93249d16a499fb714edb1f64d.1677861177.git.jbaron@akamai.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The 'base' parameter to __ddebug_add_module() is no longer in use
> after: Commit b7b4eebdba7b ("dyndbg: gather __dyndbg[] state into
> struct _ddebug_info").
>
> Cc: Jim Cromie <jim.cromie@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Tested-by: Jim Cromie <jim.cromie@gmail.com>
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
