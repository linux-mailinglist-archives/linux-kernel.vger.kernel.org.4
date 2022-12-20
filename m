Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092C26522A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbiLTOci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234046AbiLTObY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:31:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF06F1B782;
        Tue, 20 Dec 2022 06:31:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 569E6B815CF;
        Tue, 20 Dec 2022 14:31:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB19FC433D2;
        Tue, 20 Dec 2022 14:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671546680;
        bh=oix6jCKBIRd4Jchx3qGUz2mMR6jkFXMwNkKxKvweSs8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Fg8XoC6CLThJ3btHF1n1G5bB8DueBBrq7hyOcf4oAYFL4YoLjfI6DHZjaHWE2bfU6
         bQBasAOd3/8K3jIGVazW9jAe5qn9uwbk329gHOhxI6p/67cO/Yk1RtwLXL4feV4oBX
         F5VdyX+tVmxm77pBszpuZ6acwFVe6S/Qy0RERtDOLvLrT7eXMHBVPyAO9n3swU28AY
         DqFiVV2uMR+NM2MYCeFVLYlXqJ/EtlUSIM9RUc/jlw4wCgI+YMsPiWk5ineb7fSI6r
         WVRmjMteia5Tp/X38BrWneqrEBXzpOv+GIPMt4IBkYZ3hridsR5qJbtAARvaZILn1B
         TxIQlTT5pI6ow==
Date:   Tue, 20 Dec 2022 15:31:20 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 0/1] HID: input: map battery system charging
In-Reply-To: <20221124175937.7631-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2212201530500.9000@cbobk.fhfr.pm>
References: <20221124175937.7631-1-jose.exposito89@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Nov 2022, José Expósito wrote:

> Hi everyone,
> 
> This patch adds support for reporting battery status (charging/discharging)
> for devices with a charging usage in their HID descriptor:
> 
> 	0x05, 0x85,         /*      Usage Page (Battery System),    */
> 	0x09, 0x44,         /*      Usage Page (Charging),          */
> 
> I tested it on Apple hardware (mouse, trackpad and keyboard) as well as
> on UCLogic tablets with battery [1].
> 
> On other hardware (HID_DC_BATTERYSTRENGTH or digitizers with battery)
> discharging should be reported for backwards compatibility.
> I did my best to keep the old behaviour by adding KUnit tests; However,
> I don't own any of those devices, so I'd appreciate any help testing
> the patch from someone with the actual hardware.

I have applied this to hid.git#for-6.3/hid-core so that we get early 
testing coverage in linux-next as soon as 6.2-rc1 is out.

Thanks,

-- 
Jiri Kosina
SUSE Labs

