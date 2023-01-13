Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942F166940B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241212AbjAMKYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241215AbjAMKXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:23:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252DFDFB4;
        Fri, 13 Jan 2023 02:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5BCD6112C;
        Fri, 13 Jan 2023 10:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B47C43392;
        Fri, 13 Jan 2023 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673605426;
        bh=DUPv7WIfv9352Q9UfMwcmiH4ujbFGhwE4utd9cuo8jk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bcgdx/KP1w7WzRjn2rre8FUZpCFhjqm2bBTdL3dG3UyVzN+U+maa8bc1nIKwER43u
         nK+48Ni1FuBPJIuv7SDjoeVuonq/2QqBjk23Mz5TiamwTNGev5G13cPOZBBbEkfLtX
         HiNWB/tpvJAxdkRrtYMPZAeoacvtUeD7I7xGMZoVWrCxqgBwO0BJny/thap7FZMFQv
         Swq9lF8ErmAHjighV036dHa+E3ATtQ3KpgJDoJqA9Y/9WMwLKKFZEAnkLfqqpsu+f9
         J4/9EKFh5lBaEXMB6UxWTI2WrExn/WN8daQmd8xghM1O6TIVjNgz5c9YAilwusMlce
         Ti1a54/wXEPUg==
Message-ID: <656ab366-05c9-64fa-651b-12597251d116@kernel.org>
Date:   Fri, 13 Jan 2023 11:23:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 01/13] dt-binding: mediatek: add bindings for MediaTek
 mt8195 MDP3 components
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230113090321.25128-1-moudy.ho@mediatek.com>
 <20230113090321.25128-2-moudy.ho@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230113090321.25128-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 10:03, Moudy Ho wrote:
> This patch adds support for MT8195 MDP3 RDMA, and introduce more
> MDP3 components present in MT8195.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed several entries, so please resend.

Best regards,
Krzysztof

