Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33A673D13A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 15:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjFYNzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 09:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 09:55:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D45AE43
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 06:55:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B72360A70
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 13:55:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C91C433C8;
        Sun, 25 Jun 2023 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687701343;
        bh=TU57kKZ70jIL08bQ4GXtej05ic6Fbtxc5OE3lmyT3lg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b23i67TyzFrV3pSljYSOA8X/1g1w1EOSad1+nIUKl2TRq2P1Fmsrs503lcRAE8cMu
         rI/Z5T4CAOaNQjj20iWSWmObMevfGlfWZEgeXE0sDLcvpjZH7nuZnPjyQ2xposZGQr
         rgVThAZilJ33D11Ab0T97EDf3fKSefCkWC8+fNBY=
Date:   Sun, 25 Jun 2023 15:55:40 +0200
From:   "<gregkh@linuxfoundation.org>" <gregkh@linuxfoundation.org>
To:     Franziska =?iso-8859-1?Q?N=E4pelt?= 
        <franziska.naepelt@googlemail.com>
Cc:     eperi1024@gmail.com,
        Franziska =?iso-8859-1?Q?N=E4pelt?= <franziska.naepelt@gmail.com>,
        hdegoede@redhat.com, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        philipp.g.hortmann@gmail.com, quic_vjakkam@quicinc.com,
        tegongkang@gmail.com
Subject: Re: [PATCH v2 0/5] Fix some checkpatch issues
Message-ID: <2023062527-bride-unsolved-3b56@gregkh>
References: <F9C4E29E-C355-4B08-A2EC-2197A6EB7AFD@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F9C4E29E-C355-4B08-A2EC-2197A6EB7AFD@googlemail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 03:33:59PM +0200, Franziska Näpelt wrote:
> Thanks for your feedback :)
> Since not all the patches of my first patch series have been applied, I thought I have to submit the whole series again. Submitting a series of 5 patches, where 3 have been already applied of course fails.
> So does it mean, if 3 of 5 patches of a series have been applied and I want to submit a new version, I only submit patches for the remaining work and not all of them again?

Yes, just submit the remaining ones.

thanks,

greg k-h
