Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859E973FDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjF0ObC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjF0ObB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:31:01 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DAC2D57;
        Tue, 27 Jun 2023 07:30:59 -0700 (PDT)
Date:   Tue, 27 Jun 2023 16:30:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1687876257; bh=u/styuiwKTHBLIwlbUAHCI3m1sh/IGIn2gHEu3WfiH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVJevOzlIrqr6uSV2IAWBd7W3hxR+7qjq7byiJJmD9pWJz4ASZnvks+O9RIAYJNRQ
         LeJOLwxYuyIsIaLLve6Gnp92GF46Aepokcl1LcfFlD+440qEWxQZCw5gOcIFMi5SHH
         W7UUfkx5uegtnUtPHJkFZaErCLZs1wtB/wjb25YY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] dyndbg: add source file name to prefix
Message-ID: <896d52bd-20b5-4507-99c6-de4b86f9141c@t-8ch.de>
References: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221223-dyndbg-filename-v1-0-cbf8543009a1@weissschuh.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis and Greg,

it seems you are the ones picking up patches for dyndbg.

Could you take a look at this series?
It has Acks from both Jason and Jim.

Thanks,
Thomas

On 2023-01-30 02:01:17+0000, Thomas Weißschuh wrote:
> Currently dyndbg has no facility to print the source file name of a
> debug statement.
> Without the source file the line number is of limited use.
> Also the dyndbg control file uses the filename as the primary index, so
> having it in the logmessage makes the relation clearer.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (3):
>       dyndbg: constify opt_array
>       dyndbg: increase PREFIX_SIZE to 128
>       dyndbg: add source filename to prefix
> 
>  Documentation/admin-guide/dynamic-debug-howto.rst | 5 +++--
>  include/linux/dynamic_debug.h                     | 4 +++-
>  lib/dynamic_debug.c                               | 8 ++++++--
>  3 files changed, 12 insertions(+), 5 deletions(-)
> ---
> base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
> change-id: 20221223-dyndbg-filename-02e0879dae4b
> 
> Best regards,
> -- 
> Thomas Weißschuh <linux@weissschuh.net>
> 
