Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD5F5B6159
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 20:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiILSzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 14:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiILSza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 14:55:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7640527B1C;
        Mon, 12 Sep 2022 11:55:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 334D1B80CBC;
        Mon, 12 Sep 2022 18:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E84C433D6;
        Mon, 12 Sep 2022 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663008924;
        bh=Nr2K6v9ii72kaht2xEQvNKY+uGuNTAacpsEY9SU40E8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tY3a+EipbsF59Btge1Yqu+Sd8TobhHa0IGYqeP6ZX2s+dW99rHGazkDoEFSqXKLo+
         7Rgr1+YXdNZt0sFH4IU1HglbPt5EE/GN5LmBW4Hj0ddb1v7PFiV+wtqCv+XJ7+HVSs
         yrvdcH6O7N6Htcr2qdreCKPRA1m6QfMiZU7peXOo=
Date:   Mon, 12 Sep 2022 11:55:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Wang, Haiyue" <haiyue.wang@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the mm-stable tree
Message-Id: <20220912115523.89b21e0a1d652b7445fafd21@linux-foundation.org>
In-Reply-To: <BYAPR11MB3495D19731BFDC439E2C1954F7449@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20220912154547.312165c5@canb.auug.org.au>
        <BYAPR11MB3495D19731BFDC439E2C1954F7449@BYAPR11MB3495.namprd11.prod.outlook.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022 13:05:37 +0000 "Wang, Haiyue" <haiyue.wang@intel.com> wrote:

> Should I send new patch ?

Nope.  I fix things like that.

But in this case I don't think I'll bother.  The world won't end.

Thanks, Stephen.
