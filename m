Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9E773FEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjF0OvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjF0OvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78EB5586;
        Tue, 27 Jun 2023 07:48:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE8B7611BE;
        Tue, 27 Jun 2023 14:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FE3C433C0;
        Tue, 27 Jun 2023 14:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687877249;
        bh=iVGFFoHvyeH3UjpVLHehT6HeqAjfNK5+/oIAYbj6sYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxgW8zZNEFgWzeDh0EGb2mCF33KDAhnUL8/bHoHC3NxwO7mXQcpC4JZAzPtlJFyTG
         re7IU5oxjryZhXjwgn4TN5K8qX54QkaNdno+9s+HpfTKp49eR81FjXOH4jldV2szEo
         ftuRtnWCwlo6uHeCxhvkjfGkNuxCgRme6RAjSpnM=
Date:   Tue, 27 Jun 2023 16:47:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] dyndbg: add source file name to prefix
Message-ID: <2023062759-backspin-disperser-cd54@gregkh>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
 <896d52bd-20b5-4507-99c6-de4b86f9141c@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <896d52bd-20b5-4507-99c6-de4b86f9141c@t-8ch.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 04:30:56PM +0200, Thomas Weißschuh wrote:
> Hi Luis and Greg,
> 
> it seems you are the ones picking up patches for dyndbg.
> 
> Could you take a look at this series?
> It has Acks from both Jason and Jim.

It's the middle of the merge window, we can't take anything new, sorry.

Care to submit it after 6.5-rc1 is out?

thanks,

greg k-h
