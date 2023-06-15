Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450AE73157C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbjFOKfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343902AbjFOKfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C4E2121
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:35:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1613462741
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:35:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A471C433C0;
        Thu, 15 Jun 2023 10:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686825322;
        bh=shIlOxwxvaQGKkHw6CsO21QcNEeP8WomegofO5hSK+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cII6FzgK7l0z612WVICkr0VTo0nP1XCcILvmoYIG93L5QUm0AdsFDCH/WbFJ5R2HM
         gBD+OAq7zrOreHqj8saZrHH6/+DOqll8DN+PH5FK/lAurRAg5jxlOwuM5KJ56yIQBq
         iWvoZD2H66d2wpMfSDWB6F6RHZoRljOuqhEUdXKY=
Date:   Thu, 15 Jun 2023 12:35:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Neel Chakraborty <neelchakrabortykernelwork@gmail.com>
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 001/001] drivers/staging/vme_user/vme.c: Fixed alignment
 issues
Message-ID: <2023061555-posting-purple-9cfc@gregkh>
References: <20230606112321.1022783-1-neelchakrabortykernelwork@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606112321.1022783-1-neelchakrabortykernelwork@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:53:22PM +0530, Neel Chakraborty wrote:
> Made alignment match open parenthesis.

Your subject says "issues" yet you only changed one thing here.  Please
be more specific and fix this up.

thanks,

greg k-h
