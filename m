Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D55E694583
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 13:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjBMMMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 07:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjBMMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 07:11:50 -0500
X-Greylist: delayed 1821 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Feb 2023 04:10:56 PST
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C77A1B300;
        Mon, 13 Feb 2023 04:10:55 -0800 (PST)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Mon, 13 Feb 2023 12:10:13 +0100
MIME-Version: 1.0
Date:   Mon, 13 Feb 2023 12:10:13 +0100
From:   m.brock@vanmierlo.com
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] tty: n_gsm: add keep alive support
In-Reply-To: <20230213094327.3428-1-daniel.starke@siemens.com>
References: <20230213094327.3428-1-daniel.starke@siemens.com>
Message-ID: <aec7575cd784ae4fe9e9f2c1e08107a9@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D. Starke schreef op 2023-02-13 10:43:
> From: Daniel Starke <daniel.starke@siemens.com>
> +	u32 keep_alive;		/* Control channel keep-alive in ms */
[...]
> +		if (dlci && !dlci->dead)
> +			mod_timer(&gsm->ka_timer, jiffies + gsm->keep_alive * HZ / 100);

keep-alive is in ms? or in 10ms?

Maarten

