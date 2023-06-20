Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC973722B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjFTQ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjFTQ45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:56:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7244E42
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:56:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B30F612F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:56:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94AA5C433C8;
        Tue, 20 Jun 2023 16:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687280215;
        bh=biY/lqBPIIdrqVdz9cSnQ7IyQQi8qtHDX+6spwIMo60=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lCfuCMAUgRgQmeCqvi53f0PntSc/j7JCRs61w+bk0rjW3Zhv0isQvzOqTmSPLiXqq
         w6iUOrvQv1lYNgL6kKLHyd/Fk87JX6MZbSHu/WvfK8fr7H8XOrwaeyo5hCerhcjJ4/
         GwaHhxpKjB31L/VwbbUyIduV7usPAX+1tqTc3o96nvVDZRVGhLFLYp7kwlRhizgm/X
         1WM+328hPeheKIsEizro1uQ4ueYH4FtvERnYEGxPoSsqlooKxvwcVrTxe/+Pgypr2S
         yjpmC9aGQx7WNs9arkt0jl9+PeDiFXwI6Lcy1FwN678a8e3bFAvkT8nj3dssSXnJgg
         cvCidaHuARyNw==
Date:   Tue, 20 Jun 2023 09:56:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc:     Ivan Vecera <ivecera@redhat.com>, netdev@vger.kernel.org,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>
Subject: Re: [PATCH net-next] bnxt_en: Link representors to PCI device
Message-ID: <20230620095654.1050d555@kernel.org>
In-Reply-To: <CAHHeUGWQihg4bTeaCNwq8_1ZxSfL5hpdw-RQOPK6QkSGSdX0OA@mail.gmail.com>
References: <20230620144855.288443-1-ivecera@redhat.com>
        <CAHHeUGWQihg4bTeaCNwq8_1ZxSfL5hpdw-RQOPK6QkSGSdX0OA@mail.gmail.com>
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

On Tue, 20 Jun 2023 22:19:32 +0530 Sriharsha Basavapatna wrote:
> This electronic communication and the information and any files transmitted 
> with it, or attached to it, are confidential and are intended solely for 
> the use of the individual or entity to whom it is addressed and may contain 
> information that is confidential, legally privileged, protected by privacy 
> laws, or otherwise restricted from disclosure to anyone else. If you are 
> not the intended recipient or the person responsible for delivering the 
> e-mail to the intended recipient, you are hereby notified that any use, 
> copying, distributing, dissemination, forwarding, printing, or copying of 
> this e-mail is strictly prohibited. If you received this e-mail in error, 
> please return the e-mail to the sender, delete it from your computer, and 
> destroy any printed copy of it.

Your emails to the list must not include any legal note of this nature.
I'll have to manually delete your review tag from the system.
