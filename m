Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE443679AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbjAXNxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjAXNxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:53:22 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F9447EEF;
        Tue, 24 Jan 2023 05:51:17 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-15085b8a2f7so17735053fac.2;
        Tue, 24 Jan 2023 05:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNmYUl409IZsHj9DfvEccpURlLXPvpb9z3n6thycbJw=;
        b=PXOHVyAvtCMtMRojfLNF22ATgUORqO8lp6WIdj/cBaLXsXDALbbPQr9TGIOKf5GKuE
         iOKUxb/ZzKId/+UaQZEuOfgrseJYJkzCbnz95mHxbOikAUVP+67Pom+MZDaC0ICpxj0S
         /Hz5Rrc3mEWqTMyBj744OjBkxopwMAY2/H0M1VdZAcPIdI82S0o8SDygU9AAseZRnrRk
         3kdvhh+h3Nsvgtnw3lKF+PV4RVsLMzI4Mf1Fa82G+Y8BJgGeAmDehwFQup631sj1fgfP
         n+xJW44ap2rtLdftsZqVbcnkFngJkH9PaiVYNeY5DMr6wXcoNTa/+f/Cjsj20K1ehspJ
         mcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dNmYUl409IZsHj9DfvEccpURlLXPvpb9z3n6thycbJw=;
        b=qBREczcIUSypBHCyvPBF4PrVpaKLSWR9uQo/wyB+bCa4MeKU2miKeia+oJ3f/n0ltv
         mEUfRtWgqLKinBLIL1dgJIaqpj3DW3jQvDw600LlUJaKro78hONvnzRolMl86NNlPVOR
         CaXCuTX9qXOdjcwr1je0oOV82zA5Q8g6oOBZdSFHItyMGerugulfJdIGRKumOaZ3hbr8
         mlZKJN9ljTiZIY8lo3YAnejBa5DC2y0usf2/H+xLDHSrNwgD8quGOmh/y+uu4ovsbjfJ
         8or7MEbJ0TCMxxBdlnyJJPC9p7pMzTwqU0cRaJfaISunDkdyA9MjhDd7SuhRuz7dnhdW
         75Zg==
X-Gm-Message-State: AO0yUKVdZkRn7uYXA8NWsuDiUp4ahmdolYxKlbIxBlZnaW6uahw3Rfpz
        Mj5fLOrL+Uv7v/p1PXKDGbQ=
X-Google-Smtp-Source: AK7set89KGI+5szNvQVzjZUVYqBHzkd3rsbRL3vhfBOS8WcKB8UdGVG6c1E225mpRamBavwCd1vPyQ==
X-Received: by 2002:a05:6870:f28b:b0:163:1eab:b7d6 with SMTP id u11-20020a056870f28b00b001631eabb7d6mr619353oap.11.1674568201235;
        Tue, 24 Jan 2023 05:50:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k8-20020a05680808c800b0036718f58b7esm1024007oij.15.2023.01.24.05.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 05:50:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 24 Jan 2023 05:49:58 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] Docs/hwmon/index: Add missing SPDX License
 Identifier
Message-ID: <20230124134958.GA36313@roeck-us.net>
References: <20230122213650.187710-1-sj@kernel.org>
 <20230122213650.187710-5-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230122213650.187710-5-sj@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2023 at 09:36:46PM +0000, SeongJae Park wrote:
> Add missing SPDX License Identifier for hwmon documentation index file.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Is it documented somewhere that GPL 2.0 is the default in the absence
of an explicit SPDX or other license identifier ? I don't find it
in Documentation/process/license-rules.rst, though maybe I am missing
it.

Guenter

> ---
>  Documentation/hwmon/index.rst | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index c2b3c1a822dd..2186d732654f 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -1,3 +1,5 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
>  ===================
>  Hardware Monitoring
>  ===================
