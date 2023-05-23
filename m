Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE59B70E22F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbjEWQdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjEWQdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:33:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6B130
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CAE06344A
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 16:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28754C433D2;
        Tue, 23 May 2023 16:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684859576;
        bh=tXErXodtzQ7xkbVVy/c6EV2jea5JDWKVX4GsnCREwNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cSH7YN0WoNCXtGgfzGf7NMDg6v5lyBJ6hGZ89dztcR5LiBg0vY+N9snqFxT3OqiGV
         juV6iYuM1lanGqEsqkvBtx0Yxw5dgmBP+wGTt0G9AbADY1L15gPQ7M7QZDkWPgIsw1
         WDVeEBd+j3PJzppChdBGOpBfsPLkUas4PF2xLAm8=
Date:   Tue, 23 May 2023 17:32:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <2023052351-extruding-semifinal-6314@gregkh>
References: <20230517101957.14655-1-xiafukun@huawei.com>
 <2023051739-shrunk-reopen-b968@gregkh>
 <111fa8ed-9031-a393-401c-0266a9bf7544@huawei.com>
 <e27b1467-bf51-fc1f-b3ce-a45f06b5b795@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e27b1467-bf51-fc1f-b3ce-a45f06b5b795@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 04:52:23PM +0800, Xia Fukun wrote:
> Gentle ping ...

Please relax, there are lots of other changes to review before yours,
and frankly, due to all of the problems that this patch has had over
time, it's on the bottom of my list.

To help out, why don't you review stuff as well?

thanks,

greg k-h
