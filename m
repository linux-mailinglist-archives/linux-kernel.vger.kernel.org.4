Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F64766B28C
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAOQYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbjAOQYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:24:39 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120FACC3F;
        Sun, 15 Jan 2023 08:24:39 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s124so4686873oif.1;
        Sun, 15 Jan 2023 08:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=061THNsgAzdYUYCWXtpbIXJENDrwSeWOCg61cRkldE8=;
        b=n8bRVm/Po5sj0Ss87AF9yZnjNRq3VzYjMCRn223DrCawc94Mb9EtV+TiyFe99SKd/P
         jKeaSW4Nq1RD6Bz+F7beykVuvwAXTtMwFnTHGu4zwlquL9XmySHhcZjgQKlwR/vgAP8p
         dwmDa+dtdY361Iv6E4/8Nq22oC7HBiIiYaHbUDm0ru++3sEpGhrJtyfu5/xOoAah6nGP
         9thmvMuurw/D1b16wWtwStkBDUFaYDqeKPgtXqyuwI5Vp49xHS9lS8AzjvqVTcYQL3Gj
         /3EzBPgm8+Rge46nTGh40Ma+TpURYEtGrSsLzizICCkuptkNcGJWQO3oQ3RDfJzuBGG7
         1DdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=061THNsgAzdYUYCWXtpbIXJENDrwSeWOCg61cRkldE8=;
        b=QR3T4jkMW/4KdACUTtgx7i+u7hQx3odSmlOnwU1K4HJr8GNdbcvioRExpf4ZM/hytd
         jXNQaNP6+cj6b4t3mJ8KPv7aRcM1ZNvFct80pgg10dUyz/TGb5RcUz2JWJBZRTtSune9
         uMQUNm+NXHiYo+5sGw9vTMa9+3vIP154lGhQAdS9Qp0Kw8k0MkCthxunaZFzF8OMQIbN
         B799PBh46axNwJWwp/5N88i+/Qi+ssaAkXT70LbDeO2K/NG+JzqrGf5wSR6EsfRm8ek8
         TpV8rHq7P6DExh2wy2FG/cPEM1xXcXsphUSK7v64+cU11g9VeKd89WwcSVZQ6QNieSTr
         Tbkw==
X-Gm-Message-State: AFqh2krODB7yJBjve5PCoebGkvHN1dkSIsjsIP60PH4Su108R4f6L1PF
        IfZyvEE/H0DMKraFTFQx6Z60JI5CLOw=
X-Google-Smtp-Source: AMrXdXtt8bt2Xj7ihFc/CII2EXtE0/DmuFGnpK4a9HMUtIf1GKaI6S42XrZtbKdN+pHXndPvb+RaEA==
X-Received: by 2002:a05:6808:1a16:b0:364:64e9:b483 with SMTP id bk22-20020a0568081a1600b0036464e9b483mr11405119oib.14.1673799878424;
        Sun, 15 Jan 2023 08:24:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z12-20020a056808028c00b0035a81480ffcsm11641922oic.38.2023.01.15.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jan 2023 08:24:38 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 15 Jan 2023 08:24:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] hwmon: (ftsteutates) Add support for fanX_fault
 attributes
Message-ID: <20230115162436.GA1247826@roeck-us.net>
References: <20230105225107.58308-1-W_Armin@gmx.de>
 <20230105225107.58308-4-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105225107.58308-4-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 11:51:07PM +0100, Armin Wolf wrote:
> The driver knows internally when a fan is not connected,
> but does not export this knowledge to userspace. Use the
> standard fanX_fault attributes to notify userspace if a
> fan is not connected.
> 
> Tested on a Fujitsu DS3401-B1.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied to hwmon-next.

Thanks,
Guenter
