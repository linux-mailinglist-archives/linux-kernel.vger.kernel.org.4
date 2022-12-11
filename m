Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AF264963E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbiLKU3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:29:36 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6670BDEF8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:29:34 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 79451100002;
        Sun, 11 Dec 2022 20:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670790572;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aenmLYSaueVuHHm3ZGdyynlhDziBV89ECrB6pS619oE=;
        b=K5nSiGj+w03kznIe4Vt/Bnq8KcsIXtrAMY9XJuvr/LjBke+ag8ISwW2vTbXlhwNUv6QNva
        x2+1wy0Loqrn7+V2IHqSnB7upF/Ppr/2apvCnlCkueRr8POYYFKz7+OtPy/AyKhExvjw14
        OsFf6guopliUWfx851eWundkp9i7PNBE7fKm38GqGmdSKmRfVkjw0/rfkWBBVQVvkH+kMx
        CSpXE1kAG6ic2XLljVBD7Z7VFT+MS3havXHvytMNdwSf2fJDuKJlwhf6LNK/6VJ5H7W4mU
        0roTMIzJvnGRWwHzWzYjusTv6lc1W8YTRGYhLT29Y4TGiHgpdVXmc8L+aKgZgg==
Date:   Sun, 11 Dec 2022 21:29:32 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jack Chen <zenghuchen@google.com>
Cc:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        linux-kernel@vger.kernel.org,
        Mark Slevinsky <markslevinsky@google.com>,
        linux-i3c@lists.infradead.org
Subject: Re: [PATCH] I3C: export SETDASA method
Message-ID: <167079040326.15858.302543275649765579.b4-ty@bootlin.com>
References: <20221207205059.3848851-1-zenghuchen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207205059.3848851-1-zenghuchen@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 15:50:59 -0500, Jack Chen wrote:
> Because not all I3C drivers have the hot-join feature ready, and
> especially not all I3C devices support hot-join feature, exporting
> SETDASA method could be useful. With this function, the I3C controller
> could perform a DAA to I3C devices when users decide to turn these I3C
> devices off and on again during run-time.
> 
> Tested: This change has been tested with turnning off an I3C device and
> turning on it again during run-time. The device driver calls SETDASA
> method to perform DAA to the device. And communication between I3C
> controller and device is set up again correctly.
> 
> [...]

Applied, thanks!

[1/1] I3C: export SETDASA method
      commit: 672825cd2823a0cee4687ce80fef5b702ff3caa3

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
