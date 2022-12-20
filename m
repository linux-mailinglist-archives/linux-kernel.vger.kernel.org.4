Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF506522D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbiLTOiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiLTOiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:38:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7018BB4;
        Tue, 20 Dec 2022 06:38:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38861CE130B;
        Tue, 20 Dec 2022 14:38:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10509C433D2;
        Tue, 20 Dec 2022 14:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671547088;
        bh=HbvMVtbJpAGje0faURE4t4UNf1v10j4sjbwVUYRb5vo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XqlMy2pl8933VtVA2+UvOS2kku44Z0bYsjKQYnZxVnJJrWR+y35EBAOO6AqiPnue0
         q27+Mxqjq7ZVmnp/AaT0WXFOH2WXEgjju7RgD4dkqFZ4g3iCS6MjXqN585gQLfyk8N
         j/CNFs8Jd0GgvebP8940CTNa63R3xRHw3/xs9vJaaD2nR6HDNVVJiqZ+h6Y6KVg2ia
         0iSLrko6Uny9qOts8J4tt4y4jOq7A1XdSzlgoaB33FsuKh/4RSfGyqVBw3Bjt9gRem
         9ioUuvKdhRrCcptSkRHdmTagshCuszx82KTirpkOGlMBYKhqR7lR3XvuYdRJxnMwl4
         tAWL7h2wa8V1g==
Date:   Tue, 20 Dec 2022 15:38:08 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     =?ISO-8859-15?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
cc:     benjamin.tissoires@redhat.com, rydberg@bitmath.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: sony: Fix unused function warning
In-Reply-To: <20221128165524.6387-1-jose.exposito89@gmail.com>
Message-ID: <nycvar.YFH.7.76.2212201537570.9000@cbobk.fhfr.pm>
References: <20221128165524.6387-1-jose.exposito89@gmail.com>
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

On Mon, 28 Nov 2022, José Expósito wrote:

> Compiling this driver without setting "CONFIG_SONY_FF" generates the
> following warning:
> 
> 	drivers/hid/hid-sony.c:2358:20: warning: unused function
> 	'sony_send_output_report' [-Wunused-function]
> 	static inline void sony_send_output_report(struct sony_sc *sc)
> 	                   ^
> 	1 warning generated.
> 
> Add the missing preprocessor check to fix it.
> 
> Signed-off-by: José Expósito <jose.exposito89@gmail.com>

Thanks for fixing this, now applied.

-- 
Jiri Kosina
SUSE Labs

