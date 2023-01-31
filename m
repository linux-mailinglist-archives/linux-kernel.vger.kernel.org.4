Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE039682C26
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjAaMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjAaMDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:03:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA624CE6F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:03:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62FFEB81C01
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:03:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7699CC433EF;
        Tue, 31 Jan 2023 12:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675166610;
        bh=eZPwAa3uVEmQhS+VUB7emHsAjVwBiFMfTB3sPV6910Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTVu6jJaZOoDZ8GCdZ0z8lGwNpvTbD8jvSWt/BExP6jT1zMCD7cjlLhPYkbe4Izy1
         bOtaYy5+CRtKMFOK7sgXTQI4Ruai4ab9FPDEjke8VXM55tvt7xkDpUgV0qm8gNeKR1
         B/+FNMJPamScJ+EgQrEh7R5K6Xh1AGV0Xe+1IpQudSbX8WH38hCCNqXCMxGMnDezrK
         8Yf2qduOWzLLpEWSkj5XLSX/h3WKaisW+Mhlp5OKAQDyAXKsqLqhP2Uc7OWnRZFAKb
         Wp2jEaAAJ5jLnZgGuwUC3rVP8jHtq+JsDGW20t4JSDqxS0XhdJ7URG1qCCUBf26P1S
         ZEC3rnOX73gZA==
Date:   Tue, 31 Jan 2023 17:33:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v2] soundwire: bus_type: Avoid lockdep assert in
 sdw_drv_probe()
Message-ID: <Y9kDje/NwUluB2O0@matsya>
References: <20230123172520.339367-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123172520.339367-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-23, 17:25, Richard Fitzgerald wrote:
> Don't hold sdw_dev_lock while calling the peripheral driver
> probe() and remove() callbacks.

Applied, thanks

-- 
~Vinod
