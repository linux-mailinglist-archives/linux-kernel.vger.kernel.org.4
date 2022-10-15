Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CED5FFA12
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 14:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJOM57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 08:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJOM5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 08:57:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE103F1F4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 05:57:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e129so6600263pgc.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 05:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N3/h+H1MFE4DJWa6SQPVF/UUmeIpSTtWx78clITVlSs=;
        b=LtnUc+dWYQSsI3Opi8iItvicki34Z21Q42I8uaYXxalxvQTbvbvRifUW86C5yfYb77
         XhMOq/h0lDymBxkD+ShabJ6m1QnfpuY6kUKD9fUbkzhnh9pctPBGKT5qZ0WOP2qzZVX1
         IRa1BsxDbiUnj1Gb2X6XDxilytI4n287R5vddCS0CahqEG5ulrPNCJbrypVg3w3p8/US
         Qekkw/j8ZEuS6tb5fDcRC2NtXEEOjt771gVG7dBk5jEc86mditNxrEGB1dHRe+4PrBb4
         rK3iV+yzlfziIEn6dmmJn1vGXIFGskxyAHK303cRFvpnYKE3SJXbETWoNxXdNvayMpa3
         yukA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:in-reply-to:references:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3/h+H1MFE4DJWa6SQPVF/UUmeIpSTtWx78clITVlSs=;
        b=Tjq3GXiMQYEgzemHhu7USeXM1su5cxc7JPeCMB2GT6cgnKD66O3K8CDJ40HFnPTfpO
         JWQ6e8oTxat091cXER+YIpY1mk1cbXs0O3zjffluxCSwTI4Rtf/rnUlopm5JeMln208Q
         Qp7j+4mmGYiBhYh5hp9etn6crXO+JiuMgewAprFnkcHhf4nG8+PFvYo2SOKi2Lu7vz0o
         fGDsO4W4hO6dhrCiUsnit/82Qu/a9UoWPGGdCj2+TUXe3aWXxEkAZ5QD5YAicqa4Gk6q
         VTPnJmQZKEW34xrwLWE/ALS3LHp6adbBprrETnXjYiRvEvPHRgz10RZ1ZETKouBBAKiX
         BwZw==
X-Gm-Message-State: ACrzQf3WjZE1edyaE/AhCAHBKL1MdPzPEPHhD8rxW1En44zJwxUcy5LH
        iM88weFjNENxAOSE4GR0g+unEUPpGq8l6Go/kwWJPg==
X-Google-Smtp-Source: AMsMyM4Jrwmtqk3BdWxj8QVpKhXP88Fbe535tPjA+ApCcC6PNhRIxEwGrr08nTsVInEiMhkuNo8o+B0sUdLiaR4axyE=
X-Received: by 2002:a63:a06:0:b0:458:2853:45e4 with SMTP id
 6-20020a630a06000000b00458285345e4mr2496376pgk.20.1665838671587; Sat, 15 Oct
 2022 05:57:51 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 15 Oct 2022 05:57:50 -0700
Mime-Version: 1.0
From:   Fabien Parent <fabien.parent@linaro.org>
X-Mailer: aerc 0.12.0
References: <20221001171027.2101923-1-fabien.parent@linaro.org>
 <20221010055530.2mf6lq4mn6zfdkzt@vireshk-i7> <20221010060225.bglyfnr274ivu23i@vireshk-i7>
In-Reply-To: <20221010060225.bglyfnr274ivu23i@vireshk-i7>
Date:   Sat, 15 Oct 2022 05:57:50 -0700
Message-ID: <CAPFo5V+5Surbn3jjybTKAVJHhV_5M88Gg2W0-2amwoVKTpie6g@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpufreq: qcom: fix memory leak in error path
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ilia.lin@kernel.org, agross@kernel.org, bjorn.andersson@linaro.org,
        rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

> > Applied. Thanks.
>
> Btw, it will be good to have a Fixes or Cc:Stable for this patch too.
> I can directly add the lines myself, just let me know what you want.

I will send the patch with the "Fixes" tag in v2.
