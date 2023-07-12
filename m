Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8033750732
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjGLLyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbjGLLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:54:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0526C1FEE;
        Wed, 12 Jul 2023 04:52:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6A1761780;
        Wed, 12 Jul 2023 11:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8050CC433C8;
        Wed, 12 Jul 2023 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689162778;
        bh=z/2unuxkQBfu6lN68wWhSCQcwSPkxxj54V22sMSdgxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYuCAJAEzWZK8BwlhyvLp8JVuMejLvy+16dY3CnLT2dCyJuoeq32469WAni+mKBT2
         CIJteXVRd9wmCXNtL1rnmuKalYjQ/C138i5FnlmZhMepnoSB1fNqwOGc2+liucP6LE
         e4PQRSWwl4uZyZx+9ZHghM9je+FqtvVFrkqfZ5JIQjJHFJ2z1KFo3SV03rvf6MvTRm
         IwO7VideHzHBGQsGFHdm66GG8CCTyzL+01uPfPVZ8UdsQf9XfuTEVMT1gDbCwJ2lYT
         yfTMmT7BLDStSVOneEpqsMIy9X7xXf3sLBHmyKFqGLzzW8lf/X8vz2v6oLmM7xYas2
         qCaoWGqz60jMQ==
Date:   Wed, 12 Jul 2023 12:52:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: simatic-ipc-leds-gpio: fix comment style in
 SPDX header
Message-ID: <20230712115252.GA10768@google.com>
References: <20230706161040.21152-1-henning.schild@siemens.com>
 <20230706161040.21152-3-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706161040.21152-3-henning.schild@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jul 2023, Henning Schild wrote:

> This was found with giving the file to checkpatch.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/leds/simple/simatic-ipc-leds-gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/leds/simple/simatic-ipc-leds-gpio.h b/drivers/leds/simple/simatic-ipc-leds-gpio.h
> index bf258c32f83d..3d4877aa4e0c 100644
> --- a/drivers/leds/simple/simatic-ipc-leds-gpio.h
> +++ b/drivers/leds/simple/simatic-ipc-leds-gpio.h
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0
> +/* SPDX-License-Identifier: GPL-2.0 */

What prompted this change?

% git grep -F "// SPDX-License-Identifier:" -- drivers/leds | wc -l
117
% git grep -F "/* SPDX-License-Identifier:" -- drivers/leds | wc -l
2

-- 
Lee Jones [李琼斯]
