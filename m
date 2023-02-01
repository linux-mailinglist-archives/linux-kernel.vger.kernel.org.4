Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01EB7686513
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjBALLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 06:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjBALLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 06:11:13 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43B44F369;
        Wed,  1 Feb 2023 03:11:11 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 1AD52165B;
        Wed,  1 Feb 2023 12:11:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1675249870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAdLTSx9aZVPgU2yXpW13ESsr057NA3ZhA2Ul60b64I=;
        b=2HqGAuAzLYYlhRsUU3EiKYIn/RqES/gaEF/Smvw1qlXTRS4rWCeA49iESbGNoMmJJw3vwb
        fp0lq+m0UqYUxi6L6kIwZ/GY3u2vZa5QqiWj9zzJbMLnwYnN+gUePW3U9dnfTmHZsYuU4T
        Bx18zZ+50cyykmEz3Unpt6uFTmTchoN3AqczpFcULJvWTn4CqusZyfqymhvTibbuV9DACI
        lhMN57a8qJWGmxu4Udh+xuhlfDkJXFTJdPsiERjlFaE63jK/83RjQuXjd0jtcJQbr6yHlM
        1Vfn9NUYmaoV3069OvHsKN3TN+dBLPDY10DJxgIh7TCyFGzz6YBEXA8bB4p+5w==
MIME-Version: 1.0
Date:   Wed, 01 Feb 2023 12:11:09 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     devicetree@vger.kernel.org, hayashi.kunihiko@socionext.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        mhiramat@kernel.org, rafal@milecki.pl, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH 3/4] nvmem: mtk-efuse: replace driver with a generic MMIO
 one
In-Reply-To: <618392ed-7d20-a49f-1ec5-b27850d71dec@gmail.com>
References: <20230201064717.18410-4-zajec5@gmail.com>
 <20230201084821.1719839-1-michael@walle.cc>
 <8452b341-8695-05d8-9d03-47c9aeca0ec7@gmail.com>
 <017a17eb99ac2b2c858d27b65c5dd372@walle.cc>
 <618392ed-7d20-a49f-1ec5-b27850d71dec@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9c17f253542610da58f843b920e63f4a@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> nitpick btw: why not "nvmem-mmio"?
> 
> Because I read from left to right ;)

if you have more compatibles do you prefer

  a-grp
  bcdef-grp
  gh-grp

or

  grp-a
  grp-bcdef
  grp-gh

To my eyes the latter looks nicer, but it's just a matter of taste ;)

-michael
