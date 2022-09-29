Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190D35EF2F1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 12:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbiI2KCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 06:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiI2KCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 06:02:33 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4587013BCFF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:02:32 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id k6so952539vsc.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 03:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=s5OrniKzl4rmm8uJE8QHztsHv1KOZNfgmUrLh5SNgvA=;
        b=EwjW1C7nLHlmLOHmx2r+kWE3CmfvAv4iXfmeeZu6EDuWYBgbur0dbdtycfgIGlznm3
         27zzu40FLq4EGcNcQ/rh1N/MAS85afAB7x8FamLKkyVM4pnDKvATEV2ZT0qHeqxu+GyX
         XWHSifuCZLnXV/SBx85xsLyP9MMCMrXtnOLiU9H4ozh4XUcMcMarPn+//3yr7Rb0Ekq4
         fZvoPy2z95uHHHOusbEIa8Ui8wu3UODlBKD6jovIP2uAke4ZmceM137VQNy+isCdf6vn
         SibGAB/395Ta/nKUxC/VNITcWoirNuS1YpZIqroBn56rwHuJjjcmLFCsoWn7uShMABju
         B/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=s5OrniKzl4rmm8uJE8QHztsHv1KOZNfgmUrLh5SNgvA=;
        b=dlsAc3i+iOyVDw3qJ9oQBSWXEJZLlptolsB0Os+VFJ2ccxizm474dQr3gju3zwAIgG
         LJsHLbbzRsf6M6Xf15LGPj44H5CG3T8JZLjdtZqklr9A9W/HpyYCDztzGVBy/1cDUe+f
         hQoNZgjr96/ZQ5q97dqU3Y1e68jEOr34ln+hmhx1z5wW5gEn5VoB6wFbHwfd0Dmk0hRP
         oxAU2FtVzQVEP8yuPWKPropLl/W/Rx2LgLDQkJY6GkypOzIZ+VOTTczoKhKBwUPE9Sgz
         3vb8WxlUmvqxoMO6cTV6Vyc9dPS3LPGjRw2zwGmyBG/UWv2MLt2J8uHIWhG00J3gJN1Z
         BuWw==
X-Gm-Message-State: ACrzQf0b2L27PJlmU4j32PJ3g1c62rbR9cDZ7umBvo8w7Fu0iUia+bon
        OEoj7VuGAGW62CbD79JCH9/kLu2dTwoOmkAQdEZBXw==
X-Google-Smtp-Source: AMsMyM5Xe8KnmTyLzcTapEvLYjfXlTWFegc470kap8tnWEU8YGbLGL1Ovy0RU1mLDUUA6VfQeyTefbgEnXvk194lQu0=
X-Received: by 2002:a67:c891:0:b0:398:a7ff:e0f0 with SMTP id
 v17-20020a67c891000000b00398a7ffe0f0mr880016vsk.22.1664445751374; Thu, 29 Sep
 2022 03:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220902202248.3061262-1-dlatypov@google.com>
In-Reply-To: <20220902202248.3061262-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 29 Sep 2022 18:02:19 +0800
Message-ID: <CABVgOSkiddQwHAD+QagKdOB9RkDF_hUFGKtoYt82cDKEZgdvkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kunit: tool: remove UML specific options from all_tests_uml.config
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 3, 2022 at 4:22 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> Commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> made it so we enable these options by default for UML.
> Specifying them here is now redundant.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Looks good to me, thanks!

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  tools/testing/kunit/configs/all_tests_uml.config | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/kunit/configs/all_tests_uml.config b/tools/testing/kunit/configs/all_tests_uml.config
> index bdee36bef4a3..f990cbb73250 100644
> --- a/tools/testing/kunit/configs/all_tests_uml.config
> +++ b/tools/testing/kunit/configs/all_tests_uml.config
> @@ -16,8 +16,6 @@ CONFIG_EXT4_FS=y
>  CONFIG_MSDOS_FS=y
>  CONFIG_VFAT_FS=y
>
> -CONFIG_VIRTIO_UML=y
> -CONFIG_UML_PCI_OVER_VIRTIO=y
>  CONFIG_PCI=y
>  CONFIG_USB4=y
>
>
> base-commit: 0b3acd1cc0222953035d18176b1e4aa06624fd6e
> --
> 2.37.2.789.g6183377224-goog
>
