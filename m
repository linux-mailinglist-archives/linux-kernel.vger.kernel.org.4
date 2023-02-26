Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9E6A2D0B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 03:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBZCF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 21:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjBZCFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 21:05:55 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53CC113C0;
        Sat, 25 Feb 2023 18:05:54 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id b5so1238516iow.0;
        Sat, 25 Feb 2023 18:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x/0MEJE8eloddSd5KLY1ASt9rHQoQE4Cfr7iia6AURE=;
        b=B3g3/YTYCORgwWWLF4iJlTMvpGOrOtxDVMearm05vuwTR7VnMT0YMktYnfCvk57nr6
         hfqtxaNgU6PgokEN5ivb+fO8JHuAy9tDAHSYdronSPdV40rOwvs67vCY3JbFS6hpalYI
         IBhVDQKDiCacYQVx/+d5qp4MTicO6/dFPzpIYZgQWcT45FC/1OH3wQodzbJDX3/6+y48
         2safF1xZbnZH3ShH5FohXsbA0PuBzXkxWn0DscXRRMGHTUAVTaFZyS5Z4tJmN6kivzpW
         CL+/wea8RiPywO3F2clR10qtGPH1xwoGq9K6gWC23dVR2CFmNIrb340Z1ohKZv6HvsdX
         xL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/0MEJE8eloddSd5KLY1ASt9rHQoQE4Cfr7iia6AURE=;
        b=OlvcNeMFBAaUWIt9GgwU1nXsvHhX+rf0dCVAkGMS8Z5tdXpSmwricSOXugeOsAvDtD
         z+a9LdthYu5R6Q85fToSScEG2XDNRPlRUaytyk4orAJMiPVBaWkYGkfytxKEOyDaCeA3
         fpe2bJICzktXG1Wnapj8Cz8w/Xplmt3m0S84JCOFF6VbE7nyNH8RNm0IHLqccwxFwCrw
         IMlitVEkcC+0P+Q+TiX1c6rY20gAjb3O0+LFR8DlF4l/A4FeON3FNCBvM/G6gm+JhNVi
         Z8zD5SLEjtrAEtLRks2qJ5gVt43XgwrAzGYliI3Ssy6kVOuhUUcRa4MaW5v+YPtLDAmH
         ukOQ==
X-Gm-Message-State: AO0yUKWd+AN1p6hNZVALaCuznoBgQK7ptA8bHqN49R39jej0mifsp45Z
        qmxKJHYyKyvc8VeR0gI96FSS/JtntBzjfH3rE/M=
X-Google-Smtp-Source: AK7set+58Mh0Ks2ffDoUFBfLA+3gK+Y7iXCq4YAsGujRDITldiSnnN49ICUzOMR8phZqcqomY+jV3HRN4kuLD8jjvUg=
X-Received: by 2002:a6b:1481:0:b0:745:5dec:be5b with SMTP id
 123-20020a6b1481000000b007455decbe5bmr4076170iou.0.1677377154273; Sat, 25 Feb
 2023 18:05:54 -0800 (PST)
MIME-Version: 1.0
References: <20221021201838.306176-1-helgaas@kernel.org>
In-Reply-To: <20221021201838.306176-1-helgaas@kernel.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sat, 25 Feb 2023 21:05:43 -0500
Message-ID: <CAEdQ38Er01WkGqydMSU3VAfiZCJREhOFDRxnujDp53jLVdN7Gg@mail.gmail.com>
Subject: Re: [PATCH] alpha: remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 4:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Remove unused __SLOW_DOWN_IO and SLOW_DOWN_IO definitions.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>
> [Sorry for the noise; I sent this a few minutes ago, but it bounced from
> all the individual recipients because of DMARC issues]
>
> Previously posted v1 4/15/2022 at
>   https://lore.kernel.org/all/20220415190817.842864-1-helgaas@kernel.org/
> and reposted v1 10/13/2022 at
>   https://lore.kernel.org/all/20221014001911.3342485-1-helgaas@kernel.org/
>
> Changes from v1 to v2:
>   - Drop the ia64 patch because Andrew applied it
>       https://lore.kernel.org/all/20221021045245.99636C433C1@smtp.kernel.org/
>
>   - Split sh and alpha to separate series
>
>  arch/alpha/include/asm/io.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/alpha/include/asm/io.h b/arch/alpha/include/asm/io.h
> index 1c3605d874e9..7aeaf7c30a6f 100644
> --- a/arch/alpha/include/asm/io.h
> +++ b/arch/alpha/include/asm/io.h
> @@ -14,10 +14,6 @@
>     the implementation we have here matches that interface.  */
>  #include <asm-generic/iomap.h>
>
> -/* We don't use IO slowdowns on the Alpha, but.. */
> -#define __SLOW_DOWN_IO do { } while (0)
> -#define SLOW_DOWN_IO   do { } while (0)
> -
>  /*
>   * Virtual -> physical identity mapping starts at this offset
>   */
> --
> 2.25.1
>

Thanks for the patch! This was included in my pull request today and
is now upstream in Linus' tree.
