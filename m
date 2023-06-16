Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A832732673
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjFPFBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFPFBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDD9269E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:01:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 326AD6141D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:01:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15477C433C8;
        Fri, 16 Jun 2023 05:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686891659;
        bh=1NLRzcoTWYknb6o5aQswk0SIj/J+4fc5WMrmmbozYPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pBv6btSDnSItXAwxyTIc8T9pJaJge5augEBT20Bmd53Cs3iyPl2MObhGocSdhzE+K
         GVTzppKMTRSg/LQgC2BjD1ilgXPccUFPlL8ALAmUKgZ+gc7wq4bypET9rKLNRqP0i4
         H9T+tnCCHhXobODU58zl168x1NLaEhlIH+uWP6R/EN5D4r+L6B307y/y4J+MB7xcAw
         rvLsTdAOsKxMIWCtRmBmWS67XPYzoBaC9uGiSHz9fiRf/Qhr7AfpW2J4DHbC7eOycs
         Rc6tJWm/d4SF2TKeyUDIrWBgO3YATgsNj3RcRqFwRrhar89KE/PmU4M28rPdb3JDoT
         ZtewrjziGN+8Q==
Date:   Thu, 15 Jun 2023 22:00:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] devlink: report devlink_port_type_warn source
 device
Message-ID: <20230615220058.0915a056@kernel.org>
In-Reply-To: <20230615095447.8259-1-poros@redhat.com>
References: <20230615095447.8259-1-poros@redhat.com>
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

On Thu, 15 Jun 2023 11:54:47 +0200 Petr Oros wrote:
> devlink_port_type_warn is scheduled for port devlink and warning
> when the port type is not set. But from this warning it is not easy
> found out which device (driver) has no devlink port set.

good idea

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
