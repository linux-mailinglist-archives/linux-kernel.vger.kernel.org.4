Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C315E6D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiIVUdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiIVUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:33:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DA610FE17
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 13:33:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9DE461272
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 20:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0201EC43140;
        Thu, 22 Sep 2022 20:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663878798;
        bh=6yc/9oZqd47b6PzwGBho4m4l0+NbSQxX8KSF6IPY750=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8U4D0V+Hjn+wMSA1SgJ/ZmezdwlSNiqR6DNi48zG6HpeyCn241FUi/SUBJlbIcMN
         02MDGeIRJ4/lBGeTpooScRX2ZyHhyQI1LqM1SmJhAn9wllB8jfXed9+9HdXmGX58uw
         apy29pEYhgILpSfI7FaWbtVvDDsUa1qTP+TN1nXxPUOLiEzey7yHBriZeUkmuyt1Db
         COlsIAD0onLWODqoeToFi1I177Tof0fghg0GcBmu74VDL/Bw6pMu4G3d49Gaf0HfDq
         DS9C4GPXYL2tSS+jL1AYhiMoggzTjWS8msCh6798FIxxXLEfVFRZVkxVZRKqOURU7P
         2KXJ1YCf7dxAA==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, robin.murphy@arm.com,
        mark.rutland@arm.com, rdunlap@infradead.org,
        zhuo.song@linux.alibaba.com, baolin.wang@linux.alibaba.com
Subject: Re: [PATCH v4 0/3] drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC
Date:   Thu, 22 Sep 2022 21:33:05 +0100
Message-Id: <166385215080.183489.10700070349183346434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220818031822.38415-1-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com> <20220818031822.38415-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 11:18:19 +0800, Shuai Xue wrote:
> I am wondering that do you have any comments to this patch set? If/when you're
> happy with them, cloud you please queue them up?
> 
> Thank you :)
> 
> Cheers,
> Shuai.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] docs: perf: Add description for Alibaba's T-Head PMU driver
      https://git.kernel.org/will/c/a6f92909d6bb
[2/3] drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC
      https://git.kernel.org/will/c/cf7b61073e45
[3/3] MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver
      https://git.kernel.org/will/c/d813a19e7d2e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
