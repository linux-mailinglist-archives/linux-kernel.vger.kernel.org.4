Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DEE6FF625
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjEKPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238201AbjEKPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:38:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D665247
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85BD360B6A
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 15:38:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75585C433EF;
        Thu, 11 May 2023 15:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683819502;
        bh=Td5HP6TP3K83360YR/MjsrMoI2xW08/giFCz9NLYbAg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=E//E09ovBXL1ZIxZeTaaKiNKSG681Z9Hk7MOTirWKxJjvnSXUCsPDEQFA9SOHGI5j
         3y2A2vH+Tg9PeOA/fBuS7c+cSp77J2SXn58leFSxm2A6tcJtz7bpGgf2Rpu7OI+lJH
         zwK3QFHMAsDKFmeZexLyqjChW8aTrdOnnSeNoxzeQk/XvykzKq/zbF6LwBoxcpPxzj
         AC/rgFw0n+4QNF6gnYvq3os0/WACy1ij/i871bL5e2oiiZFPu8xINaMAbJz9+feapo
         Df7m5snweR729mTDsijKX1ZpgxUNKrrExxKmC5t5XrmTclNJdpJUfThocou8XOrHAZ
         Uwudp99pnaRuQ==
Date:   Thu, 11 May 2023 08:38:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?5YiY5rWp5q+F?= <iccccc@hust.edu.cn>
Cc:     "david s. miller" <davem@davemloft.net>,
        "david ahern" <dsahern@kernel.org>,
        "eric dumazet" <edumazet@google.com>,
        "paolo abeni" <pabeni@redhat.com>,
        hust-os-kernel-patches@googlegroups.com, yalongz@hust.edu.cn,
        error27@gmail.com, "dongliang mu" <dzm91@hust.edu.cn>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/ipv6: silence 'passing zero to
 ERR_PTR()' warning
Message-ID: <20230511083820.3c87f138@kernel.org>
In-Reply-To: <5bd5bfa.4758.1880b4c8bb2.Coremail.iccccc@hust.edu.cn>
References: <20230413101005.7504-1-iccccc@hust.edu.cn>
        <5bd5bfa.4758.1880b4c8bb2.Coremail.iccccc@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 22:52:25 +0800 (GMT+08:00) =E5=88=98=E6=B5=A9=E6=AF=85 =
wrote:
> ping?

Do not send "pings", if you don't understand the discussion reply=20
to the correct email and say "I don't understand".
