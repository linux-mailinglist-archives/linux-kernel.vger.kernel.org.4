Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12473FF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjF0O6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232102AbjF0O5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:57:44 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D641991;
        Tue, 27 Jun 2023 07:57:37 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:57:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687877855; bh=P/z2u+Zv1zRwayzFvFSpwcYYNWbBKO+2o6HlKnsj9iY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aD+TRuHNADe9npAgYuJDKRZhzCaI5Jv+QB9NS58Z5SP9PB2pBYrF5KF7Jxy5S6/x7
         Nlu0kusv4TWZ4Hc8rsaLz7NjG4dWTL3ftUr54xG5NxzPPA/Ed4ZGSfIF6Loe57dlyK
         2d8c+HcL0UGv4P9JzeDzp7WZZP8NrQRJpeYub/E0=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] dyndbg: add source file name to prefix
Message-ID: <79a77af6-c5f5-4abb-ae46-cdcf4d40b75e@t-8ch.de>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
 <896d52bd-20b5-4507-99c6-de4b86f9141c@t-8ch.de>
 <2023062759-backspin-disperser-cd54@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023062759-backspin-disperser-cd54@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-06-27 16:47:26+0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 27, 2023 at 04:30:56PM +0200, Thomas Weißschuh wrote:
> > Hi Luis and Greg,
> > 
> > it seems you are the ones picking up patches for dyndbg.
> > 
> > Could you take a look at this series?
> > It has Acks from both Jason and Jim.
> 
> It's the middle of the merge window, we can't take anything new, sorry.

Just noticed this, too. Sorry for the noise.

> Care to submit it after 6.5-rc1 is out?

I'll ping again should it still apply cleanly to 6.5-rc1
othewise I'll resend.

Thanks,
Thomas
