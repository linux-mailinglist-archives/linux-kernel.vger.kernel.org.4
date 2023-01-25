Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675567C135
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 00:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235892AbjAYX4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 18:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjAYX4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 18:56:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7131A1E1C3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 15:56:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3C360B3A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 23:56:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28509C433EF;
        Wed, 25 Jan 2023 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674690973;
        bh=kJ8ABJ0KvkhO/F8tnFyaa5QXvT/bIqvvJq2iFu7Vw+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vOUxx+b+sOXVJJ3qWY8VPJipTrNYDxRT5FSK9u8oMJvwIK6h/MErzfGfG1F4eXNNa
         KRR9Fz5TT806duDIOWHJfDHrsRps5qBimu1Now/auQ6FD5nl/9H0dq2SGBc2uWz+jm
         3EjsHz5+Tggioo+k+Uc1MFilDrrLWXZK05JO+oufdhLZaujZv+OiNvQMAigxZBXfrh
         spqv2aP/BESRbhDLa38KfgVNBqOcYsRMz0TPU5N9R1SCbGEjtGGNIEpJqKEoFUYkck
         XJceygbKfNTLf5ZkIlIK6OewwXU9nadbI6T3PClvU+pPuOfmthKMxy1sG3BJ8rW7CH
         LZO1MJp9VTQxA==
Date:   Thu, 26 Jan 2023 07:56:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     s.hauer@pengutronix.de, linux-imx@nxp.com, kernel@pengutronix.de,
        festevam@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk
Subject: Re: [PATCH] ARM: imx: Call ida_simple_remove() for ida_simple_get
Message-ID: <20230125235605.GF20713@T480>
References: <20230105061123.2085-1-angus.chen@jaguarmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105061123.2085-1-angus.chen@jaguarmicro.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 02:11:23PM +0800, Angus Chen wrote:
> The function call ida_simple_get maybe fail,we should deal with it.
> And if ida_simple_get success ,it need to call ida_simple_remove also.
> BTW,devm_kasprintf can handle id is zero for consistency.
> 
> Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

Applied, thanks!
