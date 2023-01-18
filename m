Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57624671C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjARMhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjARMfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:35:44 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8392838039
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:00:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65C52169C;
        Wed, 18 Jan 2023 04:01:04 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 11D393F71A;
        Wed, 18 Jan 2023 04:00:20 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Yong-Xuan Wang <yongxuan.wang@sifive.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH -next v4 0/1] drivers: base: cacheinfo: fix shared_cpu_map
Date:   Wed, 18 Jan 2023 12:00:17 +0000
Message-Id: <167404289498.885570.11940427601059140052.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230117105133.4445-1-yongxuan.wang@sifive.com>
References: <20230117105133.4445-1-yongxuan.wang@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 10:51:32 +0000, Yong-Xuan Wang wrote:
> Changelog:
> --- v4 ---
> break after we find the shared instance.
>
> --- v3 ---
> Remove unneeded semicolon
>
> [...]

Applied to sudeep.holla/linux (for-next/cacheinfo), thanks!

[1/1] drivers: base: cacheinfo: fix shared_cpu_map
      https://git.kernel.org/sudeep.holla/c/198102c9103f

--
Regards,
Sudeep

