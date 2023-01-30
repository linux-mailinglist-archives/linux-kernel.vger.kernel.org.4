Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D238168053D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjA3Et3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:49:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235728AbjA3Esx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:48:53 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E513DEB;
        Sun, 29 Jan 2023 20:48:37 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q9so6791369pgq.5;
        Sun, 29 Jan 2023 20:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjU6vQ2reF1QaFmnV6OzBgk2jZ+1LG7bM7VzcqOvsb0=;
        b=Ru2zriJFMRr6cN7hIcrPrz8bufyHE7ZzfmKctioQ2Obre6QpmQCJScMQOqZzzNMoRG
         V8FYQc+GPHH0f5FpwunOWyCUfIuo13CfZTUzHLk3eM/Q3n3JlLgo5ChJh7PVWo1Zshl0
         W5kdMkwDsw1w9Z9PPTP7lTVlTfW/Cx2kNg6o3SdsICs4fD7d/A9v42oirEQnrR+lbzmJ
         NHCE9ppf33R9w7lI4GyQK8yhw3ciD2bwdNqNMlocj+gvvDtTHYTowGi+ZNlDZsXeew5O
         Zn7JOsdSlQg68XmCOxEBG419VZaYxBPTLsHX8OTy1zWCe3qYZ5FnmKhljPlbdGEtG3J/
         VoaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjU6vQ2reF1QaFmnV6OzBgk2jZ+1LG7bM7VzcqOvsb0=;
        b=zRk7dIPKg1sDDuz6nXAC8p5BllruCANHIiX+UqxCkWaqkChP6u5e7a2rQyOVTKfJXb
         B4LQyxRKrsQkyoKb5QrLAgOcvnqcGhuebupCKiLmyAK4wDkz4CbwwToBeG0D5XmhMXFl
         olmuLXx5CeX5vJzmls/IJUj6ixMY75OkvAUJ5FYm4OpvztdwgvQB4qxOTvGxOupeOH4N
         EyUfnXPE6Lsv4GAAy0d3CQzsjDs6cnJP4eal/19SuvTdQDz46v14vS/gPaIWJNaeJ9Jq
         iaRwUpFmvSbW2Gk5ZtX4R6UbG+A9StHQkAunPVpdYwaphM3cN7h60aYi/DbLFJ9eYncB
         OwCw==
X-Gm-Message-State: AO0yUKXZ+Tq0QDwyFvc/nvnvgnzJdvJOgvIkI/SGgXLDY2UxXrJiWcVF
        4D4woce/gOo5MQ+CRl2hBrM=
X-Google-Smtp-Source: AK7set9MKoy3+TEPICzgmKgLpK/H/pjbuNAE13suLHY5SN1THxBwPk29+KPgNif9rfBwM1VBpFyaJg==
X-Received: by 2002:a05:6a00:815:b0:592:d313:b26e with SMTP id m21-20020a056a00081500b00592d313b26emr11884645pfk.17.1675054117307;
        Sun, 29 Jan 2023 20:48:37 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id h8-20020a056a00230800b0058e08796e98sm6305769pfh.196.2023.01.29.20.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:48:36 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:48:33 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-input@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?tegra-kb?=
 =?iso-8859-1?Q?c_-_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresource?=
 =?iso-8859-1?B?KCk=?=
Message-ID: <Y9dMIW7xXabY2Fqn@google.com>
References: <202301281613032191431@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281613032191431@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:13:03PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
