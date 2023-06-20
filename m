Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84759736E66
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjFTOLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233204AbjFTOLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:11:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24232E6E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 07:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B22DA6127D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C18A0C433CA;
        Tue, 20 Jun 2023 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687270296;
        bh=BySw7zeEB+zqgTdSK07c1pD8YXeUFZjxQogJ1e5vW+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqW7UZIwMPujOd37QYsJAwDjyW9IfiLgFlA1DZ4rwi3pYToXRoN5ycs/OLYxtX0X8
         NaYpi+6iNl8kSjeKbWmcPrUxJ8BDkPB2FvTXMqHjWv8XFDN2k4k/jcbjurI6CwC2zB
         jB0e9WOD3ZRdO3Y/gmUWM7dpDqlrSCyQvLPL1pEs=
Date:   Tue, 20 Jun 2023 16:11:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] staging: vchiq_arm: Remove extra struct vchiq_instance
 declaration
Message-ID: <2023062022-emerald-bartender-4065@gregkh>
References: <20221221074047.233473-1-umang.jain@ideasonboard.com>
 <52a40c60-f044-c757-f8fd-241f456fb722@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a40c60-f044-c757-f8fd-241f456fb722@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:16:15PM +0530, Umang Jain wrote:
> Hi again,
> 
> Can this be collected please?. The series has two R-b tags and I think it
> got skipped during the last window?

SOrry for the delay, this got dropped somewhere, now queued up.

greg k-h
