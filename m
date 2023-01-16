Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC11066B8C6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjAPIGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:06:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjAPIGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:06:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C51449F;
        Mon, 16 Jan 2023 00:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A489EB80D52;
        Mon, 16 Jan 2023 08:04:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59004C433EF;
        Mon, 16 Jan 2023 08:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673856249;
        bh=vlGBHwtLoXaueQt3amdQXXyo8la0rtzvu7Fd/pdvFGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYQUCQNVUy0YsnxDqyRtt1HctYkD2y14FAE9JIpRMH2CrORxSNBqd6vsU/CVkm+7j
         4kSoGjxNtyQGg5PWzXyTtaVK2NgDDW761GYk9BbP9HY57R9myHIl83T6DnX6u2FgmY
         R8+37fWVaF64cAg4CDolBPR8k7e5GCS2seiVbyAFeZSmiBKQYCcjlbZsjPOm0U8ry9
         +Vw+6tw9mkn/xHFg/J8VfAaOgVNlrF52I5TqCkmqQRj+1jfpJ/f6ZanaWd5Dra28zy
         rzy/3hOLf1Pi54dt2pbk76O8QX9WRbDH5wav2s34QjPuInYTQbrSxIhl8aWo8Rld2X
         SVqWWp+woh7tw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pHKTj-0000a1-Q6; Mon, 16 Jan 2023 09:04:27 +0100
Date:   Mon, 16 Jan 2023 09:04:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     clabbe@baylibre.com, gregkh@linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 1/2] usb: serial: add support for CH348
Message-ID: <Y8UFC/1vH/Y9PeBN@hovoldconsulting.com>
References: <0fa6e2b8-0585-87a3-f255-5301774a6d9d@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0fa6e2b8-0585-87a3-f255-5301774a6d9d@ixit.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please fix your mailer which generates broken Reply-To headers:

	Reply-To: 20230106135338.643951-2-clabbe@baylibre.com
]

On Sat, Jan 14, 2023 at 10:05:18PM +0100, David Heidelberg wrote:
> Acked-by: David Heidelberg <david@ixit.cz>
> 
>  > +    int i;
>  > +
>  > +    for (i = 1; i < CH348_MAXPORT; ++i) {
> 
> One nitpick; it would be nice to have a "for" loop from C99+.

No, I prefer this as it stands (and we only have about 80 instances of
such fancy stuff outside of tooling it seems).

Johan
