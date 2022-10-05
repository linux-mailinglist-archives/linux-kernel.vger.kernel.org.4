Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56ECE5F540D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiJELwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJELwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:52:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE0DBD1;
        Wed,  5 Oct 2022 04:52:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8F42616C2;
        Wed,  5 Oct 2022 11:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19CACC433D6;
        Wed,  5 Oct 2022 11:52:22 +0000 (UTC)
References: <20220930114041.1306711-1-gregkh@linuxfoundation.org>
User-agent: mu4e 1.8.9; emacs 28.2
From:   Felipe Balbi <felipe@balbi.sh>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: move USB gadget and phy entries under the
 main USB entry
Date:   Wed, 05 Oct 2022 14:51:55 +0300
In-reply-to: <20220930114041.1306711-1-gregkh@linuxfoundation.org>
Message-ID: <87czb6wkr0.fsf@balbi.sh>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> Felipe has done a wonderful job over the years, but now it makes sense
> to just maintain all of the USB stack in one tree.  Do so by removing
> the current USB gadget and phy entries so that all portions of the stack
> are now covered by the main USB maintainer entry.
>
> Cc: Felipe Balbi <balbi@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Felipe Balbi <balbi@kernel.org>

-- 
balbi
