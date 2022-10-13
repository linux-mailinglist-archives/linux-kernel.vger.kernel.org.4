Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269435FE17C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiJMSk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJMSjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:39:51 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524E7CBFEA;
        Thu, 13 Oct 2022 11:37:49 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id h15so2283454qtu.2;
        Thu, 13 Oct 2022 11:37:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZmvxazc2sXXNdPho7QU50pFfOmoWil5WJIRMNVjEqw=;
        b=2y7Tj4TdF4OVWkIvv1oU5YVa2okYkUNOucAgqK+mvA0PdBomdmEcfRpNNOd1xYDBKT
         jQ++U+nXf4JJ7WDU83qFW3sxnhyEcB2/ZJP6V+P8ssymJ8sFEPZqVJgn1e3LLjle77PH
         QXFnfvBbCajf6xbvhQtVzZ1lqtNi33H/DBwMidSw1/gH+O7wbfEbwqA4Fzt9nrG2ESaH
         IvvEYIn0GXwRSBnAz/Yoi195eGIttaPIkH80Kntw4KeYPH17aPhAbobJGUWz/8Tyai3i
         1LFXCDYWUHlVy/TTErZh57eE7hOh03T/PSFi9QvNza0M9kFRb/WHLUN3wW31D6QRrYee
         I14g==
X-Gm-Message-State: ACrzQf1ADNnko6UtqMFPhdDWrBmQC2leS0NsXBWysnbooIMzn29laa1M
        xbtnPyGmMHRMsPRLy/1ZbFxwemPZ0zs2WPXUCnzI40pW
X-Google-Smtp-Source: AMsMyM6N+rqJd383wNo0tTFwOWxlQOUXB+NdPnp+xo591oKu26Yb32t9/qC65lbULR/MeM3lMDHuw+Bkc7qA6i6cb8w=
X-Received: by 2002:a05:620a:468c:b0:6ec:5c7f:8a3d with SMTP id
 bq12-20020a05620a468c00b006ec5c7f8a3dmr978896qkb.285.1665686194490; Thu, 13
 Oct 2022 11:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221011122600.620690-1-bagasdotme@gmail.com>
In-Reply-To: <20221011122600.620690-1-bagasdotme@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 13 Oct 2022 20:36:23 +0200
Message-ID: <CAJZ5v0jCX=+XwWRwyVv+VxHQHR2buRNLH5Fw19pR4mVpzi95bQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: ACPI: Prune DSDT override documentation
 from index
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 2:26 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Commit d206cef03c4827 ("ACPI: docs: Drop useless DSDT override documentation")
> removes useless DSDT override documentation. However, the commit forgets
> to prune the documentation entry from table of contents of ACPI admin
> guide documentation, hence triggers Sphinx warning:
>
> Documentation/admin-guide/acpi/index.rst:8: WARNING: toctree contains reference to nonexisting document 'admin-guide/acpi/dsdt-override'
>
> Prune the entry to fix the warning.
>
> Fixes: d206cef03c4827 ("ACPI: docs: Drop useless DSDT override documentation")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/admin-guide/acpi/index.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/admin-guide/acpi/index.rst b/Documentation/admin-guide/acpi/index.rst
> index 71277689ad97f4..b078fdb8f4c934 100644
> --- a/Documentation/admin-guide/acpi/index.rst
> +++ b/Documentation/admin-guide/acpi/index.rst
> @@ -9,7 +9,6 @@ the Linux ACPI support.
>     :maxdepth: 1
>
>     initrd_table_override
> -   dsdt-override
>     ssdt-overlays
>     cppc_sysfs
>     fan_performance_states
>
> base-commit: 27bc50fc90647bbf7b734c3fc306a5e61350da53
> --

Applied as 6.1-rc material, thanks!
