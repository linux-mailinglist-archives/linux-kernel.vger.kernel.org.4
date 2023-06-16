Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E44732C63
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbjFPJn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245519AbjFPJnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:43:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E33230FD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A08C63471
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:43:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37DEFC433C9;
        Fri, 16 Jun 2023 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686908590;
        bh=mDqf9UcBQG4wfwzaQjfPhMXh9FL+mDBknpAMOZt/rlc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TTBaozSstINS1Fiqtku/Rkwd70kHnvQru7vGJ3FrtI++594ueHYL+KAMQYQNB1+1l
         WxfezVDDNe11KJrDngvUAirGN6Jt5boqO+Gu6zaQMJqQzPe4bbtXRZe3+8OAUTra53
         jghGAKJ2V3BA01gr3PWFawIJM0aZJIZXlfBr3FB4=
Date:   Fri, 16 Jun 2023 11:43:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Ming <machel@vivo.com>
Cc:     =linyunsheng@huawei.com, opensource.kernel@vivo.com,
        Sunil Goutham <sgoutham@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers:net:ethernet:Add missing fwnode_handle_put()
Message-ID: <2023061600-gong-pursuant-34d5@gregkh>
References: <20230616091549.1384-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230616091549.1384-1-machel@vivo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 05:15:01PM +0800, Wang Ming wrote:
> 本邮件及其附件内容可能含有机密和/或隐私信息，仅供指定个人或机构使用。若您非发件人指定收件人或其代理人，请勿使用、传播、复制或存储此邮件之任何内容或其附件。如您误收本邮件，请即以回复或电话方式通知发件人，并将原始邮件、附件及其所有复本删除。谢谢。
> The contents of this message and any attachments may contain confidential and/or privileged information and are intended exclusively for the addressee(s). If you are not the intended recipient of this message or their agent, please note that any use, dissemination, copying, or storage of this message or its attachments is not allowed. If you receive this message in error, please notify the sender by reply the message or phone and delete this message, any attachments and any copies immediately.
> Thank you

Now deleted.
