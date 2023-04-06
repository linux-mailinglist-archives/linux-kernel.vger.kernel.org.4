Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2536DA01C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbjDFSo1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDFSoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:44:25 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2547AA0;
        Thu,  6 Apr 2023 11:44:24 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-4fd23c30581so1604615a12.3;
        Thu, 06 Apr 2023 11:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDA+dksksQNDEuzzs61qyponW4UF20LMlnHUFg/t76g=;
        b=zJWuhs9vO3UKxHqRk6g1nurRLfBxdajDRmuR9Kn3kD84owT8OKOTWmvdkiNMDA43E2
         Zq2Ayw/yp8NX5tTmoX9N0m2MiaJpyjN5jQT3NZXRxQSH09TSzlHKbezW9DbUgHffTdKc
         WUIsPvVkLG16LJCZp5nJUM5vu9y8nKyE6Q2Ym6QI4W6f1j6c63SCavm0emOk8zFgZqa+
         eT4vMZae7F9lINFBnc4DJNp0lT4ZDl29EuPo2Ei6uLAAchw906PB1oJ6Zxvgw+8qfuPB
         ndvyh6HMLtTZPHC6ECFj7Zfd4T4nwTbfQJjbrOsuLJWtRMvsPVroZcFAuEbQQ8wvEntf
         ScoA==
X-Gm-Message-State: AAQBX9dao6rCz5UXSACar0Vb0rA13KGhbzNJuaxtcHDkd/hiBik1uLh0
        VtNTa9vTHLO9IHzZ8Gb3I/2SaTNI/4py0YcxYDYwndPL
X-Google-Smtp-Source: AKy350btzX7xj4Ck5Dhx+s3+ft75bxx4c7cSBxV9CtxOp60Q3UzJVgqnCYppB2QqDl2r1hRM2j2PKabqH2vIAv9W49Y=
X-Received: by 2002:a50:a6d5:0:b0:4fb:c8e3:1ae2 with SMTP id
 f21-20020a50a6d5000000b004fbc8e31ae2mr292150edc.3.1680806663299; Thu, 06 Apr
 2023 11:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230331160842.7817-1-mario.limonciello@amd.com>
In-Reply-To: <20230331160842.7817-1-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Apr 2023 20:44:12 +0200
Message-ID: <CAJZ5v0gkUGhRdfOL=ciTF12EZWCMyMT7ZYams-PDtcwVSfUotA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: utils: Add Picasso to the list for forcing StorageD3Enable
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, Stuart Axon <stuaxo2@yahoo.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 6:09 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Picasso was the first APU that introduced s2idle support from AMD,
> and it was predating before vendors started to use `StorageD3Enable`
> in their firmware.
>
> Windows doesn't have problems with this hardware and NVME so it was
> likely on the list of hardcoded CPUs to use this behavior in Windows.
>
> Add it to the list for Linux to avoid NVME resume issues.
>
> Reported-by: Stuart Axon <stuaxo2@yahoo.com>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2449
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/utils.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/acpi/x86/utils.c b/drivers/acpi/x86/utils.c
> index da5727069d85..ba420a28a4aa 100644
> --- a/drivers/acpi/x86/utils.c
> +++ b/drivers/acpi/x86/utils.c
> @@ -213,6 +213,7 @@ bool acpi_device_override_status(struct acpi_device *adev, unsigned long long *s
>        disk in the system.
>   */
>  static const struct x86_cpu_id storage_d3_cpu_ids[] = {
> +       X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 24, NULL),  /* Picasso */
>         X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 96, NULL),  /* Renoir */
>         X86_MATCH_VENDOR_FAM_MODEL(AMD, 23, 104, NULL), /* Lucienne */
>         X86_MATCH_VENDOR_FAM_MODEL(AMD, 25, 80, NULL),  /* Cezanne */
> --

Applied as 6.4 material, thanks!
