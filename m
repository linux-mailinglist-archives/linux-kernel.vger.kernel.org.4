Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D71A5B660F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiIMDQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiIMDQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7226F543D4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 20:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 093C1612E4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A6C433C1;
        Tue, 13 Sep 2022 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663038959;
        bh=aTrY3NGN8P43xzKdOh0uIpOhrM/d4B6KbePZQKV8auE=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=SX2HaEI7Dduecanpggo3q8MAg0xshdOiuKeoJdqvSmcRKIv6Z4zYQmC6m/cPj3MQR
         Va/vttXGbbDJlBL39Oysk1ydOSjwtdtvI8UNrlwQ5tPfnWQor02GNhWQrsCEXc+d5f
         KEn943Ke6boqLix5pzyP6CmMncWw1Lg2cPh0v9QYeTsEd/tCQuj92yeYrrOyGD0YAt
         plUZTcyDuKiuQsJQHyMAggF25RfGqdLI+0p6+PfVG5fS4avI3sMEL9m5nQLp8BBfjD
         DAs/WmUHkXWJNSbbuTNW2H4cC3GnsMG2D6IC+brHzgBIV2QqaHZqjgv84+uHLnYLh8
         vpEd0ECMoQ+LA==
Message-ID: <7e0bd17e-f1e5-47fd-16c2-94921d772567@kernel.org>
Date:   Tue, 13 Sep 2022 11:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [f2fs-dev] [PATCH] f2fs: increase the limit for reserve_root
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220823172124.2285995-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220823172124.2285995-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/24 1:21, Jaegeuk Kim wrote:
> This patch increases the threshold that limits the reserved root space from 0.2%
> to 12.5% by using simple shift operation.
> 
> Typically Android sets 128MB, but if the storage capacity is 32GB, 0.2% which is
> around 64MB becomes too small. Let's relax it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
