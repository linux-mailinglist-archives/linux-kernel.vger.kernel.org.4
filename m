Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFF69A2F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 01:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjBQAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 19:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBQAcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 19:32:00 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF24934022;
        Thu, 16 Feb 2023 16:31:59 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 47C7E37F;
        Fri, 17 Feb 2023 00:31:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 47C7E37F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1676593919; bh=t99FLisIb5DjH+kY7LLBukE/x/skG1GTEOH6ox5y8ZE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fR0WTullAFqX7/ussmzgrjZZ+TM99+4dlKC3eXolnKtk8n6k+V/ADpRbBrWj+ZDTc
         yuelPRSpo/AjMK0sWIx9Xtm9UR+7hDceMFee3/mgQQwsPpYHdoqGy1faxihSJTZguE
         +XI5MYyqAeYJ+k8eTlTijRp/RZmkmAgc+ygxk1dBzca5Bz4jRzm7kDUxcO4JlfLRsE
         zEG+z8xG2d3w9Nbgy4PiG90MG9nX5GvxcZmNsdljcozEdxtkttN5ZDrIkvRmhhbeh2
         MXatoHh+54OE3lGYotR2uI6k3p6h6z5kPVYyH5MpK3ECL4tEV6EvUgkm4ANPGNvudD
         hc+d7quKC2F+Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: Re: [PATCH 0/2] Documentation/Watchdog/hpwdt
In-Reply-To: <20230210184247.221134-1-jerry.hoemann@hpe.com>
References: <20230210184247.221134-1-jerry.hoemann@hpe.com>
Date:   Thu, 16 Feb 2023 17:31:58 -0700
Message-ID: <87y1oxf7y9.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerry Hoemann <jerry.hoemann@hpe.com> writes:

> Two small documentation fixes.
>
> First: Fix reference to documentation that moved.
> Second: Update List formatting.
>
>
>
> Jerry Hoemann (2):
>   Documentation/watchdog/hpwdt: Fix Reference
>   Documentation/watchdog/hpwdt: Fix Format
>
>  Documentation/watchdog/hpwdt.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
