Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FFA67CE52
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjAZOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjAZOhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:37:40 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B323862;
        Thu, 26 Jan 2023 06:37:35 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C19AD2D3;
        Thu, 26 Jan 2023 14:37:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C19AD2D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1674743854; bh=0562LnNUCt9JJJhRg4NFLkVnEkQms9BWIzzgPLd1QRM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=WluIPROi/OYJ6Ckue5eY2R57K5jPfXBoV01kK89mACVlFNDTWTlRTNXuc8wtXIhHz
         7WFv0hnqotkBWr9pFkiAV2D0Da2VI/iuwrZza6jn4rHB29rsdDepw8TdvkljX7lyAf
         QBISnW9/3zrfzqLy0ZYWvtUF4ma09pJlldKJUHJJdfhbC26aK8Cflz/7v5b0ByIQh3
         K98S5hKzdzkRHfpdXUdGDvxmRdaN6ROHTJOfqwLmUmJgEMK38oLxfwkCujnjZx06BF
         DGfa13+iRz3Zm32/Jh650R4LDuiCKmziuC9tMHfUGZ4viS2c4pZuBGt/EbYe4Ss98n
         zeitpWiNljs4w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: leds: fix the following docu build warning
In-Reply-To: <5fd77765-4f55-f204-6aa0-963830cd13d8@gmail.com>
References: <20230125154426.12464-1-skhan@linuxfoundation.org>
 <5fd77765-4f55-f204-6aa0-963830cd13d8@gmail.com>
Date:   Thu, 26 Jan 2023 07:37:33 -0700
Message-ID: <87bkmlbbv6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 1/25/23 22:44, Shuah Khan wrote:
>> Add leds-qcom-lpg to Documentation/leds/index.rst to fix the following
>> doc build warning.
>> 
>
> The patch subject should have been "docs: leds: add missing documentation
> to the toctree"

Shuah has been doing this for a while and really does not need your
instructions on how to do a patch; this one is fine as-is.

Bagas, please stop harassing our contributors.  I'm getting fairly tired
of asking that.

> Otherwise, LGTM.
>
> Acked-by: Bagas Sanjaya <bagasdotme@gmail.com>

Do you have a history or status with the LED subsystem that puts you in
a position to ack this patch?

jon
