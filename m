Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DD47282C0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbjFHOcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjFHOcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:32:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F133F2729;
        Thu,  8 Jun 2023 07:32:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD0764E17;
        Thu,  8 Jun 2023 14:32:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C597C433D2;
        Thu,  8 Jun 2023 14:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686234769;
        bh=AZXHnB2XK7W9ZtACZYfGecUAbwN9IkRTRN0lekZ5OEI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=pzMFe547k3lUElWZag1QeQWhKS8p7E5k/Q4BgPYKavrJNh3peEEFlyji31cLzdJ9S
         PhEHozSUq1X64nS30WG6wcrqIHzv999fhveFFSJPSbfIN8SYNq6jukHesWcwr/aM9Q
         XfOYzzopPSzU3NS8EIENrnQ2C9bkiXNMkbVELM9IRGpguuaSAuKqujIZKIwt9cGeUp
         k2JiAVXcIWEtiaLArgFYIYeABfgnIEUG+Epvitn4spwcUKGty5Ff3SQqjATtjuCZMZ
         MyUNlLZw+UXFuuQeURGm8Eg60ImgBQ58mJoF6qRYS+WVCTmyY1570qc606vGjPy75d
         ltIWRSXS6Z5mA==
Date:   Thu, 8 Jun 2023 16:32:45 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Stuart Hayhurst <stuart.a.hayhurst@gmail.com>
cc:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v2] HID: logitech-hidpp: Add USB and Bluetooth IDs for
 the Logitech G915 TKL Keyboard
In-Reply-To: <20230530144427.24732-1-stuart.a.hayhurst@gmail.com>
Message-ID: <nycvar.YFH.7.76.2306081632260.5716@cbobk.fhfr.pm>
References: <20230530144427.24732-1-stuart.a.hayhurst@gmail.com>
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

On Tue, 30 May 2023, Stuart Hayhurst wrote:

> From: stuarthayhurst <stuart.a.hayhurst@gmail.com>
> 
> Adds the USB and Bluetooth IDs for the Logitech G915 TKL keyboard, for device detection
> For this device, this provides battery reporting on top of hid-generic
> 
> Reviewed-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Stuart Hayhurst <stuart.a.hayhurst@gmail.com>

Applied. thanks.

-- 
Jiri Kosina
SUSE Labs

