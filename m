Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66A9709AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjESPNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232231AbjESPNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:13:43 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7756B1AD;
        Fri, 19 May 2023 08:13:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0EAF37C0;
        Fri, 19 May 2023 15:13:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0EAF37C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684509216; bh=9y+CNJUJ/q53O04APVAqsBIL53iBrmcTq7YLBNX8bkU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=eHU//7R89icFJlQhKcfphBAKpEZT2kWF0ZDwLEhvsxrVXuqnaHON78v7aoBlrvGiV
         bTr2i3kNU0jFFgiFLngJDmN5HXbSsWXHuVsyWSiZMhui9MbYagzLBI7ZMtxZjtJck1
         mH/df7gu6X1SyIHolXJ/DGiRGxRTJcRx39LEkeeU1v6+o7zgfsudxxhCiJvi7u5bvs
         PH7qEFIqKHZit3vLoYit3wLU4Lkt696E4oi3Y4BvGM/Zi8Vl5lEHAfNhEYlT3eWPy9
         UAaV4RfPYOhiKBMdFpTuIGoch3VU58nrxzJDOPSKYwx+twEuZuyb16RRVmPKmmIs6c
         y/YOR4pKyCsqw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     James Seo <james@equiv.tech>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     James Seo <james@equiv.tech>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Generate documentation for error pointer functions
In-Reply-To: <20230509175543.2065835-1-james@equiv.tech>
References: <20230509175543.2065835-1-james@equiv.tech>
Date:   Fri, 19 May 2023 09:13:35 -0600
Message-ID: <877ct4nylc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Seo <james@equiv.tech> writes:

> The error pointer functions are collectively mentioned hundreds of times
> in existing documentation (e.g. "Return: an ERR_PTR() on failure.",
> "If IS_ERR() is true, the function failed and PTR_ERR() gives you the
> error code.")
>
> This series adds kerneldocs for them and brings them into the docs build,
> immediately turning most such mentions into automatic cross-references.
>
> James Seo (3):
>   Documentation: conf.py: Add __force to c_id_attributes
>   err.h: Add missing kerneldocs for error pointer functions
>   Documentation: core-api: Add error pointer functions to kernel-api
>
>  Documentation/conf.py                 |  1 +
>  Documentation/core-api/kernel-api.rst |  6 ++++
>  include/linux/err.h                   | 48 +++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)

Series applied, thanks.

jon
