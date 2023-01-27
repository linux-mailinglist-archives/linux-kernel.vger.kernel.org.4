Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2CC67E02A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:30:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjA0Ja1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232020AbjA0JaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:30:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9856E29438;
        Fri, 27 Jan 2023 01:30:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B6C8B82003;
        Fri, 27 Jan 2023 09:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38A7C433D2;
        Fri, 27 Jan 2023 09:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674811807;
        bh=8RGl0thJpJI4hbt6lrO6mUP2W3lcWRSRhnlQ2Slbcl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozw3TkWnI0o/RyU1TRy+HbTwECH0dPsnHzCUgY2sL7mD18Ciwf9FOCXwzPuKPbS+G
         S1+QIvetSHjsqTx4cjN5NfDqUpTZ0exhE8ayub6wFqwJqe8cMMozkbPsjTLuzK6SUd
         4e4aL/PLiiyDnOzJvYb2ZVxgUw0XNHmjJYSKp3+idOEVloED2dOXOrwzDgxnxVEAE4
         z8BMEJ3b0d/y7M5aqaelbDgPLU9Tc3NN+Prywzc5D75XXZcTBdzR2Zm0SCnVpj64Fx
         xR/Vlu13U46lUmL5DeboLb3zmMpvg7IofmFz/1R4+qRjhGSHBHNJo/KIUwGuDhNlEa
         EWjJUnZw66zVw==
Date:   Fri, 27 Jan 2023 09:30:01 +0000
From:   Lee Jones <lee@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 14/35] Documentation: leds: correct spelling
Message-ID: <Y9OZmf92Dd4QEBkF@google.com>
References: <20230127064005.1558-1-rdunlap@infradead.org>
 <20230127064005.1558-15-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230127064005.1558-15-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jan 2023, Randy Dunlap wrote:

> Correct spelling problems for Documentation/leds/ as reported
> by codespell.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Lee Jones <lee@kernel.org>
> Cc: linux-leds@vger.kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/leds/leds-qcom-lpg.rst |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
