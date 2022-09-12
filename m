Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D405B5ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 15:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiILNE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 09:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILNEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 09:04:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80CAD21264;
        Mon, 12 Sep 2022 06:04:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F0B1B80D29;
        Mon, 12 Sep 2022 13:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE0AC433D6;
        Mon, 12 Sep 2022 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662987860;
        bh=7q4sA9wAuyHoIHWhAi1rO3s232J8n3z65j2WOT21gqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qpRIfQQnnOF39nhfoIPmNqwXkW1lJAaPtHpIMcghD/lWJPu1SgePK/XMhTj1FJZRh
         AYi8zowjKThbZNTvFSPxxNxqAZM98LxvKpVbyiGXvcIQGn/W8KOspvedM4dEAC0sgB
         2qs2+ZcTEmPxFvIu9rfB3mXwBaFDMeQIDSo3l6bIpTmvzEa4BelVPFnwFAA+buSZkL
         2dafRdORD0Ey0vqRFQIoSo5A+/cHTJavW+ChqTxh+wKE81QuVEFRgwWHwvZ2RTQ4cc
         5Ki/ewRBUu8MOpbuNOolznY0bFTvEbB/GaYVlqYWhwAOojC/ETGZfenkuLL3OMSoLO
         yzk6GdP8znIMA==
Date:   Mon, 12 Sep 2022 14:04:15 +0100
From:   Lee Jones <lee@kernel.org>
To:     Silvan Jegen <s.jegen@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [RESEND] HID: steam: Prevent NULL pointer dereference in
 steam_{recv,send}_report
Message-ID: <Yx8uT8UEK5GjOOaE@google.com>
References: <20220803111831.387506-1-lee@kernel.org>
 <Yx8cYZnmnN09lD4A@google.com>
 <3HW30DP4UX94G.2T1G25E825X7D@homearch.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3HW30DP4UX94G.2T1G25E825X7D@homearch.localdomain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2022, Silvan Jegen wrote:

> Hi
> 
> Lee Jones <lee@kernel.org> wrote:
> > On Wed, 03 Aug 2022, Lee Jones wrote:
> > 
> > > It is possible for a malicious device to forgo submitting a Feature
> > > Report.  The HID Steam driver presently makes no prevision for this
> > > and de-references the 'struct hid_report' pointer obtained from the
> > > HID devices without first checking its validity.  Let's change that.
> > 
> > This patch has been floating around since the beginning of July.
> > 
> > It fixes a real issue which was found by creating a virtual
> > (software based) malicious device and registering it as a HID device.
> > 
> > There is nothing preventing a real attacker from creating a H/W
> > version of the device in order to instigate an out-of-bounds read,
> > potentially leading to a data leak.
> > 
> > Would someone be kind enough to review please?
> 
> AFACT this patch has been applied by Jiri on the 25th of August already.

Ah, I missed his reply to the original patch.

> Is a review still needed in this case?

Certainly not.  Thank you for your reply.

-- 
Lee Jones [李琼斯]
