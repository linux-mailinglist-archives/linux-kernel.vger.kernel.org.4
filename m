Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4823613BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 17:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiJaQxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 12:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231709AbiJaQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 12:53:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7678411A11
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 09:53:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1232A61225
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 16:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C8D8C433C1;
        Mon, 31 Oct 2022 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667235216;
        bh=5FSyXkqQ+xG6XJPWEaNeDpN+GhxNh7sIjAazomfszxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FhDTJbR2xkaiNkwUqUNHpFYx21ABX1SaHTNxi1yNIbXUOqzzeqwQTAi6iY0Mr6yOz
         8Uwr5JbltXRtFW6GPdlnwprPUXgDex3PDHYcvcEe0iom1AQpVTyLf4NZMarlOZcu21
         q6+xbmoEetX4A5puqYLCppVlz3qqg3KsKtKRYxbY=
Date:   Mon, 31 Oct 2022 17:54:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: vt6655: change variable name wTimeStampOff
Message-ID: <Y1/9yBVf4AcSp8Cs@kroah.com>
References: <Y1/fLjJmma28LudO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1/fLjJmma28LudO@elroy-temp-vm.gaiao0uenmiufjlowqgp5yxwdh.gvxx.internal.cloudapp.net>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:43:58PM +0000, Tanjuate Brunostar wrote:
> The Linux coding style does not allow CamelCase variable naming.

That is a correct statement, but why say that here?  We have
documentation that describes this already :)

Please read the kernel documentation for how to write a good changelog
text and resend this as a v2.

thanks,

greg k-h
