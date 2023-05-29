Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410857147F8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 12:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjE2Kit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 06:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjE2Kis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 06:38:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32724C9;
        Mon, 29 May 2023 03:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAF3261190;
        Mon, 29 May 2023 10:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51322C4339B;
        Mon, 29 May 2023 10:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685356726;
        bh=9JWPvuPWtS6jgAcG1MVh7XvKkuO5DwH+t/KUYEfRb2E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uiht0ia8ULkKw+gGfVQtm/U5Gvm78e7M4csikBY8gQTKP13XfjXf/aG7KFzCWVYvW
         3yc2Uz7xAwwo2Ra9XlyFT79m9y1wGawMoaotm4fN9Po/HKETiZaVwIsHngrAK46TMx
         xoQ7LBiwfp2xZDlSw2/gBwcIX7Kqm3KyltvnyntvfFWy7At2PojECehZxaEAZr0tLU
         PAzRFKDLreKZnKwRW6+5TL+7DWC5W51eMGL58cUeUGeW4o3Ud3cMA/XWBCQNxbnSgI
         65UvvaxlRdlfFsVAvlm5MVHc6cJCOG1TyWzKzETbLH0+4tcyc7EGKjCxkSywDkpZX4
         0apPEBtOAo0Dw==
Message-ID: <8b7f4b22-76e2-e812-92ed-35e5ecdd6309@kernel.org>
Date:   Mon, 29 May 2023 13:38:39 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] opp: Provide a function for just setting bandwidth
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230526-topic-opp_bw-v1-1-e881091363af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On 26.05.23 12:17, Konrad Dybcio wrote:
> Currently it's not possible to set just the bandwidth if the OPP
> describes other properties (required-opps, opp-hz etc.).
> 
> Introduce dev_pm_opp_set_bw() to solve this problem.
> 

Who is going to use this?

BR,
Georgi

