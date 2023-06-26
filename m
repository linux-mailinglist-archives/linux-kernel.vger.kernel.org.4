Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BB773E290
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjFZOyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 10:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjFZOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 10:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B61D3;
        Mon, 26 Jun 2023 07:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0BB0E60C08;
        Mon, 26 Jun 2023 14:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB7DC433C9;
        Mon, 26 Jun 2023 14:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687791279;
        bh=VvKXlkNbyCjvlkKVGqZkEHFqFzCn0Jcjw7pEQfU+8yc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=niHOUldNdf2h1/wo50ereF/ZjhX3C54s7tad5hYjjZG1p2YdiRBVv9DM/Lu/eJOfn
         Fk+aRuGW/Q0/nZ5x0FCfaDzUNXWA9NJIew5h8ppUhI4qPDfkAsYC/1U1EATCv8qLeu
         5J4YzcYI1aHQPMcSmULGvBWagp3CvqR7TnLMMtdJvyDsOd61YBvpyfa2W5o9TCZErl
         OIuzDRv3/3GDadYKxZOxUGS+U+kQyU3+l4jyExVsQ7a7mTcie2fpogiM+i1Yi96fzz
         OH1O+ivwtqgfaOgKwa+Z2N8iOGf213A4dAQXlrHMhsQ4KI6BAVMmi+nE5Fk11xJQpQ
         oAVwBxi+mFd8g==
From:   bentiss@kernel.org
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Jason Gerecke <killertofu@gmail.com>
Cc:     Benjamin Tissoires <bentiss@kernel.org>,
        Ping Cheng <pinglinux@gmail.com>,
        Aaron Armstrong Skomra <skomra@gmail.com>,
        Joshua Dickens <Joshua@Joshua-Dickens.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Jason Gerecke <jason.gerecke@wacom.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: wacom: Use ktime_t rather than int when dealing with timestamps
Date:   Mon, 26 Jun 2023 16:54:21 +0200
Message-Id: <168779116662.356699.3703314952636539084.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608213828.2108-1-jason.gerecke@wacom.com>
References: <20230607214102.2113-1-jason.gerecke@wacom.com> <20230608213828.2108-1-jason.gerecke@wacom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Tissoires <bentiss@kernel.org>

On Thu, 08 Jun 2023 14:38:28 -0700, Jason Gerecke wrote:
> Code which interacts with timestamps needs to use the ktime_t type
> returned by functions like ktime_get. The int type does not offer
> enough space to store these values, and attempting to use it is a
> recipe for problems. In this particular case, overflows would occur
> when calculating/storing timestamps leading to incorrect values being
> reported to userspace. In some cases these bad timestamps cause input
> handling in userspace to appear hung.
> 
> [...]

Updated the "from" email from your patch.
It would be nice if you could fix your workflow (I know you well enough
to know what is your gmail address, but not having to fix this by hand
would be preferable)

Applied to hid/hid.git (for-6.5/wacom), thanks!

[1/1] HID: wacom: Use ktime_t rather than int when dealing with timestamps
      https://git.kernel.org/hid/hid/c/9a6c0e28e215

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>
