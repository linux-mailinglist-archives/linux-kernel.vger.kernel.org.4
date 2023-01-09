Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9DFD66214A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAIJTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236719AbjAIJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:19:20 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0BEF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:15:49 -0800 (PST)
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id D360D7E709;
        Mon,  9 Jan 2023 09:15:47 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673255749;
        bh=XlAWklpJsfq5jvUyl6OM6+cc02RzRDCsA5FyKYa6IWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8Xgl3RCezlLC5g7IDh2VWkq6/4PqYRlbw+NKuVAOsCqPhjB+zWvq0Y5sAw7f90oV
         gIp7vGwqyebNTSTQlDDLQgsDVsEKMt/Vuf65aGvVEao7hrwiyVTj+qCw0b+p0vsSad
         7P2Fd3UapbB4dGme5DHLzxD1/6LPNzwlnS9cH2fSG4+WE5kWyZ29Lm3/rSFyazhHxA
         E3oiIcgj75LJ7bvzIihcUCyxFR/QqKZJ7E1HdMYbm0dkB+yjM55JcQYAqCW3KfgyIS
         iJo3l6Ne5C9jvuXZSDn3XGOA1kBf0EeA4cyRF6cwaUp8LenrSquX4nlZKzAgezPcPs
         xs2Sf2hRJdVeg==
Date:   Mon, 9 Jan 2023 16:15:44 +0700
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/22] nolibc: usability improvements (errno, environ,
 auxv)
Message-ID: <Y7vbQEZ56Td15nTs@biznet-home.integral.gnuweeb.org>
References: <20230109084208.27355-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109084208.27355-1-w@1wt.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 09:41:46AM +0100, Willy Tarreau wrote:
> Ammar Faizi (3):
>   nolibc/stdlib: Implement `getauxval(3)` function
>   nolibc/sys: Implement `getpagesize(2)` function
>   selftests/nolibc: Add `getpagesize(2)` selftest

Now that these went through your hands, they also need your signoff :-)

-- 
Ammar Faizi

