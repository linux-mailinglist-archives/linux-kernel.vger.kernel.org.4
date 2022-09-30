Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D132E5F0B41
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiI3MEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiI3ME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:04:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E3D1777B9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 05:04:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6250B82870
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 12:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF1FC433D6;
        Fri, 30 Sep 2022 12:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664539466;
        bh=U7CrY5N3SSGHOpsBnYGJip0ROeZK/n1WSl2bwv7ZBrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7BNizyvoepDy11fPRA/stw4hoTGP+1rRfqn+APwaeUidCRExavNgwWRjatvjuGsy
         2b8tzCUoiI+CiU8nDrS/rPukp1kAyrtHiujlRbGo+HoRmKn2zcMiv0DAOtU/UYYTFd
         ikioKIXyfaMsMSZwhWCpLmBgILMq4vzAV3si1r1Q=
Date:   Fri, 30 Sep 2022 14:04:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deming Wang <wangdeming@inspur.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] vme: fix the typo
Message-ID: <YzbbSDohVcPgJ9DA@kroah.com>
References: <20220927192102.8623-1-wangdeming@inspur.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927192102.8623-1-wangdeming@inspur.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:21:02PM -0400, Deming Wang wrote:
> fix the typo of the enty.

I am sorry, but I do not understand this changelog text at all.  Please
reword it to be more descriptive as to what is wrong and what is being
changed.

thanks,

greg k-h
