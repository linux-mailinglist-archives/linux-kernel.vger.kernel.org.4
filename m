Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188736882EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjBBPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjBBPpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:45:17 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFADF79215
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:44:49 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qw12so7184174ejc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Larx4zrp/OS0f2YK4Nurdgp9E3q9pvZQ+O3YyQF6LE0=;
        b=N2yTY4wMB/3/sAUiH7vSAhukjRWgIKSiDqm6dPmz6z2pyKZvw2vcwYX8J6o8S5O7Oj
         WdhljRfBg7/TEXTHeoCx4Avck1y4EwBaGvOLT8i4PiNgSF8h0psBdiTjVllKhRT8R6sp
         +Xh+MpB7RDNG9KX/FVP7qvAU7AI05nFHR/AC9HIWTjzfU8gdZFYbF1TEi+axV/9tivFN
         iwjjfcQAMoMT2JPOurC69RlWgXm9TOfBb3yTdSviYwZQYNZ6KeM8ViUL6B90IFOIwL2n
         WTl+kAUIrnR/sRuLjC+uDV3fLfAE3sN2GU1NMHVwZuh17gIKOun9NxOdjh5K9T20iUsB
         GYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Larx4zrp/OS0f2YK4Nurdgp9E3q9pvZQ+O3YyQF6LE0=;
        b=t1HiiJsBXtQU0w/viRlcWYLo+1sREUAWnCqyAYayitieBn61YJLRnniW7W4trxHMpi
         XhifcBbVLuP+rDaTr3lFf0KkhN5+LTfi0nD8dkI1V4gOn2wVAmYIuuwKGAnfnbIsihpo
         m8302HeDgobcarUqoPH71QKGzOwr30c4SWzj9us0EKt2j2pUfifpaGOMa/wbHzrFu0E+
         aK2fuCwMa76JwdjCpLGGN+MePotLhk/W44P8EEsNWy0qg8XdzUKPdIdV30pVy7NZeyBg
         Gv5MwmG3xkj/yJJXUH/FKQiuMau7qjp41N3X2YJ3v8AtY/tpP/iIZTPMvbcBeYDS3p4Q
         Hzug==
X-Gm-Message-State: AO0yUKUx3hldh/WwGSdtDsshdgPuY4YzH/WAZ0WeeqS8ztvY0thG/5xJ
        T9NToA7sjDjmlP1FMEQYrP9SDA==
X-Google-Smtp-Source: AK7set8cbNQBhXkYcUM25lzZrCVG3jA4R9/dpx0iVCHSkzGXWJY7GDoZJGVrXYMhY1IktXOugXNd4Q==
X-Received: by 2002:a17:906:c241:b0:878:60da:1f63 with SMTP id bl1-20020a170906c24100b0087860da1f63mr5884676ejb.43.1675352659261;
        Thu, 02 Feb 2023 07:44:19 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm10529264edb.79.2023.02.02.07.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:44:18 -0800 (PST)
Date:   Thu, 2 Feb 2023 16:44:17 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] devlink: Move devlink dev code to a
 separate file
Message-ID: <Y9vaUZkiERmasO/9@nanopsycho>
References: <1675349226-284034-1-git-send-email-moshe@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675349226-284034-1-git-send-email-moshe@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 02, 2023 at 03:46:59PM CET, moshe@nvidia.com wrote:
>This patchset is moving code from the file leftover.c to new file dev.c.
>About 1.3K lines are moved by this patchset covering most of the devlink
>dev object callbacks and functionality: reload, eswitch, info, flash and
>selftest.
>
>Moshe Shemesh (7):
>  devlink: Split out dev get and dump code
>  devlink: Move devlink dev reload code to dev
>  devlink: Move devlink dev eswitch code to dev
>  devlink: Move devlink dev info code to dev
>  devlink: Move devlink dev flash code to dev
>  devlink: Move devlink_info_req struct to be local
>  devlink: Move devlink dev selftest code to dev
>
> net/devlink/Makefile        |    2 +-
> net/devlink/dev.c           | 1343 ++++++++++++++++++++++++++++++++
> net/devlink/devl_internal.h |   30 +
> net/devlink/leftover.c      | 1470 ++---------------------------------
> 4 files changed, 1435 insertions(+), 1410 deletions(-)
> create mode 100644 net/devlink/dev.c

Looks fine to me.

Thanks Moshe!

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
