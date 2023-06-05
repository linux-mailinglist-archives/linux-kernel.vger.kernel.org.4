Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13087233A9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 01:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjFEX2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 19:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFEX2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 19:28:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C31A7;
        Mon,  5 Jun 2023 16:28:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F221662486;
        Mon,  5 Jun 2023 23:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E738FC433D2;
        Mon,  5 Jun 2023 23:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686007727;
        bh=XiOUqFkBFIP5V7pNs1yYEv3oCLkj75O1WRaqsOUoVJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=agIjqbn5mbnNnNEztgr8kzjeY754U60ZJCsZMQsbkHPFGBItJ3D3npGTc58Zlktc+
         1N+MRZ79PGu12oXB9IMR7Jkj0/IXFWsy6JLfpli4mHNYsJ1HRvPdWmDaRYD0XwWkeX
         +36Z4HxUgVxudy/2GUq9ljNPQC3QkYNiSGPAberlFw4VRmmYfsLUGbzrgCqjvAi5Pd
         /qo0yf2E5WFO6G/K9TYaJj7X581NHJUG0yvaQkbAZe9W5iwjAB1CXukD6knfCD7npC
         zhqgLUs80Vq7BBQtENDdATXJ0iNYAaPKI6HdJQNjS9TteVoMs0MTRxSM1ziUNM3wxe
         tyG0dc6xEytXQ==
Date:   Mon, 5 Jun 2023 16:28:45 -0700
From:   Eduardo Valentin <evalenti@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Eduardo Valentin <evalenti@kernel.org>, eduval@amazon.com,
        linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] thermal: enhancements on thermal stats
Message-ID: <ZH5vrfXi3LP0OkLx@uf8f119305bce5e.ant.amazon.com>
References: <20230519032719.2581689-1-evalenti@kernel.org>
 <CAJZ5v0i1bYu0aPWc-xTG9HxOm_Ysczfo_cJPPV40MCG7qOGRTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i1bYu0aPWc-xTG9HxOm_Ysczfo_cJPPV40MCG7qOGRTQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:22:11PM +0200, Rafael J. Wysocki wrote:
> 
> There are still some other things I need to take care of before I can
> get to this series, but I will get to it.
> 
> Thanks!

Ok, no worries.


-- 
All the best,
Eduardo Valentin
