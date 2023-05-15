Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A73702C65
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 14:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbjEOMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbjEOMMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:12:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADCB1AD;
        Mon, 15 May 2023 05:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47F7761540;
        Mon, 15 May 2023 12:12:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EA1C433D2;
        Mon, 15 May 2023 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684152772;
        bh=n51sMV+oqfmSxDsAlIziws1ZZJXFWAH2B0TAPyC5COQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApqAHljfoyeZKwcFo3Kn8jiE9XpcGevZw0Z0YEOqmR49EKd58vmuoQ/D/LNPE+yYu
         DArWEA4qsk2AgFIos84m4+/hwAhGRAboqs3Uckrw7yKnjOZcxBJf62LtSNY+BXoW7j
         /NpF3OGRL8ugUbjUhQOwhL+z2q8mh0uIRWah/ttSwtvZ3z+rqg1gUy1ygxdh4ZYKtS
         PwzfF1i5fmdBazpDR9LrdbCU7trcVyJuuuE3Ju1MN2axFO/cmMhH8rQljcdcH/RVuh
         k9ClRdBI4eRamHWjD7UCBJduKZ+CJe2e6P1qQkkT56TUpWHyXLY+0iJZlo5PGCJZ9P
         3PcBLEPcjG4CA==
Date:   Mon, 15 May 2023 13:12:47 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <20230515121247.GB10825@google.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230513120818.21b99596@md1za8fc.ad001.siemens.net>
 <20230515095042.GE8963@google.com>
 <20230515120138.66e48bd4@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515120138.66e48bd4@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Henning Schild wrote:

> Am Mon, 15 May 2023 10:50:42 +0100
> schrieb Lee Jones <lee@kernel.org>:
> 
> > On Sat, 13 May 2023, Henning Schild wrote:
> > 
> > > Ping.
> > > 
> > > As far as i remember this one should be ready to merge.
> > > 
> > > ACKed by Hans, and Andy had no objections given the maintainers
> > > would accept the patches.
> > > 
> > > So i think it is the maintainers turn now, Pavel and/or Lee i
> > > guess.  
> > 
> > Looks like there are lots of mail threads in reply to each of the
> > patches.  If these culminated in acceptance, please collect all of the
> > Acks you've received until this point and submit a [RESEND].  If there
> > are changes to be made still, please do the same but submit as a new
> > version.
> 
> Ok i will send it again and include the ACK from Hans. There would be no
> code change. Please review the code already, if you find it acceptable
> we might receive a second ACK from Andy.

Not sure what you mean by 'already'.

I shall not be reviewing this set until it is resent, thanks.

-- 
Lee Jones [李琼斯]
