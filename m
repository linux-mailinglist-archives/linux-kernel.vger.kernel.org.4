Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2CD6B9F32
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCNS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCNS50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:57:26 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25CA5ACB9B;
        Tue, 14 Mar 2023 11:57:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id AAD7E823;
        Tue, 14 Mar 2023 18:57:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AAD7E823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1678820242; bh=TzkGt8A9DDpMEyIXJHQAoEC8I5YpIpqrHqxHKmmtkLo=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Mthh9kNep0Z5BYFro04tnA0DgaiejRklf8Xqgf14QZjTgcGXXmIRu4EQEdMOMt1ta
         Lp+UUYKgRUuuP53VgdYJel1aEPu98wW19g0iGneo5vgqD3W/Ucoce1QjX9ZXt74sUs
         zsmTkUqWHJbGd/eur1LeJB47ygaK/y2g66qmndRitCqxubwjMyz5JcmS5uX1uTeccu
         hnzvYzzN7m9lEQL4dqd2oW5i8ByKZKBjp1ufuQ27vfiWuV1IXyrjePs3ydUEo6WFqc
         xzsLeFIjcFvrgB/iJEHTaF+lq2SHn9F4RMHVG5MLy6H1xl0EsWzPd24V97cQ8XIHuV
         6srD8Cpgg+4ig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     kaiwan.billimoria@gmail.com, rlove@rlove.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] docs: Add relevant kernel publications to list of books
In-Reply-To: <a577b165-1e18-e689-7580-cac3f37317f8@amd.com>
References: <20230222183445.3127324-1-carlos.bilbao@amd.com>
 <a577b165-1e18-e689-7580-cac3f37317f8@amd.com>
Date:   Tue, 14 Mar 2023 12:57:21 -0600
Message-ID: <87jzzjqhym.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> For the list of kernel published books, include publication covering kern=
el
> debugging from August, 2022 (ISBN 978-1801075039) and one from March, 2021
> on the topic of char device drivers and kernel synchronization (ISBN
> 978-1801079518). Also add foundational book from Robert Love (ISBN
> 978-1449339531) and remove extra spaces.
>
> Co-developed-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> Signed-off-by: Kaiwan N Billimoria <kaiwan.billimoria@gmail.com>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
>
> ---
> Changes since v2:
>   - Fix SoB chain.

So this showed up approximately 4.23=C2=B5s after I applied v2 ... I went
back in and tweaked the signoffs to match this version.

Thanks,

jon
