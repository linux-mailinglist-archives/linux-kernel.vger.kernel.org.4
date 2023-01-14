Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4C866AC6C
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjANQEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjANQE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:04:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407879020;
        Sat, 14 Jan 2023 08:04:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF0FA60B43;
        Sat, 14 Jan 2023 16:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC24C433EF;
        Sat, 14 Jan 2023 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673712268;
        bh=JwjASFQ4ksG7ApunCN9jgPwqPyq8DUQCAd7wZFR7Azg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VqjyTP+4tpvb9DErLV/Jk9C8/vlOWmzeMUfwZe360e4mUMBlru+JVS9/wNDMGjVSV
         ljhLrVWbD1QfBiDfUNjgqV3VNGQJWN7KSqlOzS9lmiupMrK9SQd+ot/J9hA8cxdVkU
         dRy/iHPLzHZ7S1+FyPJs4jRlyRdi19rbBVJRq/XLqsUGHl5K5lTVhf0HVRVIsNDPj6
         wcYUA64y5SvsdCcHBY9QgW7s1RiZpGma0NTt3husDDEWWz/DMfQHrvlG0208D9X1GV
         LRo1haL0PARAu7Rw+QXjTTyV8Mm8LX6+HeVz6XVatRRBJPO/J5g7XSGqf1D12XnErr
         UHJdRUevGeWOg==
Date:   Sat, 14 Jan 2023 16:18:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 1/1] iio: chemical: scd30_core: Switch to use
 dev_err_probe()
Message-ID: <20230114161805.02f2dd5e@jic23-huawei>
In-Reply-To: <20230113141917.23725-1-andriy.shevchenko@linux.intel.com>
References: <20230113141917.23725-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2023 16:19:17 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Switch to use dev_err_probe() to simplify the error paths and
> unify message template.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied,

Thanks,
