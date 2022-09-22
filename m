Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1EB5E5CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiIVIB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIVIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:01:25 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2042034E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 01:01:24 -0700 (PDT)
References: <20220916030655.11105-1-anjan@momi.ca>
 <28159639-c011-62a0-e8bd-07a79aadca91@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=momi.ca; s=key1;
        t=1663833683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p0yNopc1Gi0yMjAQNP4Zf9e0rxlj1CWidMLuNaUxDY0=;
        b=n/MGXy+lmhuEqiGv5GNmJL1RYZ2xdAf74PP8XiD8QexpebBwedngI79Qk7DnpjPTUBzsxN
        gEx0mKiDqxaYrJZaWTjGIZO4faGiZrRks3hfjlVRV7P/Px8O9UzNAG+YNaS/ms4CaytNrH
        EJV6FLF4Tq0uH7ecCJF0h3pi4OetvtJwwsvYvyhJhjrfwv3fR/4yBasCWfZHpgFAsIhN/T
        NJekAUgAgN+zmsKyGUeTIQA3bSmsdzJieqyFBjw6Q9Q560hiOvB00GTDEA+iApOPblMQFl
        a9aaox7zzb5kos+R1PCkEhtpOTs7Ux8/4YIGVyhQb2w5QnegAk+GIwRcP+LW/Q==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Anjandev Momi <anjan@momi.ca>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8192e: fixed brace, space, and align coding
 style issues
Date:   Thu, 22 Sep 2022 04:00:14 -0400
In-reply-to: <28159639-c011-62a0-e8bd-07a79aadca91@gmail.com>
Message-ID: <878rmbalda.fsf@momi.ca>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: momi.ca
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review. I just sent v2 of this patch. Splitting this
patch up into multiple patches helped me make better commit messages.
Please bear with me as I try to learn how to contribute.

Best,
Anjandev
--
w:] www.momi.ca
pgp:] https://momi.ca/publickey.txt
