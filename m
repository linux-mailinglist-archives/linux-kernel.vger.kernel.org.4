Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6211672233B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjFEKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjFEKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:17:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BAFF3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:17:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DF1D61265
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA2BC433D2;
        Mon,  5 Jun 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685960240;
        bh=FiHHxNGuVuh8NYTFMvBFhzbSQvGZWk4euNTD4S75B0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CvODY0sIwndKbZXpWJGkycwNo2n4P41wGcyb+XhMmX0Oj6UsJyBC7bXC4/EA9/FEY
         ySW4wIqs26z1Uvk4XyraX5a2zGqkBAlf81p/4wQpkvz8CSyxYXKektL0moTRF9qMjD
         AMooUmh2MXG5WmDSRlePW48lM+HWJTBD54/vHzApABr1Fma04ZNq+RbamLzSeMAFS8
         CGJD+jjmB2egcgPX+8b5jSeTS6jfkLqX8U57mUyKOz6YDo21F69KMxIkvn7q943tlR
         eUylPUDcbLTxEVWxEmI4s4GDJd/HqsTCuz86bvHOxkCI75OP+9Z5iarHAPMZAwSoMX
         aqDGSzUQMOoJQ==
Date:   Mon, 5 Jun 2023 11:17:15 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Thomas Voegtle <tv@lio96.de>
Cc:     linux-kernel@vger.kernel.org, Hyunwoo Kim <imv4bel@gmail.com>
Subject: Re: Sometimes DVB broken with commit 6769a0b7ee0c3b
Message-ID: <20230605111715.4c0ba2ed@sal.lan>
In-Reply-To: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
References: <da5382ad-09d6-20ac-0d53-611594b30861@lio96.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 30 May 2023 13:12:57 +0200 (CEST)
Thomas Voegtle <tv@lio96.de> escreveu:

> Hello,
> 
> 
> I have the problem that sometimes my DVB card does not initialize 
> properly booting Linux 6.4-rc4.
> This is not always, maybe in 3 out of 4 attempts.
> When this happens somehow you don't see anything special in dmesg, but the 
> card just doesn't work.

Can you paste the full dmesg?

> 
> Reverting this helps:
> commit 6769a0b7ee0c3b31e1b22c3fadff2bfb642de23f
> Author: Hyunwoo Kim <imv4bel@gmail.com>
> Date:   Thu Nov 17 04:59:22 2022 +0000
> 
>      media: dvb-core: Fix use-after-free on race condition at dvb_frontend

What do you mean by helps? Does it fix it every time, or it just
reduces the number of init problems?

Regards,
Mauro
