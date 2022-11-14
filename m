Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E03627652
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235931AbiKNHUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbiKNHUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:20:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D521F8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 23:20:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCAEF60ED2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 07:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B63CC433C1;
        Mon, 14 Nov 2022 07:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668410399;
        bh=PRMT7kECNZoMA7eX2WsddsDL98klDYjZ2EvzH7BYzSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvVmSS7fpiHrsezj/H3NMRpqaxHEoW97AIry0hGFuH5x92Jqk/cbSlBCzNmP4jVL5
         jImJ+iwicTFgPdO/qn8tkbjTpfNTOjVPleOaTmln3f30h+ebvf/PHU354F2yGgCyS7
         eHHMGnsnB3Qyl+amSPWwvr5k7L57ExiWzlOeys5g=
Date:   Mon, 14 Nov 2022 08:19:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhengchao Shao <shaozhengchao@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        akpm@linux-foundation.org, paulkf@microgate.com,
        weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH] tty: synclink_gt: release resources when synclink_gt
 driver open failed
Message-ID: <Y3HsHKbugkKDD7b5@kroah.com>
References: <20221114010734.314910-1-shaozhengchao@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221114010734.314910-1-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 09:07:34AM +0800, Zhengchao Shao wrote:
> When synclink_gt driver open failed, it doesn't release resources. Compile
> tested only.

How was this found?  Please always provide the proper required
information about stuff like this as our documentation requires.

thanks,

greg k-h
