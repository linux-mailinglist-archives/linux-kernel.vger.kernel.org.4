Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B257C671F49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjAROT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjAROS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:18:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06F560493
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:00:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D2BC617D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:00:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96C8C433D2;
        Wed, 18 Jan 2023 14:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674050428;
        bh=hUeaJyhp46Uj0IvaF7paV4Yon3F3s91YJZv8SwmsW4c=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=DpAKsAJgdUxH401TQ36g1vGdLpdnida35NylAi7OoV+ZGojeDv+4llAEVAYWKZwxl
         EKEbwn+IfSY3EISSOvLvpbSOu14BQLCrjR510GZBLUCyUGhksPJMiMxuZEj/BLriDo
         or/sBhPO2jjEW13r2oQBtx8cwRcvjhhHrHnw78lXn76YRhpiUJrtdP/NYHkQZYWH3z
         YmztlwcOlgEY3rTGTAuvr6XGwhpR9fC8GY5JVpXXyvT9zACxYORZof+ioQlmZRskZV
         Fmmi5/SdmJsfjvxPO4Dh4L4Z5L/2J8RdGhewvboXEdaH6y7ayabrMKfJVR1iAAsJ1C
         3Z0QqzW4FWjmw==
Date:   Wed, 18 Jan 2023 15:00:23 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
Subject: Re: [kbd] [patchv2 0/3] VT: Support >32x32 fonts for hidpi displays
Message-ID: <Y8f7d2WjH+gwtjhH@example.org>
References: <20221218003209.503539532@ens-lyon.org>
 <20230110205536.6kiju6swwabazr6u@begin>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110205536.6kiju6swwabazr6u@begin>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 09:55:36PM +0100, Samuel Thibault wrote:
> Hello,
> 
> Ping, is there anything to be done on this?

The patches look good to me.

I will apply a userspace patch once the kernel part is applied.

> Samuel
> 
> Samuel Thibault, le dim. 18 déc. 2022 01:32:09 +0100, a ecrit:
> > Hello,
> > 
> > This patch series adds to Linux and kbd the support for fonts larger than 32x32
> > by dropping the oldish VGA constraints that don't apply to fb-based consoles.
> > 
> > Samuel
> _______________________________________________
> kbd mailing list
> kbd@lists.altlinux.org
> https://lists.altlinux.org/mailman/listinfo/kbd

-- 
Rgrds, legion

