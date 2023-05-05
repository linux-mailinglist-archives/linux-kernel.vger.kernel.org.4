Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FC56F8543
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 17:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjEEPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjEEPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 11:10:47 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7BB2719;
        Fri,  5 May 2023 08:10:45 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A953E2E0;
        Fri,  5 May 2023 15:10:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A953E2E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1683299444; bh=wkhumPHAYafzx7X/FXo2zkhZYpZdAZ6mqzkz2bNFv0s=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GLjAIfMZC6Ft1QYzBgQVdJqn+JqgSBNPL2FnagfBNZHGm3Kn+El3L/z1r6p2ls1Nb
         2y7REisCZE5RLiTa4qIXPzZrKbR+ZixppY8WloowOmgL9k7xuTE8frkwCbdcuKTMXb
         Nh8WiUBMyXf1Kg6EpkEkc34qWjXeRviVSCWriA81s3TUDrWc2qgP++ggNWY16yOxWk
         /CK8Nytpe8nhaffOwSi4zs/V++DQ20jBO+YAJri5HDJZWNuSAcIZc/vO9RwRQs8tZN
         i6bbZNVfyAEWz3HFA77f6QIpHz2ecxzXbbIS3JQ2y2LXI2hXPBOeHYsChCH/zxfKj+
         S151fcFflDW1Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     James Seo <james@equiv.tech>, Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     James Seo <james@equiv.tech>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 07/11] Documentation/hwmon: Revise sysfs interface
 specification
In-Reply-To: <ZFUaNQAxjvnFnsOr@equiv.tech>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-8-james@equiv.tech> <ZFSLN6KmGgfW4YzE@debian.me>
 <ZFUaNQAxjvnFnsOr@equiv.tech>
Date:   Fri, 05 May 2023 09:10:43 -0600
Message-ID: <87cz3en79o.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

James Seo <james@equiv.tech> writes:

> On Fri, May 05, 2023 at 11:51:03AM +0700, Bagas Sanjaya wrote:
>> On Thu, May 04, 2023 at 12:57:48AM -0700, James Seo wrote:
>>> +**RO**    Read-only value.
>>> +**WO**    Write-only value.
>>> +**RW**    Read/write value.
>> 
>> Why are the permissions be emphasized?
>
> I don't remember, to be honest. I will deemphasize permissions.

Just to say ... you are interacting with a personality known for driving
contributors into the ground with nit-picky comments.  We do lean toward
minimal markup, but this is not an example that really needed to be
called out.  Do whatever seems best to you here.

Thanks,

jon
