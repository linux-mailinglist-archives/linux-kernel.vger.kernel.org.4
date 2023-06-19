Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C77358F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjFSNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFSNxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C726BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDDC760670
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 13:53:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAADBC433C8;
        Mon, 19 Jun 2023 13:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687182812;
        bh=kCKiD5fhFEy0gvMVk7RDP9g5QMN6OPehQVjGRcV+P8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAMVwzQmxhRioT42KFYyC7x9NbIPwZmIL+XoxvE/UrpB49eF9jv4TeItklHVLOPub
         RJ43cO6RPlhUsuVDb0XmOLn/BJ/7T7183OcrtHdGlZkzbM1pA44l5hAmV7zDCiZ6fH
         Vz5SWKZGu/oEJbir2k6gQNyI/argnwH2+f7x5DGU=
Date:   Mon, 19 Jun 2023 15:53:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: Re: [PATCH v3 0/4] Trivial code cleanup patches
Message-ID: <2023061922-numeric-runner-f36d@gregkh>
References: <cover.1687092111.git.yogi.kernel@gmail.com>
 <e80d385d-5515-ed42-e5dd-f9c977f7d4d1@gmail.com>
 <2023061938-unbounded-unbent-e706@gregkh>
 <ZJBc4bok1krfjqWf@zephyrusG14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJBc4bok1krfjqWf@zephyrusG14>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 07:19:21PM +0530, Yogesh Hegde wrote:
> Hi Greg, 
> On Mon, Jun 19, 2023 at 02:57:56PM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Jun 18, 2023 at 10:26:37PM +0200, Philipp Hortmann wrote:
> > > This patch series alone is fine. But when my patch series ([PATCH 0/9]
> > > staging: rtl8192e: Remove unsupported modes a and 5G) is applied before it
> > > fails as we change same lines. Will see what happens.
> > 
> > Yes, none of these apply :(
> > 
> > Yogesh, can you rebase this on my staging-next branch and resend?
> Sure, will rebase and resend. Did you mean staging-testing branch instead of 
> staging-next branch ? 

Yes, sorry.

