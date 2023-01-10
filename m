Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A378664DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjAJUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjAJUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:55:41 -0500
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0C91EAF9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:55:40 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by sonata.ens-lyon.org (Postfix) with ESMTP id 4A71520173;
        Tue, 10 Jan 2023 21:55:38 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
        by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AdSpmhsHG5XT; Tue, 10 Jan 2023 21:55:37 +0100 (CET)
Received: from begin (adijon-658-1-86-31.w86-204.abo.wanadoo.fr [86.204.233.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by sonata.ens-lyon.org (Postfix) with ESMTPSA id 31BDD2015C;
        Tue, 10 Jan 2023 21:55:37 +0100 (CET)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1pFLei-006YPd-2X;
        Tue, 10 Jan 2023 21:55:36 +0100
Date:   Tue, 10 Jan 2023 21:55:36 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [patchv2 0/3] VT: Support >32x32 fonts for hidpi displays
Message-ID: <20230110205536.6kiju6swwabazr6u@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kbd@lists.altlinux.org,
        linux-kernel@vger.kernel.org
References: <20221218003209.503539532@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221218003209.503539532@ens-lyon.org>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ping, is there anything to be done on this?

Samuel

Samuel Thibault, le dim. 18 déc. 2022 01:32:09 +0100, a ecrit:
> Hello,
> 
> This patch series adds to Linux and kbd the support for fonts larger than 32x32
> by dropping the oldish VGA constraints that don't apply to fb-based consoles.
> 
> Samuel
