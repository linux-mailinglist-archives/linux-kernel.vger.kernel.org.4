Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AAC65B829
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 00:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjABX1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 18:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjABX1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 18:27:01 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE126268;
        Mon,  2 Jan 2023 15:27:00 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6A90F2E0;
        Mon,  2 Jan 2023 23:26:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6A90F2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672702019; bh=pOLTTJ5qYN6lHTiOnMKQrXACGMVjbpTTTFynIgZ3JSQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=g9iz/LDvyNf8G1+9W9lBfTYi31IV2i1h35+wvrD5WbsoN16kOBcaVLukLbqs/3Um6
         Im9d67KQMm3J5YVMD5/Z/Qw536UxOkqzsMwiWleYg9wwzgnt8v/0VBg/7LGeouhaDm
         b0JkSMY6+XT2tVjF5F6e5wxBh/YFPHCGVKMe31+uyVMI8otfPwNl7ouWagyK5IONTC
         CsT7D8xVP9XhjHJUIfk7MUkkK+19Yaw2lEryouwCvrTO1RWWnDMf/8ghMZcqAxvk69
         WLEzBa+3Ff0mos/OHhPYWBIcY7UE58WOVCncJQsQRx0nnA5YIP03SDEOAAkQ6a5k+G
         eOX5kM8kpzyTQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chen Xiao <abigwc@gmail.com>
Cc:     akpm@linux-foundation.org, yejiajian2018@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, zhangyinan2019@email.szu.edu.cn,
        akiyks@gmail.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Xiao <abigwc@gmail.com>
Subject: Re: [PATCH] docs: mm/page_owner: fix spelling mistakes
In-Reply-To: <1670479443-8484-1-git-send-email-abigwc@gmail.com>
References: <1670479443-8484-1-git-send-email-abigwc@gmail.com>
Date:   Mon, 02 Jan 2023 16:26:58 -0700
Message-ID: <87r0wch60t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen Xiao <abigwc@gmail.com> writes:

> Fix several spelling mistakes in page_owner documentation.
>
> Signed-off-by: Chen Xiao <abigwc@gmail.com>
> ---
>  Documentation/mm/page_owner.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst

Applied, thanks.

jon
