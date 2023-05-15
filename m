Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58282704147
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245503AbjEOXFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 19:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243628AbjEOXFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 19:05:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9D410A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 16:05:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40E86236D
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 23:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F38C433D2;
        Mon, 15 May 2023 23:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684191912;
        bh=YRWlUP9YOxpkcQm0uppiGS961/PCkUeOMBnnNF2bwDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gt+cQipsGWojt6hdB8fnovOebDhHCHtbkjtXyo/AhYLpyiyX50+5GyQ/IyyLa7pFx
         OwPM7uIGPuZtsGu888047EYv8vY9uhc693bi3mcjtbYzfV5zCxjFL5bQj0IfP2E+vx
         iLzo7GyZx/Bsvu7OWJA/k4+AhU34C0ulD8dJBKq4b7iHzJxTQMaqeDICu9brAEutnr
         ztTd4xiRO8GBRcAnquxyWpwc0FnpizOULaHyUmlUm0ZSbxp4ediyW5aTvhLgO0M+sM
         h8dlL+myaP3270UOarW16qC+K/+/ebfUDjjLNjleqnrGtcu7+XsD77jamkxUiu04N5
         tOY4HhiGZwakw==
Date:   Mon, 15 May 2023 16:05:10 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vernon Lovejoy <vlovejoy@redhat.com>,
        linux-kernel@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v3] x86/show_trace_log_lvl: ensure stack pointer is
 aligned, again
Message-ID: <20230515230510.ho2nn27fktgpoqvk@treble>
References: <20230512104232.GA10227@redhat.com>
 <20230515182608.GA21285@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230515182608.GA21285@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 08:26:08PM +0200, Oleg Nesterov wrote:
> Josh, this is boring.
> 
> We are changing this simple fix for the second time, precisely following
> your recommendations. And for the second time, you mysteriously disappear
> afterward.

Patience, please.  I'm not just sitting around waiting for your patches.

> Please tell us if you finally agree with this version or if you think we
> should make changes again.

Looks fine.

Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>

-- 
Josh
