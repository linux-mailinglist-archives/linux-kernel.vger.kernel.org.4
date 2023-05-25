Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E12711940
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbjEYVjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbjEYVjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBF51A2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 14:39:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8444264B60
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 21:39:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531AFC433D2;
        Thu, 25 May 2023 21:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1685050742;
        bh=ifHbzh3pec3yqvmX9F0OZzDTjTGDEDgj+fBkFuIO95o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H3GfJpFlWacAa2fLs8q7IprbF1I4AZZ+vHFTE4tD8maHrgfo3uCNazQeVTWIBFttr
         F1vnouhg7gTSmd394ccL17BBQsp2FlUa5Fdd/jTyZY6nhxkxHc0Jaj3FPFQzO9vPMz
         r83a6ub6iEZ4Z72z+lj4t3McREDmEFAVF1jTkOEE=
Date:   Thu, 25 May 2023 14:39:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] Process connector bug fixes & enhancements
Message-Id: <20230525143901.dc8c3d8cced48e52d3b136c1@linux-foundation.org>
In-Reply-To: <20230420202709.3207243-1-anjali.k.kulkarni@oracle.com>
References: <20230420202709.3207243-1-anjali.k.kulkarni@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 13:27:03 -0700 Anjali Kulkarni <anjali.k.kulkarni@oracle.com> wrote:

> Oracle DB is trying to solve a performance overhead problem it has been
> facing for the past 10 years and using this patch series, we can fix this 
> issue.  

An update to Documentation/driver-api/connector.rst would be
appropriate.

If you're feeling generous, please review the existing material in
there, check that it is complete and accurate.  Thanks.

