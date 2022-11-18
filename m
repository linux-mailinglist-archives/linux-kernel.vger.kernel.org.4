Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1843762F228
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbiKRKJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:09:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKRKI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:08:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C74A2B60D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 02:08:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2D0623FE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 10:08:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78486C433D6;
        Fri, 18 Nov 2022 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668766133;
        bh=RJlksabIXgLvCItKH/+Gz+PN2UGlsTyg0/Bb/Gkj/PI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zAT/qr7DNt+kR47RTVm2HLc6Vm4qcT+X6S8NsinNocV5dD12LUrUaqecKn6pS91th
         kapIdqM0u+dag0u2vE+GK16WbkXbSW0MkA4tZ9uUHwC7ux8RIUoBaxI7SeMmeLe7Ll
         S3F9krFYmt/eL8vunZwtCST8GKorgfy8wn0xvnpQ=
Date:   Fri, 18 Nov 2022 10:12:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     vincenzo.frascino@arm.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] lib/vdso: use "grep -E" instead of "egrep"
Message-ID: <Y3dMgfPXNMm/vaG2@kroah.com>
References: <ad42d19d-959c-61b4-8581-02ce0990c23f@arm.com>
 <788b5155-fef5-0e44-721a-f9183e145ae5@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788b5155-fef5-0e44-721a-f9183e145ae5@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 04:44:50PM +0800, Tiezhu Yang wrote:
> Hi,
> 
> This patch can not be found in the torvalds/linux.git or
> next/linux-next.git tree, please take a look, thank you.

That is because no one has applied it to their trees :(
