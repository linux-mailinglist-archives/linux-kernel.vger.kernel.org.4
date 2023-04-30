Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B7C6F2B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 00:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbjD3WsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 18:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjD3WsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 18:48:20 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 30 Apr 2023 15:48:17 PDT
Received: from www.vigovproductions.net (www.vigovproductions.net [86.43.91.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FF11BF
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 15:48:17 -0700 (PDT)
Received: from vigov-webserver.vigovproductions.net (localhost [127.0.0.1])
        by vigov-webserver.vigovproductions.net (OpenSMTPD) with ESMTP id be784070;
        Sun, 30 Apr 2023 23:41:35 +0100 (IST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=vigovproductions.net; h=to
        :cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=mail; bh=
        juXyoiof4ex/uZvf7aBY5+aQaAo=; b=iTkoFPC8xWMvBjg2WoxloPHwvnMZLdRb
        Lk/oxT1NmYgFohaeRK+G48wyYdD97pn7IgYUTd7VwChNvzdJYFz7BTKDxafbXKe+
        gwWBWkzkBGoH+N1aD7D+XmmnND5WSnHl+kqRUkEhY43rqxqutfpokmeIKFbC5shl
        xofJt2MUSAS+mziW7c0uwhsvAqjwbxQJ5GzmMQ5oH9a+P9fIftTT6E7sAFpUH9AG
        vmQ2Cqw5mG3RrbnlBnwmVX2xYBEknV874hNR40TkwrkMx0+8LqdT6wbwU2f3//Ks
        rMrMbqE8PodPxLtbx/frQBazyvFnXIT30jObs0oVQ7zAuJvVasCXdQ==
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vigovproductions.net; h=to
        :cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; q=dns; s=
        mail; b=Li2USaB56wmXQTAb8AvXbMvISqCk2YHGynIPV6Bhr+ijkwUakwYc80/Z
        gFqOcLyWOXTiq0lJUctts0pC5VhY1/57NSRkl+hvLK0KSjt6sgSJl1Uy+kLwj1Kd
        4Vu3DCGcchEzk/GRQ3dmWlO26M+/Jr0pcVlRNQyU+ZGPCCsmYvqJ4wC7GaoKlVVZ
        sHZjF7PLTxsWWTGF+oxJ+8FdLdLIA9iE6sQQcCbnfru4tFuGNbkTrKGdH8W1XfP4
        7pZgCCfgwmXoxo30iy0UKU5LqroWBRjUl51U7a1/MwuS9PJWTHfown97jAD/xhWL
        NjCkhoXcEQszW1VqqijnfGvPe6HFPQ==
Received: from [192.168.1.52] (www.vigovproductions.net [86.43.91.159])
        by www.vigovproductions.net (OpenSMTPD) with ESMTPSA id 416617b0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 30 Apr 2023 23:41:35 +0100 (IST)
To:     Tad <support@spotco.us>, liam.howlett@oracle.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rick.p.edgecombe@intel.com
References: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
From:   Michael Keyes <mgkeyes@vigovproductions.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mgkeyes@vigovproductions.net; prefer-encrypt=mutual; keydata=
 xsBNBFbRwEIBCACtizW7jkoD17g0VZFc+pBoevENZSJ6um8pNY1KEzmUOjHpz3hM+4qYp+/O
 XdmDOuh24n9yegOjy/29ILifLeAmYbzDI/a7+2HHtcOX6ekCWpEaS3tuED+4q0qPPBeN407C
 LVGh4aJqlphQxRcOVduJv1qmxFzuNjLbkL9JVcjQ7iuJgKr3yUp766gULp95z10GmlpogkEV
 2av19L8nHOjMqS+cXZYuqnks+uNEduZNg9U8alVF4Z61DZZO/69XBN3y+fUDZkB7RNIWPkhh
 qbpWwR1wB8El+ZmQveLX64AKp7+y9ouwdlfYxQFFjWcJDnhYlBeFN+3FrFnvWGtrrO6vABEB
 AAHNLE1pY2hhZWwgS2V5ZXMgPG1na2V5ZXNAdmlnb3Zwcm9kdWN0aW9ucy5uZXQ+wsB3BBMB
 CAAhBQJW0cBCAhsDBQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEI0xE/fTb4M8SpoH/RGS
 0SdDeE/FCFY51HNvRs/DfPT+lkpzOmvRz9VghTG1uAJ18XhGZyloj4Y45zvvfwuIZ4h4/Rs5
 hUGZvUNdzqqTsKv1oVzvf7Jk/9Y8ycnfuXHO/QavpKCj5LnRIT0WUFU2tezDs4fwcqw3wXbu
 iz5sa+jTCSNkH6WryytkDx8CSq4KftgjB/uujvz3YMExvS7JjyPSnLsVYXws7HlHvl4u9oMD
 aCfci4bp/0i8oL499yUO7HC5jQwwkP9OZbAlgySPErEpahXG9Kx6MD82yy1JHdLmePyc74M8
 U1k1FKABvjXEigoCRzjVtyiINCpNv6+kMS6M+fQMLuVM5gQKKLjOwE0EVtHAQgEIANgZcP6N
 Zy+jGkG4xp2Cs2E0SndXI4BV4HD6BZhsfQdrluhv058pdkz9Y081v6NzRTFuqeOCNzp1lftS
 qwA6UzpshTQB2SvUk1H/mwdEWhG8DDf4FFtde4m5nEvr0Sj/ZIzaynQIUHzQBnuuS1y4Btyi
 yQGFalRwQqcnuWJ+f+/zj9haXbdWPmZdSxIeO4C3v6+leh/cWdNjFt6xtWy546QkW9IZO++m
 31+DdxlxwlwZQZrrV6orS60HWB4IYJBI0W5/z3EBlqJ026eLiWapYrNtrJyePI9pIP3diOd3
 m6WiFSZELD3YSUHOSvcBoBfkl7LOUALLXKE3/CRucN7sH3MAEQEAAcLAXwQYAQgACQUCVtHA
 QgIbDAAKCRCNMRP302+DPM83CACTbzcLgrHEj5So0+FkSToc3pO5KOH0qLu9fA2TTY3jjM5U
 BproFhlDR3nrZBrtveN7B6ni7efOgZnFlSYfJBLnDg0joQLqM4DrdBJLsGo/eAomMJbLMWSm
 fSQ6VhIISNgPoh7db4HyACfr0SpBmK+OmkMB/yIhtqFjYJ7+Ms1IUd2TMlpDYaP98zsf4Hl5
 A2ClhHpU+EB5AjCA+inVSwtj7NLJC30UOTJV9IbFwhPml/OdwZoSntWGY2OTIuBnt+3XbuHD
 zg9A46AXrTTLkqWrUI6IZtApqJd4sIXytnvf0W8MZ8pmP9wX7isvmychTrQ4JsEFxc3e1Sm9
 m3gn/II+
Subject: Re: [PATCH v2] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <90777046-a420-b19f-1847-d353b9938131@vigovproductions.net>
Date:   Sun, 30 Apr 2023 23:41:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <e6108286ac025c268964a7ead3aab9899f9bc6e9.camel@spotco.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.23 15:32, Tad wrote:
> This reintroduces the issue described in
> https://lore.kernel.org/linux-mm/cb8dc31a-fef2-1d09-f133-e9f7b9f9e77a@s=
ony.com/
Yes, I also ran into this (even though I'd somehow missed it the
previous time).

Apparently the issue arises at mm/mmap.c:1582, where low_limit is set to
vm_end_gap(tmp). Occasionally, this returns a 64-bit address (e.g.
0x7fedea581000), which is obviously greater than high_limit for a 32-bit
mmap, and causes the next call to mas_empty_area() to fail.

I'm not sure why vm_end_gap(tmp) occasionally returns a 64-bit address,
or if the best solution is to just check for this and skip the retry if
it occurs=E2=80=A6

--=20
Michael


