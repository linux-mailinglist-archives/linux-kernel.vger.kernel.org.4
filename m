Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87A46EC929
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjDXJla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:41:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2F06E66
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 02:41:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5310BD75;
        Mon, 24 Apr 2023 02:42:11 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D6BA3F5A1;
        Mon, 24 Apr 2023 02:41:26 -0700 (PDT)
Date:   Mon, 24 Apr 2023 10:41:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Tom Rix <trix@redhat.com>
Cc:     mark.rutland@arm.com, lpieralisi@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: smccc: set variables
 smccc_soc_id_version,revision storage-class-specifier to static
Message-ID: <20230424094123.suueva23r4njjbfg@bogus>
References: <20230423153428.3938525-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423153428.3938525-1-trix@redhat.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 11:34:28AM -0400, Tom Rix wrote:
> smatch reports
> drivers/firmware/smccc/smccc.c:20:21: warning: symbol
>   'smccc_soc_id_version' was not declared. Should it be static?
> drivers/firmware/smccc/smccc.c:21:21: warning: symbol
>   'smccc_soc_id_revision' was not declared. Should it be static?
> 
> These variables are only used in their defining file so should be static
>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Since the patch introducing this issue comes from irqchip tree, we must
either route this through that if they have earlier fixes set or wait
until v6.4-rc1 and send it through SoC tree. Please cc soc@kernel.org and
Marc Z and repost. It is better to be explicit and mention it is either
based on -next or mention the commit introducing the issue since it make
no sense if one has no knowledge of -next change.

-- 
Regards,
Sudeep
