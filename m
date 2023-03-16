Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428266BD444
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbjCPPoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjCPPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:44:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C4A4ECDB;
        Thu, 16 Mar 2023 08:43:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F66D62088;
        Thu, 16 Mar 2023 15:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65092C433D2;
        Thu, 16 Mar 2023 15:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678981362;
        bh=ubuWRpXYumnYKpvSuHJeibQZdBLGJXwvOQq4t3bHDtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CqBRuh+deIOVqKl5dgUY57bnvvc0oR8zoEbsx8Bc70t206OccBLm+Us+Gebole6/f
         Bhdf3wYH3bOfj3KZaUn8WNqV5yFhvEqUl+AtYgfjt3PwTImn8prawiLL1/tfE9zDF2
         uUnjCB9RQy6MKjdBt1LMK0KhaNWIrBlZxnQD75C728K4M8zNNQ+5IsM8LaiNwhRYrp
         uzmTjLKDBerZ8SfpGe+m0rnnUg5IbEA0xrnUzriBCewCp5XnqS0lGFK84FaT8izYkD
         FjfklqS5sRG+TZnauBx/5B2doduUdzO1KuGj/Y/3za2Lr5bFPup8CE6cimW17wXEE8
         Yo345wXU3SByg==
Date:   Thu, 16 Mar 2023 15:42:37 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 01/18] mfd: da903x: remove MODULE_LICENSE in non-modules
Message-ID: <20230316154237.GJ9667@google.com>
References: <20230308194307.374789-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230308194307.374789-1-nick.alcock@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Mar 2023, Nick Alcock wrote:

> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/da903x.c | 1 -
>  1 file changed, 1 deletion(-)

All applied, thanks

--
Lee Jones [李琼斯]
