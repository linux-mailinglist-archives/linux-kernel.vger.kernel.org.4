Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61113621810
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiKHPXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:23:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiKHPXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:23:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF4167D4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 07:23:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A65716162D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 15:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97869C433D6;
        Tue,  8 Nov 2022 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667921016;
        bh=uS0okb+qfQuarqze9+mm9LuFlTvjUVNK5qOFiOfm210=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHkE3wlH5cFW/b5r68j3qWGrMqoa84JePsIEzElGK1iBRX13wlPfFql6WuKS4Ujxd
         reSeXGE+/v7PAKf4uk1wBfpGdmj1D/48hKUaLqqdRShpRi8g7xcs0UaCKhYhdMVNug
         FK4p2cwBzUEMrqarpycMMiuFbVRX1MjzVyHvAJbs=
Date:   Tue, 8 Nov 2022 16:23:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jacob Bai <jacob.bai.au@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] staging: rtl8192e: rename r8192E_hwimg.c/h to
 table.c/h
Message-ID: <Y2p0dNLBqiWFPzB9@kroah.com>
References: <cover.1667723306.git.jacob.bai.au@gmail.com>
 <9bb563727915e3f3edd863837608336b99564462.1667723306.git.jacob.bai.au@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bb563727915e3f3edd863837608336b99564462.1667723306.git.jacob.bai.au@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 07:31:17PM +1100, Jacob Bai wrote:
> Same as other rtlwifi drivers, use table.c/h.

You say what you do here, but not why.

Why rename the file?  What's wrong with the existing name?  It's not
causing any problems, right?

thanks,

greg k-h
