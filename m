Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F16F2B05
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjD3VwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 17:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjD3VwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 17:52:05 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A386E46
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 14:52:03 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E1CBC0002;
        Sun, 30 Apr 2023 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682891521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aNS6bTrYpPgW4eO7ylJ0uOc6JEAYmZn76L/XRnu+sso=;
        b=EaoMNzwyIp+wzM931r/MMCcgnYDeG7SooBPb1bDnmnHRvQHEcioMInNu7R4kWwbYyX5J7t
        buPPWM/THXlfhj6Vrrv5l8EK9Bd+dVZA/XgT1lFvHVqOU80WPTU3AxlcULzVY0gHvBouId
        CU+u0yzk5MzsOZ1wZpXcCBQvbrsCBY9KyK78v5M69nQ1TdRO3rQV34SR//tygymkAuqKq5
        QkQtKzv07jIV28hUJ8ITYVuf/uv9brjyNpdRwRZrgrmwG0ziNkTULzzm/pkUNmUTc0lhOy
        qdt0BGVOIT+aTBlPGs04qZ8otqt4XplTMISf0SPpKLRlpxSHjWEFks593IkTmg==
Date:   Sun, 30 Apr 2023 23:51:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     jk@codeconstruct.com.au, Tom Rix <trix@redhat.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: ast2600: set variable ast2600_i3c_ops
 storage-class-specifier to static
Message-ID: <168289147474.50482.8490566834895045084.b4-ty@bootlin.com>
References: <20230429134601.2688558-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230429134601.2688558-1-trix@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Apr 2023 09:46:01 -0400, Tom Rix wrote:
> smatch reports
> drivers/i3c/master/ast2600-i3c-master.c:121:34: warning: symbol
>   'ast2600_i3c_ops' was not declared. Should it be static?
> 
> This variable is only used in its defining file, so it should be static.
> 
> 
> [...]

Applied, thanks!

[1/1] i3c: ast2600: set variable ast2600_i3c_ops storage-class-specifier to static
      commit: 6b496a94c5905fca7879bc0dc438a47de40b7d4f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
