Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0118D729EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbjFIPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbjFIPni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:43:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301B13C2A;
        Fri,  9 Jun 2023 08:43:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACC2B6589D;
        Fri,  9 Jun 2023 15:43:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E7DC433D2;
        Fri,  9 Jun 2023 15:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686325406;
        bh=k5H0w5Da6WZZ3aTGInSoVeleNc+ktLVZTOXjpBlYsqI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=ZI3OoO392J6Fyh3Q6JpxeL35MUDlmqeUudg/Mw++d7JKiz5TKNywgXAzcih6P7jv+
         B5+UuuWrp/uSH3inZ1VFgKYGnBuBtDl7Jl3K1DSS9MT5Gl/vSlN0tvTtFpMbt3Neve
         y+gs71F0Lyc1zWlb/jgFSWkTMMCl+GFoDgeFMfdSiAVzopHBF++raQVJo7EYflRiiv
         lLD0nk5gQCduGnOCQbInAzIH8m3v1YLmkQqxiike+o4TeVuXNEnX8o/ICnRifETRPg
         qDHIoCcL4LYDAG4Dnd+ahn5wP/1M0HZB56ulqoh08oXxRrBz9gNhbsa+9p3+30/NJ4
         lMSMdySjUDNtQ==
Date:   Fri, 9 Jun 2023 17:43:21 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
cc:     Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sensor-hub: Allow multi-function sensor devices
In-Reply-To: <20230528092427.42332-1-daniel.thompson@linaro.org>
Message-ID: <nycvar.YFH.7.76.2306091742090.5716@cbobk.fhfr.pm>
References: <20230528092427.42332-1-daniel.thompson@linaro.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 May 2023, Daniel Thompson wrote:

> The Lenovo Yoga C630 has a combined keyboard and accelerometer that
> interfaces via i2c-hid. Currently this laptop either has a working
> keyboard (if CONFIG_HID_SENSOR_HUB is disabled) or a working accelerometer.
> only works on kernels. Put another way, most distro kernels enable
> CONFIG_HID_SENSOR_HUB and therefore cannot work on this device since the
> keyboard doesn't work!
> 
> Fix this by providing a richer connect mask during the probe. With this
> change both keyboard and screen orientation sensors work correctly.
> 
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

Srinivas, are you aware of any multi-function device that this patch might 
break?

Thanks,

-- 
Jiri Kosina
SUSE Labs

