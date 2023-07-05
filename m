Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A79748F9C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjGEVPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjGEVPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17D519AB;
        Wed,  5 Jul 2023 14:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 851C161751;
        Wed,  5 Jul 2023 21:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACABFC433C8;
        Wed,  5 Jul 2023 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688591702;
        bh=eZCwl0ASZcwUZJRL6Vxpai1gV1Cb6EdTaZpskXrzTO0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DSVQVwdPDQxORGrivwtBaspYBxxKcme1K9PvSBMs6zkKz6QrGzfJ1JBCqgK4UBmtb
         DwVOf61tc6FNxG8ZC6pN3BwgMen5yv5P6uhmM2UYWMlQBPnIN7fIYV2CcOTo+N687s
         WPNZyd8BhPKh+gU59pRxRYFeMG60zE0YsPSYMU4w4IZSOtSDG7NnA1Td+Jg0kC/UXt
         Mr9AUCrdz3I/MNUT4lbc6GBvrroEw5TsNRfJqMtoTO7f7izO/3DA1p+AQPy1GUnDsi
         GAm66H7uCCcgX0xtBSpeHKn1Nab0w8qtS9sobP3Sa2hs66DfUvGNUe+CouMC4StXRk
         F35hYLlb1NF1Q==
Date:   Wed, 5 Jul 2023 14:15:01 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: ath9k: fix printk specifier
Message-ID: <20230705141501.3f1a5d2f@kernel.org>
In-Reply-To: <20230630130303.28308-1-dzm91@hust.edu.cn>
References: <20230630130303.28308-1-dzm91@hust.edu.cn>
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

On Fri, 30 Jun 2023 21:03:02 +0800 Dongliang Mu wrote:
> Smatch reports:
> 
> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
> 
> Fix it by modifying %lx to %px in printk.

The patch does %p not %px.
