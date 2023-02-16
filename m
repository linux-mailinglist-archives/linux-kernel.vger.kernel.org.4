Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89866990DB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjBPKPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBPKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:15:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC5A1422E;
        Thu, 16 Feb 2023 02:15:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF9AD61F35;
        Thu, 16 Feb 2023 10:15:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7B0C433EF;
        Thu, 16 Feb 2023 10:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676542543;
        bh=Rtt/TC5ii7FJNzfCAGiCoypbGARCs96y92KYuqTCsNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gl4Ld0KgvNitRX2m4d6MWvfnpdDhCVwEKSdCc1Zf0ZdvMH/MgTL6im2RULJSoWFE8
         w+71ld6l/azOT3rG5TvKMcwTyhrQGPhpueamIKocujM3QRtbsvqzN4ORqrlAhMa6qi
         qshPaAzqV9zO2oT0/rcUAObCGX1IoArNPx/z347c=
Date:   Thu, 16 Feb 2023 11:15:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     qi feng <fengqi706@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Subject: Re: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
Message-ID: <Y+4CTE81khczF5jO@kroah.com>
References: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
 <CACOZ=ZXN7Jnug_vhWexFvxknZEwaRM9BHXEo8O20q=sEKecNLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACOZ=ZXN7Jnug_vhWexFvxknZEwaRM9BHXEo8O20q=sEKecNLQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:26:16PM +0800, qi feng wrote:
> loop more

????
