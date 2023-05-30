Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489257156AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 09:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjE3H0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 03:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjE3HZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 03:25:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899F411A;
        Tue, 30 May 2023 00:24:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FAC462B07;
        Tue, 30 May 2023 07:24:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC977C4339B;
        Tue, 30 May 2023 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685431475;
        bh=PZjsJQLUJqkPPuDe93upocRDEMF7iP+p3z9H1/BFpDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5lBikm0bRWTlmqbruY9e7zAEhAuQVERl+wokcBa269qHr48uiq9i6D/XBeK4JSGv
         M93oIobut633k2ciadB8x0B8p3TWR2Fz7nzjzeZ61A7HGOhlyDyHx42cAFyd/GaVkA
         g4i6MYoQCot2wnUykkqKMqetLliGJZLEAUclpgTA=
Date:   Tue, 30 May 2023 08:24:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     stern@rowland.harvard.edu, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] Revert "Revert "usb: gadget: udc: core: Invoke
 usb_gadget_connect only when started""
Message-ID: <2023053015-afoot-slug-5553@gregkh>
References: <20230529234816.3720623-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529234816.3720623-1-badhri@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:48:14PM +0000, Badhri Jagan Sridharan wrote:
> This reverts commit f22e9b67f19ccc73de1ae04375d4b30684e261f8.

reverts of reverts aren't good.  Just submit the real fix please.

thanks,

greg k-h
