Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1685B61D88A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiKEHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEHnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:43:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0ABB7CC
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 00:43:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CF6860A7C
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 07:43:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EC9C433C1;
        Sat,  5 Nov 2022 07:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667634213;
        bh=FdBPvPyfNEsaKWxpsYXFShqySPy8bj/5cp/ZwJpEjv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loMQ3prw/yAZ1nmMWo5DsILo48yKDdSTPkssKTwUNncjGOAXWlWo6RyJeFzAmLi1u
         e4GKfxbQ99XFyRzw9UQP8NWeNhR+fF3bznOU3UKx+UYy5MB2BJJeF4lUHAmvSMgNO4
         b/T0RMVf4IY1LkZPncTzcD6QHWqQtC1t7t+dNNi4zUBUi8ysOZDj9GTTZjTCZboynu
         bk+Ctux+G4D46h8AujKo3kQNf3rMGeOma9G50uGAOwjHv8qL2l8s8hnVE+hCm5IW3/
         AYhbq6c1ZVyco8fwfie68cJU+HXRvDuMgamaiwPFaqFOqtBQWYtlOhE+a/+GVlcTR4
         ksa3P9pC3mNfQ==
Date:   Sat, 5 Nov 2022 13:13:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     justinpopo6@gmail.com
Cc:     alcooperx@gmail.com, kishon@ti.com, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH 0/6] Various bug fixes/improvements for phy-brcm-usb
 driver
Message-ID: <Y2YUIaQdfJOs22iF@matsya>
References: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1665005418-15807-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-10-22, 14:30, justinpopo6@gmail.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> A few suspend/resume bug fixes with clocks and wake counter. Also improve
> port mode selection.

Pls order fixes first, that way they can go into -rc.

I have applied these, thanks

-- 
~Vinod
