Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5438F61E2FF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:28:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiKFP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiKFP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:28:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E6E9F;
        Sun,  6 Nov 2022 07:28:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BC9560BFF;
        Sun,  6 Nov 2022 15:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831EBC433C1;
        Sun,  6 Nov 2022 15:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667748502;
        bh=E9NRTTEykCALmdyzeT0Ev2PHNAi8E5E9zOmBGoR0aek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YBO7cJ2t00yDUPmHVOQNZrOGiaFTdT1twkaVa4dQzVTfRNTeDecrLyeHWj9S4m1FD
         gctw89/r0kxy3Ra2+XQscUdbBtIqYfL2IjlVgtHza9QhhOhXLoFVrrinY+v0VfvBXz
         CRTvoPEEqBZ98xz7ubzxeTQ6XujFp0dwe9WcJeWRYvEPpzxeBwXHVw/1q7iXLRHahT
         JdcEP6q1PBpgJdD85UeBgZ2zcLX1h2LFuCUXx6JhVlX6yLpqVyqKBTqHd0FFDLSbtk
         +T73+CY8/9XfT0dB6COU+sbri+1MMoN+Iw8oBd3Ww1+WKl3QQfl0AmbpXx6IYW7q1I
         zqLpLkR01WkPw==
Date:   Sun, 6 Nov 2022 15:28:12 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     lars@metafoo.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, rajat.khandelwal@intel.com
Subject: Re: [PATCH v7] iio: temperature: Add driver support for Maxim
 MAX30208
Message-ID: <20221106152812.5ed5ef2f@jic23-huawei>
In-Reply-To: <20221101174409.316447-1-rajat.khandelwal@linux.intel.com>
References: <20221101174409.316447-1-rajat.khandelwal@linux.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Nov 2022 23:14:09 +0530
Rajat Khandelwal <rajat.khandelwal@linux.intel.com> wrote:

> Maxim MAX30208 is a digital temperature sensor with 0.1=C2=B0C accuracy.
>=20
> Add support for max30208 driver in iio subsystem.
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX30208.pdf
>=20
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>

Hi Rajat,

Given ongoing discussion on v6 (sorry I didn't get back to you earlier
in the week), will result in some changes in here, I'll wait for v8 before
taking another close look.

Jonathan


