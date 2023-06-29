Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0755D742A69
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 18:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbjF2QPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 12:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjF2QPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 12:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5B170F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 09:15:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 046C96156E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 16:15:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EA1C433C0;
        Thu, 29 Jun 2023 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688055300;
        bh=ZZ0x/hfKHeOr7h69Wp129mhxshiks3zVTS8Y7lb2+Dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PFhVcRaysQqUKb92I6zVf3GTwCJFBnGsYiGsW7XDdQLB1Pmk28lq78fhcQmj/mHAx
         7wJ+Oi3uiV6f0WQ0ZgyPlB9lup3N8ZsMRWbvPfG6pX8FRiBSa3HcdxujBYAzVX9LHV
         ATdClk7KBcfPVW6IUCJgbL2iHQDD5uq8g1fHBXNwl5+LUosSHeMD3GkNQrYys6wE1J
         tpi7rGqRKY2VH/zGf5uI2UJ3QhzOetvBUo8GQgy3kxha+tdPg1JLxuMNPCfr0EOtDk
         ny8dxnVDuhujbG+/LlFCdNaNrKJ/bEKWC4wpZ37Yx9/qufkr7E9XsdoaYUonVDNIML
         kmDNBbN9PZJ+g==
Date:   Thu, 29 Jun 2023 09:14:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Tobias Heider <me@tobhe.de>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
Message-ID: <20230629091459.5e442d21@kernel.org>
In-Reply-To: <ZJ2JARrRUUd4YRvX@tobhe.de>
References: <ZJt7LKzjdz8+dClx@tobhe.de>
        <CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
        <aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
        <ZJ2JARrRUUd4YRvX@tobhe.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jun 2023 15:37:05 +0200 Tobias Heider wrote:
> Would "Fixes: c4dab50697ff ("video: remove unnecessary platform_set_drvdata()")"
> work?

Modulo the text in the brackets but yes ;) I'll add when applying.
