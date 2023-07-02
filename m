Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D450744CF2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 11:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjGBJZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 05:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjGBJZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 05:25:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76E1E4D
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 02:25:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 72B6D60B42
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jul 2023 09:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BE9C433C9;
        Sun,  2 Jul 2023 09:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688289931;
        bh=8hDKfzE3cEwfFRozXD3BGJYPuuNWm2Nh8JXbaScWBSI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qmKeQNtJ2QlDBnHPDX9FvdOpup5M/lv4f1F1I5nbokYjJwVB6YfkOVAef4Zxmod0M
         vv/xsigGs5nwurl2Cdn+Rs30XrgAWPfC2iAcwQlo7r8VH5gF/8hu/7KmqIep+e/tK1
         AtAEmHvYnbjM8wj67zB2ZEE1AIEwl0GwXQfNhkZPiy/wgBE0kSkbIw+sX/SW8IV75E
         kQLk0dEC4vjqHGJkJr0yTcR+J1QqF7Rv0xnklWDlpn+YXpm3wHU8vy70LIZ3eF7H0i
         4jsA9qk8p04fUJmRDdZash13edEixLvFj7MWiYkW7L5HRYaLUIVfQhTd6UXbJK+hXn
         MyjPnpkahKkGA==
Message-ID: <4ba70074-b8ff-ccfb-37df-8e7a187582df@kernel.org>
Date:   Sun, 2 Jul 2023 11:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/6] dt-bindings: perf: marvell: Add YAML schemas for
 Marvell PEM pmu
Content-Language: en-US
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sgoutham@marvell.com, bbhushan2@marvell.com, gcherian@marvell.com,
        lcherian@marvell.com
References: <20230630120351.1143773-1-gthiagarajan@marvell.com>
 <20230630120351.1143773-3-gthiagarajan@marvell.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230630120351.1143773-3-gthiagarajan@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2023 14:03, Gowthami Thiagarajan wrote:
> Add device tree bindings for Marvell PEM performance monitor unit
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> Signed-off-by: Linu Cherian <lcherian@marvell.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by our
tools. Performing review on untested code might be a waste of time, thus
I will skip this patch entirely till you follow the process allowing the
patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


Best regards,
Krzysztof

