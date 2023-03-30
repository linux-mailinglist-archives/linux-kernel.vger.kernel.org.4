Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B87E6D02AE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjC3LMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjC3LMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38819770
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:11:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BE226200A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 11:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A961EC433EF;
        Thu, 30 Mar 2023 11:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680174717;
        bh=VazfsNN0HKVU/vlqWe4mJ8uHxWTQN5z65oUqPF2fABM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLHLEgUW6O7WfuF/l4TUf6qQD+9QastfYaE11UsfpOAXDNv9TW2jxTIyab363Ukqv
         QhPYXO1HUaOy7j9Q57TCIfBw0b6RGCyVjbVxBOq48TrLQJG3r3lWklXgHOQ65ecMXb
         nzTrOrUTXs1Wc8uVGAPDaHeWNgBF+Fph1wGpBfwdSYkoXMCTost1vglscmJcpH0Lqj
         ITZp5lsz8LtJ4+iIBLnEljSWzm2ey+9hHneda+s5hGWlHglbtn2HCrMwdGnxntrwLi
         RCZIdHhmOVHth8ZfXuuD6+eBm0rgB8KPas2XXACwP+A1gw3Tvqph0KRt2CSCJarjHB
         tV2WlG1iqgGAw==
Date:   Thu, 30 Mar 2023 12:11:53 +0100
From:   Lee Jones <lee@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH] mfd: arizona-i2c: add the missing device table IDs for of
Message-ID: <20230330111153.GA434339@google.com>
References: <20230319124153.35294-1-git@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319124153.35294-1-git@apitzsch.eu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Mar 2023, André Apitzsch wrote:

> This patch adds missing MODULE_DEVICE_TABLE definition
> which generates correct modalias for automatic loading
> of this driver when it is built as a module.

Next time please wrap at a more suitable point (~80-chars).

I've fixed this for you this time.

> Signed-off-by: André Apitzsch <git@apitzsch.eu>
> ---
>  drivers/mfd/arizona-i2c.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
