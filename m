Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23763628B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiKNVjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiKNVjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:39:41 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC165D5;
        Mon, 14 Nov 2022 13:39:39 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0CBFBC0005;
        Mon, 14 Nov 2022 21:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668461978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sOWF5F92EnS9hSP1qtXx6Twhli4lGixQXs89KujgSY0=;
        b=CT0ynaGQQ4O7aGn67+bY6uYj/KAlSL9TIfp5i3cdwNQpAz2QwuajT69z6DzZi0S0FK5adi
        73pVc0m1yWKI8OfsVjzBYida1CWlCupM/IrtepI/en7s+h42BRphUqWHDlQp/NrKyDgorr
        EvwiDxhkpJ6dY8x9XZXmNvjbYViOCFZX9ugXs6Gi7VeUNOhlbdGuD/ol0MciLo1aRaY1FL
        fVyRSYihiNWJLfUnjRHRBF8P7qrj9ESc1s5AM9dFl/w4ssr5TdBEwc9FaQ+pvkG5i3xyiu
        kR3w3wPHQ69y/kDJ/K8zuH/s0W2RzfhhemD3cKEgiSeedQG+3PCFI1BWPczu2A==
Date:   Mon, 14 Nov 2022 22:39:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     cgel.zte@gmail.com
Cc:     ye xingchen <ye.xingchen@zte.com.cn>, linux-rtc@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, a.zummo@towertech.it,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] rtc: s35390a: Remove the unneeded result
 variable
Message-ID: <166846192191.2116555.12061921477464300716.b4-ty@bootlin.com>
References: <20220905090119.335121-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905090119.335121-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2022 09:01:19 +0000, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value s35390a_set_reg() directly instead of storing it in
> another redundant variable.
> 
> 

Applied, thanks!

[1/1] rtc: s35390a: Remove the unneeded result variable
      commit: ba9c9a77035907295c542cf343d3cdd85cdc9a9e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
