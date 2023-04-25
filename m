Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADD6EE2D1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 15:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjDYNWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 09:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbjDYNWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:22:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FBC273D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 06:22:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8EBF62665
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 13:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A24C433EF;
        Tue, 25 Apr 2023 13:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682428942;
        bh=p4jH7K9rtwY6jo3lSgcDmKK28tFwnvicCz7SMeIkOpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7gC8G0oW6IqoZidkz2k9+a2ovqDtQHnm0kHVAKl01/T9/6CJhjkajJWO/2GH2wLJ
         qFDY37/zcWM7evhRbNlNt5wXUwJnbnIe0vywsSfTLQBHEK4ajFTkoBvJ/RDt6Ag9Jf
         RMLcwUfL2TIGdPNOXtnMzPRWCc/l/rR55tIwgHlY=
Date:   Tue, 25 Apr 2023 15:22:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>
Subject: Re: [GIT PULL] extcon next for 6.4
Message-ID: <2023042544-cargo-reexamine-ed86@gregkh>
References: <1d2b9fd2-4a59-cb3b-2fd3-9f6635f3bbf8@gmail.com>
 <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b49bdb2-642e-214b-7334-911721f62ce6@gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 09:58:47PM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> Gently ping for v6.4.

Ouch, something went wrong with your first email and it ended up in my
spam folder in gmail, so sorry about that :(

Is your tree included in linux-next already?

thanks,

greg k-h
