Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E5B5F698A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiJFOYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJFOYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:24:46 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 78DD21C422
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:24:43 -0700 (PDT)
Received: (qmail 787496 invoked by uid 1000); 6 Oct 2022 10:24:42 -0400
Date:   Thu, 6 Oct 2022 10:24:42 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: Replace NO_IRQ by 0
Message-ID: <Yz7lKhs5qUXaoFsF@rowland.harvard.edu>
References: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
 <Yz7dI5iTaguhn73K@rowland.harvard.edu>
 <0d2056d8-ed12-88d3-b9c1-d6c1e772dcf3@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d2056d8-ed12-88d3-b9c1-d6c1e772dcf3@csgroup.eu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 02:01:57PM +0000, Christophe Leroy wrote:
> 
> 
> Le 06/10/2022 à 15:50, Alan Stern a écrit :
> > On Thu, Oct 06, 2022 at 07:15:44AM +0200, Christophe Leroy wrote:
> >> NO_IRQ is used to check the return of irq_of_parse_and_map().
> >>
> >> On some architecture NO_IRQ is 0, on other architectures it is -1.
> >>
> >> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.
> > 
> > This isn't clear.  Does absence of an irq count as an error?  In other
> > words, will irq_of_parse_and_map() sometimes return 0 and other times
> > return NO_IRQ?  What about architectures on which 0 is a valid irq
> > number?
> 
> NO_IRQ doesn't exist anywhere in core functions. Only some drivers and 
> some architectures have relics of it.
> 
> irq_of_parse_and_map() will always return 0 on error.
> 
> 0 can't be a valid logical IRQ number. It may only be a valid hwirq 
> number but it will always be translated to a non-zero logical irq number.
> 
> I'm trying to get rid of NO_IRQ completely in powerpc code, therefore 
> trying to clean-up all drivers used by powerpc architecture.
> 
> Long time ago Linus advocated for not using NO_IRQ, see 
> https://lkml.org/lkml/2005/11/21/221

Okay, good.  Please resubmit the patch and include some of these things 
in the patch description.

Alan Stern
