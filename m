Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42856CA872
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjC0PBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjC0PBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0EB835BD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CCC8B8160F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:01:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CD1C4339C;
        Mon, 27 Mar 2023 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929292;
        bh=G8madpQxPQL6Eo1F+NjodE/hhZA5rOulWNSgejw8wqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VApLAVL5yJRqoj98fZbgd+z+dVYm1dTeWN/verYuX77iDMgxKdaB+ZK3meuwsSFfA
         F6WoSNXlKQ8WFEY6Pp/9g5aOO1+02Oykke0RS7eGN/Z6mECa9aKtWiQ6HQjRU1hpHV
         HMgOem39ebh01TmjG8EJc/dAXqdp7D9oYaDu8U5awWs9jxwMEscq3cMhgNC6RwUhmx
         /zNFrDJxOCiGMprtMDDziTOY7y3IlYZJU/e91jU9PdSfSuFERtSxC+1HE0eV+daVv5
         vUqYS+7NI7J5r3WFpWGmZDmq5EyFguFM2vSXgVqNNS5aDYa/X9zE5oo+0fiPaft9g4
         fZo+XS0C/WXWA==
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-amlogic@lists.infradead.org,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <cphealy@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Chris Healy <healych@amazon.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] perf/amlogic: Fix config1/config2 parsing issue
Date:   Mon, 27 Mar 2023 16:01:14 +0100
Message-Id: <167992632671.3835408.8265372943884338081.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
References: <20230209115403.521868-1-jiucheng.xu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Feb 2023 19:54:01 +0800, Jiucheng Xu wrote:
> The 3th argument of for_each_set_bit is incorrect, fix them.
> 
> 

Applied first patch only to will (for-next/perf), thanks!

[1/3] perf/amlogic: Fix config1/config2 parsing issue
      https://git.kernel.org/will/c/c61e5720f232

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
