Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC396E07FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 09:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDMHmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 03:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjDMHmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 03:42:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59A83E4;
        Thu, 13 Apr 2023 00:42:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9690362D5E;
        Thu, 13 Apr 2023 07:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC36C433D2;
        Thu, 13 Apr 2023 07:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681371719;
        bh=0fipDVhShnsLvDpz8npwfblLULSYuyXBmR5sweJClf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sYz1rhd7DHPHT+ZMPcAozScHks6IMi3rLw8awOOYx22ZQi/mxqIzchFpcsBVwnRQ9
         KuL11PMstX9OI1tfPN83WpkPrwEPEUV7B+4v5kz9H8l+7S3Go4Hh9zy2BR1S2DZ99K
         pJL7L8C5cfzV9XsIp/XhBiHn4wq7ph4Ro0KXZUkE=
Date:   Thu, 13 Apr 2023 09:41:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stanley =?utf-8?B?Q2hhbmdb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] usb: dwc3: core: add support for disabling
 High-speed park mode
Message-ID: <2023041355-parole-enviable-b002@gregkh>
References: <20230411053550.16360-1-stanley_chang@realtek.com>
 <20230411213158.r7i6thg67okbovjp@synopsys.com>
 <e9964b3cd1a34b05990c1061af9d1951@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9964b3cd1a34b05990c1061af9d1951@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:15:35AM +0000, Stanley Chang[昌育德] wrote:
> 
> CC more maintainers by using scripts/get_maintainers.pl
> 

I do not see any message here, so I am totally confused.

You have to use the script when determining who to send the patch to,
you can't do it after the fact like this as it will not work at all.

greg k-h
