Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EE05B6D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbiIMMo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiIMMow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:44:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841E0B857;
        Tue, 13 Sep 2022 05:44:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3AB17B80DFF;
        Tue, 13 Sep 2022 12:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1002C433D6;
        Tue, 13 Sep 2022 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663073088;
        bh=Omb7QPvUV9WRYB+PRwh8LVj30AZBT2jNOEFHKTUXWUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rpvopf9yGnlwBQ6IvftF9UyTLqSRXVxEaiV/4ZaAIuywuNWz272oGgeBimQr/o0hN
         z/qoGGnawR9cBxUeKsySOr7yxfuSQwZeGvkjcB/+Xkz+kyf81LXED6Riogb2aJt8Y+
         GH9Fvk3eMLTQ1Vy8E0A1mTjgkNHcASmSYKY/2eXxw3/MQ9bg1xqAMMevpEwYrCLuU0
         rsJ2LzUb/JuJ4ECXl+gA9hNaaG/zuSGTN3PQophRMGmL5F6fkxTQqNTWxbTnnPXyhL
         BdZY62ji4nwwJPtJUhs8sSlxc1pWRXodnENkOCB1XD0C/F1LRL7WTjhITRcPldvXLN
         fcd//9fS8ij6w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY5HU-0003Zc-4f; Tue, 13 Sep 2022 14:44:48 +0200
Date:   Tue, 13 Sep 2022 14:44:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     jerry meng <jerry-meng@foxmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel RM520N
Message-ID: <YyB7QCAK2IfulCg0@hovoldconsulting.com>
References: <tencent_23054B863154DC02C6E98E5942416BFC200A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_23054B863154DC02C6E98E5942416BFC200A@qq.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 02:35:33PM +0800, jerry meng wrote:
> add support for Quectel RM520N which is based on Qualcomm SDX62 chip.
> 
> 0x0801: DIAG + NMEA + AT + MODEM + RMNET

> Signed-off-by: jerry meng <jerry-meng@foxmail.com>

Now applied, thanks.

For future patches, shouldn't you capitalise your names ("Jerry Meng")?

Johan
