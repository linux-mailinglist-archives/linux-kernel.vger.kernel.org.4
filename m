Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 534F06F59A3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjECOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjECOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:15:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B75BB8;
        Wed,  3 May 2023 07:15:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB78E62DD1;
        Wed,  3 May 2023 14:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381F8C433EF;
        Wed,  3 May 2023 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683123345;
        bh=WXfzt02XnN5koo+L5ZOxuxXtCWVa3F5RaFgKMKx9tVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LZwF9VbBkk11MGYQSJvK3BfXzlSseYFLKTrf+iTd7crvxCzyP4S7ZHaOOoCTtpcu5
         ck3XCznYwJGqEux16mWUBsQ2ss2BxKy0ZakLMeWiFY2bfTSpx9ONHM8JAgiY5yGW1R
         sp7WXKxdlqJNatYInjp2zGPH2pchPROnMfmW+Ays2qCOTMuZ14LGo+nNtQng5LqFuR
         DUrw2BBQlHnfTBDYsZwsSWW4571Ttmt7hpnCIR6cxjCHqTX+optvU69cDEGP4FLSfD
         3us+tLQA1y9eQ4Y1+/4TvRGU3RJKoTk2wkwaF9OiXgvAciVMElS8FJXVljnfuQCVFl
         8yeyVjUQPS45w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 968A7403B5; Wed,  3 May 2023 11:15:42 -0300 (-03)
Date:   Wed, 3 May 2023 11:15:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] Fix perf test probe libc's inet_pton on s390
Message-ID: <ZFJsjtzGtqwVYhfD@kernel.org>
References: <20230503081134.3372415-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503081134.3372415-1-tmricht@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 03, 2023 at 10:11:34AM +0200, Thomas Richter escreveu:
> With Fedora 38 the perf test 86 probe libc's inet_pton
> fails on s390. The call chain of the ping command changed.
> The functions text_to_binary_address() and gaih_inet() do
> not show up in the call chain anymore.

Thanks, applied.

- Arnaldo

