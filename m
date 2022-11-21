Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F39D632E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiKUVR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKUVRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:17:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60D5A1B8;
        Mon, 21 Nov 2022 13:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59C0AB81636;
        Mon, 21 Nov 2022 21:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FC3C433C1;
        Mon, 21 Nov 2022 21:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669065455;
        bh=tTnHsLcJ45Pykkgdlf5D4zGgI3hdA2fsDCJrGM5RR1Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=i4He++5dfUqj9x0v0ECTasfwdNU4FknwaVmcFvZ5PdFBQncfB07BzT3jk7hE/TCOz
         5v9hUAbMSh177xg/dUaK/vrmOfgudEXajAxL+GOl/NhojnHHkuvXXc5avQiJaWqCAn
         9VxXJtRgmyar7j0KzY7K1wRUmqRGMTIOvDsLlh3gk++rmwmW8MR43lA3JGxe80QVcI
         6Uue3BgArRtgfjFW5R8nRdndGVcGslps+dNKVpfhEiwZbJwKy/awQDdJ6INJJXSdXH
         gCkdlkGrr5MPKoBLGmUwXhKmVoajfECCRErHeXWpCMhithNlJQHtdU+g3S/Yv9oVDy
         PhO7Tiklgm9MA==
Date:   Mon, 21 Nov 2022 22:17:33 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: hid-elan: use default remove for hid
 device
In-Reply-To: <20221117121314.5577-1-marcus.folkesson@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211212217270.6045@cbobk.fhfr.pm>
References: <20221117121314.5577-1-marcus.folkesson@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Marcus Folkesson wrote:

> hid_device_remove() will call hid_hw_stop() as default .remove function
> if no function is specified.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Applied.

-- 
Jiri Kosina
SUSE Labs

