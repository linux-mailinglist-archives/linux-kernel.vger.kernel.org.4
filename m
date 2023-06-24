Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01A673CB63
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjFXOY4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 24 Jun 2023 10:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFXOYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:24:54 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51151BD6;
        Sat, 24 Jun 2023 07:24:50 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id DD01F15360;
        Sat, 24 Jun 2023 15:24:47 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id BABD8219FD1; Sat, 24 Jun 2023 15:24:47 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen Hofstee <jhofstee@victronenergy.com>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [RESEND][PATCH] net: cpsw: fix obtaining mac address for am3517
References: <20230624121211.19711-1-mans@mansr.com>
        <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch>
Date:   Sat, 24 Jun 2023 15:24:47 +0100
In-Reply-To: <ad0ec6ac-2760-4a03-8cee-0d933aea98eb@lunn.ch> (Andrew Lunn's
        message of "Sat, 24 Jun 2023 16:17:33 +0200")
Message-ID: <yw1x352h3plc.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Lunn <andrew@lunn.ch> writes:

> On Sat, Jun 24, 2023 at 01:10:59PM +0100, Mans Rullgard wrote:
>> From: Jeroen Hofstee <jhofstee@victronenergy.com>
>> 
>> Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
>> id to common file") did not only move the code for an am3517, it also
>> added the slave parameter, resulting in an invalid (all zero) mac address
>> being returned for an am3517, since it only has a single emac
>
> Hi Mans
>
> If there is only a single emac, why is the function being called with
> slave=1? Given the description, it seems like you are fixing the wrong
> problem.

See previous discussion:
https://lore.kernel.org/lkml/d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com/

-- 
Måns Rullgård
