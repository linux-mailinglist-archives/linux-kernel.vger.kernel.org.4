Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334C564F906
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 14:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiLQNSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 08:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLQNSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 08:18:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334D13CEE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 05:18:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6E04B8077D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 13:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C47C433D2;
        Sat, 17 Dec 2022 13:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671283113;
        bh=26FMEBU6hkqnKk5Fev0Qg8m9V2JGK2TXo473bevwxVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yt3seslVvJWor4vgNGZS3hrCzuNDa6agmW9vS1B2yEZzUCTW9d3s6U7B/sQqDXdd/
         1otl7H2UVI9P7fu7DlOM8U7/OFcfN8BohciOEenMs4m2ptPxsgDXZ7sl3QRfQUqcQb
         ecpeDACa7KufRK7MoPnWTbbkax/Sw1WRMKUAI+K0=
Date:   Sat, 17 Dec 2022 14:18:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y53BputYK+3djDME@kroah.com>
References: <CAPDLWs-Z8pYkwQ13dEgHXqSCjiq4xVnjuAXTy26H3=8NZCpV_g@mail.gmail.com>
 <Yz/ZWBeNZvKenEVM@kroah.com>
 <CAPDLWs9KWKs_-fpAp2=97uBARYqrHSYTPEU6RbqtWjAD8NpqgQ@mail.gmail.com>
 <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDLWs9CoWw7NLfrtCfMsRAdCSfBgomVELRhM70QWVca99z65A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 06:32:48PM +0530, Kaiwan N Billimoria wrote:
> Hi,
> Any update on 6.1 being set as the next LTS release?

You tell me please.  How has your testing gone for 6.1 so far?  Does it
work properly for you?  Are you and/or your company willing to test out
the -rc releases and provide feedback if it works or not for your
systems?  Do you have problems with 6.1.y vs. older kernels?  Is there
anything missing in it that you feel needs to be addressed with a newer
kernel instead?

thanks,

greg k-h
