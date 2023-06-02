Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE9D71F92C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 06:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbjFBENw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 00:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjFBENh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:13:37 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32781AC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 21:13:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b041cceb16so14253675ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 21:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685679210; x=1688271210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CEV47gt+ZCZAA8du0k/DRIUXH34XMcva/BFXCCGFINc=;
        b=XuwSId57gjd8r07z06gEvKOJy7AhpKGKpbN238DHatkKvVPw5ZqvBupXh1owDImg8/
         KDMNQJrf10NXVNMbAJFy8W/oe6/buICZnojYYykjKrAVrhvPZASaQy/lSFoESFEZ+vXt
         I+emnc9KjBi1gSDvMsPi2P6RKqWGfZUpSD45I1Tlzl04D+XCLta/luk3K99tzO+othxz
         qHveZIELIiM7ET0h7pTtN2Iammc1GNhFIU8jUZXoWFfuJz+nbcNimueLXBbAJ0D1dYJr
         GLjbi108pvoUmcXA6mBru20GFY88sjFAKY3PEqVtgb9CynZ3KZoJgFe1IxyVxskB2lRR
         RDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685679210; x=1688271210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEV47gt+ZCZAA8du0k/DRIUXH34XMcva/BFXCCGFINc=;
        b=PGei0B1NJe8+NnSaSWBfK6Qni3EcfmLs5VbfV7+D8OETXPTKBcMQ7Me9jEKd6bUNDT
         sMLzcPqlbjFyrqj3ftREKaY8yivAkcymbtq26NYYhzZCCderOF00U9DXcw5Hp0BKNQTf
         U/ptZBf18OYxh/QYigXGt5bmnpsS/B1XASe6e39ppG+yujeyX6Bz6wqlFvjT1AgNnl6D
         TxMPpHloqg9CFKBQMj6BFHoD+swrnCAFnrw1uX0khAetqz8Km7PzbtGf2L2wYQB8qtoz
         vnCmM9+ooKoJHpac8Of9eNsVLD/YosZtnSY+HMBLD5kH53WyahA+8N73C1C4rJm3doCv
         +8ig==
X-Gm-Message-State: AC+VfDybry7nWXTyZbmpNQjDmmhtgGwI8fdNtmQKqSq+qIm2LzcH19UL
        exaXsgDWdqKp/Tn7bHbOhfqKaV9ENJl8SRAxEKA=
X-Google-Smtp-Source: ACHHUZ62tXR3tRhbGClnMrXrJBv4svBg6ZDY81NDJr5a+svSbolCg1mmUaznB+ELePuz5sRaQK1smg==
X-Received: by 2002:a17:903:249:b0:1b0:522d:8ff4 with SMTP id j9-20020a170903024900b001b0522d8ff4mr1360769plh.21.1685679210408;
        Thu, 01 Jun 2023 21:13:30 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id w5-20020a170902904500b001ae365072cfsm187707plz.219.2023.06.01.21.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 21:13:29 -0700 (PDT)
Date:   Fri, 2 Jun 2023 09:43:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     rafael@kernel.org, ilia.lin@kernel.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, ansuelsmth@gmail.com
Subject: Re: [PATCH 1/2] cpufreq: qcom-nvmem: add support for IPQ8074
Message-ID: <20230602041327.klyjs4cevmzn6vs7@vireshk-i7>
References: <20230530165409.641661-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530165409.641661-1-robimarko@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-05-23, 18:54, Robert Marko wrote:
> IPQ8074 comes in 2 families:
> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> 
> So, in order to be able to share one OPP table lets add support for IPQ8074
> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> 
> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> will get created by NVMEM CPUFreq driver.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>

I am waiting for someone from Qcom to review this stuff.

-- 
viresh
