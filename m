Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1E55FC088
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 08:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiJLGUG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 02:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJLGUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 02:20:04 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796F4AD7C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:20:02 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i3so6051942pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1DBCnqUWhGB+br9qPogkPCpewlTh7l7APNpyuPMgnc=;
        b=tSIgrK9R8quYMlKPHoAR2TiQYQinwSPupSlTrpqcDazc8Djrf8h+J8uy1Deju1sRaP
         HUIm8v1EDo2lEXoCQcin34U8dIBoxU+u0FKqHjuxw2fdwcnIeZtjDOSALN/WKjEsg9YX
         OPkMPS3zp5hOn9jjmlix4NRhEiI+2pCUQyPUzTlUy4ePKW62SaVqcyy0HuOWSPHJUgej
         3l51Lo1Y4HrKmkmCmLsl1Zy1MKYOTIWH2L0tRtdQzzbbd2RncC/DsSrMWre8h+1zNYnK
         6ha9w41B98s3rVRxHaS8ap4k5Ll8e9eTtdi9nVq6OfP1gBh8cbwlMedwQom2L0UjE6fO
         84iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1DBCnqUWhGB+br9qPogkPCpewlTh7l7APNpyuPMgnc=;
        b=wQSgH6fFkkW3ShAbPlZi1nDuR0QPcg6xJjG+lrjEaO21RnUBvw/d+2oIFXDLdUgULO
         svjaoh8Ti/32Z0WLqFSX5ivfXtclThA1JFArDArupeNtcxmJkeeQaFmnKhGILYkZ2aJ6
         OamamZi6ToPsnMmLeIQxbNgRWvt2IItC83qv9hxF9vyyFUB0o9s28shsMdN/xvLDZdNh
         GlHNF+HTiA3dGAApNN6opD7O8oxq7VpOvljSka2JGK9ziB9UcEcar54DaB9v7qfKlP1l
         gJA4GoXUXQITi1xMB6D9lZ4BOVIYBiiWixE+EeTxBSk/CuuR0mLkVk398hJnU+BLM5FV
         qBmQ==
X-Gm-Message-State: ACrzQf1cYWERSC5S+yN8BVddGVmgqd5ypCpRFQeU6wtlVaOR1hWPm4yX
        sRKuzgBZLFEGRwqZgENGV+3TKw==
X-Google-Smtp-Source: AMsMyM5d4J4J3Gk4lp+FLUDAe2grvtFcBiQy+UBxS3dMKP5NY726GPrMuMnikSc3GVmxYo5eEh3cCg==
X-Received: by 2002:a05:6a00:1956:b0:557:7f97:3ff3 with SMTP id s22-20020a056a00195600b005577f973ff3mr29340817pfk.77.1665555601674;
        Tue, 11 Oct 2022 23:20:01 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709029a4300b0016d773aae60sm9696338plv.19.2022.10.11.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 23:20:00 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:49:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?5rSq5oiQ5paHKEtldmVuKQ==?= <hongchengwen@oppo.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6ZmI5b6B6byO?= <chenzhengding@oppo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFORFJPSUQ=?= =?utf-8?Q?=3A?=
 cpufreq: times: record fast switch frequency transitions
Message-ID: <20221012061958.xoio4xt3kywpjyf3@vireshk-i7>
References: <1665231397-115755-1-git-send-email-hongchengwen@oppo.com>
 <20221010063235.3zb6bgtxwpmltlrk@vireshk-i7>
 <HK0PR02MB3379062A9BE6515D1DADB306A0229@HK0PR02MB3379.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR02MB3379062A9BE6515D1DADB306A0229@HK0PR02MB3379.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-10-22, 06:17, 洪成文(Keven) wrote:
> Viresh Kumar
> 
> This is a modification based on the Linux kernel, not an Android version.
> You may have misunderstood some fields in the commit message.

Linux doesn't have cpufreq_times_record_transition().

-- 
viresh
