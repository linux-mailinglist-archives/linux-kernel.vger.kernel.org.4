Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876C46A5F28
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 20:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjB1TFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 14:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB1TFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 14:05:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9A72A9A8;
        Tue, 28 Feb 2023 11:05:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DED0611A7;
        Tue, 28 Feb 2023 19:05:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390E2C433D2;
        Tue, 28 Feb 2023 19:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677611105;
        bh=BEVSlWE7Hdyraa/Sod6gs2PRTZn7touzwnv11SD6P78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0J0CbOmsK+afsjHSUHuq3U5Jj/jT4TPZVHM2NmPToEVsbEaebx0n1mNR7md7UXUOm
         WYwSOZZY2gsnt+vyxFmMsFk3pE7LOcuDpHzwc7tzELkGV69JRuD9XtDFKs5GYvMsC9
         hVNEeLrnSjdV1IGrdaw70IUe42PwF0FkfmTAruAE=
Date:   Tue, 28 Feb 2023 20:05:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Michael Wu <michael@allwinnertech.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gong, Richard" <Richard.Gong@amd.com>
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Message-ID: <Y/5QX1gYsGinrPNF@kroah.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
 <Y/dMq2KKYfdMdrjh@kroah.com>
 <801338c3-7c0d-6b3e-eac8-872ee5add466@suse.com>
 <MN0PR12MB6101B1BF9748F0602684FED5E2AB9@MN0PR12MB6101.namprd12.prod.outlook.com>
 <f2142d88-259f-302d-da61-e0fc39d1f041@suse.com>
 <MN0PR12MB61017A45BEF80013FD7B77D5E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB61017A45BEF80013FD7B77D5E2AC9@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 06:50:18PM +0000, Limonciello, Mario wrote:
> I still keep getting inquiries about this where teams that work on the same
> hardware for Windows and Linux complain about this difference during
> their testing.
> 
> I keep educating them to change it in sysfs (or to use a udev rule), but
> you have to question if you keep getting something asked about policy
> over and over if it's actually the right policy.

Why not complain to the Windows team to get them to change their policy
back as they are the ones that changed it over time and are not
backwards-compatible with older systems?

:)

thanks,

greg k-h
