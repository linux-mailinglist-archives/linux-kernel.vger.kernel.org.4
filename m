Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A1F6C10A5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjCTLTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjCTLTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:19:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6842D2D43;
        Mon, 20 Mar 2023 04:19:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D26C6FEC;
        Mon, 20 Mar 2023 04:19:54 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06DA73F67D;
        Mon, 20 Mar 2023 04:19:09 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] firmware: arm_scmi: Use the bitmap API to allocate bitmaps
Date:   Mon, 20 Mar 2023 11:19:01 +0000
Message-Id: <167930959710.2462578.17747677460338953983.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <c073b1607ada34d5bde6ce1009179cf15bbf0da3.1657308593.git.christophe.jaillet@wanadoo.fr>
References: <c073b1607ada34d5bde6ce1009179cf15bbf0da3.1657308593.git.christophe.jaillet@wanadoo.fr>
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

On Fri, 08 Jul 2022 21:30:01 +0200, Christophe JAILLET wrote:
> Use devm_bitmap_zalloc() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 

(sorry for the delay, it seemed to have slipped through the cracks,
thanks to Cristian for pointing this out)

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!

[1/1] firmware: arm_scmi: Use the bitmap API to allocate bitmaps
      https://git.kernel.org/sudeep.holla/c/d617808e3b83
--
Regards,
Sudeep

